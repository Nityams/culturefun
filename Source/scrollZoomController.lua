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

	c:setScale( scale )

	return c
end


function Controller:getScale()
	return self.object.xScale
end


function Controller:setScale( scale )
	self.object.xScale = scale
	self.object.yScale = scale
	self.listener:dispatchEvent( "move", nil )
end


function Controller:addEventListener( eventName, handlerFn )
	self.listener:addEventListener( eventName, handlerFn )
end


function Controller:handleTouch( event )
	if event.phase == "began" then
		display.getCurrentStage():setFocus( self.object )

		self.touchStartX = event.x
		self.touchStartY = event.y

		self.touchStartScale = self:getScale()

	elseif event.phase == "moved" then
		local dx = event.x - self.touchStartX
		local dy = event.y - self.touchStartY

		local scale = self.touchStartScale * math.exp( -1 * dy / 500 )

		self:setScale( scale )

	else  -- event.phase == "ended" or event.phase == "cancelled"
		display.getCurrentStage():setFocus( nil )

		local scale = self:getScale()

		if scale < self.minScale then
			scale = self.minScale
		elseif self.maxScale < scale then
			scale = self.maxScale
		end

		self:setScale( scale )

	end

	return true
end


return Controller
