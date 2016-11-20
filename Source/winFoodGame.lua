local composer = require( "composer" )
local sounds = require( "Source.sounds" )
local wallet = require( "Source.wallet" )


-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

local scene = composer.newScene()


local function returnToMenu()
	audio.fadeOut( 500 )
	audio.stopWithDelay( 500 )
	composer.gotoScene( "Source.menu" )
end

local function returnToGame()
	audio.fadeOut( 500 )
	audio.stopWithDelay( 500 )
	composer.gotoScene( "Source.difficultySelector" )
end

local function returnToWallet()
	audio.fadeOut( 500 )
	audio.stopWithDelay( 500 )
	composer.gotoScene( "Source.passport" )
end



local function setBackground()
	sounds.defineSound( "Win Theme", "Assets/Sounds/FlagGame/YAY_FX.mp3", 1	 )
	sounds.play( "Win Theme" )
	-- background = display.newRect(sceneGroup,0,0,4,3)
	-- background.x = display.contentWidth / 2
	-- background.y = display.contentHeight / 2
	-- background:scale(500,500)

	background = display.newImage( sceneGroup, "Assets/Images/FoodGame/foodBack.png")
	background.x = display.contentCenterX
	background.y = display.contentCenterY
	background:scale(1.9,2.5)

	local exit = display.newImageRect( sceneGroup, "Assets/Images/FoodGame/backtoMenu2.png", 200, 100 )--11
	exit.y = display.contentCenterY - display.contentCenterY / 2
	exit.x = display.contentCenterX - display.contentCenterX / 2 - 15
	exit:addEventListener("tap", returnToMenu)

	local returnbtn = display.newImageRect( sceneGroup, "Assets/Images/FoodGame/returnbtn.png", 220, 100 )--11
	returnbtn.y = display.contentCenterY - display.contentCenterY / 2
	returnbtn.x = display.contentCenterX + display.contentCenterX / 2
	returnbtn:addEventListener("tap", returnToGame)

	local character_one = display.newImage(sceneGroup,"Assets/Images/FoodGame/bear.png")
	character_one:scale(0.45,0.45)
	character_one.x = display.contentCenterX + display.contentCenterX/2 + 40
	character_one.y = display.contentCenterY + 20

	local winBox = display.newImage(sceneGroup,"Assets/Images/FoodGame/winBox.png" )
	winBox.x = display.contentCenterX - 40
	winBox.y = display.contentCenterY + 20
	winBox:scale(0.57,0.66)

	local myCoins = display.newImageRect(sceneGroup, "Assets/Images/FoodGame/myCoins.png", 220, 100)
	myCoins.y = winBox.y + 170
	myCoins.x = winBox.x
	myCoins:addEventListener("tap", returnToWallet)
end

local function showCoins(difficulty)
	if difficulty == 1 then
		coin = display.newImage( sceneGroup, "Assets/Images/FoodGame/c1.png")
		winText = display.newText(sceneGroup,"You won 100 gold coins")--, display.contentCenterX)-- display.contentCenterY + 20, native.systemFont, 30 )
		wallet.addCoins( 100 )
	elseif difficulty == 2 then
		coin = display.newImage( sceneGroup, "Assets/Images/FoodGame/c2.png")
		winText = display.newText(sceneGroup, "You won 200 gold coins")--, display.contentCenterX)-- display.contentCenterY +20, native.systemFont, 30 )
		wallet.addCoins( 200 )
	elseif difficulty == 3 then
		coin = display.newImage( sceneGroup, "Assets/Images/FoodGame/c3.png")
		winText = display.newText(sceneGroup, "You won 300 gold coins", display.contentCenterX, display.contentCenterY +20, native.systemFont, 30 )
		wallet.addCoins( 300 )
	else
		print("nothing to see here")
	end
	coin.x = display.contentCenterX - 20
	coin.y = display.contentCenterY + 5
	coin:scale(0.3,0.3)
	winText.x = coin.x - 10
	winText.y = coin.y + 80
	winText:setFillColor(0,0,0)

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


-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

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
