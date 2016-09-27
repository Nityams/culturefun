
local composer = require( "composer" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

local countryNames = {
	"Egypt",
	"Honduras",
	"Hungary",
	"Madagascar",
	"Mexico",
	"Mongolia",
	"Morocco",
	"New Zealand",
	"Peru",
	"Philippines",
	"Russia",
	"South Africa",
	"Switzerland",
	"Taiwan",
	"Ukraine",
	"United Kingdom",
	"United States",
	"Vietnam"
};

local countryFiles = {
	"Assets/Images/Flags/Egypt_Flag.png",  -- a few of these images have a large white border that needs to be cropped; they came this way
	"Assets/Images/Flags/Honduras_Flag.png",
	"Assets/Images/Flags/Hungary_Flag.png",
	"Assets/Images/Flags/Madagascar_Flag.png",
	"Assets/Images/Flags/Mexico_Flag.png",
	"Assets/Images/Flags/Mongolia_Flag.png",
	"Assets/Images/Flags/Morocco_Flag.png",
	"Assets/Images/Flags/New_Zealand_Flag.png",
	"Assets/Images/Flags/Peru_Flag.png",
	"Assets/Images/Flags/Philippines_Flag.png",
	"Assets/Images/Flags/Russia_Flag.png",
	"Assets/Images/Flags/South_Africa_Flag.png",
	"Assets/Images/Flags/Switzerland_Flag.png",
	"Assets/Images/Flags/Taiwan_Flag.png",
	"Assets/Images/Flags/Ukraine_Flag.png",
	"Assets/Images/Flags/United_Kingdom_Flag.png",
	"Assets/Images/Flags/United_States_Flag.png",
	"Assets/Images/Flags/Vietnam_Flag.png"
};

local function returnToMenu()
	composer.gotoScene( "Source.menu" )
end



-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen

	local flagImage = display.newImageRect( sceneGroup, countryFiles[5], 358, 206 )
	flagImage.x = display.contentCenterX
	flagImage.y = 230

	display.newText( sceneGroup, "This is the flag game", display.contentCenterX, display.contentCenterY, native.systemFont, 44 )
end


-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen

		-- In two seconds return to the menu
		timer.performWithDelay( 2000, returnToMenu )
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
