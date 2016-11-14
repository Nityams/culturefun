local EventListener = require( "Source.eventListener" )

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
	print( "x", x )
	print( "y", y )
	print( "scale", scale )

	scale = (scale or self:getScale())
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
	local count = 0
	local sumX = 0
	local sumY = 0

	for _,touch in pairs( self.touches ) do
		count = count + 1
		sumX = sumX + touch.x
		sumY = sumY + touch.y
	end

	return sumX / count, sumY / count
end


function Controller:handleTouch( event )
	local id = event.id

	if event.phase == "began" then
		display.getCurrentStage():setFocus( self.object )

		self.touches[id] = {
			x = event.x,
			y = event.y
		}

		self.oldMapX = self.object.x
		self.oldMapY = self.object.y
		self.touchCenterX, self.touchCenterY = self:calculateCenter()

	elseif event.phase == "moved" then
		self.touches[id] = {
			x = event.x,
			y = event.y
		}

		local newCenterX, newCenterY = self:calculateCenter()

		local dx = newCenterX - self.touchCenterX
		local dy = newCenterY - self.touchCenterY

		--local scale = self.oldScale * math.exp( -1 * dy / 500 )
		local scale = self:getScale()

		self:requestMoveTo( self.oldMapX + dx, self.oldMapY + dy, scale )

	else  -- event.phase == "ended" or event.phase == "cancelled"
		self.touches[id] = nil

		if #self.touches > 0 then
			self.oldMapX = self.object.x
			self.oldMapY = self.object.y
			self.touchCenterX, self.touchCenterY = self:calculateCenter()
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
