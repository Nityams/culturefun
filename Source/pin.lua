local Button = require( "Source.button" )
local EventListener = require( "Source.eventListener" )
local images = require( "Source.images" )


images.defineImage( "Pin", "Passport/pin.png", 39, 58 )


local Pin = {}
Pin.__index = Pin


function Pin:new( displayGroup, x, y )
	-- p inherits from Pin
	local p = {}
	setmetatable( p, Pin )

	local image = images.get( displayGroup, "Pin" )
	image.anchorY = 1.0  -- Make image.y be for the bottom of the image.

	p.image = image
	p.x = x
	p.y = y

	-- TODO: make a Button
	-- TODO: button.addEventListener( "tap", onTap )

	return p
end


function Pin:addEventListener( eventName, handlerFn )
	self.image:addEventListener( eventName, handlerFn )
end


function Pin:reposition( mapTop, mapLeft, mapWidth, mapHeight )
	self.image.x = mapLeft + mapWidth * self.x
	self.image.y = mapTop + mapHeight * self.y
end


return Pin
