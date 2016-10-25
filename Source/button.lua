local EventListener = require( "Source.eventListener" )

local tapSound = audio.loadSound( "Assets/Sounds/Menu/Button Tap.wav" )
local allowance = 30  -- pixels around the button that still trigger it

local Button = {}

-- Arguments: parentGroup, font, fontSize, fontColor, text, x, y,
--            paddingX, paddingY, fillColor, fillColorPressed,
--            borderWidth, borderColor
function Button:new( options )
	-- b inherits from Button
	local b = {}
	setmetatable( b, self )
	self.__index = self

	local fgGroup = display.newGroup()
	local text = display.newText(
		fgGroup,
		options.text,
		options.x,
		options.y,
		options.font,
		options.fontSize
	)
	text:setFillColor( unpack( options.fontColor ) )

	local textWidth = text.width
	local textHeight = text.height

	b.touchPanel = display.newRect(
	 	fgGroup,
		options.x,
		options.y,
		textWidth + 2*options.paddingX + 2*options.borderWidth + 2*allowance,
		textHeight + 2*options.paddingY + 2*options.borderWidth + 2*allowance
	)
	b.touchPanel:setFillColor( 0, 0, 0, 0.01 )

	local bgGroup = display.newGroup()
	b.bg = display.newRect(
	 	bgGroup,
		options.x,
		options.y,
		textWidth + 2*options.paddingX + 2*options.borderWidth,
		textHeight + 2*options.paddingY + 2*options.borderWidth
	)

	b.bg.strokeWidth = options.borderWidth
	b.bg:setStrokeColor( unpack( options.borderColor ) )
	b.bg:setFillColor( unpack( options.fillColor ) )

	b.fillColor = options.fillColor
	b.fillColorPressed = options.fillColorPressed

	b.group = display.newGroup()
	b.group:insert( bgGroup )
	b.group:insert( fgGroup )

	options.parentGroup:insert( b.group )

	b.listener = EventListener:new()

	b.touchPanel:addEventListener( "tap", function( e ) return b:onTap( e ) end )
	b.touchPanel:addEventListener( "touch", function( e ) return b:onTouch( e ) end )

	return b
end

function Button:onTap( event )
	local channel = audio.play( tapSound )
	audio.setVolume( 1, { channel=channel } )

	self.listener:dispatchEvent( "press", nil )

	return true
end

function Button:onTouch( event )
	if event.phase == "began" then
		display.getCurrentStage():setFocus( event.target )
		self:setDepressed( true )

	elseif event.phase == "moved" then
		local panel = self.touchPanel
		if (panel.x - panel.width/2 < event.x and
		    event.x < panel.x + panel.width/2 and
		    panel.y - panel.height/2 < event.y and
			event.y < panel.y + panel.height/2) then
		   self:setDepressed( true )
	    else
		   self:setDepressed( false )
		end

	elseif event.phase == "ended" or event.phase == "cancelled" then
		display.getCurrentStage():setFocus( nil )
		self:setDepressed( false )

	end

	return true
end

function Button:setDepressed( yes )
	if yes then
		self.bg:setFillColor( unpack( self.fillColorPressed ) )
	else
		self.bg:setFillColor( unpack( self.fillColor ) )
	end
end

function Button:addEventListener( eventName, handlerFn )
	self.listener:addEventListener( eventName, handlerFn )
end

function Button:removeSelf()
	self.group:removeSelf()
	self.listener:clear()
end

return Button
