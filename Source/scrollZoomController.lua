local easing = require( "easing" )

local EventListener = require( "Source.eventListener" )
local math2 = require( "Source.math2" )
local util = require( "Source.util" )
local Vector = require( "Source.vector" )

local NOW = 0
local SOON = 1


local Controller = {}
Controller.__index = Controller


function Controller:new( options )
	local c = {}
	setmetatable( c, Controller )

	c.object = options.object
	c.minScale = options.minScale
	c.maxScale = options.maxScale
	c.scale = options.defaultScale
	c.minX = options.minX
	c.maxX = options.maxX
	c.minY = options.minY
	c.maxY = options.maxY

	c.enabled = true
	c.listener = EventListener:new()
	c.touches = {}

	c:setScale( c.scale )

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
	if not self.enabled then
		return
	end

	if self.rubberBandTransition then
		transition.cancel( self.rubberBandTransition )
	end

	local id = event.id

	if event.phase == "began" then
		display.getCurrentStage():setFocus( self.object )
		self.touches[id] = Vector.new( event.x, event.y )
		self:startTouch()
		self:saveTouchInfo( NOW )

	elseif event.phase == "moved" then
		if self.touches[id] then
			self.touches[id] = Vector.new( event.x, event.y )
		else
			-- Touch might have originated off of the object.
			display.getCurrentStage():setFocus( self.object )
			self.touches[id] = Vector.new( event.x, event.y )
			self:startTouch()
			self:saveTouchInfo( NOW )
		end

		local endCenter = self:calculateCenter()
		local endRadius = self:calculateRadius()

		local dPos = endCenter - self.startCenter
		local dRadius = endRadius / self.startRadius

		if util.isNaN( dRadius ) then
			-- Only one finger on the screen causes a divide by zero.
			dRadius = 1
		end

		local x = math2.lerp( self.startCenter.x, self.startPos.x, dRadius ) + dPos.x
		local y = math2.lerp( self.startCenter.y, self.startPos.y, dRadius ) + dPos.y
		local scale = self.startScale * dRadius

		self:requestMoveTo( x, y, scale )

	else  -- event.phase == "ended" or event.phase == "cancelled"
		self.touches[id] = nil

		if util.size( self.touches ) > 0 then
			self:startTouch()
			self:saveTouchInfo( SOON )
		else
			display.getCurrentStage():setFocus( nil )
			self:startRubberBand()
		end

	end

	return true
end


function Controller:saveTouchInfo( when )
	if self.saveTouchTimer then
		timer.cancel( self.saveTouchTimer )
	end

	if when == NOW then
		self.recentStartCenter = self.startCenter

	else  -- when == SOON
		-- If the player lets go of all their fingers from a multi-touch gesture, we
		-- lose the information about where their fingers were centered. Preserve
		-- it for a little while.

		self.saveTouchTimer = timer.performWithDelay( 100, function()
			self.recentStartCenter = self.startCenter
		end)
	end
end


function Controller:startRubberBand()
	local scale = self:getScale()
	local x = self.object.x
	local y = self.object.y

	self.rbStartScale = scale
	self.rbStartX = x
	self.rbStartY = y

	local dRadius = self.rbEndScale / scale
	x = math2.lerp( self.recentStartCenter.x, self.object.x, dRadius )
	y = math2.lerp( self.recentStartCenter.y, self.object.y, dRadius )

	-- TODO: Don't use these min* max* values: just make sure there's no
	-- background showing.
	self.rbEndScale = math2.clamp( scale, self.minScale, self.maxScale )
	self.rbEndX = math2.clamp( x, self.minX, self.maxX )
	self.rbEndY = math2.clamp( y, self.minY, self.maxY )

	self.rubberBandTransition = util.transition( 300, easing.outExpo, function( t )
		self:rubberBandProgress( t )
	end)
end


function Controller:rubberBandProgress( t )
	self:moveTo(
		math2.lerp( self.rbStartX, self.rbEndX, t ),
		math2.lerp( self.rbStartY, self.rbEndY, t ),
		math2.lerp( self.rbStartScale, self.rbEndScale, t )
	)
end


return Controller
