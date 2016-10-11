
local composer = require( "composer" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

local countryNames = {
	"Egypt",
	"Honduras",
	"Hungary",
	"Madagascar",
	"Mexico",
	"Mongolia",
	"Morocco",
	"New Zealand",
	"Peru",
	"Philippines",
	"Russia",
	"South Africa",
	"Switzerland",
	"Taiwan",
	"Ukraine",
	"United Kingdom",
	"United States",
	"Vietnam"
};

local countryFiles = {
	"Assets/Images/Flags/Egypt_Flag.png",  -- a few of these images have a large white border that needs to be cropped; they came this way
	"Assets/Images/Flags/Honduras_Flag.png",
	"Assets/Images/Flags/Hungary_Flag.png",
	"Assets/Images/Flags/Madagascar_Flag.png",
	"Assets/Images/Flags/Mexico_Flag.png",
	"Assets/Images/Flags/Mongolia_Flag.png",
	"Assets/Images/Flags/Morocco_Flag.png",
	"Assets/Images/Flags/New_Zealand_Flag.png",
	"Assets/Images/Flags/Peru_Flag.png",
	"Assets/Images/Flags/Philippines_Flag.png",
	"Assets/Images/Flags/Russia_Flag.png",
	"Assets/Images/Flags/South_Africa_Flag.png",
	"Assets/Images/Flags/Switzerland_Flag.png",
	"Assets/Images/Flags/Taiwan_Flag.png",
	"Assets/Images/Flags/Ukraine_Flag.png",
	"Assets/Images/Flags/United_Kingdom_Flag.png",
	"Assets/Images/Flags/United_States_Flag.png",
	"Assets/Images/Flags/Vietnam_Flag.png",
};

local sceneBuild ={
	"Assets/Images/Scene/1.png",
	"Assets/Images/Scene/2.png",
	"Assets/Images/Scene/3.png",
	"Assets/Images/Scene/4.png",
	"Assets/Images/Scene/5.png",
	"Assets/Images/Scene/6.png",
	"Assets/Images/Scene/7.png",
	"Assets/Images/Scene/8.png",
	"Assets/Images/Scene/9.png",
	"Assets/Images/Scene/10.png",
	"Assets/Images/Scene/11.png",
	"Assets/Images/Scene/12.png",
	"Assets/Images/Scene/13.png", -- 13
	"Assets/Images/Scene/14.png",
	"Assets/Images/Scene/15.png",
	"Assets/Images/Scene/16.png",
	"Assets/Images/Scene/17.png",
	"Assets/Images/Scene/18.BMP",
};

local audioFiles = {
	"Assets/Sounds/Whimsical-Popsicle.mp3"	,
	"Assets/Sounds/YAY_FX.mp3",
	"Assets/Sounds/DING_FX.mp3",
	"Assets/Sounds/WRONG_FX.mp3",
};

local function returnToMenu()
	composer.gotoScene( "Source.menu" )
end



-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )
	-- !! need to work on the ratio for the resolutions
	local sceneGroup = self.view
	local currentWidth = display.contentWidth
	local currentHeight = display.contentHeight
	local backgroundMusic = audio.loadStream(audioFiles[1])
	local count = 0
	local level1 = 6  -- 6 rounds
	local speed1 = 1000
	local speed2 = 1000
	local flag
	--background music, loop infinite, fadein in 5s
    -- local backgroundMusicChannel = audio.play(backgroundMusic,{channel1=1,loops=-1,fadein=5000})
	-- animal sprite --
	local sheetDataCat =
	{
		width = 276.29,
		height = 238.29,
		numFrames = 49,
		sheetContentWidth = 1934,
		sheetContentHeight = 1668
	};

	local sequenceDataCat = {
		{
			name = "idle",
			frames = {5,6,7,12,13,14,19,20,21,26},
			time = 3000,
			loopCount = 0
		},
		{
			name = "sad",
			frames = {1,2,3,4,8,9,10,15,16,17},
			time = 1000,
			loopCount = 0
		},
		{
			name = "happy",
			frames = {29,30,31,36,37,38,43,44},
			time = 1000,
			loopCount = 0
		}
	};
	local mySheetCat = graphics.newImageSheet("Assets/Images/Sprite/2.png", sheetDataCat)
	
	local sheetDataDog =
	{
		width = 547,
		height = 481,
		numFrames = 18,
		sheetContentWidth = 9846,
		sheetContentHeight = 481
	};

	local sequenceDataDog = {
		{
			name = "run",
			start = 1,
			count = 8,
			time = 500,
			loopCount = 2
		},
		{
			name = "idle",
			start = 9,
			count = 18,
			time = 2000,
			loopCount = 0
		},
	};
	local mySheetDog = graphics.newImageSheet("Assets/Images/Sprite/3.png", sheetDataDog)
	-- end animal sprite -- 
	-------------------------------------------------------------------------------------------------------
	-- Front-end --
	-------------------------------------------------------------------------------------------------------
	-- background placeholder
	local background = display.newImageRect( sceneGroup,
											 sceneBuild[1],
											 currentWidth, 
											 currentHeight * 1
										   )
	background.x = display.contentCenterX
	background.y = display.contentCenterY 

    -- screen split placeholder
	local collumn = display.newImageRect( sceneGroup,
										  sceneBuild[13],
										  currentWidth/8,
										  currentHeight )
	collumn.x = currentWidth * 2 / 3 
	collumn.y = currentHeight / 2

	-- pause button placeholder
	local pauseButton = display.newImageRect( sceneGroup,
										      sceneBuild[10],
										      currentWidth/20, 
										      currentHeight/14
										    )
	pauseButton.x = currentWidth / 20 --50
	pauseButton.y = currentHeight / 5 --150

	-- replay button placeholder
	local replayButton = display.newImageRect( sceneGroup, 
											   sceneBuild[11], 
											   currentWidth/20, 
											   currentHeight/14
											 )
	replayButton.x = pauseButton.x + currentWidth / 16
	replayButton.y = pauseButton.y

	-- pause/play event 
	-- temp2 store the values to decide play/pause
	-- need to implement overlay when pause to stop all interactions with gameplay
	local temp2 = 0
	local function pauseTap()
		if temp2 == 0 then
			transition.pause(flag)
			temp2 = 1
		else
			transition.resume(flag)
			temp2 = 0
		end
	end
	local function replayTap()
		-- this will stop the animations
		--transition.cancel()
		returnToMenu()
	end
	pauseButton:addEventListener("tap", function()
		pauseTap()
	end)
	replayButton:addEventListener("tap",function()
		replayTap()
	end
	)
	-- End event Pause/Replay --

	-- flag pole placeholder
	local pole = display.newImageRect( sceneGroup,
									   sceneBuild[2],
									   currentWidth/10,
									   currentHeight/1.8
									 )
	pole.x = currentWidth * 1 / 3
	pole.y = currentHeight - pole.height + 60

	-- animal 1 placeholder
	local animal1 = display.newSprite(sceneGroup,mySheetCat,sequenceDataCat)
	animal1:scale(0.5,0.5)
	animal1.x = pole.x / 2
	animal1.y = currentHeight - (animal1.height * 0.74)
	animal1:setSequence("idle")
	animal1:play()

	-- animal 2 placeholder
	local animal2 = display.newSprite(sceneGroup,mySheetCat,sequenceDataCat)
	animal2:scale(-0.5,0.5)
	animal2.x = pole.x + pole.x / 2
	animal2.y = currentHeight - (animal1.height * 0.74)
	animal2:setSequence("idle")
	animal2:play()
		
	-- place holders for answer text 
	local optionBox1 = display.newImageRect( sceneGroup, 
											 sceneBuild[14],
											 currentWidth/5, 
											 currentHeight/12
										   )
	optionBox1.x = animal1.x
	optionBox1.y = animal1.y - currentHeight/8
	local optionBox2 = display.newImageRect( sceneGroup,
										     sceneBuild[14],
										     currentWidth/5, 
										     currentHeight/12
										   )
	optionBox2.x = animal2.x
	optionBox2.y = animal2.y - currentHeight/8
	-------------------------------------------------------------------------------------------------------
	-- end front-end --
	-------------------------------------------------------------------------------------------------------
	
	-- right side of screen --
	-------------------------------------------------------------------------------------------------------
	local function moveUpDown(obj,num)
		local temp = currentHeight - 135
		if num == 0 then
			transition.to(obj, {y = temp})
		else
			transition.to(obj, {y = temp - currentHeight/9 * num})
		end
		obj:setSequence("run")
		obj:play()
	end
	-------------------------------------------------------------------------------------------------------
	-- temp = placeholder for all right side 
	local temp = display.newImageRect(sceneGroup, sceneBuild[16],currentWidth * 1 / 3, currentHeight)
	temp.x = collumn.x + collumn.x / 4
	temp.y = display.contentCenterY
	temp:setFillColor(0,0,0)
	-- placeholder for road
	local road = display.newImageRect(sceneGroup,sceneBuild[15],100,currentHeight)
	road.x = collumn.x + collumn.x /4
	road.y = currentHeight/2
	-- placeholder for animal on the road
	local animal3 = display.newSprite(sceneGroup,mySheetDog,sequenceDataDog)
	animal3:scale(0.18,0.18)
	animal3.x = road.x
	animal3.y = currentHeight - (animal3.height * 0.28)
	animal3:setSequence("idle")
	animal3:play()
	
	-- place holder for trophy
	local trophy = display.newImageRect(sceneGroup, sceneBuild[5], 46*1.5, 47*1.5)
	trophy.x = road.x
	trophy.y = 140
	
	-- need to work on resolution for left.width + left.x
	local leftRoad = display.newImageRect(sceneGroup, sceneBuild[17], 120, currentHeight)
	leftRoad.x = 743
	leftRoad.y = display.contentCenterY
	leftRoad:setFillColor(255,255,255,1.0)
	
	-- need to work on resolution for right.width + right.x
	local rightRoad = display.newImageRect(sceneGroup, sceneBuild[17],120, currentHeight)
	rightRoad.x = road.x + road.width + 10
	rightRoad.y = display.contentCenterY
	rightRoad:setFillColor(255,255,255,1.0)
	
	-- monuments place holder
	-- 80 -> 6 monuments -> 6 rounds
	local size = 80
	for i = 0, 6 do 
		local placeHolder = display.newImageRect(sceneGroup, sceneBuild[18], size, size)
		if i % 2 == 0 then 
			placeHolder.x = leftRoad.x
		else
			placeHolder.x = rightRoad.x
		end
		placeHolder.y = 150 + i * size
		placeHolder:setFillColor(255,255,255,0.9)
	end
	-- end right side of screen --
	-------------------------------------------------------------------------------------------------------
	
	-- back-end -- Left side of screen --
	-------------------------------------------------------------------------------------------------------
	local usedFlag = {}
	local textBox1 -- text box for option 1
	local textBox2 -- text box for option 2
	local textBox3 -- text box for answer
	
	-- function to decrease the Count
	local function minusCount()
		if count > 0 then
			count = count - 1
		end
	end
	-- function for flags transition + round control	
	local function cleanUP( obj )
		-- if flag reaches bottom, count--
		if obj.y >= pole.y+120 then
			minusCount() 
			moveUpDown(animal3,count)
		end 
		obj:removeSelf()
	    onComplete = startGame()
	end
	-- function to stop when an option is chose
	local function animationStop(obj)
		transition.cancel(obj)
		transition.fadeOut(obj ,
		{
			time=2000,
			onComplete = cleanUP
   	    })
	end
	local function animationEnd( obj )
		transition.to(obj ,
		{
			time = speed1,
		    y = pole.y * 1.3,
		    onComplete = cleanUP
		})
	end
	local function animationStart( obj )
		transition.to(obj,
		{
			time = speed2, 
			y = pole.y * 0.7,
			onComplete = animationEnd
		})
	end
	-- random to choose the box 
	local function startRound ()
		local randomFlag = math.random(1,12)
		for i,key in ipairs(usedFlag) do
			if countryNames[randomFlag] == key then randomFlag = math.random(1,12) end
		end
		flag = display.newImageRect( sceneGroup, 
										   countryFiles[randomFlag],
										   currentWidth/7,
										   currentHeight/7
										 )
		flag.x = pole.x
		flag.y = pole.y * 1.2
		-- random between 2 boxes
		local randomBox = math.random(1,2) --countryNames[randomBox]
		local rightAnswer = countryNames[randomFlag]
		local wrongAnswer = nil
		local box1
		local box2
		-- loop to get wrong answer
		for i=1,11 do
			wrongAnswer = countryNames[math.random(1,13)]
			if  wrongAnswer ~= countryNames[randomFlag] then
				break
			end
		end
		-- random placer
		if randomBox == 1 then 
			box1 = rightAnswer
			box2 = wrongAnswer
		else
			box1 = wrongAnswer
			box2 = rightAnswer
		end
		-- text box to hold the answer texts
		textBox1 = display.newText( sceneGroup, 
										  box1,
										  optionBox1.x, 
										  optionBox1.y, 
										  native.systemFont, 35 
										)

		textBox2 = display.newText( sceneGroup, 
										  box2, 
										  optionBox2.x, 
										  optionBox2.y, 
										  native.systemFont, 35
										)

		-- color for the text 
		textBox1:setFillColor( 0, 0, 0 )
		textBox2:setFillColor( 0, 0, 0 )
		
		--test
		local function handler() Runtime:removeEventListener("tap",handler) end

		-- Event for textboxes --	
		local function textTap( obj, value )
			obj:removeSelf()
			textBox3 = display.newText( sceneGroup, 
								   value, 
							  	   obj.x, 
								   obj.y, 
								   native.systemFont, 44
								 )
			if obj == textBox1 then
				textBox2:removeSelf()
			else
				textBox1:removeSelf()
			end
		end
		-- load sound fx 
		local ding_fx = audio.loadSound(audioFiles[3])
		local lose_fx = audio.loadSound(audioFiles[4])
		-- Event listener for text box 1
		textBox1:addEventListener("tap", function()
			if randomBox == 1 then
				textTap(textBox1,"Correct!")
				count = count + 1;
				animationStop(flag)
				table.insert(usedFlag,countryNames[randomFlag])
				local sound1 = audio.play(ding_fx)
				animal1:setSequence("happy")
				animal1:play()
				--animal2:setSequence("sad")
				--animal2:play()
				moveUpDown(animal3,count)
			else
				textTap(textBox1,"Wrong!")
				animationStop(flag)
				minusCount()
				local sound2 = audio.play(lose_fx)
				animal1:setSequence("sad")
				animal1:play()
				--animal2:setSequence("happy")
				--animal2:play()
				moveUpDown(animal3,count)
			end
			-- prepare for memory dump
			textBox1 = nil
			textBox2 = nil
		end)
		-- Event listener for text box 2
		textBox2:addEventListener("tap", function()
			if randomBox ~= 1 then
				textTap(textBox2,"Correct!")
				count = count + 1;
				animationStop(flag)
				table.insert(usedFlag,countryNames[randomFlag])
				local sound1 = audio.play(ding_fx)
				animal2:setSequence("happy")
				animal2:play()
				--animal1:setSequence("sad")
				--animal1:play()
				moveUpDown(animal3,count)
			else
				textTap(textBox2,"Wrong!")
				animationStop(flag)
				minusCount()
				local sound2 = audio.play(lose_fx)
				animal2:setSequence("sad")
				animal2:play()
				--animal1:setSequence("happy")
				--animal1:play()
				moveUpDown(animal3,count)
			end
			-- prepare for memory dump
			textBox1 = nil
			textBox2 = nil
		end)
		-- prepare for memory dump
		textBox3 = nil
		animationStart(flag)
	end 
	-------------------------------------------------------------------------------------------------------
	-- End event for textboxes --
	-------------------------------------------------------------------------------------------------------
	-- function to start the game
	function startGame()
	    -- memories dump
		animal1:setSequence("idle")
		animal2:setSequence("idle")
		animal1:play()
		animal2:play()
		animal3:setSequence("idle")
		animal3:play()
		if textBox1 ~= nil then
			textBox1:removeSelf()
		end
		if textBox2 ~= nil then
			textBox2:removeSelf()
		end
		if textBox3 ~= nil then
			textBox3:removeSelf()
		end 
		-- check to start new round
		if count ~= level1 then
			print(pole)
			startRound()
		else
			animal1:setSequence("happy")
			animal2:setSequence("happy")
			animal1:play()
			animal2:play()
			local win_fx = audio.loadSound(audioFiles[2])
			local sound1 = audio.play(win_fx)
			display.newText(sceneGroup,"YOU WON !", display.contentCenterX,display.contentCenterY-50,native.systemFont,44)
		end
		--display.newText(sceneGroup,count, display.contentCenterX,display.contentCenterY,native.systemFont,44)
	end
	-- end back-end -- left side
	-------------------------------------------------------------------------------------------------------
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
		startGame()
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
		-- this remove the scene completely ?
		-- composer.removeScene("Source.flagGame")
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
