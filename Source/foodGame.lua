local composer = require( "composer" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

local function returnToMenu()
  composer.gotoScene( "Source.menu" )
  composer.removeScene( "Source.foodGame" )
end

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
local setBackground
local callCharacters
local setFoods
local callGreetings
local flagAnimation
local startGame
local eventRemover

local currentWidth
local currentHeight
local sceneGroup
local character_one
local randomCountryNumber

-- local closeScene  -- testing

--creating main table
local Countries = require "Countries"
-- other scenes from the game:

-- create()
function scene:create( event )

  -- Temporary Music
  local backgroundMusicChannel = audio.play(
    audio.loadStream("Assets/Sounds/Whimsical-Popsicle.mp3"),
    { channel1 = 1, loops =- 1, fadein = 5000 }
  )

  sceneGroup = self.view
  currentWidth = display.contentWidth
  currentHeight = display.contentHeight
  -- `Code here runs when the scene is first created but has not yet appeared on screen

  --
  startGame()
end

local function resetGame()
  randomCountryNumber = 0
  secondRandom = 0
  path = nil
end

function startGame()
  resetGame()
  randomCountryNumber = math.random(1,10) -- selecting random country from Countries module /table
  setBackground()
  setFoods()
  callCharacters()
end

function setBackground()
  local background = display.newImageRect(sceneGroup, "Assets/Images/FoodGame/Background2.jpg",currentWidth, currentHeight )
  background.x = display.contentCenterX
  background.y = display.contentCenterY

  local replayButton = display.newImageRect( sceneGroup, "Assets/Images/Scene/11.png", 50, 50 )
  replayButton.y = display.contentCenterY - display.contentCenterY/1.6
  replayButton.x = display.contentCenterX + display.contentCenterX / 2 - 50

  replayButton:addEventListener("tap", returnToMenu)
end

function setFoods()
  -- local randomCountryNumber = math.random(1,10) -- selecting random country from Countries module /table
  randomFood = math.random(1, 4) -- selecting random( out of 4) place in the food selection grid
  print("****** random grid :", randomFood)
  -- Setting random countries i.e, not the correct one on the food grid

  secondRandom = (randomCountryNumber) % 10 + 1 -- random country for food1
  path = Countries[secondRandom].flag
  food1 = display.newImageRect(sceneGroup, path, currentWidth / 5, currentHeight / 5)
  food1_name = Countries[secondRandom].name

  secondRandom = (secondRandom) % 10 + 1 -- random country for food 2
  path = Countries[secondRandom].flag
  food2 = display.newImageRect(sceneGroup, path, currentWidth / 5, currentHeight / 5)
  food2_name = Countries[secondRandom].name

  secondRandom = (secondRandom ) % 10 + 1 -- random country for food 3
  path = Countries[secondRandom].flag
  food3 = display.newImageRect(sceneGroup, path, currentWidth / 5, currentHeight / 5)
  food3_name = Countries[secondRandom].name

  secondRandom = (secondRandom ) % 10 + 1 -- random country for food 4
  path = Countries[secondRandom].flag
  food4 = display.newImageRect(sceneGroup, path, currentWidth / 5, currentHeight / 5)
  food4_name = Countries[secondRandom].name

  -- Setting the correct country on the random food grid

  local correctPath = Countries[randomCountryNumber].flag
  print("******* correctPath: ", Countries[randomCountryNumber].name)
  if randomFood == 1 then
    food1:removeSelf()
    food1 = display.newImageRect(sceneGroup, correctPath, currentWidth / 5, currentHeight / 5)
    food1_name = Countries[randomCountryNumber].name
  elseif randomFood == 2 then
    food2:removeSelf()
    food2 = display.newImageRect(sceneGroup, correctPath, currentWidth / 5, currentHeight / 5)
    food2_name = Countries[randomCountryNumber].name
  elseif randomFood == 3 then
    food3:removeSelf()
    food3 = display.newImageRect(sceneGroup, correctPath, currentWidth / 5, currentHeight / 5)
    food3_name = Countries[randomCountryNumber].name
  else
    food4:removeSelf()
    food4 = display.newImageRect(sceneGroup, correctPath, currentWidth / 5, currentHeight / 5)
    food4_name = Countries[randomCountryNumber].name
  end

  -- Setting the positio of all four grid

  food1.alpha = 0; food2.alpha = 0; food3.alpha = 0; food4.alpha = 0;
  food1:scale(0,0); food2:scale(0,0); food3:scale(0,0); food4:scale(0,0);
  food1.x = display.contentCenterX + 50 ; food1.y = display.contentCenterY - display.contentCenterY / 8
  food2.x = food1.x + food1.width + 100; food2.y = food1.y
  food3.x = food1.x; food3.y = food1.y + food1.width
  food4.x = food2.x ; food4.y = food3.y

  -- setting the animation (pop up) for all the food in the grid
  local function food3Animation()
    transition.to(food3, { time = 200, alpha = 1, xScale = 1, yScale = 1, onComplete = food3Animation })
  end
  local function food4Animation()
    transition.to(food4, { time = 200, alpha = 1, xScale = 1, yScale = 1, onComplete = food3Animation })
  end
  local function food2Animation()
    transition.to(food2, { time = 200, alpha = 1, xScale = 1, yScale = 1, onComplete = food4Animation })
  end
  transition.to(food1, { time = 200, alpha = 1, xScale = 1, yScale = 1, onComplete = food2Animation })

  -- tap acrion listener and answer checker for all the foods in the grid

  food1:addEventListener("tap", function ()
      print("*** food1 pressed, food1 is ", food1_name, " and the answer is ", Countries[randomCountryNumber].name)
      if food1_name == Countries[randomCountryNumber].name then
        print("yay yay yay - 1")
        eventRemover()
      else
        print("nay nay nay - 1")
      end
    end )
  food2:addEventListener("tap", function ()
      print("*** food2 pressed, food2 is ", food2_name, " and the answer is ", Countries[randomCountryNumber].name)
      if food2_name == Countries[randomCountryNumber].name then
        print("yay yay yay -2")
        eventRemover()
      else
        print("nay nay nay - 2")
      end
    end )
  food3:addEventListener("tap", function ()
      print("*** food3 pressed, food3 is ", food3_name, " and the answer is ", Countries[randomCountryNumber].name)
      if food3_name == Countries[randomCountryNumber].name then
        print("yay yay yay - 3" )
        eventRemover()
      else
        print("nay nay nay - 3")
      end
    end )
  food4:addEventListener("tap", function ()
      print("*** food4 pressed, food4 is ", food4_name, " and the answer is ", Countries[randomCountryNumber].name)
      if food4_name == Countries[randomCountryNumber].name then
        print("yay yay yay -4")
        eventRemover()
      else
        print("nay nay nay - 4")
      end
    end )
end

function eventRemover()
  display.remove( food1 )
  display.remove( food2 )
  display.remove( food3 )
  display.remove( food4 )
  leaveCharacters()
end

function leaveCharacters()
  -- character_one = display.newImage(sceneGroup,"Assets/Images/FoodGame/boy.png")
  display.remove( dialogBox )
  transition.to(character_one, {
    x = currentWidth/10 * -1,
    time = 500,
    alpha = 0,
    transition = easing.outQuad,
    onComplete = startGame
  })
end

function test()
  print("leave")
end

function callCharacters()
  character_one = display.newImage(sceneGroup,"Assets/Images/FoodGame/boy.png")
  character_one.y = display.contentCenterY
  character_one.x = 0
  transition.to(character_one,{time = 500, x = display.contentCenterX/2.5, onComplete = callGreetings})
end

function callGreetings()
  print("****** greeings: ",randomCountryNumber,":", Countries[randomCountryNumber].name)
  path = Countries[randomCountryNumber].greetings_food
  print(path)
  dialogBox = display.newImage(sceneGroup,path)
  dialogBox.xScale = 0.5
  dialogBox.yScale = 0.5
  dialogBox.y = display.contentCenterY - display.contentCenterY/1.9
  dialogBox.x = character_one.x
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
  audio.stop(1)

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
