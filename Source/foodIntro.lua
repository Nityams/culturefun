
local composer = require( "composer" )


local Countries = require "Countries"
local sounds = require( "Source.sounds" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

local function returnToMenu()
	composer.gotoScene( "Source.menu" )
end

local function gotoGame()
	composer.gotoScene("Source.foodGame")
end

local function bellsound()
	sounds:defineSound( "Door Bell", "Assets/Sounds/door_bell.wav" )
	sounds:play( "Door Bell", 0.6 )
end
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )
	-- Code here runs when the scene is first created but has not yet appeared on screen

	local sceneGroup = self.view

	self.background = display.newImageRect(
		sceneGroup,
		"Assets/Images/FoodGame/Intro.png",
		display.contentWidth, display.contentHeight
	)
	self.background.x = display.contentCenterX
	self.background.y = display.contentCenterY

end


-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

		self.background.alpha = 0
		transition.to( self.background, { time=800, alpha=1, onComplete=bellsound } )

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen

		-- In two seconds go to the food game
		timer.performWithDelay( 2000, gotoGame )
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
