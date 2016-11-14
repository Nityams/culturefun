local EventListener = require( "Source.eventListener" )
local util = require( "Source.util" )
local Vector = require( "Source.vector" )


local Controller = {}
Controller.__index = Controller


function Controller:new( object, minScale, maxScale, scale )
	local c = {}
	setmetatable( c, Controller )

	c.object = object
	c.minScale = minScale
	c.maxScale = maxScale
	c.scale = scale

	c.listener = EventListener:new()
	c.touches = {}

	c:setScale( scale )

	return c
end


function Controller:getScale()
	return self.object.xScale
end


function Controller:moveTo( x, y, scale )
	local obj = self.object
	obj.x = x
	obj.y = y
	obj.xScale = scale
	obj.yScale = scale
	self.listener:dispatchEvent( "move", nil )
end


function Controller:setScale( scale )
	self:moveTo( self.object.x, self.object.y, scale )
	self.listener:dispatchEvent( "move", nil )
end


function Controller:requestMoveTo( x, y, scale )
	if self.request then
		timer.cancel( self.request )
	end
	self.request = timer.performWithDelay( 0, function()
		self.request = nil
		self:moveTo( x, y, scale )
	end)
end


function Controller:addEventListener( eventName, handlerFn )
	self.listener:addEventListener( eventName, handlerFn )
end


function Controller:calculateCenter()
	-- Mean location of all touches

	local count = 0
	local sumX = 0
	local sumY = 0

	for _,touch in pairs( self.touches ) do
		count = count + 1
		sumX = sumX + touch.x
		sumY = sumY + touch.y
	end

	return Vector.new( sumX / count, sumY / count )
end


function Controller:calculateRadius()
	-- Mean distance from touches to center of touches

	local center = self:calculateCenter()

	local count = 0
	local sum = 0

	for _,touch in pairs( self.touches ) do
		count = count + 1
		sum = sum + center:distanceTo( touch )
	end

	return sum / count
end


function Controller:startTouch()
	self.startPos = Vector.new( self.object.x, self.object.y )
	self.startScale = self:getScale()

	self.startCenter = self:calculateCenter()
	self.startRadius = self:calculateRadius()
end


function Controller:handleTouch( event )
	local id = event.id

	if event.phase == "began" then
		display.getCurrentStage():setFocus( self.object )
		self.touches[id] = Vector.new( event.x, event.y )
		self:startTouch()

	elseif event.phase == "moved" then
		if self.touches[id] then
			self.touches[id] = Vector.new( event.x, event.y )
		else
			-- Touch might have originated off of the object.
			display.getCurrentStage():setFocus( self.object )
			self.touches[id] = Vector.new( event.x, event.y )
			self:startTouch()
		end

		self.touches[id] = Vector.new( event.x, event.y )

		local endCenter = self:calculateCenter()
		local endRadius = self:calculateRadius()

		local dPos = endCenter - self.startCenter
		local dRadius = endRadius / self.startRadius

		if util.isNaN( dRadius ) then
			-- Only one finger on the screen causes a divide by zero.
			dRadius = 1
		end

		-- TODO: Set scale.
		--local scale = self.startScale * math.exp( -1 * d.y / 500 )
		local x = self.startPos.x + dPos.x
		local y = self.startPos.y + dPos.y
		local scale = self.startScale * dRadius

		self:requestMoveTo( x, y, scale )

	else  -- event.phase == "ended" or event.phase == "cancelled"
		self.touches[id] = nil

		if util.size( self.touches ) > 0 then
			self:startTouch()
		else
			display.getCurrentStage():setFocus( nil )
			self:startRubberBand()
		end

	end

	return true
end


function Controller:startRubberBand()
	local scale = self:getScale()

	if scale < self.minScale then
		scale = self.minScale
	elseif self.maxScale < scale then
		scale = self.maxScale
	end

	-- TODO: Do this over some period of time.
	self:setScale( scale )
end


return Controller
