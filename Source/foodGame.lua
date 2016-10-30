local composer = require( "composer" )

local musics = require( "Source.musics" )

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

--
-- local sheetTimer = {
-- width = 276,
-- height = 276,
-- numFrames = 4,
-- sheetContentWidth = 1345,
-- sheetContentHeight = 1010
-- };
-- local sequenceTimer = {
-- {
-- name = "1",
-- frame ={1},
-- loopCount = 0
-- },
-- {
-- name = "2",
-- frame ={4},
-- loopCount = 0
-- },
-- {
-- name = "1",
-- frame ={1},
-- loopCount = 0
-- },
-- };
-- local mySheetTimer = graphics.newImageSheet("Assets/Images/FoodGame/timer/timer.png", sheetTimer)

-- local closeScene -- testing

--creating main table
local Countries = require "Countries"
local choices = {}
-- other scenes from the game:

-- Temporary Music
musics:defineMusic( "Food Theme", "Assets/Sounds/Music/Whimsical-Popsicle.mp3", 1, 5000 )

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

-- local function resetGame()
--   randomCountryNumber = 0
--   secondRandom = 0
--   path = nil
-- end

function startGame()
  -- resetGame()
  -- randomCountryNumber = math.random(1,10) -- selecting random country from Countries module /table
  setBackground()
  -- Could replace these lines with newFoods()
  newFoods()

  -- local time1 = display.newSprite(sceneGroup,mySheetTimer,sequenceTimer)
  -- time1.x = display.contentCenterX + display.contentCenterX /2
  -- time1.y = display.contentCenterY - display.contentCenterY /2
  -- time1:setSequence("1")
  -- time1:play()
end

function newFoods()
  -- resetGame()
  setFoods()
  callCharacters()
end

function setBackground()

  local background = display.newImageRect(sceneGroup, "Assets/Images/FoodGame/Background4.png",currentWidth, currentHeight )
  background.x = display.contentCenterX
  background.y = display.contentCenterY

  local replayButton = display.newImageRect( sceneGroup, "Assets/Images/Scene/return.png", 60, 60 )--11
  replayButton.y = display.contentCenterY - display.contentCenterY / 1.5
  replayButton.x = display.contentCenterX - display.contentCenterX / 2 - 50

  replayButton:addEventListener("tap", returnToMenu)

  local pauseButton = display.newImageRect( sceneGroup, "Assets/Images/Scene/pause.png", 60 , 60 )--10
  pauseButton.y = replayButton.y
  pauseButton.x = replayButton.x - 100
  -- pauseButton:addEventListener("tap", function()
  -- audio.stop() end)

  local oven = display.newImageRect(sceneGroup, "Assets/Images/FoodGame/oven.png", currentWidth, currentHeight)
  oven.x = display.contentCenterX - display.contentCenterX / 2
  oven.y = display.contentCenterY + display.contentCenterY / 1.8
  oven:scale(0.5, 0.22)

  local foodBack= display.newImageRect(sceneGroup, "Assets/Images/FoodGame/foodBack.png", currentWidth, currentHeight)
  foodBack.x = display.contentCenterX + display.contentCenterX / 2
  foodBack.y = display.contentCenterY + replayButton.y / 2
  foodBack:scale(0.5, 0.58)
  checkScore()

end

function checkScore()
  --local scoreCounter = display.newImage(sceneGroup,"Assets/Images/FoodGame/timer/0.png", currentWidth/20,currentHeight/20)

  -- Shouldn't need these because dimensions are hard set at end
  -- local width = currentWidth/2
  -- local height = currentHeight/2

  scoreCounter = display.newImage(sceneGroup, "Assets/Images/FoodGame/timer/0.png")

  for timer=11,0,-1
  do
    -- User score on timer
    if score % 12 == timer then
      if DEBUG then print("***** Timer is set to: ", timer) end
      if score > 0 then
        -- Update timer with new score
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
  if score > 36 then
    display.remove( star1 )
    display.remove( star2 )
    display.remove( star3 )
    star1 = display.newImage(sceneGroup, "Assets/Images/FoodGame/star.png", currentWidth, currentHeight)
    star2 = display.newImage(sceneGroup, "Assets/Images/FoodGame/star.png", currentWidth, currentHeight)
    star3 = display.newImage(sceneGroup, "Assets/Images/FoodGame/star.png", currentWidth, currentHeight)
  elseif score > 24 then
    display.remove( star1 )
    display.remove( star2 )
    star1 = display.newImage(sceneGroup, "Assets/Images/FoodGame/star.png", currentWidth, currentHeight)
    star2 = display.newImage(sceneGroup, "Assets/Images/FoodGame/star.png", currentWidth, currentHeight)
  elseif score > 12 then
    display.remove( star1 )
    star1 = display.newImage(sceneGroup, "Assets/Images/FoodGame/star.png", currentWidth, currentHeight)
  end

  star1.x = display.contentCenterX + display.contentCenterX / 2 - 150
  star1.y = display.contentCenterY - display.contentCenterY / 1.5 + 15

  star2.x = display.contentCenterX + display.contentCenterX / 2
  star2.y = display.contentCenterY - display.contentCenterY / 1.5 + 15

  star3.x = display.contentCenterX + display.contentCenterX / 2 + 150
  star3.y = display.contentCenterY - display.contentCenterY / 1.5 + 15

  star1:scale(0.5,0.5)
  star2:scale(0.5,0.5)
  star3:scale(0.5,0.5)

end

function getChoices()
  -- Ensure deck has sufficient countries
  if leftInDeck() < 4 then
    buildDeck()
    shuffleDeck()
    if DEBUG then
      print("***** Shuffled deck")
      showDeck()
    end
  end

  -- Draw countries from deck
  choices = drawDeck(4)
  if DEBUG then
    print("***** Drawn choices:")
    showTable(choices)
  end
  print("***** Countries left in deck: "..leftInDeck())
end

function setFoods()
  -- Setting random countries i.e, not the correct one on the food grid

  -- 4 new random countries

  getChoices()

  for i,v in ipairs(choices) do
    v.image = display.newImageRect(foodGroup, v.flag, currentWidth / 5, currentHeight / 5)
  end

  -- selecting random( out of 4) place in the food selection grid

  math.randomseed(os.clock()*10000)
  correctFood = math.random(4)
  print("***** Correct country: "..correctFood..". "..choices[correctFood].name)


  -- Setting the position of all four grid

  for i,v in ipairs(choices) do
    v.image.alpha = 0
    v.image:scale(0, 0)
  end
  choices[1].image.x = display.contentCenterX + 125
  choices[1].image.y = display.contentCenterY - display.contentCenterY / 8
  
  choices[2].image.x = choices[1].image.x + choices[1].image.width + 50
  choices[2].image.y = choices[1].image.y
  
  choices[3].image.x = choices[1].image.x
  choices[3].image.y = choices[1].image.y + choices[1].image.width
  
  choices[4].image.x = choices[2].image.x
  choices[4].image.y = choices[3].image.y

  -- Staggered animation for food choice grid

  for i,v in ipairs(choices) do
    v.appear = function ()
      transition.to(v.image, {
        time = 1000,
        alpha = 1,
        xScale = 1,
        yScale = 1,
        transition = easing.outElastic
      })
    end
  end

  timer.performWithDelay(200, choices[3].appear)
  timer.performWithDelay(400, choices[4].appear)
  timer.performWithDelay(600, choices[2].appear)
  timer.performWithDelay(800, choices[1].appear)

  -- tap action listener and answer checker for all the foods in the grid

  for i,v in ipairs(choices) do
    v.image:addEventListener("tap", function ()
      print("***** Chose: "..i..". "..v.name..", correct: "..correctFood..". "..choices[correctFood].name)
      if i == correctFood then
        correctAnswer()
      end
    end)
  end

end

function correctAnswer()
  score = score + 1
  checkScore()
  eventRemover()
end

function eventRemover()
  for i,v in ipairs(choices) do
    display.remove(v.image)
  end
  leaveCharacters()
end

function callGreetings()
  print("***** greetings: "..correctFood..". "..choices[correctFood].name)
  greeting = choices[correctFood].greetings_food
  print(greeting)
  dialogBox = display.newImage(sceneGroup, greeting)
  dialogBox.xScale = 0.5
  dialogBox.yScale = 0.5
  dialogBox.y = display.contentCenterY - display.contentCenterY/2.5
  dialogBox.x = character_one.x - 30
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
  character_one = display.newImage(sceneGroup,"Assets/Images/FoodGame/boy.png")
  character_one.y = display.contentCenterY
  character_one.x = 0
  character_one:scale(0.8,0.8)
  transition.to(character_one,{time = 500, x = display.contentCenterX/2.5, onComplete = callGreetings})
end

-- show()
function scene:show( event )

  local sceneGroup = self.view
  local phase = event.phase

  if ( phase == "will" ) then

  elseif ( phase == "did" ) then

  end
end

-- hide()
function scene:hide( event )

  local sceneGroup = self.view
  local phase = event.phase

  if ( phase == "will" ) then

    audio.fade( 500 )
    audio.stopWithDelay( 500 )

  elseif ( phase == "did" ) then

  end
end

-- destroy()
function scene:destroy( event )

  local sceneGroup = self.view

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
