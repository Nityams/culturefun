local composer = require( "composer" )

local scene = composer.newScene()


local setBackground
local sceneGroup
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

local function returnToMenu()
	composer.gotoScene( "Source.menu" )
end



-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
function setBackground()

  background = display.newRect(sceneGroup,0,0,4,3)
  background.x = display.contentWidth / 2
  background.y = display.contentHeight / 2
  background:scale(500,500)
end

local function startGame()
  setBackground()
  local difficulty = composer.getVariable( "difficulty" )
  if difficulty == 1 then
    winText = display.newText(sceneGroup, "Yay you win a coin and new food. Use this coin to travel around the world... 1", display.contentCenterX, display.contentCenterY, native.systemFont, 20 )
  elseif difficulty == 2 then
		winText = display.newText(sceneGroup, "Yay you win a coin and new food. Use this coin to travel around the world... 2", display.contentCenterX, display.contentCenterY, native.systemFont, 20 )
  elseif difficulty == 3 then
		winText = display.newText(sceneGroup, "Yay you win a coin and new food. Use this coin to travel around the world... 3", display.contentCenterX, display.contentCenterY, native.systemFont, 20 )
  else
		winText = display.newText(sceneGroup, "Yay you win a coin and new food. Use this coin to travel around the world... 0", display.contentCenterX, display.contentCenterY, native.systemFont, 20 )
  end
  winText:setFillColor(0,0,0)
end

-- create()
function scene:create( event )

	sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen
startGame()
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
		--timer.performWithDelay( 2000, returnToMenu )
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
