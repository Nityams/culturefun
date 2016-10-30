local composer = require( "composer" )

local musics = require( "Source.musics" )
local sounds = require( "Source.sounds" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

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
local checkScore
local checkStar
local correctAnswer
local starShine

local foodGroup

local currentWidth
local currentHeight
local sceneGroup
local character_one
local randomCountryNumber
local DEBUG = true -- toggle verbose debugging
local score = 0
local star1
local star2
local star3

local function returnToMenu()

  composer.gotoScene( "Source.menu" )
  composer.removeScene( "Source.foodGame" )
  foodGroup:removeSelf()
end


--creating main table
local Countries = require "Countries"
local foodChoices = {}
-- other scenes from the game:

-- Temporary Music
musics:defineMusic( "Food Theme", "Assets/Sounds/Music/Whimsical-Popsicle.mp3", 1, 5000 )
sounds:defineSound("Win","Assets/Sounds/win.wav",0.5 )
sounds:defineSound("starWin", "Assets/Sounds/starWin.wav",0.5)
-- create()
function scene:create( event )

  musics:play( "Food Theme" )

  sceneGroup = self.view
  currentWidth = display.contentWidth
  currentHeight = display.contentHeight
  foodGroup = display.newGroup()
  -- `Code here runs when the scene is first created but has not yet appeared on screen

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
  -- Could replace these lines with newFoods()
  setFoods()
  callCharacters()

  -- Initialize foodChoices
  for i=1,4 do
    if DEBUG then print("Populating choice ", i) end

    foodChoices[i] = Countries[i] -- placeholder country
    -- foodChoices[i] = {}
    -- for key,value in pairs(Countries[i]) do
    --   table.insert(foodChoices[i], key, value)
    --   if DEBUG then print("Added", key, value) end
    -- end

    if DEBUG then print("Added", foodChoices[i].name) end -- test if country can be retrieved
    -- Might want to recreate table and add image for retrieving to delete
  end

  --
  -- local time1 = display.newSprite(sceneGroup,mySheetTimer,sequenceTimer)
  -- time1.x = display.contentCenterX + display.contentCenterX /2
  -- time1.y = display.contentCenterY - display.contentCenterY /2
  -- time1:setSequence("1")
  -- time1:play()
end

local function newFoods()
  resetGame()
  randomCountryNumber = math.random(1,10)
  setFoods()
  callCharacters()
end

function setBackground()

  local background = display.newImageRect(sceneGroup, "Assets/Images/FoodGame/Background4.png",currentWidth, currentHeight )
  background.x = display.contentCenterX
  background.y = display.contentCenterY

  local replayButton = display.newImageRect( sceneGroup, "Assets/Images/Scene/return.png", 60, 60 )--11
  replayButton.y = display.contentCenterY - display.contentCenterY/1.5
  replayButton.x = display.contentCenterX - display.contentCenterX / 2 - 50

  replayButton:addEventListener("tap", returnToMenu)

  local pauseButton = display.newImageRect( sceneGroup, "Assets/Images/Scene/pause.png", 60 , 60 )--10
  pauseButton.y = replayButton.y
  pauseButton.x = replayButton.x - 100
  pauseButton:addEventListener("tap", function()
  audio.stop() end)

  local oven = display.newImageRect(sceneGroup, "Assets/Images/FoodGame/oven.png", currentWidth, currentHeight)
  oven.x = display.contentCenterX - display.contentCenterX /2
  oven.y = display.contentCenterY + display.contentCenterY /1.8
  oven:scale(0.5,0.22)

  local foodBack= display.newImageRect(sceneGroup, "Assets/Images/FoodGame/foodBack.png", currentWidth, currentHeight)
  foodBack.x = display.contentCenterX + display.contentCenterX /2
  foodBack.y = display.contentCenterY + replayButton.y/2
  foodBack:scale(0.5,0.58)
  checkScore()

end

function checkScore()
  --local scoreCounter = display.newImage(sceneGroup,"Assets/Images/FoodGame/timer/0.png", currentWidth/20,currentHeight/20)

  -- Shouldn't need these because dimensions are hard set at end
  -- local width = currentWidth/2
  -- local height = currentHeight/2

  if scoreCounter ~= nil then
      scoreCounter:removeSelf()
  end

  scoreCounter = display.newImage(sceneGroup, "Assets/Images/FoodGame/timer/0.png")

  -- User score on timer
  for timer=11,0,-1
  do
    if score % 12 == timer then
      if DEBUG then print("Timer is set to: ", timer) end
      -- Remove timer if drawn before
      if score > 0 then
        -- Redraw timer
        scoreCounter:removeSelf()
        scoreCounter = display.newImage(sceneGroup, string.format("Assets/Images/FoodGame/timer/%i.png", timer)
        )
      end
    end
  end

  -- Manually set x, y for all counters
  scoreCounter.x = display.contentCenterX - display.contentCenterX /2+6
  scoreCounter.y = display.contentCenterY + display.contentCenterY /2
  scoreCounter:scale(0.19,0.19)
  checkStar()
end

function checkStar()
  star1 = display.newImage(sceneGroup, "Assets/Images/FoodGame/starGrey.png", currentWidth, currentHeight)
  star2 = display.newImage(sceneGroup, "Assets/Images/FoodGame/starGrey.png", currentWidth, currentHeight)
  star3 = display.newImage(sceneGroup, "Assets/Images/FoodGame/starGrey.png", currentWidth, currentHeight)
  starShine()
  if score == 36 then
    display.remove( star1 )
    display.remove( star2 )
    display.remove( star3 )
    star1 = display.newImage(sceneGroup, "Assets/Images/FoodGame/star.png", currentWidth, currentHeight)
    star2 = display.newImage(sceneGroup, "Assets/Images/FoodGame/star.png", currentWidth, currentHeight)
    star3 = display.newImage(sceneGroup, "Assets/Images/FoodGame/star.png", currentWidth, currentHeight)
  elseif score >= 24 then
    display.remove( star1 )
    display.remove( star2 )
    star1 = display.newImage(sceneGroup, "Assets/Images/FoodGame/star.png", currentWidth, currentHeight)
    star2 = display.newImage(sceneGroup, "Assets/Images/FoodGame/star.png", currentWidth, currentHeight)
  elseif score >= 12 then
    display.remove( star1 )
    star1 = display.newImage(sceneGroup, "Assets/Images/FoodGame/star.png", currentWidth, currentHeight)
  else
  end
  star1.x = display.contentCenterX + display.contentCenterX /2 - 150
  star1.y = display.contentCenterY - display.contentCenterY/1.5 + 15

  star2.x = display.contentCenterX + display.contentCenterX /2
  star2.y = display.contentCenterY - display.contentCenterY/1.5+ 15

  star3.x = display.contentCenterX + display.contentCenterX /2 + 150
  star3.y = display.contentCenterY - display.contentCenterY/1.5+ 15

  star1:scale(0.5,0.5)
  star2:scale(0.5,0.5)
  star3:scale(0.5,0.5)

end

function starShine()
  if score == 12 then
    sounds:play("starWin")
    -- star1:scale(4,4)
    -- transition.to(star1,{time = 500, alpha = 1, xScale = 1, yScale = 1 })
    -- starShineAnimation(star1)
  elseif score == 24 then
    sounds:play("starWin")
    -- starShineAnimation()
  elseif score == 36 then
    sounds:play("starWin")
    -- starShineAnimation()
  else
  end
end


function setFoods()
  -- local randomCountryNumber = math.random(1,10) -- selecting random country from Countries module /table
  randomFood = math.random(1, 4) -- selecting random( out of 4) place in the food selection grid
  print("****** random grid :", randomFood)
  -- Setting random countries i.e, not the correct one on the food grid

  secondRandom = (randomCountryNumber) % 10 + 1 -- random country for food1
  path = Countries[secondRandom].flag
  food1 = display.newImageRect(foodGroup, path, currentWidth / 5, currentHeight / 5)
  food1_name = Countries[secondRandom].name

  secondRandom = (secondRandom) % 10 + 1 -- random country for food 2
  path = Countries[secondRandom].flag
  food2 = display.newImageRect(foodGroup, path, currentWidth / 5, currentHeight / 5)
  food2_name = Countries[secondRandom].name

  secondRandom = (secondRandom ) % 10 + 1 -- random country for food 3
  path = Countries[secondRandom].flag
  food3 = display.newImageRect(foodGroup, path, currentWidth / 5, currentHeight / 5)
  food3_name = Countries[secondRandom].name

  secondRandom = (secondRandom ) % 10 + 1 -- random country for food 4
  path = Countries[secondRandom].flag
  food4 = display.newImageRect(foodGroup, path, currentWidth / 5, currentHeight / 5)
  food4_name = Countries[secondRandom].name

  -- Setting the correct country on the random food grid

  local correctPath = Countries[randomCountryNumber].flag
  print("******* correctPath: ", Countries[randomCountryNumber].name)
  if randomFood == 1 then
    food1:removeSelf()
    food1 = display.newImageRect(foodGroup, correctPath, currentWidth / 5, currentHeight / 5)
    food1_name = Countries[randomCountryNumber].name
  elseif randomFood == 2 then
    food2:removeSelf()
    food2 = display.newImageRect(foodGroup, correctPath, currentWidth / 5, currentHeight / 5)
    food2_name = Countries[randomCountryNumber].name
  elseif randomFood == 3 then
    food3:removeSelf()
    food3 = display.newImageRect(foodGroup, correctPath, currentWidth / 5, currentHeight / 5)
    food3_name = Countries[randomCountryNumber].name
  else
    food4:removeSelf()
    food4 = display.newImageRect(foodGroup, correctPath, currentWidth / 5, currentHeight / 5)
    food4_name = Countries[randomCountryNumber].name
  end

  -- Setting the position of all four grid

  food1.alpha = 0; food2.alpha = 0; food3.alpha = 0; food4.alpha = 0;
  food1:scale(0.1,0.1); food2:scale(0.1,0.1); food3:scale(0.1,0.1); food4:scale(0.1,0.1);
  food1.x = display.contentCenterX + 125 ; food1.y = display.contentCenterY - display.contentCenterY / 8
  food2.x = food1.x + food1.width + 50; food2.y = food1.y
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
        correctAnswer()
      end
    end )
  food2:addEventListener("tap", function ()
      print("*** food2 pressed, food2 is ", food2_name, " and the answer is ", Countries[randomCountryNumber].name)
      if food2_name == Countries[randomCountryNumber].name then
        correctAnswer()
      end
    end )
  food3:addEventListener("tap", function ()
      print("*** food3 pressed, food3 is ", food3_name, " and the answer is ", Countries[randomCountryNumber].name)
      if food3_name == Countries[randomCountryNumber].name then
        correctAnswer()
      end
    end )
  food4:addEventListener("tap", function ()
      print("*** food4 pressed, food4 is ", food4_name, " and the answer is ", Countries[randomCountryNumber].name)
      if food4_name == Countries[randomCountryNumber].name then
        correctAnswer()
      end
    end )
end

function correctAnswer()
  local difficulty = composer.getVariable( "difficulty" )
  if difficulty == 1 then  -- Easy
      score = score + 3
  elseif difficulty == 2 then  -- Medium
      score = score + 2
  else  -- Hard
      score = score + 1
  end

  if(score ~= 12 and score ~= 24 and score ~=36) then
    sounds:play("Win")
  end
  checkScore()
  eventRemover()
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
      onComplete = newFoods
    })
end

function callCharacters()
  character_one = display.newImage(sceneGroup,"Assets/Images/FoodGame/deer.png")
  character_one.y = display.contentCenterY+15
  character_one.x = 0
  character_one:scale(1.3,1)
  transition.to(character_one,{time = 500, x = display.contentCenterX/2.5, onComplete = callGreetings})
end

function callGreetings()
  print("****** greeings: ",randomCountryNumber,":", Countries[randomCountryNumber].name)
  path = Countries[randomCountryNumber].greetings_food
  print(path)
  dialogBox = display.newImage(sceneGroup,path)
  dialogBox.xScale = 0.5
  dialogBox.yScale = 0.5
  dialogBox.y = display.contentCenterY - display.contentCenterY/2.5
  dialogBox.x = character_one.x - 30
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

    audio.fade( 500 )
    audio.stopWithDelay( 500 )

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
