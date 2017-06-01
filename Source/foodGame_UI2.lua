local composer = require( "composer" )
local images = require( "Source.images" )
local musics = require( "Source.musics" )
local sounds = require( "Source.sounds" )
local Button = require( "Source.button" )

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
local choiceFade
local checkScore
local checkStar
local correctAnswer
local starShine
-- local audioButton
local getOverlayPause
local infobutton
local reutnBFunction
local checkFunction

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
local difficulty
local mute = false
local pause = false
local isFoodPlaced = false;

-- local muteButton
local infoButton
local pauseButton
local choices = {}

-- images.defineImage( "Paused Screen", "FoodGame/Background4-blur.png", display.contentWidth+190, currentHeight)

local function returnToMenu()
  if DEBUG then print("***** Returning to menu") end
  musics.stop()
  composer.removeScene( "Source.foodGame_UI2" )
  composer.gotoScene( "Source.menu" )
end

local function makeBox( sceneGroup, x, y, text )
	local totalWidth = currentWidth/5
	local borderWidth = 2
	local fillWidth = totalWidth - 2*borderWidth
	return Button:newTextButton{
		group=sceneGroup,
		font=font, fontSize=36, fontColor={ 0.0 },
		text=text,
		x=x, y=y, width=fillWidth, height=currentHeight/14-10,
		fillColor={ 0.77, 0.61, 0.44 }, fillColorPressed={ 0.77*0.8, 0.61*0.8, 0.44*0.8 },
		borderWidth=borderWidth, borderColor={ 0, 0, 0 }
	}
end

local function disableMain()
  print("disableMain called!!!!")
  pause = true
  sounds.mute();
  pauseButton:removeEventListener("tap", getOverlayPause)
  -- if muteButton ~=nil then
  -- muteButton:removeEventListener("tap", audioButton) end
  -- if muteButton ~= nil then
  --    muteButton:removeSelf()
  --   muteButton = nil end

  infoButton:removeEventListener("tap", infobutton)
  print("IS FOOD PLACED??"..tostring(isFoodPlaced))
end

local function enableMain()
  print("EnableMain called!!!!")
  pause = false
  sounds.unMute();
  pauseButton:addEventListener("tap", getOverlayPause)
  infoButton:addEventListener("tap", infobutton)
  -- reset dialog
  -- setFoods()
  -- -- callGreetings()

  callCharacters()
  if (isFoodPlaced == false) then
    setFoods()
  end
end


function checkFunction(event)
  -- made changes here
   print("Nityam- myChoice in function ="..event.target.num)
   print("Nityam - correctAnswer = "..tostring(correctFood))
   if event.target.num == correctFood then
     correctAnswer()
   else
     wrongAnswer() --v
   end
 end

function getOverlayPause()
  print("!!!pauseButton clicked!!!")
  pause = true
  disableMain()
  local overlay = display.newImageRect( sceneGroup, "Assets/Images/FoodGame/Background4blur.png", display.contentWidth + 190, display.contentHeight )
  overlay.x = display.contentCenterX
  overlay.y = display.contentCenterY + 30
  local pausedText = display.newText("Sure want to return?", display.contentCenterX,display.contentCenterY-100,font,100)
  pausedText:setFillColor(0,0,0)
  local resumeButton = makeBox(sceneGroup, display.contentCenterX, display.contentCenterY+20, "Resume" )
  local quitButton = makeBox(sceneGroup, display.contentCenterX, display.contentCenterY+100, "Quit" )
  -- dump memories
  local function purgeObjs()
    overlay:removeSelf()
    overlay = nil
    resumeButton:removeSelf()
    resumeButton = nil
    pausedText:removeSelf()
    pausedText = nil
    quitButton:removeSelf()
    quitButton = nil
  end
  -- functions on Paused Screen
  local function resumeTap()
    enableMain()
    purgeObjs()
    -- enableButtons()
  -- transition.resume()
  end
  local function quitTap()
    purgeObjs()
    transition.cancel()
    returnToMenu()
  end
  resumeButton:addEventListener("tap", resumeTap)
  quitButton:addEventListener("tap", quitTap)
end

local function winScene()
  if DEBUG then print("**** Going to win scene") end
  composer.gotoScene( "Source.winFoodGame" )
  if score ~= nil then
    score = 0
  end
  composer.removeScene( sceneGroup )
  composer.removeScene( "Source.foodGame_UI2" )
  -- foodGroup:removeSelf()
end

--creating main table
local Countries = require "Source.Countries"

-- other scenes from the game:

-- Temporary Music
musics.defineMusic( "Food Theme", "Assets/Sounds/Music/bensound-buddy.mp3", 0.9, 5000 )
sounds.defineSound("Win","Assets/Sounds/win.wav",0.8 )
sounds.defineSound("starWin", "Assets/Sounds/starWin.wav",0.8)
sounds.defineSound("correct", "Assets/Sounds/FlagGame/DING_FX.mp3",0.8)
sounds.defineSound("wrong","Assets/Sounds/FlagGame/WRONG_FX.mp3",0.8)
-- create()
function scene:create( event )
    print( "scene:create" )
  musics.play( "Food Theme" )

  sceneGroup = self.view
  currentWidth = display.contentWidth
  currentHeight = display.contentHeight
  -- foodGroup = display.newGroup()

  startGame()
end

function startGame()
  difficulty = composer.getVariable( "difficulty" )

  if DEBUG then print("Difficulty set to "..difficulty) end

  setBackground()
  newFoods()

end

function newFoods()

    if victory then
      if DEBUG then print("***** You win!") end
      winScene()
    else
      if DEBUG then print("********** Starting round! ****************************************") end
      -- if pause == false then
        setFoods()
        callCharacters()
      -- end
    end

end


function infobutton()
  print("!!!infobutton CLICKED!!!")
  pause = true
    musics.pause()
    disableMain()
    local overlay = display.newImageRect( sceneGroup, "Assets/Images/FoodGame/food_tutorial.png", display.contentWidth , display.contentHeight - 170)
    overlay.x = display.contentCenterX
    overlay.y = display.contentCenterY - 12
    local returnB = display.newImageRect( sceneGroup, "Assets/Images/FlagGame/Scene/9.png", 60, 60 )--11
    returnB.y = display.contentCenterY - display.contentCenterY / 2.1
    returnB.x = display.contentCenterX - display.contentCenterX / 1.3
  -- dump memories

    local function purgeObjs()
      print("Nityam - returnB event removed")
      overlay:removeSelf()
      overlay = nil
      -- returnB:removeEventListener("tap", reutnBFunction)
      returnB:removeSelf()
      resumeB = nil
      musics.unPause()

    end
   function reutnBFunction()
      pause = false
      enableMain()
      purgeObjs()
      -- transition.cancel()
    end

      returnB:addEventListener("tap", reutnBFunction)
    -- returnB:addEventListener("tap", purgeObjs)
    -- YOUR CODE HERE
end

function setBackground()

  local background = display.newImageRect(sceneGroup, "Assets/Images/FoodGame/Background4.png",currentWidth, currentHeight )
  background.x = display.contentCenterX
  background.y = display.contentCenterY

  pauseButton = display.newImageRect( sceneGroup, "Assets/Images/FlagGame/Scene/9.png", 60, 60 )--11
  pauseButton.y = display.contentCenterY - display.contentCenterY / 1.5
  pauseButton.x = display.contentCenterX - display.contentCenterX / 1.1

  pauseButton:addEventListener("tap", getOverlayPause)

  -- muteButton = display.newImageRect( sceneGroup, "Assets/Images/FlagGame/Scene/unmute.png", 60, 60 )
  -- muteButton.y = pauseButton.y
  -- muteButton.x = pauseButton.x + 70
  -- muteButton:addEventListener("tap", audioButton)

  infoButton = display.newImageRect ( sceneGroup, "Assets/Images/FlagGame/Scene/11.png", 60, 60)
  infoButton.y = pauseButton.y + 70
  infoButton.x = pauseButton.x
  infoButton:addEventListener("tap", infobutton)

  local foodBack = display.newImageRect(sceneGroup, "Assets/Images/FoodGame/foodBack.png", currentWidth, currentHeight)
  foodBack.x = display.contentCenterX + display.contentCenterX / 2
  foodBack.y = display.contentCenterY
  foodBack:scale(0.5, 0.9)

  woodbar_h = display.newImage(sceneGroup, "Assets/Images/FoodGame/woodBar.png")
  woodbar_h.rotation = 180
  woodbar_h.x = display.contentCenterX + 275
  woodbar_h.y = display.contentCenterY
  woodbar_h:scale(0.32,0.25)

  woodbar_v = display.newImage(sceneGroup, "Assets/Images/FoodGame/woodBar.png")
  woodbar_v.rotation = 90
  woodbar_v.x = woodbar_h.x - 26
  woodbar_v.y = woodbar_h.y
  woodbar_v:scale(0.4,0.25)
  checkScore()

  topBorder = display.newImage(sceneGroup, "Assets/Images/FlagGame/Scene/21.png")
  topBorder.x = currentWidth/2
  topBorder.y = 0
  topBorder:scale(1,0.5)

  botBorder = display.newImage(sceneGroup, "Assets/Images/FlagGame/Scene/21.png")
  botBorder.x = currentWidth/2
  botBorder.y = display.contentCenterY + 225 + 135
  botBorder:scale(1,0.5)
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

  scoreCounter.x = woodbar_h.x -26
  scoreCounter.y = display.contentCenterY
  scoreCounter:scale(0.23, 0.23)

  checkStar()
end

function checkStar()
  star1 = display.newImage(sceneGroup, "Assets/Images/FoodGame/starGrey.png", currentWidth, currentHeight)
  star2 = display.newImage(sceneGroup, "Assets/Images/FoodGame/starGrey.png", currentWidth, currentHeight)
  star3 = display.newImage(sceneGroup, "Assets/Images/FoodGame/starGrey.png", currentWidth, currentHeight)


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

  star1.x = display.contentCenterX - display.contentCenterX / 1.3
  star1.y = display.contentCenterY + display.contentCenterY / 1.8

  star2.x = display.contentCenterX - display.contentCenterX / 2
  star2.y = display.contentCenterY + display.contentCenterY / 1.8

  star3.x = display.contentCenterX - display.contentCenterX / 4
  star3.y = display.contentCenterY + display.contentCenterY / 1.8

  star1:scale(0.5, 0.5)
  star2:scale(0.5, 0.5)
  star3:scale(0.5, 0.5)
  starShine()

end

function starShine()
  if score == 12 then
     if DEBUG then print( "score star here!!" ) end
    sounds.play("starWin")
   star1:scale(10,10)
   star1.x = display.contentCenterX
   star1.y = display.contentCenterY
    transition.to(star1,{time = 500,
                        alpha = 1,
                        x = display.contentCenterX - display.contentCenterX / 1.3,
                         y = display.contentCenterY + display.contentCenterY / 1.8,
                         xScale = 0.5, yScale = 0.5 })
    --starShineAnimation(star1)
  elseif score == 24 then
    sounds.play("starWin")
    star2:scale(10,10)
    star2.x = display.contentCenterX
    star2.y = display.contentCenterY
     transition.to(star2,{time = 500,
                         alpha = 1,
                         x = display.contentCenterX - display.contentCenterX / 2,
                          y = display.contentCenterY + display.contentCenterY / 1.8,
                          xScale = 0.5, yScale = 0.5 })
     --starShineAnimation(star1)
    -- starShineAnimation()
  elseif score == 36 then
    sounds.play("starWin")
    star3:scale(10,10)
    star3.x = display.contentCenterX
    star3.y = display.contentCenterY
     transition.to(star3,{time = 500,
                         alpha = 1,
                         x = display.contentCenterX - display.contentCenterX / 4,
                          y = display.contentCenterY + display.contentCenterY / 1.8,
                          xScale = 0.5, yScale = 0.5 })
     --starShineAnimation(star1)
    -- starShineAnimation()
  else
  end
end

function getChoices()
  -- Ensure deck has sufficient countries
  if leftInDeck() < 4 then
    buildDeck(difficulty)
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
  if isFoodPlaced == false then
    getChoices()

    -- selecting random( out of 4) place in the food selection grid
    math.randomseed(os.clock()*10000)
    correctFood = math.random(4)
    print("***** Correct country: "..correctFood..". "..choices[correctFood].name)

    -- Begin drawing food grid
    for i,v in ipairs(choices) do
       v.image = display.newImageRect(sceneGroup, v.flag, currentWidth / 5, currentHeight / 5)
    end

    -- Setting the position of all four grid
      for i,v in ipairs(choices) do
        v.image.alpha = 0
        v.image:scale(0, 0)
      end
      print ("Pause Value:")
      print (pause)

      choices[1].image.x = display.contentCenterX + 125
      choices[1].image.y = display.contentCenterY - 175

      choices[2].image.x = choices[1].image.x + choices[1].image.width + 50
      choices[2].image.y = choices[1].image.y

      choices[3].image.x = choices[1].image.x
      choices[3].image.y = display.contentCenterY + 150

      choices[4].image.x = choices[2].image.x
      choices[4].image.y = choices[3].image.y

      if (pause == false) then
        print("PAUSE IS FALSE")
        for i,v in ipairs(choices) do
          v.text = display.newText(sceneGroup, v.name, v.image.x, v.image.y + 96, "Helvetica", 31)
          v.text:setFillColor(0, 0, 35)
        end
        -- end
        -- Staggered animation for food choice grid
        for i,v in ipairs(choices) do
          v.appear = function ()
            transition.to(v.image, {
                time = 1000,
                alpha = 1,
                xScale = 1,
                yScale = 1,
                transition = easing.outElastic
              })end
        end
        -- if (pause == false) then
          timer.performWithDelay(200, choices[3].appear)
          timer.performWithDelay(400, choices[4].appear)
          timer.performWithDelay(600, choices[2].appear)
          timer.performWithDelay(800, choices[1].appear)
          isFoodPlaced = true;
      end
      -- tap action listener and answer checker for all the foods in the grid

      for i,v in ipairs(choices) do
        -- print("Nityam- Printing the myChoice before callings: "..i)
        v.image.num = i
        v.image:addEventListener("tap", checkFunction)
      end
  end
end
---------------------------
function wrongAnswer()
  if DEBUG then print("WRONG!!!!") end
  sounds.play("wrong")
  wrongChoiceCharacter()
  choiceRemover()
  timer.performWithDelay(1900, setFoods)

  -- if choice.response ~= nil then
  -- if DEBUG then print("Removing existing response") end
  -- display.remove(choice.response)
  -- -- choice.response:removeSelf()
  -- end

  -- --
  -- choice.response = display.newText(sceneGroup, "X", choice.image.x, choice.image.y, "Helvetica", 250)
  -- choice.response:setFillColor(1,0,0)
  -- choice.response.alpha = 0
  -- choice.response:scale(1.5, 1.5)

  -- transition.to(choice.response, {
  -- time = 200,
  -- alpha = 1,
  -- xScale = 1,
  -- yScale = 1,
  -- transition = easing.outQuart
  -- })
end

----------
function correctAnswer()
  sounds.play("correct")
  if difficulty == 1 then -- Easy
    score = score + 3
  elseif difficulty == 2 then -- Medium
    score = score + 12
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
    -- display.remove(v.response)
    display.remove(v.text)
    display.remove(v.image)
    -- v.text:removeSelf()
  end
  -- leaveCharacters()
end

function callGreetings()
  -- print("***** greetings: "..correctFood..". "..choices[correctFood].name)
  -- greeting = "Assets/Images/FoodGame/Dialogs/dialogBox_white.png"
  if DEBUG then
    print("<NITYAM>..Correct from the deck -> "..choices[correctFood].name)
  end

    fname = choices[correctFood].food
    greet = choices[correctFood].greeting
    -- print(greeting)

    -- dialogBox = display.newImage(sceneGroup, "greeting")
    -- dialogBox.xScale = 0.5
    -- dialogBox.yScale = 0.5
    -- dialogBox.y = display.contentCenterY - display.contentCenterY/2.5
    -- dialogBox.x = character_one.x - 30

    display.remove(dialogBox) -- in case it was there before
    if pause == false then
     dialogBox = display.newImage(sceneGroup, "Assets/Images/FoodGame/Dialogs/dialogBox_white.png")
    end
    dialogBox.xScale = 0.4
    dialogBox.yScale = 0.35

    dialogBox.y = display.contentCenterY - display.contentCenterY/2.5 - 20

    dialogBox.x = character_one.x + 85
    greetingText = greet..", \n may I get some \n "..fname
    display.remove(dialogText) -- in case it was there before
    if pause == false then
      dialogText = display.newText(sceneGroup, greetingText, dialogBox.x, dialogBox.y - 10, "Helvetica", 27)
    end
    dialogText:setFillColor(0,0,0)


end

function callCharacters()
  if (pause == false) then
    print("Pause Set Back to False")
  character_one = display.newImage(sceneGroup,"Assets/Images/FoodGame/bear.png")
  character_one.y = display.contentCenterY + 30
  -- character_one.x = - 20
  character_one.x = display.contentCenterX/2.5
  callGreetings()
  --character_one:scale(0.8,0.8)
  character_one:scale(0.45,0.45)
  -- if (pause == false) then
    -- print("Pause Set Back to False")
    -- transition.to(character_one,{time = 500, x = display.contentCenterX/2.5, onComplete = callGreetings})
  end
end

function choiceFade()
  for i,v in ipairs(choices) do
    v.image._functionListeners = nil


    transition.to(v.image, {time = 500, alpha = 0})
    transition.to(v.text, {time = 500, alpha = 0})
    -- if v.response ~= nil then
    -- transition.to(v.response, {time = 1000, alpha = 0})
    -- end
  end
end

function thankCharacter()
  if DEBUG then print("Thank you!!!!") end
  isFoodPlaced = false;
  choiceFade()

  display.remove(dialogText)
  dialogText = display.newText(sceneGroup, "Thank you!", dialogBox.x, dialogBox.y - 10, "Helvetica", 27)
  dialogText:setFillColor(0,0,0)

  transition.to(dialogText, {
      time = 2000,
      alpha = 1,
      onComplete = leaveCharacters
    })
end

function wrongChoiceCharacter()

  choiceFade()

  display.remove(dialogText)
  dialogText = display.newText(sceneGroup, "I didn't order \nthat.", dialogBox.x, dialogBox.y - 10, "Helvetica", 27)
  dialogText:setFillColor(0,0,0)
    isFoodPlaced = false;
  transition.to(dialogText, {
      time = 2000,
      alpha = 1,
      onComplete = callGreetings
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
  choiceRemover()
end

-- function audioButton(event)
--   print("!!!audioButton clicked!!! audio is now: "..tostring(mute))
--   if mute == false then
--     mute = true
--     musics.pause()
--     sounds.mute()
--     muteButton = display.newImageRect( sceneGroup, "Assets/Images/FlagGame/Scene/mute.png", 60, 60 )
--     muteButton.y = pauseButton.y
--     muteButton.x = pauseButton.x + 70
--   else
--     mute = false
--     musics.unPause()
--     sounds.unMute()
--     muteButton = display.newImageRect( sceneGroup, "Assets/Images/FlagGame/Scene/unmute.png", 60, 60 )
--     muteButton.y = pauseButton.y
--     muteButton.x = pauseButton.x + 70
--   end
-- end


-- show()
function scene:show( event )
    -- print( "scene:show" )
  local sceneGroup = self.view
  local phase = event.phase

  if ( phase == "will" ) then

  elseif ( phase == "did" ) then
  end
end

-- hide()
function scene:hide( event )
  print( "scene:hide" )
  print( "Destroy scene called" )
  composer.removeScene( "Source.foodGame_UI2" )
  score = 0
  checkStar()
  local sceneGroup = self.view
  local phase = event.phase

  if ( phase == "will" ) then
    score = 0
    checkStar()
    composer.removeScene( "Source.foodGame_UI2" )

    print( "Destroy scene called" )
    audio.fade( 500 )
    audio.stopWithDelay( 500 )
  elseif ( phase == "did" ) then
    score = 0
    checkStar()
    composer.removeScene( "Source.foodGame_UI2" )
    print( "Destroy scene called at the last" )
  end
end

-- destroy()
function scene:destroy( event )
    print( "scene:destroy" )
  print( "Destroy scene called" )
  local sceneGroup = self.view
  print( "Destroy scene called here too" )
  -- score:removeSelf()
  -- scoreCounter:removeSelf()
  -- sceneGroup:removeSelf()

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
