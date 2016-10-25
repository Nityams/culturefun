local EventListener = require( "Source.eventListener" )

local Button = {}

-- Arguments: parentGroup, font, fontSize, fontColor, text, x, y,
--            paddingX, paddingY, fillColor, borderWidth, borderColor
function Button:new( options )
	-- b inherits from Button
	local b = {}
	setmetatable( b, self )
	self.__index = self

	b.textGroup = display.newGroup()
	b.text = display.newText( b.textGroup, options.text, options.x, options.y, options.font, options.fontSize )
	b.text:setFillColor( unpack( options.fontColor ) )

	textWidth = b.text.width
	textHeight = b.text.height

	b.bgGroup = display.newGroup()
	b.bg = display.newRect(
	 	b.bgGroup,
		options.x,
		options.y,
		textWidth + 2*options.paddingX + 2*options.borderWidth,
		textHeight + 2*options.paddingY + 2*options.borderWidth
	)

	b.bg.strokeWidth = options.borderWidth
	b.bg:setStrokeColor( unpack( options.borderColor ) )
	b.bg:setFillColor( unpack( options.fillColor ) )

	b.group = display.newGroup()
	b.group:insert( b.bgGroup )
	b.group:insert( b.textGroup )

	options.parentGroup:insert( b.group )

	b.listener = EventListener:new()

	b.text:addEventListener( "tap", function( e ) return b:onTap( e ) end )
	b.bg:addEventListener( "tap", function( e ) return b:onTap( e ) end )

	return b
end

function Button:onTap( event )
	self.listener:dispatchEvent( "press", nil )
	return true
end

function Button:addEventListener( eventName, handlerFn )
	self.listener:addEventListener( eventName, handlerFn )
end

function Button:removeSelf()
	self.group:removeSelf()
	self.listener:clear()
end

return Button
