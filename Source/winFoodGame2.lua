local composer = require( "composer" )
local sounds = require( "Source.sounds" )
local wallet = require( "Source.wallet" )
local Button = require "Source.button"
local images = require( "Source.images" )

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
images.defineImage( "toMenu",  "Assets/Images/FoodGame/backtoMenu2.png", 200, 100 )
images.defineImage( "toPassport", "Assets/Images/FoodGame/myCoins.png", 220, 100 )
images.defineImage( "togame",  "Assets/Images/FoodGame/returnbtn.png", 220, 100 )

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
  sounds.defineSound( "Win Theme", "Assets/Sounds/FlagGame/YAY_FX.mp3", 1 )
  sounds.play( "Win Theme" )

  background = display.newImage( sceneGroup, "Assets/Images/FoodGame/foodBack.png")
  background.x = display.contentCenterX
  background.y = display.contentCenterY
  background:scale(1.9,2.5)

  local character_one = display.newImage(sceneGroup,"Assets/Images/FoodGame/bear.png")
  character_one:scale(0.45,0.45)
  character_one.x = display.contentCenterX + display.contentCenterX/2 + 40
  character_one.y = display.contentCenterY + 20

  local winBox = display.newImage(sceneGroup,"Assets/Images/FoodGame/winBox.png" )
  winBox.x = display.contentCenterX - 40
  winBox.y = display.contentCenterY + 20
  winBox:scale(0.57,0.66)
end

local function showCoins(difficulty)
  if difficulty == 1 then
    coin = display.newImage( sceneGroup, "Assets/Images/FoodGame/c1.png")
    winText = display.newText(sceneGroup,"You won 100 gold coins", display.contentCenterX, display.contentCenterY + 20, native.systemFont, 30 )
    wallet.addCoins( 100 )
  elseif difficulty == 2 then
    coin = display.newImage( sceneGroup, "Assets/Images/FoodGame/c2.png")
    winText = display.newText(sceneGroup, "You won 200 gold coins", display.contentCenterX, display.contentCenterY +20, native.systemFont, 30 )
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
end

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )
  sceneGroup = self.view
  -- Code here runs when the scene is first created but has not yet appeared on screen
  startGame()
  self.toFoodButton = Button:newImageButton{
    group = uiGroup,
    image = display.newImage( sceneGroup,"Assets/Images/FoodGame/backtoMenu2.png",200,100),    -- wimages.get("togame"),
    x = display.contentCenterX,
    y = display.contentCenterY + 50,
    --width = images.width( "togame" ), -- may be hae syntax error
    --height = images.height( "togame" )
  }

  self.toPassportButton = Button:newImageButton{
    group = uiGroup,
    image = display.newImage( sceneGroup,"Assets/Images/FoodGame/backtoMenu2.png",200,100),--images.get("toPassport"),
    x = display.contentCenterX,
    y = display.contentCenterY + 50,
  --  width = images.width( "toPassport" ),
  --  height = images.height( "toPassport")
  }
  self.toMenuButton = Button:newImageButton{
    group = uiGroup,
    image = display.newImage( sceneGroup,"Assets/Images/FoodGame/backtoMenu2.png",200,100),--images.get("toMenu"),
    x = display.contentCenterX,
    y = display.contentCenterY + 50,
    --width = images.width("toMenu"),
    --height = images.height("toMenu")
  }
  showCoins(composer.getVariable( "difficulty" ))
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
