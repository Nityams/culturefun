local Button = require( "Source.button" )
local EventListener = require( "Source.eventListener" )
local images = require( "Source.images" )


images.defineImage( "Pin", "Passport/pin.png", 39, 58 )
images.defineImage( "Pin Pressed", "Passport/pin-pressed.png", 39, 58 )


local Pin = {}
Pin.__index = Pin


function Pin:new( displayGroup, x, y )
	-- p inherits from Pin
	local p = {}
	setmetatable( p, Pin )

	p.x = x
	p.y = y

	local image = images.get( displayGroup, "Pin" )
	local imagePressed = images.get( displayGroup, "Pin Pressed" )

	-- Make image.y be for the bottom of the image.
	image.anchorY = 1.0
	imagePressed.anchorY = 1.0

	p.button = Button:newImageButton{
		group = displayGroup,
		image = image,
		imagePressed = imagePressed,
		x = x,
		y = y,
		width = images.width( "Pin" ),
		height = images.height( "Pin" ),
		alpha = 0.75
	}

	-- TODO: button.addEventListener( "tap", onTap )

	return p
end


function Pin:addEventListener( eventName, handlerFn )
	self.image:addEventListener( eventName, handlerFn )
end


function Pin:reposition( mapTop, mapLeft, mapWidth, mapHeight )
	self.button.x = mapLeft + mapWidth * self.x
	self.button.y = mapTop + mapHeight * self.y
end


return Pin
