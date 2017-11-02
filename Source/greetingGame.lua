
local composer = require( "composer" )
local physics = require ( "physics")

local Button = require( "Source.button" )
local fonts = require( "Source.fonts" )
local images = require( "Source.images" )
local musics = require( "Source.musics" )
local Preloader = require( "Source.preloader" )
local sounds = require( "Source.sounds" )

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

local scene = composer.newScene()

local screenLeft = 0
local screenRight = display.contentWidth
local screenTop
-- dynamically choose right screen top based on resolutions
if display.viewableContentHeight < 760 then 
	screenTop = (display.contentHeight - display.viewableContentHeight) / 2
else
	screenTop = (display.contentHeight - display.viewableContentHeight) / 2 + 100
end
local screenBottom = (display.contentHeight + display.viewableContentHeight) / 2

local currentWidth = display.contentWidth
local currentHeight = display.contentHeight

local countryNames = {
	"United States", -- 1
	"United Kingdom",
	"Canada",
	"South Korea",
	"Netherlands",
	"Japan",
	"Australia",
	"Vietnam",
	"Mexico",
	"China", -- 10
	"Russia",
	"South Africa",
	"Germany",
	"Italy",
	"Malaysia",
	"Uruguay",
	"Brazil",
	"Thailand",
	"Taiwan",
	"Egypt", -- 20
	"Honduras",
	"Hungary",
	"Madagascar",
	"Mongolia",
	"Morocco",
	"New Zealand",
	"Peru",
	"Philippines",
	"Switzerland",
	"Ukraine", -- 30
	"Croatia",
	"Dominician",
	"East Timor",
	"El Salvador",
	"France",
	"Georgia",
	"Guatemala",
	"Haiti",
	"Kazakhstan",
	"Kenya", -- 40
	"Laos",
	"Liberia",
	"Luxembourg",
	"Macedonia",
	"Maldives",
	"Montenegro",
	"Mozambique",
	"Nauru",
	"Nigeria",
	"Norway", -- 50
	"Palau",
	"Portugal",
	"Saudi Arabia",
	"Serbia",
	"Singapore",
	"Slovakia",
	"Slovenia",
	"Sudan",
	"Syria",
	"Vatican City", -- 60
	"Zimbabwe"
};

local countryFiles = {
	"Assets/Images/Flags/United_States_Flag.png",
	"Assets/Images/Flags/United_Kingdom_Flag.png",
	"Assets/Images/Flags/Canada_Flag.png",
	"Assets/Images/Flags/South_Korea_Flag.png",
	"Assets/Images/Flags/Netherlands_Flag.png",
	"Assets/Images/Flags/Japan_Flag.png",
	"Assets/Images/Flags/Australia_Flag.png",
	"Assets/Images/Flags/Vietnam_Flag.png",
	"Assets/Images/Flags/Mexico_Flag.png",
	"Assets/Images/Flags/China_Flag.png",
	"Assets/Images/Flags/Russia_Flag.png",
	"Assets/Images/Flags/South_Africa_Flag.png",
	"Assets/Images/Flags/Germany_Flag.png",
	"Assets/Images/Flags/Italy_Flag.png",
	"Assets/Images/Flags/Malaysia_Flag.png",
	"Assets/Images/Flags/Uruguay_Flag.png",
	"Assets/Images/Flags/Brazil_Flag.png",
	"Assets/Images/Flags/Thailand_Flag.png",
	"Assets/Images/Flags/Taiwan_Flag.png",
	"Assets/Images/Flags/Egypt_Flag.png",
	"Assets/Images/Flags/Honduras_Flag.png",
	"Assets/Images/Flags/Hungary_Flag.png",
	"Assets/Images/Flags/Madagascar_Flag.png",
	"Assets/Images/Flags/Mongolia_Flag.png",
	"Assets/Images/Flags/Morocco_Flag.png",
	"Assets/Images/Flags/New_Zealand_Flag.png",
	"Assets/Images/Flags/Peru_Flag.png",
	"Assets/Images/Flags/Philippines_Flag.png",
	"Assets/Images/Flags/Switzerland_Flag.png",
	"Assets/Images/Flags/Ukraine_Flag.png",
	"Assets/Images/Flags/Croatia_Flag.png",
	"Assets/Images/Flags/Dominican_Republic_Flag.png",
	"Assets/Images/Flags/East_Timor_Flag.png",
	"Assets/Images/Flags/El_Salvador_Flag.png",
	"Assets/Images/Flags/France_Flag.png",
	"Assets/Images/Flags/Georgia_Flag.png",
	"Assets/Images/Flags/Guatemala_Flag.png",
	"Assets/Images/Flags/Haiti_Flag.png",
	"Assets/Images/Flags/Kazakhstan_Flag.png",
	"Assets/Images/Flags/Kenya_Flag.png",
	"Assets/Images/Flags/Laos_Flag.png",
	"Assets/Images/Flags/Liberia_Flag.png",
	"Assets/Images/Flags/Luxembourg_Flag.png",
	"Assets/Images/Flags/Macedonia_Flag.png",
	"Assets/Images/Flags/Maldives_Flag.png",
	"Assets/Images/Flags/Montenegro_Flag.png",
	"Assets/Images/Flags/Mozambique_Flag.png",
	"Assets/Images/Flags/Nauru_Flag.png",
	"Assets/Images/Flags/Nigeria_Flag.png",
	"Assets/Images/Flags/Norway_Flag.png",
	"Assets/Images/Flags/Palau_Flag.png",
	"Assets/Images/Flags/Portugal_Flag.png",
	"Assets/Images/Flags/Saudi_Arabia_Flag.png",
	"Assets/Images/Flags/Serbia_Flag.png",
	"Assets/Images/Flags/Singapore_Flag.png",
	"Assets/Images/Flags/Slovakia_Flag.png",
	"Assets/Images/Flags/Slovenia_Flag.png",
	"Assets/Images/Flags/Sudan_Flag.png",
	"Assets/Images/Flags/Syria_Flag.png",
	"Assets/Images/Flags/Vatican_City_Flag.png",
	"Assets/Images/Flags/Zimbabwe_Flag.png"
};

local sceneBuild ={
	"Scene/1.png",
	"Scene/2.png",
	"Scene/3.png",
	"Scene/4.png",
	"Scene/5.png",
	"Scene/6.png",
	"Scene/7.png",
	"Scene/8.png",
	"Scene/9.png",
	"Scene/10.png",
	"Scene/11.png",
	"Scene/12.png",
	"Scene/13.png", -- 13
	"Scene/14.png",
	"Scene/15.png",
	"Scene/16.png",
	"Scene/17.png",
	"Scene/18.png",
	"Scene/19.png",
	"Scene/20.png",
	"Scene/21.png",
	"Scene/22.png", -- 22
	"Scene/10-pressed.png", -- 23
	"Scene/19-blurred.png" -- 24
};


images.defineImage( "Top Border", sceneBuild[21], currentWidth, 300 )
images.defineImage( "Background", sceneBuild[19], currentWidth, currentHeight - 190 )
images.defineImage( "House 1", "Greeting/house1.png", currentWidth/1.2, currentHeight + 100)
images.defineImage( "Paused Screen", sceneBuild[24], currentWidth+190, currentHeight)
images.defineImage( "Info Screen", sceneBuild[3], currentWidth, currentHeight - 190)
images.defineImage( "Bottom Border", sceneBuild[21], currentWidth, 300 )
images.defineImage( "Platform 1", sceneBuild[20], currentWidth, currentHeight/15 )
images.defineImage( "Column", sceneBuild[13], currentWidth/8, currentHeight-175 )
images.defineImage( "Pause Button", "Scene/10.png", currentWidth/20, currentHeight/14 )
images.defineImage( "Pause Button Pressed", "Scene/10-pressed.png", currentWidth/20, currentHeight/14 )
images.defineImage( "Info Button", "Scene/11.png", currentWidth/20, currentHeight/14 )
images.defineImage( "Info Button Pressed", "Scene/11-pressed.png", currentWidth/20, currentHeight/14 )
images.defineImage( "Return Button", "Scene/9.png", currentWidth/20, currentHeight/14)
images.defineImage( "Return Button Pressed", "Scene/9-pressed.png", currentWidth/20, currentHeight/14)
images.defineImage( "Right Side", sceneBuild[1], currentWidth / 3, currentHeight-174 )
images.defineImage( "Road", sceneBuild[15], 100, currentHeight-174 )
images.defineImage( "Cont Button", "Scene/22.png", currentWidth/5, currentHeight/8)
images.defineImage( "Cont Button Pressed", "Scene/22-pressed.png", currentWidth/5, currentHeight/8)
images.defineSheet( "Cat", "Sprite/2.png", {
	width = 276.29,
	height = 238.29,
	numFrames = 49,
	sheetContentWidth = 1934,
	sheetContentHeight = 1668
})
images.defineSheet( "Star", "Sprite/6.png", {
	width = 252,
	height = 210,
	numFrames = 9,
	sheetContentWidth = 756,
	sheetContentHeight = 639
})
images.defineSheet( "Emoticon", "Sprite/7.png", {
	width = 167,
	height = 173,
	numFrames = 16,
	sheetContentWidth = 671,
	sheetContentHeight = 692
})

sounds.defineSound( "Win FX", "Assets/Sounds/FlagGame/YAY_FX.mp3", 0.5 )
sounds.defineSound( "Celebrate FX", "Assets/Sounds/FlagGame/CROWD.wav", 0.5 )
sounds.defineSound( "Ding FX", "Assets/Sounds/FlagGame/DING_FX.mp3", 0.5 )
sounds.defineSound( "Lose FX", "Assets/Sounds/FlagGame/WRONG_FX.mp3", 0.5 )
sounds.defineSound( "Cat FX", "Assets/Sounds/FlagGame/CAT_SOUND_FX.wav", 0.1 )
sounds.defineSound( "Flag Flapping", "Assets/Sounds/FlagGame/Flag Flapping.wav", 1 )
sounds.defineSound( "Port In", "Assets/Sounds/FlagGame/PowerUp18.mp3", 0.3 )
sounds.defineSound( "Port Out", "Assets/Sounds/FlagGame/PowerUp18_reversed.mp3", 0.3 )

musics.defineMusic( "Flag Theme", "Assets/Sounds/Music/Whimsical-Popsicle.mp3", 0.8, 5000 )
musics.defineMusic( "Birds", "Assets/Sounds/FlagGame/AMBIENT_BIRDS_FX.mp3", 0.8, 5000 )
musics.defineMusic( "Wind", "Assets/Sounds/FlagGame/WIND_FX.mp3", 0.4, 5000 )

local function startMusic()
	musics.play( "Flag Theme" )
	musics.play( "Birds" )
	--musics.play( "Wind" )
end

local function returnToMenu()
	composer.gotoScene( "Source.menu" )
end

local font = fonts.neucha()

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


-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

function scene:preload()
	local numberSheets = 5
	local numberImages = 13
	local numberMusics = 2
	local numberSounds = 8
	local totalImportantObjects = numberSheets + numberImages + numberMusics + numberSounds

	return Preloader:new(coroutine.create(function()
		images.loadSheet( "Cat" ); coroutine.yield()
		images.loadSheet( "Dog" ); coroutine.yield()
		images.loadSheet( "Star" ); coroutine.yield()
		images.loadImage( "Top Border" ); coroutine.yield()
		images.loadImage( "Background" ); coroutine.yield()
		images.loadImage( "Bottom Border" ); coroutine.yield()
		images.loadImage( "Platform 1" ); coroutine.yield()
		images.loadImage( "Column" ); coroutine.yield()
		images.loadImage( "Pause Button" ); coroutine.yield()
		images.loadImage( "Pause Button" ); coroutine.yield()
		images.loadImage( "Pause Button Pressed" ); coroutine.yield()
		images.loadImage( "Info Button" ); coroutine.yield()
		images.loadImage( "Info Button Pressed" ); coroutine.yield()
		images.loadImage( "Right Side" ); coroutine.yield()
		images.loadImage( "Road" ); coroutine.yield()
		musics.loadMusic( "Flag Theme" ); coroutine.yield()
		musics.loadMusic( "Birds" ); coroutine.yield()
		sounds.loadSound( "Port In" ); coroutine.yield()
		sounds.loadSound( "Port Out" ); coroutine.yield()
		sounds.loadSound( "Ding FX" ); coroutine.yield()
		sounds.loadSound( "Lose FX" ); coroutine.yield()
		sounds.loadSound( "Cat FX" ); coroutine.yield()
		sounds.loadSound( "Win FX" ); coroutine.yield()
		sounds.loadSound( "Celebrate FX" ); coroutine.yield()
		sounds.loadSound( "Flag Flapping" ); coroutine.yield()
	end), totalImportantObjects)
end

-- create()
function scene:create( event )
	-- !! need to work on the ratio for the resolutions
	--physics.start()
	local sceneGroup = self.view
	local count = 0 -- keeping track round's score
	local count2 = 0 -- keeping track wrong answers left

	-- level declarations
	local level
	local lives
	local randomNum
	local distance
	-- flag speed for level 1
	local speed1
	local speed2 = 1000
	-- end level declarations

	local difficulty = composer.getVariable( "difficulty" )

	if difficulty == 1 then
		level = 6		-- 6 rounds
		lives = 3 		-- 3 lives
		randomNum = 15  -- use the first 15 flags
		distance = 9
		speed1 = 7000
	elseif difficulty == 2 then
		level = 12		-- 12 rounds
		lives = 4		-- 3 lives
		randomNum = 30	-- use the first 30 flags
		distance = 18
		speed1 = 6000
	else
		level = 15		-- 15 rounds
		lives = 5		-- 5 lives
		randomNum = 60	-- use the first 60 flags
		distance = 22
		speed1 = 5000
	end

	local flag
	local flagFlipping = false
	local flipNearDone = false
	local wantAnotherFlip = false
	local mon_placeholders = {}

	-- animal sprite --
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
	local mySheetCat = images.getSheet( "Cat" )

	-------------------------------------------------------------------------------------------------------
	-- star animations --
	local sequenceDataStar = {
		{
			name = "normal",
			frames = {2,2,2,5,5,5,8,8,8,9,9,9,6,6,6,3,3,3},
			time = 1000,
			loopCount = 0
		},
		{
			name = "end",
			frames = {2,5,8,9,6,3,7},
			time = 2000,
			loopCount = 1
		}
	};
	local mySheetStar = images.getSheet( "Star" )
	-- end star animations --
	-- Front-end --
	-------------------------------------------------------------------------------------------------------

	-- background placeholder
	local background = images.get( sceneGroup, "Background" )
	background.x = display.contentCenterX
	background.y = display.contentCenterY
	background:setFillColor(0,0,0)

	local house = images.get (sceneGroup , "House 1")
	house.x = display.contentCenterX *2/3
	house.y = display.contentCenterY / 1.5

	-- top border
	local topBorder = images.get( sceneGroup, "Top Border" )
	topBorder.x = currentWidth/2
	topBorder.y = -55
	topBorder:setFillColor(1,1,1)

	-- bottom border
	local botBorder = images.get( sceneGroup, "Bottom Border" )
	botBorder.x = currentWidth/2
	botBorder.y = background.height+255
	botBorder:setFillColor(1,1,1,0.7)

	-- platform placeholder
	local platform1 = images.get( sceneGroup, "Platform 1" )
	platform1.x = display.contentCenterX
	platform1.y = display.contentCenterY*2 - platform1.height*2 - 3
	--platform1:setFillColor(0,0,0)

    -- screen split placeholder
	local collumn = images.get( sceneGroup, "Column" )
	collumn.x = currentWidth * 2 / 3
	collumn.y = display.contentCenterY+8

	-- pause button placeholder
	local pauseButton = Button:newImageButton{
		group = sceneGroup,
		image = images.get( sceneGroup, "Pause Button" ),
		imagePressed = images.get( sceneGroup, "Pause Button Pressed" ),
		x = 50,
		y = screenTop + 50,
		width = images.width( "Pause Button" ),
		height = images.height( "Pause Button" ),
		alpha = 0.9,
		allowance = 8  -- Normally 30, but they are 16 pixels apart
	}

	-- info button placeholder
	local infoButton = Button:newImageButton{
		group = sceneGroup,
		image = images.get( sceneGroup, "Info Button" ),
		imagePressed = images.get( sceneGroup, "Info Button Pressed" ),
		x = pauseButton.x,
		y = pauseButton.y + currentWidth/16,
		width = images.width( "Pause Button" ),
		height = images.height( "Pause Button" ),
		alpha = 0.9,
		allowance = 8  -- Normally 30, but they are 16 pixels apart
	}

	-- pause/play event
	-- temp2 store the values to decide play/pause
	-- overlay
	local function getOverlayPause()
		local overlay = images.get( sceneGroup, "Paused Screen" )
		overlay.x = display.contentCenterX
		overlay.y = display.contentCenterY
		local pausedText = display.newText("Game is Paused", display.contentCenterX,display.contentCenterY-100,font,100)
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
			purgeObjs()
			enableButtons()
			transition.resume(flag)
		end
		local function quitTap()
			purgeObjs()
			transition.cancel()
			returnToMenu()
		end
		resumeButton:addEventListener("tap", resumeTap)
		quitButton:addEventListener("tap", quitTap)
	end

	local function pauseTap()
		transition.pause(flag)
		disableButtonsHelper()
		getOverlayPause()
	end

	local function infoTap()
		-- this will stop the animations
		disableButtonsHelper()
		transition.pause(flag)
		local overlay = images.get( sceneGroup, "Info Screen" )
		overlay.x = display.contentCenterX
		-- dynamically position based on screen's resolution
		if display.viewableContentHeight < 760 then
			overlay.y = display.contentCenterY
		else
			overlay.y = display.contentCenterY+9
		end
		local returnButton = Button:newImageButton{
			group = sceneGroup,
			image = images.get( sceneGroup, "Return Button" ),
			imagePressed = images.get( sceneGroup, "Return Button Pressed" ),
			x = 70,
			y = screenTop + 60,
			width = images.width( "Pause Button" ),
			height = images.height( "Pause Button" ),
			alpha = 0.9,
			allowance = 8  -- Normally 30, but they are 16 pixels apart
		}
		local function returnTap()
			overlay:removeSelf()
			overlay = nil
			returnButton:removeSelf()
			returnButton = nil
			transition.resume(flag)
			enableButtons()
		end
		returnButton:addEventListener("tap", returnTap)
	end
	pauseButton:addEventListener("tap", pauseTap)
	infoButton:addEventListener("tap", infoTap)
	-- End event Pause/Replay --

	-- end front-end --
	-------------------------------------------------------------------------------------------------------

	-- right side of screen --
	-------------------------------------------------------------------------------------------------------
	
	-- temp = placeholder for all right side
	local temp = images.get( sceneGroup, "Right Side" )
	temp.x = collumn.x + collumn.x / 4
	temp.y = display.contentCenterY+8
	--temp:setFillColor(0,0,0,0)

	-- placeholder for road
	local road = images.get( sceneGroup, "Road" )
	road.x = collumn.x + collumn.x /4
	road.y = temp.y
	-- placeholder for animal on the road

	-- placeholder for star
	local star = display.newSprite(sceneGroup,mySheetStar,sequenceDataStar)
	star.x = road.x
	star.y = 140
	star:scale(0.35,0.35)
	star:setSequence("normal")
	star:play()
	-- end right side of screen --
	-------------------------------------------------------------------------------------------------------

	-- back-end -- Left side of screen --
	-------------------------------------------------------------------------------------------------------
	local usedFlag = {}
	local textBox1 -- text box for option 1
	local textBox2 -- text box for option 2
	local temp2 = 0 -- do not animate if the lives stay the same
	
	-- function to decrease the Count
	local function minusCount()
		if count > 0 then
			count = count - 1
		end
		count2 = count2 + 1
	end
	-- random to choose the box
	local function startRound ()
		math.randomseed(os.time())
		local randomFlag = math.random(1,randomNum)
		local i = 1
		while usedFlag[i] do
			if usedFlag[i] == countryNames[randomFlag] then
				randomFlag = math.random(1,randomNum)
				i = 1
			else i = i + 1 end
		end

		-- random between 2 boxes
		local randomBox = math.random(1,2) --countryNames[randomBox]
		local rightAnswer = countryNames[randomFlag]
		-- don't have to change the constant here, it's just wrong answer
		local wrongAnswer = countryNames[math.random(1,randomNum)]
		local box1
		local box2
		-- loop to get wrong answer
		-- don't have to change the constant here, it's just wrong answer
		while wrongAnswer == countryNames[randomFlag] do
			wrongAnswer = countryNames[math.random(1,randomNum)]
		end
		-- random placer
		if randomBox == 1 then
			box1 = rightAnswer -- string 
			box2 = wrongAnswer
		else
			box1 = wrongAnswer
			box2 = rightAnswer
		end
		-- text box to hold the answer texts
		if textBox1 == nil then
			textBox1 = makeBox( sceneGroup, animal1.x, animal1.y - currentHeight/5, box1 )
		end
		if textBox2 == nil then
			textBox2 = makeBox( sceneGroup, animal2.x, animal2.y - currentHeight/5, box2 )
		end
		textBox1:setText( box1 )
		textBox2:setText( box2 )

		-- Event for textboxes --
		function disableButtonsHelper()
			disableButtons()
			pauseButton.enabled = false
			infoButton.enabled = false

		end
		function disableButtons()
			textBox1.enabled = false
			textBox2.enabled = false
		end
		function enableButtons()
			textBox1.enabled = true
			textBox2.enabled = true
			pauseButton.enabled = true
			infoButton.enabled = true
		end
		local function textTap( obj, value )
			if obj == textBox1 then
				textBox1:setText( value )
				textBox2:setText( "" )
			else
				textBox1:setText( "" )
				textBox2:setText( value )
			end
		end
		-- Event listener for text box 1
		textBox1:clearEventListeners()
		textBox1:addEventListener("pretap", disableButtons)
		textBox1:addEventListener("tap", function()
			if randomBox == 1 then
				textTap(textBox1,"Correct!")
				count = count + 1;
				table.insert(usedFlag,countryNames[randomFlag])
				sounds.play( "Ding FX" )
			else
				textTap(textBox1,"Wrong!")
				minusCount()
				sounds.play( "Lose FX" )
			end
		end)
		-- Event listener for text box 2
		textBox2:clearEventListeners()
		textBox2:addEventListener("pretap", disableButtons)
		textBox2:addEventListener("tap", function()
			if randomBox ~= 1 then
				textTap(textBox2,"Correct!")
				count = count + 1;
				table.insert(usedFlag,countryNames[randomFlag])
				sounds.play( "Ding FX" )
			else
				textTap(textBox2,"Wrong!")
				minusCount()
				sounds.play( "Lose FX" )
			end
		end)
		--animationStart(flag)
	end
	-------------------------------------------------------------------------------------------------------
	-- End event for textboxes --
	-------------------------------------------------------------------------------------------------------

	local function contButtonTap()
		-- this will stop the animations
		transition.cancel()
		returnToMenu()
	end
	-- function to start the game
	function startGame()
	    -- memories dump
		if textBox1 ~= nil then
			textBox1.enabled = true
		end
		if textBox2 ~= nil then
			textBox2.enabled = true
		end
		-- check to start new round
		if count2 == lives then
			textBox1:removeSelf()
			textBox2:removeSelf()
			textBox1 = nil
			textBox2 = nil
			pauseButton:removeSelf()
			pauseButton = nil
			infoButton:removeSelf()
			infoButton = nil

		elseif count ~= level then
			startRound()
		-- this happens when the round ended
		else
			textBox1:removeSelf()
			textBox2:removeSelf()
			textBox1 = nil
			textBox2 = nil
			pauseButton:removeSelf()
			pauseButton = nil
			infoButton:removeSelf()
			infoButton = nil

			sounds.play( "Win FX" )
			sounds.play( "Celebrate FX" ) 
		end
		--display.newText(sceneGroup,count, display.contentCenterX,display.contentCenterY,font,44)
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
		--physics.setGravity( 0, 9.8 )

		--startGame()
		--timer.performWithDelay( 25, startMusic )
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
		--physics.stop()
	end
end


-- destroy()
function scene:destroy( event )
	-- Code here runs prior to the removal of scene's view

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
