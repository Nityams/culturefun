local Button = require( "Source.button" )
local EventListener = require( "Source.eventListener" )
local images = require( "Source.images" )
local wallet = require( "Source.wallet" )


images.defineImage( "Pin", "Passport/pin.png", 39, 58 )
images.defineImage( "Pin Pressed", "Passport/pin-pressed.png", 39, 58 )
images.defineImage( "Pin 2", "Passport/pin2.png", 39, 58 )
images.defineImage( "Pin Pressed 2", "Passport/pin-pressed-2.png", 39, 58 )
images.defineImage( "Pin 3", "Passport/pin3.png", 39, 58 )
images.defineImage( "Pin Pressed 3", "Passport/pin-pressed-3.png", 39, 58 )
images.defineImage( "Pin 4", "Passport/pin4.png", 39, 58 )
images.defineImage( "Pin Pressed 4", "Passport/pin-pressed-4.png", 39, 58 )
images.defineImage( "Pin 5", "Passport/pin5.png", 39, 58 )
images.defineImage( "Pin Pressed 5", "Passport/pin-pressed-5.png", 39, 58 )


local Pin = {}
Pin.__index = Pin


function Pin:new( displayGroup, x, y )
	-- p inherits from Pin
	local p = {}
	setmetatable( p, Pin )

	p.x = x
	p.y = y
	local check = wallet.getCoins() / 500
	local image
	local imagePressed 
	if check == 1 then 
		image = images.get( displayGroup, "Pin" )
		imagePressed = images.get( displayGroup, "Pin Pressed" )
	elseif check == 2 then 
		image = images.get( displayGroup, "Pin 2" )
		imagePressed = images.get( displayGroup, "Pin Pressed 2" )
	elseif check == 3 then 
		image = images.get( displayGroup, "Pin 3" )
		imagePressed = images.get( displayGroup, "Pin Pressed 3" )
	elseif check == 4 then 
		image = images.get( displayGroup, "Pin 4" )
		imagePressed = images.get( displayGroup, "Pin Pressed 4" )
	elseif check == 5 then 
		image = images.get( displayGroup, "Pin 1" )
		imagePressed = images.get( displayGroup, "Pin Pressed 1" )
	elseif check == 6 then 
		image = images.get( displayGroup, "Pin 2" )
		imagePressed = images.get( displayGroup, "Pin Pressed 2" )
	elseif check == 7 then 
		image = images.get( displayGroup, "Pin 3" )
		imagePressed = images.get( displayGroup, "Pin Pressed 3" )
	elseif check == 8 then 
		image = images.get( displayGroup, "Pin 4" )
		imagePressed = images.get( displayGroup, "Pin Pressed 4" )
	end

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

	return p
end


function Pin:insertInto( displayGroup )
	self.button:insertInto( displayGroup )
end


function Pin:addEventListener( eventName, handlerFn )
	self.button:addEventListener( eventName, handlerFn )
end


function Pin:reposition( mapTop, mapLeft, mapWidth, mapHeight )
	self.button.x = mapLeft + mapWidth * self.x
	self.button.y = mapTop + mapHeight * self.y
end


function Pin.__newindex( pin, key, value )
	if key == "enabled" then
		pin.button.enabled = value
	else
		rawset( pin, key, value )
	end
end


return Pin
