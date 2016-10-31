local composer = require( "composer" )

local Button = require( "Source.button" )
local images = require( "Source.images" )

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

local scene = composer.newScene()

local countryNames = {
	"United States", -- 1
	"United Kingdom",
	"Canada",
	"South Korea",
	"Netherlands",
	"Japan",
	"Australia",
	"Vietnam",
	"Mexico",
	"Russia" -- 10
};

local countryFiles = {
	"Assets/Images/Flags/United_States_Flag.png",
	"Assets/Images/Flags/United_Kingdom_Flag.png",
	"Assets/Images/Flags/Canada_Flag.png",
	"Assets/Images/Flags/South_Korea_Flag.png",
	"Assets/Images/Flags/Netherlands_Flag.png",
	"Assets/Images/Flags/Japan_Flag.png",
	"Assets/Images/Flags/Australia_Flag.png",
	"Assets/Images/Flags/Vietnam_Flag.png",
	"Assets/Images/Flags/Mexico_Flag.png",
	"Assets/Images/Flags/Russia_Flag.png"
};

images.defineImage( "Book", "Passport/Book 934x700.png", display.contentWidth, display.contentHeight )
images.defineImage( "Close Button", "Scene/11.png", display.contentWidth/20, display.contentHeight/14 )
images.defineImage( "Close Button Pressed", "Scene/11-pressed.png", display.contentWidth/20, display.contentHeight/14 )


-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )
	-- Code here runs when the scene is first created but has not yet appeared on screen

	local sceneGroup = self.view

	local whiteFill = display.newRect( sceneGroup, 0, 0, display.contentWidth, display.contentHeight )
	whiteFill.x = display.contentCenterX
	whiteFill.y = display.contentCenterY
	whiteFill:setFillColor( 1, 1, 1 )

	local book = images.get( sceneGroup, "Book" )
	book.x = display.contentCenterX
	book.y = display.contentCenterY

	local returnButton = Button:newImageButton{
		group = sceneGroup,
		image = images.get( sceneGroup, "Close Button" ),
		imagePressed = images.get( sceneGroup, "Close Button Pressed" ),
		x = display.contentWidth / 20,
		y = display.contentHeight / 5,
		width = images.width( "Close Button" ),
		height = images.height( "Close Button" ),
		alpha = 0.5
	}
	returnButton:addEventListener( "tap", function()
		composer.gotoScene("Source.menu")
	end)
end


-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen

	end
end


-- hide()
function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is on screen (but is about to go off screen)

	elseif ( phase == "did" ) then
		-- Code here runs immediately after the scene goes entirely off screen

	end
end


-- destroy()
function scene:destroy( event )

	local sceneGroup = self.view
	-- Code here runs prior to the removal of scene's view

end


-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------

return scene
