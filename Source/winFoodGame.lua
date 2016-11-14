local composer = require( "composer" )
local sounds = require( "Source.sounds" )
local wallet = require( "Source.wallet" )

local scene = composer.newScene()


local setBackground
local sceneGroup
local showCoins
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

local function returnToMenu()
	audio.stop(  )
	composer.gotoScene( "Source.menu" )
	composer.removeScene( "Source.winFoodGame" )
end



-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
function setBackground()
	sounds.defineSound( "Win Theme", "Assets/Sounds/FlagGame/YAY_FX.mp3", 1	 )
	  sounds.play( "Win Theme" )
  background = display.newRect(sceneGroup,0,0,4,3)
  background.x = display.contentWidth / 2
  background.y = display.contentHeight / 2
  background:scale(500,500)

	local replayButton = display.newImageRect( sceneGroup, "Assets/Images/Scene/return.png", 100, 100 )--11
	replayButton.y = display.contentCenterY - display.contentCenterY / 1.5
	replayButton.x = display.contentCenterX - display.contentCenterX / 2.3
	replayButton:addEventListener("tap", returnToMenu)
end

function showCoins(difficulty)
  if difficulty == 1 then
    coin = display.newImage( sceneGroup, "Assets/Images/FoodGame/c1.png")
   winText = display.newText(sceneGroup,"You won 200 gold coins", display.contentCenterX, display.contentCenterY + 20, native.systemFont, 30 )
	wallet.addCoins( 200 )
elseif difficulty == 2 then
  coin = display.newImage( sceneGroup, "Assets/Images/FoodGame/c2.png")
  winText = display.newText(sceneGroup, "You won 500 gold coins", display.contentCenterX, display.contentCenterY +20, native.systemFont, 30 )
	wallet.addCoins( 500 )
elseif difficulty == 3 then
coin = display.newImage( sceneGroup, "Assets/Images/FoodGame/c3.png")
winText = display.newText(sceneGroup, "You won 750 gold coins", display.contentCenterX, display.contentCenterY +20, native.systemFont, 30 )
	wallet.addCoins( 750 )
else
	print("nothing to see here")
end
coin.x = display.contentCenterX
coin.y = display.contentCenterY - 50
coin:scale(0.3,0.3)
winText:setFillColor(0,0,31)

end

local function startGame()

  setBackground()
	showCoins(composer.getVariable( "difficulty" ))
  -- if difficulty == 1 then
  --   winText = display.newText(sceneGroup, "Yay you win a coin and new food. Use this coin to travel around the world... 1", display.contentCenterX, display.contentCenterY, native.systemFont, 20 )
  -- elseif difficulty == 2 then
	-- 	winText = display.newText(sceneGroup, "Yay you win a coin and new food. Use this coin to travel around the world... 2", display.contentCenterX, display.contentCenterY, native.systemFont, 20 )
  -- elseif difficulty == 3 then
	-- 	winText = display.newText(sceneGroup, "Yay you win a coin and new food. Use this coin to travel around the world... 3", display.contentCenterX, display.contentCenterY, native.systemFont, 20 )
  -- else
	-- 	winText = display.newText(sceneGroup, "Yay you win a coin and new food. Use this coin to travel around the world... 0", display.contentCenterX, display.contentCenterY, native.systemFont, 20 )
  -- end
  -- winText:setFillColor(0,0,0)
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
