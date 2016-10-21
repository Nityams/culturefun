
local composer = require( "composer" )
local physics = require ( "physics")

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
	"Assets/Images/Scene/18.png",
	"Assets/Images/Scene/19.png",
	"Assets/Images/Scene/20.png",
	"Assets/Images/Scene/21.png",
};

local monumentAssets = {
	"Assets/Images/Monument/Australia.png",
	"Assets/Images/Monument/Brazil.png",
	"Assets/Images/Monument/Chile.png",
	"Assets/Images/Monument/China.png",
	"Assets/Images/Monument/Egypt_Cairo.png",
	"Assets/Images/Monument/France_Eiffel.png",
	"Assets/Images/Monument/Germany_Berlin.png",
	"Assets/Images/Monument/Italy_Pissa.png",
	"Assets/Images/Monument/Japan.png",
	"Assets/Images/Monument/Mexico.png",
	"Assets/Images/Monument/Netherland.png",
	"Assets/Images/Monument/Spain_Barcelona.png",
	"Assets/Images/Monument/UK_BigBen.png",
	"Assets/Images/Monument/USA_NY.png",
};

local audioFiles = {
	"Assets/Sounds/Whimsical-Popsicle.mp3"	,
	"Assets/Sounds/YAY_FX.mp3",
	"Assets/Sounds/DING_FX.mp3",
	"Assets/Sounds/WRONG_FX.mp3",
};

local function returnToMenu()
	composer.gotoScene( "Source.menu" )
	-- composer.removeScene( "flagGame" )
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
	local speed1 = 8000
	local speed2 = 1000
	local flag
	local flagFlipping = false
	local flipNearDone = false
	local wantAnotherFlip = false
	local mon_placeholders = {}
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
			--frames = {1,2,3,4,8,9,10,15,16,17},
			frames = {2,3,2,3,2,3,2,3,2,3},
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
	-- background animation --
	local sheetDataTree1 =
	{
		width = 1463,
		height = 821,
		numFrames = 5,
		sheetContentWidth = 1463,
		sheetContentHeight = 4285
	};

	local sequenceDataTree1 = {
		{
			name = "normal1",
			frames = {1,2,2,2,3,3,3,4,4,4,4,5,5,5,3,3,3,3,3,3,3,3,5,5,2,2,2,2,2,2,2,4,4,4,4,4,4},
			time = 4000,
			loopCount = 0
		}
	};
	--end background animation --
	-- Front-end --
	-------------------------------------------------------------------------------------------------------
	-- top border
	local topBorder = display.newImageRect ( sceneGroup,
											sceneBuild[21],
											currentWidth,
											300
											)
	topBorder.x = currentWidth/2;
	topBorder.y = 0;
	topBorder:setFillColor(1,1,1,0.7)

	-- background placeholder
	local background = display.newImageRect( sceneGroup,
											 sceneBuild[19],
											 currentWidth,
											 currentHeight-190
										   )
	background.x = display.contentCenterX
	background.y = display.contentCenterY

	-- top border
	local botBorder = display.newImageRect ( sceneGroup,
											sceneBuild[21],
											currentWidth,
											300
											)
	botBorder.x = currentWidth/2;
	botBorder.y = background.height+255;
	botBorder:setFillColor(1,1,1,0.7)

	-- trees for background
	local mySheetTree1 = graphics.newImageSheet("Assets/Images/Sprite/4.png", sheetDataTree1)
	local tree1 = display.newSprite(sceneGroup,mySheetTree1,sequenceDataTree1)
	tree1:scale(0.55,0.55)
	--tree1:setFillColor(0,0,0,0.8)
	tree1.x = display.contentCenterX-110
	tree1.y = display.contentCenterY+60
	tree1:setSequence("normal")
	tree1:play()

	-- platform placeholder
	local platform1 = display.newImageRect( sceneGroup,
											 sceneBuild[20],
											 currentWidth,
											 currentHeight/15
										   )
	platform1.x = display.contentCenterX
	platform1.y = display.contentCenterY*2 - platform1.height*2 - 3
	--platform1:setFillColor(0,0,0)

    -- screen split placeholder
	local collumn = display.newImageRect( sceneGroup,
										  sceneBuild[13],
										  currentWidth/8,
										  currentHeight-175)
	collumn.x = currentWidth * 2 / 3
	collumn.y = display.contentCenterY+8

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
	replayButton.x = pauseButton.x
	replayButton.y = pauseButton.y + currentWidth / 16

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
		transition.cancel()
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
	pole.y = currentHeight - pole.height + 80

	-- animal 1 placeholder
	local animal1 = display.newSprite(sceneGroup,mySheetCat,sequenceDataCat)
	animal1:scale(0.5,0.5)
	animal1.x = pole.x / 2 - 25
	animal1.y = pole.y + pole.height - animal1.height - 25
	animal1:setSequence("idle")
	animal1:play()

	-- animal 2 placeholder
	local animal2 = display.newSprite(sceneGroup,mySheetCat,sequenceDataCat)
	animal2:scale(-0.5,0.5)
	animal2.x = pole.x + pole.x / 2 + 25
	animal2.y = pole.y + pole.height - animal1.height - 25
	animal2:setSequence("idle")
	animal2:play()

	-- physics testing
	physics.start()
	physics.addBody(platform1,"static")
	physics.addBody(animal1,"dynamic", {radius = 50, bounce = 0.1})
	physics.addBody(animal2,"dynamic", {radius = 50, bounce = 0.1})

	local function pushCat1()
		animal1:applyLinearImpulse(0,-0.75,animal1.x,animal1.y)
	end
	local function pushCat2()
		animal2:applyLinearImpulse(0,-0.75,animal2.x,animal2.y)
	end
	animal1:addEventListener("tap",pushCat1)
	animal2:addEventListener("tap",pushCat2)
	-- end physics test

	-- place holders for answer text
	local optionBox1 = display.newImageRect( sceneGroup,
											 sceneBuild[14],
											 currentWidth/5,
											 currentHeight/14
										   )
	optionBox1.x = animal1.x
	optionBox1.y = animal1.y - currentHeight/5
	local optionBox2 = display.newImageRect( sceneGroup,
										     sceneBuild[14],
										     currentWidth/5,
										     currentHeight/14
										   )
	optionBox2.x = animal2.x
	optionBox2.y = animal2.y - currentHeight/5
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
	local temp = display.newImageRect(sceneGroup, sceneBuild[1],currentWidth * 1 / 3, background.height+16)
	temp.x = collumn.x + collumn.x / 4
	temp.y = display.contentCenterY+8
	--temp:setFillColor(0,0,0,0)

	-- placeholder for road
	local road = display.newImageRect(sceneGroup,sceneBuild[15],100,temp.height)
	road.x = collumn.x + collumn.x /4
	road.y = temp.y
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
	-- end right side of screen --
	-------------------------------------------------------------------------------------------------------

	-- back-end -- Left side of screen --
	-------------------------------------------------------------------------------------------------------
	local usedFlag = {}
	local usedMonument = {}
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
			monuments_placer(2,count)
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
	-- monuments place holder
	-- 80 -> 6 monuments -> 6 rounds
	local size = 100
	for i = 1, 5 do
		local placeHolder = display.newImageRect(sceneGroup, sceneBuild[18], size+10, size+10)
		if i % 2 == 0 then
			placeHolder.x = road.x - road.width - 10
		else
			placeHolder.x = road.x + road.width + 10
		end
		placeHolder.y = 150 + i * size - 20
		placeHolder:setFillColor(1,1,1,1)
		table.insert(mon_placeholders,placeHolder)
	end
	local runFlipAnimation
	local function finishFlipAnimation( obj )
		transition.resume(obj)
		flagFlipping = false
		flipNearDone = false
		if wantAnotherFlip then
			runFlipAnimation(obj)
		end
		wantAnotherFlip = false
	end
	local function runReverseFlipAnimation( obj )
		flipNearDone = true
		transition.scaleTo(obj,
		{
			time = 250,
			xScale = 1,
			onComplete = function() finishFlipAnimation(obj) end,
			transition = easing.outCirc
		})
	end
	runFlipAnimation = function( obj )
		if flagFlipping then
			if flipNearDone then
				wantAnotherFlip = true
			end
			return
		end
		flagFlipping = true
		transition.pause(obj)
		transition.scaleTo(obj,
		{
			time = 250,
			xScale = 0.01,
			onComplete = function() runReverseFlipAnimation(obj) end,
			transition = easing.inCirc
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
										   currentWidth/7+35,
										   currentHeight/7+35
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
										  native.systemFont, 33
										)

		textBox2 = display.newText( sceneGroup,
										  box2,
										  optionBox2.x,
										  optionBox2.y,
										  native.systemFont, 33
										)

		-- color for the text
		textBox1:setFillColor( 0, 0, 0 )
		textBox2:setFillColor( 0, 0, 0 )
		-- fucntion for placing monument
		-- need t implement used monument, array created: local usedMonument
		function monuments_placer(num,num2)
			local randMonument = math.random(1,14)
			for i,item in ipairs(usedMonument) do
				if randMonument == item then randMonument = math.random(1,14) end
			end
			--local img
			for i,item in ipairs(mon_placeholders) do
				if(num == 1 and 6-num2 == i) then
					print("INSERTING")
					img = display.newImageRect( sceneGroup,
										   monumentAssets[randMonument],
										   currentWidth/7+35,
										   currentHeight/7+150
										 )
					img.x = item.x
					img.y = item.y-40
					print("INSERTED TO", i)
					table.insert(usedMonument,randMonument)
				elseif(num == 2 and 6-(num2+1) == i) then
					print("REMOVING")
					print("HERE1:",5-num2)
					print("HERE2:",i)
					if(img ~= nil)then
						img:removeSelf()
						img = nil
						print("REMOVED")
					end
				end
			end
		end
		-- end function for placing monument

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
				monuments_placer(1,count)
				animationStop(flag)
				table.insert(usedFlag,countryNames[randomFlag])
				local sound1 = audio.play(ding_fx)
				animal1:setSequence("happy")
				animal1:play()
				moveUpDown(animal3,count)
			else
				textTap(textBox1,"Wrong!")
				animationStop(flag)
				minusCount()
				monuments_placer(2,count)
				local sound2 = audio.play(lose_fx)
				animal1:setSequence("sad")
				animal1:play()
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
				monuments_placer(1,count)
				animationStop(flag)
				table.insert(usedFlag,countryNames[randomFlag])
				local sound1 = audio.play(ding_fx)
				animal2:setSequence("happy")
				animal2:play()
				moveUpDown(animal3,count)
			else
				textTap(textBox2,"Wrong!")
				animationStop(flag)
				minusCount()
				monuments_placer(2,count)
				local sound2 = audio.play(lose_fx)
				animal2:setSequence("sad")
				animal2:play()
				moveUpDown(animal3,count)
			end
			-- prepare for memory dump
			textBox1 = nil
			textBox2 = nil
		end)
		flag:addEventListener("tap", function()
			runFlipAnimation(flag)
		end)
		-- prepare for memory dump
		textBox3 = nil
		animationStart(flag)

		--background music, loop infinite, fadein in 5s
	    local backgroundMusicChannel = audio.play(backgroundMusic,{channel1=1,loops=-1,fadein=5000})
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
		composer.removeScene("Source.flagGame")
	end
end


-- destroy()
function scene:destroy( event )

	local sceneGroup = self.view
	-- Code here runs prior to the removal of scene's view
	-- composer.removeScene(sceneGroup)
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
