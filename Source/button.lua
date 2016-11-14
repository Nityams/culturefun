local EventListener = require( "Source.eventListener" )
local sounds = require( "Source.sounds" )
local util = require( "Source.util" )

local DEFAULT_ALLOWANCE = 30  -- pixels around the button that still trigger it

sounds.defineSound( "Button Up", "Assets/Sounds/Menu/Button Up.wav", 0.9 )
sounds.defineSound( "Button Down", "Assets/Sounds/Menu/Button Down.wav", 1 )


--
-- class TextButtonGraphics
--

local TextButtonGraphics = {}

function TextButtonGraphics:new( options )
	-- g inherits from TextButtonGraphics
	local g = {}
	setmetatable( g, self )
	self.__index = self

	g.fillColor = options.fillColor
	g.fillColorPressed = options.fillColorPressed

	g.group = display.newGroup()

	-- Create text.
	g.text = display.newText(
		g.group,
		options.text,
		options.x, options.y,
		options.font, options.fontSize
	)
	g.text:setFillColor( unpack( options.fontColor ) )

	-- Compute button's width/height.
	local boxWidth
	local boxHeight

	if options.width ~= nil then
		boxWidth = options.width + 2*options.borderWidth
	else
		boxWidth = g.text.width + 2*options.paddingX + 2*options.borderWidth
	end

	if options.height ~= nil then
		boxHeight = options.height + 2*options.borderWidth
	else
		boxHeight = g.text.height + 2*options.paddingY + 2*options.borderWidth
	end

	-- Save width and height.
	g.width = boxWidth
	g.height = boxHeight

	-- Create background fill and border.
	g.bg = display.newRect(
		g.group,
		options.x, options.y,
		boxWidth, boxHeight
	)
	g.bg.strokeWidth = options.borderWidth
	g.bg:setStrokeColor( unpack( options.borderColor ) )
	g.bg:setFillColor( unpack( options.fillColor ) )

	-- Bring text to top, above background.
	g.group:insert( g.text )

	return g
end

function TextButtonGraphics:setDepressed( yes )
	if yes then
		self.bg:setFillColor( unpack( self.fillColorPressed ) )
	else
		self.bg:setFillColor( unpack( self.fillColor ) )
	end
end

function TextButtonGraphics:setText( text )
	self.text.text = text
	-- TODO: Recompute size of bg based on text's new size.
end

function TextButtonGraphics:setX( x )
	self.text.x = x
end

function TextButtonGraphics:setY( y )
	self.text.y = y
end


--
-- class ImageButtonGraphics
--

local ImageButtonGraphics = {}

function ImageButtonGraphics:new( options )
	-- g inherits from ImageButtonGraphics
	local g = {}
	setmetatable( g, self )
	self.__index = self

	-- Width and height are differences in X and Y between image corners.
	g.width = options.width
	g.height = options.height

	g.image = options.image
	g.imagePressed = options.imagePressed

	g.group = display.newGroup()

	g.group:insert( g.image )
	g.group:insert( g.imagePressed )

	g.image.x = options.x
	g.image.y = options.y
	g.imagePressed.x = options.x
	g.imagePressed.y = options.y

	if options.alpha then
		g.image.alpha = options.alpha
		g.imagePressed.alpha = options.alpha
	end

	g:setDepressed( false )

	return g
end

function ImageButtonGraphics:setDepressed( yes )
	self.image.isVisible = not yes
	self.imagePressed.isVisible = yes
end

function ImageButtonGraphics:getRotation()
	return self.image.rotation
end

function ImageButtonGraphics:setRotation( rotation )
	self.image.rotation = rotation
	self.imagePressed.rotation = rotation
end

function ImageButtonGraphics:setX( x )
	self.image.x = x
	self.imagePressed.x = x
end

function ImageButtonGraphics:setY( y )
	self.image.y = y
	self.imagePressed.y = y
end


--
-- class Button
--

local Button = {}

function Button.preload()
	sounds.loadSound( "Button Up" )
	sounds.loadSound( "Button Down" )
end

-- Button:newTextButton()
-- Arguments: group, font, fontSize, fontColor, text, x, y,
--            paddingX, paddingY, width, height, [only two of these four needed]
--            fillColor, fillColorPressed,
--            borderWidth, borderColor,
--            allowance [optional]
-- Returns: Button
function Button:newTextButton( options )
	local graphics = TextButtonGraphics:new( options )
	return Button:new( graphics, options )
end

-- Button:newImageButton()
-- Arguments: group, image, imagePressed, x, y, width, height,
--            alpha [optional],
--            allowance [optional]
-- Returns: Button
function Button:newImageButton( options )
	local graphics = ImageButtonGraphics:new( options )
	return Button:new( graphics, options )
end

function Button:new( graphics, options )
	-- b inherits from Button
	local b = {}
	setmetatable( b, self )

	b.listener = EventListener:new()
	b.focused = false
	b.wantDepressed = false
	b.depressed = false
	b.enabled = true

	b.__x = options.x
	b.__y = options.y

	b.graphics = graphics

	b.group = display.newGroup()
	options.group:insert( b.group )

	-- Insert graphics
	b.group:insert( graphics.group )

	-- Insert touch panel above graphics
	local allowance = (options.allowance or DEFAULT_ALLOWANCE)

	b.touchPanel = display.newRect(
		b.group,
		options.x, options.y,
		graphics.width + 2*allowance, graphics.height + 2*allowance
	)
	b.touchPanel.isVisible = false
	b.touchPanel.isHitTestable = true

	b.touchPanel:addEventListener( "touch", function( e )
		return b:onTouch( e )
	end)

	return b
end

function Button:setText( text )
	if self.graphics.setText ~= nil then
		self.graphics:setText( text )
		-- TODO: Recompute size of touchPanel based on text's new size.
	else
		print( "Error: Button does not have setText() method!" )
	end
end

function Button:onPreTap( event )
	self.listener:dispatchEvent( "pretap", nil )
end

function Button:onTap( event )
	sounds.play( "Button Up" )
	self.listener:dispatchEvent( "tap", nil )
end

function Button:onTouch( event )
	if not self.enabled then
		return
	end

	if event.phase == "began" then
		self.wantDepressed = true
		self:updateDepressed()

		display.getCurrentStage():setFocus( event.target )
		self.focused = true

	elseif event.phase == "moved" and self.focused then
		self.wantDepressed = self:contains( event.x, event.y )
		self:updateDepressed()

	elseif event.phase == "ended" and self.focused then
		display.getCurrentStage():setFocus( nil )

		if self.focused and self:contains( event.x, event.y ) then
			self:onPreTap()
			util.nextFrame(function()
				-- Make sure we show the depressed graphic for at least one
				-- frame before calling onTap(), which might be an expensive
				-- operation. We'd like to freeze on the depressed graphic if
				-- possible.
				self:onTap()
			end)
		end

		self.wantDepressed = false
		util.nextFrame(function()
			-- If "began" and "ended" came in during the same frame, wait
			-- next frame before resetting our graphics.
			self:updateDepressed()
		end)

		self.focused = false

	else  -- event.phase == "cancelled" or self.focused == false
		display.getCurrentStage():setFocus( nil )
		self.focused = false

		self.wantDepressed = false
		self:updateDepressed()

	end

	return true
end

function Button:contains( x, y )
	local panel = self.touchPanel
	return util.contains(
		panel.x - panel.width/2, panel.x + panel.width/2,
        panel.y - panel.height/2, panel.y + panel.height/2,
		x, y
	)
end

function Button:updateDepressed()
    if self.depressed == false and self.wantDepressed == true then
		sounds.play( "Button Down" )
	end

	self.depressed = self.wantDepressed

	self.graphics:setDepressed( self.depressed )
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

function Button:getRotation()
	if self.graphics.getRotation then
		return self.graphics:getRotation()
	else
		return nil
	end
end

function Button:setRotation( rotation )
	if self.graphics.setRotation then
		self.graphics:setRotation( rotation )
	end
end

function Button:getX()
	return self.__x
end

function Button:setX( x )
	self.touchPanel.x = x
	self.graphics:setX( x )
end

function Button:getY()
	return self.__y
end

function Button:setY( y )
	self.touchPanel.y = y
	self.graphics:setY( y )
end

local getters = {
	rotation = function( button ) return button:getRotation() end,
	x = function( button ) return button:getX() end,
	y = function( button ) return button:getY() end
}

local setters = {
	rotation = function( button, val ) button:setRotation( val ) end,
	x = function( button, val ) button:setX( val ) end,
	y = function( button, val ) button:setY( val ) end
}

Button.__index = function( button, key )
	if getters[key] then
		return getters[key]( button )
	else
		return Button[key]
	end
end

Button.__newindex = function( button, key, value )
	if setters[key] then
		setters[key]( button, value )
	else
		rawset( button, key, value )
	end
end

return Button
