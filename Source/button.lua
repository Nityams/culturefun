local EventListener = require( "Source.eventListener" )
local sounds = require( "Source.sounds" )

local allowance = 30  -- pixels around the button that still trigger it

sounds:defineSound( "Button Up", "Assets/Sounds/Menu/Button Up.wav", 0.9 )
sounds:defineSound( "Button Down", "Assets/Sounds/Menu/Button Down.wav", 1 )

local Button = {}

-- Arguments: parentGroup, font, fontSize, fontColor, text, x, y,
--            paddingX, paddingY, width, height, [only two of these four needed]
--            fillColor, fillColorPressed,
--            borderWidth, borderColor
function Button:new( options )
	-- b inherits from Button
	local b = {}
	setmetatable( b, self )
	self.__index = self

	local fgGroup = display.newGroup()
	b.text = display.newText(
		fgGroup,
		options.text,
		options.x, options.y,
		options.font, options.fontSize
	)
	b.text:setFillColor( unpack( options.fontColor ) )

	local boxWidth
	local boxHeight

	if options.width ~= nil then
		boxWidth = options.width + 2*options.borderWidth
	else
		boxWidth = b.text.width + 2*options.paddingX + 2*options.borderWidth
	end

	if options.height ~= nil then
		boxHeight = options.height + 2*options.borderWidth
	else
		boxHeight = b.text.height + 2*options.paddingY + 2*options.borderWidth
	end

	b.touchPanel = display.newRect(
	 	fgGroup,
		options.x, options.y,
		boxWidth + 2*allowance, boxHeight + 2*allowance
	)
	b.touchPanel.isVisible = false
	b.touchPanel.isHitTestable = true

	local bgGroup = display.newGroup()
	b.bg = display.newRect(
	 	bgGroup,
		options.x, options.y,
		boxWidth, boxHeight
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
	b.focused = false
	b.depressed = false
	b.enabled = true

	-- Read-only! Changing them does not change the location of the button.
	b.x = options.x
	b.y = options.y

	b.touchPanel:addEventListener( "touch", function( e ) return b:onTouch( e ) end )

	return b
end

function Button:setText( text )
	self.text.text = text
	-- TODO: Recompute sizes of bg and touchPanel based on text's size.
end

function Button:onPress( event )
	sounds:play( "Button Up" )
	self.listener:dispatchEvent( "tap", nil )

	return true
end

function Button:onTouch( event )
	if not self.enabled then
		return
	end

	if event.phase == "began" then
		self:setDepressed( true )

		display.getCurrentStage():setFocus( event.target )
		self.focused = true

	elseif event.phase == "moved" then
		if self.focused then
			self:setDepressed( self:contains( event.x, event.y ) )
		end

	elseif event.phase == "ended" or event.phase == "cancelled" then
		display.getCurrentStage():setFocus( nil )
		self:setDepressed( false )

		if self.focused and self:contains( event.x, event.y ) then
			self:onPress()
		end

		self.focused = false

	elseif event.phase == "ended" or event.phase == "cancelled" then
		display.getCurrentStage():setFocus( nil )
		self:setDepressed( false )

		self.focused = false

	end

	return true
end

function Button:contains( x, y )
	local panel = self.touchPanel
	return (panel.x - panel.width/2 < x and
	        panel.y - panel.height/2 < y and
	        x < panel.x + panel.width/2 and
		    y < panel.y + panel.height/2)
end

function Button:setDepressed( yes )
    if self.depressed == false and yes == true then
		sounds:play( "Button Down" )
	end

	self.depressed = yes

	if yes then
		self.bg:setFillColor( unpack( self.fillColorPressed ) )
	else
		self.bg:setFillColor( unpack( self.fillColor ) )
	end
end

function Button:addEventListener( eventName, handlerFn )
	self.listener:addEventListener( eventName, handlerFn )
end

function Button:clearEventListeners()
	self.listener:clear()
end

function Button:removeSelf()
	self.group:removeSelf()
	self.listener:clear()
end

return Button
