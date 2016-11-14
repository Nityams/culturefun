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
local choiceRemover
local checkScore
local checkStar
local correctAnswer
local starShine

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
local text1
local text2
local text3
local text4
local victory = false

local function returnToMenu()
  if DEBUG then print("***** Returning to menu") end
  composer.gotoScene( "Source.menu" )
  composer.removeScene( "Source.foodGame" )
  -- foodGroup:removeSelf()
end

local function winScene()
  composer.gotoScene( "Source.winGame" )
  composer.removeScene( "Source.foodGame" )
  -- foodGroup:removeSelf()
end

--creating main table
local Countries = require "Source.Countries"
local choices = {}
-- other scenes from the game:

-- Temporary Music
musics.defineMusic( "Food Theme", "Assets/Sounds/Music/Whimsical-Popsicle.mp3", 1, 5000 )
sounds.defineSound("Win","Assets/Sounds/win.wav",0.5 )
sounds.defineSound("starWin", "Assets/Sounds/starWin.wav",0.5)
-- create()
function scene:create( event )

  musics.play( "Food Theme" )

  sceneGroup = self.view
  currentWidth = display.contentWidth
  currentHeight = display.contentHeight
  -- foodGroup = display.newGroup()
  -- `Code here runs when the scene is first created but has not yet appeared on screen

  startGame()
end

function startGame()
  setBackground()
  newFoods()

  -- local time1 = display.newSprite(sceneGroup,mySheetTimer,sequenceTimer)
  -- time1.x = display.contentCenterX + display.contentCenterX /2
  -- time1.y = display.contentCenterY - display.contentCenterY /2
  -- time1:setSequence("1")
  -- time1:play()
end

function newFoods()
  if victory then
    if DEBUG then print("***** You win!") end
    returnToMenu()
  else
    if DEBUG then print("********** Starting round! ****************************************") end
    setFoods()
    callCharacters()
  end
end

function setBackground()

  local background = display.newImageRect(sceneGroup, "Assets/Images/FoodGame/Background4.png",currentWidth, currentHeight )
  background.x = display.contentCenterX
  background.y = display.contentCenterY

  local replayButton = display.newImageRect( sceneGroup, "Assets/Images/Scene/9.png", 60, 60 )--11
  replayButton.y = display.contentCenterY - display.contentCenterY / 1.2
  replayButton.x = display.contentCenterX - display.contentCenterX / 1.2

  replayButton:addEventListener("tap", returnToMenu)

  -- local pauseButton = display.newImageRect( sceneGroup, "Assets/Images/Scene/pause.png", 60 , 60 )--10
  -- pauseButton.y = replayButton.y
  -- pauseButton.x = replayButton.x - 200
  -- pauseButton:addEventListener("tap", function()
  --     audio.stop() end)

    local oven = display.newImageRect(sceneGroup, "Assets/Images/FoodGame/oven.png", currentWidth, currentHeight)
    oven.x = display.contentCenterX - display.contentCenterX / 2
    oven.y = display.contentCenterY + display.contentCenterY / 1.8
    oven:scale(0.5, 0.22)

    local foodBack = display.newImageRect(sceneGroup, "Assets/Images/FoodGame/foodBack.png", currentWidth, currentHeight)
    foodBack.x = display.contentCenterX + display.contentCenterX / 2
    foodBack.y = display.contentCenterY + replayButton.y / 2 + 4
    foodBack:scale(0.5, 0.6)

    checkScore()

  end

  function checkScore()
    --local scoreCounter = display.newImage(sceneGroup,"Assets/Images/FoodGame/timer/0.png", currentWidth/20,currentHeight/20)

    if scoreCounter ~= nil then
      if DEBUG then print("***** Removed old scoreCounter") end
      display.remove(scoreCounter)
      -- scoreCounter:removeSelf()
    end

    scoreCounter = display.newImage(sceneGroup, "Assets/Images/FoodGame/timer/0.png")

    for timer=11,0,-1
    do
      -- User score on timer
      if score % 12 == timer then
        if DEBUG then
          print("***** Score is : "..score)
          print("***** Timer is set to: "..timer)
        end
        if score > 0 then
          -- Update timer with new score
          scoreCounter:removeSelf()
          scoreCounter = display.newImage(sceneGroup, string.format("Assets/Images/FoodGame/timer/%i.png", timer)
          )
        end
      end
    end

    -- Manually set x, y for all counters

    scoreCounter.x = display.contentCenterX - display.contentCenterX / 2 + 6
    scoreCounter.y = display.contentCenterY + display.contentCenterY / 2
    scoreCounter:scale(0.19, 0.19)

    checkStar()
  end

  function checkStar()
    star1 = display.newImage(sceneGroup, "Assets/Images/FoodGame/starGrey.png", currentWidth, currentHeight)
    star2 = display.newImage(sceneGroup, "Assets/Images/FoodGame/starGrey.png", currentWidth, currentHeight)
    star3 = display.newImage(sceneGroup, "Assets/Images/FoodGame/starGrey.png", currentWidth, currentHeight)

    starShine()

    if score >= 36 then
      if DEBUG then print("***** You have "..math.floor(score/12).." out of 3 stars!") end
      display.remove( star1 )
      display.remove( star2 )
      display.remove( star3 )
      star1 = display.newImage(sceneGroup, "Assets/Images/FoodGame/star.png", currentWidth, currentHeight)
      star2 = display.newImage(sceneGroup, "Assets/Images/FoodGame/star.png", currentWidth, currentHeight)
      star3 = display.newImage(sceneGroup, "Assets/Images/FoodGame/star.png", currentWidth, currentHeight)

      if DEBUG then print("***** Victory has been achieved") end
      victory = true

    elseif score >= 24 then
      if DEBUG then print("***** You have "..math.floor(score/12).." out of 3 stars!") end
      display.remove( star1 )
      display.remove( star2 )
      star1 = display.newImage(sceneGroup, "Assets/Images/FoodGame/star.png", currentWidth, currentHeight)
      star2 = display.newImage(sceneGroup, "Assets/Images/FoodGame/star.png", currentWidth, currentHeight)
    elseif score >= 12 then
      if DEBUG then print("***** You have "..math.floor(score/12).." out of 3 stars!") end
      display.remove( star1 )
      star1 = display.newImage(sceneGroup, "Assets/Images/FoodGame/star.png", currentWidth, currentHeight)
    end

    star1.x = display.contentCenterX + display.contentCenterX / 2 - 150
    star1.y = display.contentCenterY - display.contentCenterY / 1.5 + 15

    star2.x = display.contentCenterX + display.contentCenterX / 2
    star2.y = display.contentCenterY - display.contentCenterY / 1.5 + 15

    star3.x = display.contentCenterX + display.contentCenterX / 2 + 150
    star3.y = display.contentCenterY - display.contentCenterY / 1.5 + 15

    star1:scale(0.5, 0.5)
    star2:scale(0.5, 0.5)
    star3:scale(0.5, 0.5)

  end

  function starShine()
    if score == 12 then
      sounds.play("starWin")
      -- star1:scale(4,4)
      -- transition.to(star1,{time = 500, alpha = 1, xScale = 1, yScale = 1 })
      -- starShineAnimation(star1)
    elseif score == 24 then
      sounds.play("starWin")
      -- starShineAnimation()
    elseif score == 36 then
      sounds.play("starWin")
      -- starShineAnimation()
    else
    end
  end

  function getChoices()
    -- Ensure deck has sufficient countries
    if leftInDeck() < 4 then
      buildDeck()
      shuffleDeck()
      if DEBUG then
        print("***** Shuffled new deck")
        -- showDeck()
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

    -- selecting random( out of 4) place in the food selection grid

    math.randomseed(os.clock()*10000)
    correctFood = math.random(4)
    print("***** Correct country: "..correctFood..". "..choices[correctFood].name)

    -- Draw the food grids

    -- Setting the image of all four grid
    for i,v in ipairs(choices) do
      v.image = display.newImageRect(sceneGroup, v.flag, currentWidth / 5, currentHeight / 5)
      v.image.alpha = 0
      v.image:scale(0, 0)
    end

    -- Positions
    choices[1].image.x = display.contentCenterX + 125
    choices[1].image.y = display.contentCenterY - display.contentCenterY / 8

    choices[2].image.x = choices[1].image.x + choices[1].image.width + 50
    choices[2].image.y = choices[1].image.y

    choices[3].image.x = choices[1].image.x
    choices[3].image.y = choices[1].image.y + choices[1].image.width

    choices[4].image.x = choices[2].image.x
    choices[4].image.y = choices[3].image.y

    -- Country text
    for i,v in ipairs(choices) do
      v.text = display.newText(sceneGroup, v.name, v.image.x, v.image.y + 96, "Helvetica", 31)
      v.text:setFillColor(0, 0, 35)
    end

    --  Create response placeholders
    for i,v in ipairs(choices) do
      v.response = display.newText(sceneGroup, "", v.image.x, v.image.y, "Helvetica")
    end

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
          else
            wrongAnswer(v)
          end
        end)
    end

  end

  function wrongAnswer( choice )
    if DEBUG then print("WRONG!!!!") end

    if choice.response ~= nil then
      if DEBUG then print("Removing existing response") end
      display.remove(choice.response)
      -- choice.response:removeSelf()
    end

    -- 
    choice.response = display.newText(sceneGroup, "X", choice.image.x, choice.image.y, "Helvetica", 250)
    choice.response:setFillColor(1,0,0)
    choice.response.alpha = 0
    choice.response:scale(1.5, 1.5)
    
    transition.to(choice.response, {
      time = 200,
      alpha = 1,
      xScale = 1,
      yScale = 1,
      transition = easing.outQuart
    })
  end

  function correctAnswer()
    local difficulty = composer.getVariable( "difficulty" )
    if difficulty == 1 then -- Easy
      score = score + 3
    elseif difficulty == 2 then -- Medium
      score = score + 2
    else -- Hard
      score = score + 1
    end

    if(score ~= 12 and score ~= 24 and score ~=36) then
      sounds.play("Win")
    end
    checkScore()
    thankCharacter()
  end

  function choiceRemover()
    for i,v in ipairs(choices) do
      display.remove(v.response)
      display.remove(v.text)
      display.remove(v.image)
      -- v.text:removeSelf()
    end
    leaveCharacters()
  end

  function callGreetings()
    -- print("***** greetings: "..correctFood..". "..choices[correctFood].name)
    greeting = choices[correctFood].greetings_food
    fname = choices[correctFood].food
    greet = choices[correctFood].greeting
    -- print(greeting)

  --  dialogBox = display.newImage(sceneGroup, "greeting")
  --  dialogBox.xScale = 0.5
  --  dialogBox.yScale = 0.5
  --  dialogBox.y = display.contentCenterY - display.contentCenterY/2.5
  --  dialogBox.x = character_one.x - 30

    dialogBox = display.newImage(sceneGroup, "Assets/Images/FoodGame/Dialogs/dialogBox_white.png")
    dialogBox.xScale = 0.4
    dialogBox.yScale = 0.35
    dialogBox.y = display.contentCenterY - display.contentCenterY/2.5
    dialogBox.x = character_one.x + 30
    greetingText = greet..", \n may I get some \n "..fname
    dialogText =  display.newText(sceneGroup, greetingText, dialogBox.x, dialogBox.y - 10, "Helvetica", 27)
    dialogText:setFillColor(0,0,0)
  end

  function callCharacters()
    character_one = display.newImage(sceneGroup,"Assets/Images/FoodGame/deer2.png")
    character_one.y = display.contentCenterY+15
    character_one.x = 0
    --character_one:scale(0.8,0.8)
    character_one:scale(1.3,1)
    transition.to(character_one,{time = 500, x = display.contentCenterX/2.5, onComplete = callGreetings})
  end

  function thankCharacter()
    if DEBUG then print("Thank you!!!!") end

    for i,v in ipairs(choices) do
      v.image._functionListeners = nil
      transition.to(v.image, {time = 1000, alpha = 0})
      if v.response ~= nil then
        transition.to(v.response, {time = 1000, alpha = 0})
      end
    end

    display.remove(dialogText)
    dialogText =  display.newText(sceneGroup, "Thank you!", dialogBox.x, dialogBox.y - 10, "Helvetica", 27)
    dialogText:setFillColor(0,0,0)
    
    transition.to(dialogText, {
        time = 2000,
        alpha = 1,
        onComplete = choiceRemover
      })
  end

  function leaveCharacters()
    -- character_one = display.newImage(sceneGroup,"Assets/Images/FoodGame/boy.png")
    display.remove( dialogBox )
    display.remove(dialogText)
    transition.to(character_one, {
        x = currentWidth/10 * -1,
        time = 750,
        alpha = 0,
        transition = easing.outQuad,
        onComplete = newFoods
      })
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
