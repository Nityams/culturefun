local composer = require( "composer" )

local Countries = require "Countries"
local images = require( "Source.images" )
local sounds = require( "Source.sounds" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

images:define( "Neighborhood", "FoodGame/Intro.png", display.contentWidth, display.contentHeight )

local function gotoGame()
	composer.gotoScene("Source.foodGame")
end

local function bellsound()
	sounds:defineSound( "Door Bell", "Assets/Sounds/door_bell.wav", 0.6 )
	sounds:play( "Door Bell" )
end


-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

function scene:preload()
	return coroutine.create(function()
		images:preload( "Neighborhood" ); coroutine.yield()
	end)
end

-- create()
function scene:create( event )
	-- Code here runs when the scene is first created but has not yet appeared on screen

	local sceneGroup = self.view

	local fill = display.newRect( sceneGroup, 0, 0, display.contentWidth, display.contentHeight )
	fill.x = display.contentCenterX
	fill.y = display.contentCenterY
	fill:setFillColor( 1, 1, 1 )

	self.neighborhood = images:get( sceneGroup, "Neighborhood" )
	self.neighborhood.x = display.contentCenterX
	self.neighborhood.y = display.contentCenterY

end


-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

		self.neighborhood.alpha = 0
		transition.to( self.neighborhood, { time=800, alpha=1, onComplete=bellsound } )

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
