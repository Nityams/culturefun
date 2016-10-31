
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
local screenTop = (display.contentHeight - display.viewableContentHeight) / 2
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
	"Motenegro",
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

images.defineImage( "Top Border", sceneBuild[21], currentWidth, 300 )
images.defineImage( "Background", sceneBuild[19], currentWidth, currentHeight - 190 )
images.defineImage( "Bottom Border", sceneBuild[21], currentWidth, 300 )
images.defineImage( "Platform 1", sceneBuild[20], currentWidth, currentHeight/15 )
images.defineImage( "Column", sceneBuild[13], currentWidth/8, currentHeight-175 )
images.defineImage( "Pause Button", "Scene/10.png", currentWidth/20, currentHeight/14 )
images.defineImage( "Pause Button Pressed", "Scene/10-pressed.png", currentWidth/20, currentHeight/14 )
images.defineImage( "Info Button", "Scene/11.png", currentWidth/20, currentHeight/14 )
images.defineImage( "Info Button Pressed", "Scene/11-pressed.png", currentWidth/20, currentHeight/14 )
images.defineImage( "Pole", sceneBuild[2], currentWidth/17, currentHeight/1.8 )
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
images.defineSheet( "Dog", "Sprite/3.png", {
	width = 557,
	height = 491,
	numFrames = 30,
	sheetContentWidth = 2785,
	sheetContentHeight = 2946
})
images.defineSheet( "Tree", "Sprite/4.png", {
	width = 1463,
	height = 821,
	numFrames = 5,
	sheetContentWidth = 1463,
	sheetContentHeight = 4105
})
images.defineSheet( "Monu", "Sprite/5.png", {
	width = 248,
	height = 242,
	numFrames = 19,
	sheetContentWidth = 4892,
	sheetContentHeight = 242
})
images.defineSheet( "Star", "Sprite/6.png", {
	width = 252,
	height = 210,
	numFrames = 9,
	sheetContentWidth = 756,
	sheetContentHeight = 639
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
	return Preloader:new(coroutine.create(function()
		images.loadSheet( "Cat" ); coroutine.yield()
		images.loadSheet( "Dog" ); coroutine.yield()
		images.loadSheet( "Tree" ); coroutine.yield()
		images.loadSheet( "Monu" ); coroutine.yield()
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
		images.loadImage( "Pole" ); coroutine.yield()
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
	end))
end

-- create()
function scene:create( event )
	-- !! need to work on the ratio for the resolutions
	local sceneGroup = self.view
	local count = 0

	-- level declarations
	local level
	local randomNum
	local distance
	-- flag speed for level 1
	local speed1
	local speed2 = 1000
	-- end level declarations

	local difficulty = composer.getVariable( "difficulty" )

	if difficulty == 1 then
		level = 6		-- 6 rounds
		randomNum = 15  -- use the first 15 flags
		distance = 9
		speed1 = 7000
	elseif difficulty == 2 then
		level = 12		-- 12 rounds
		randomNum = 30	-- use the first 30 flags
		distance = 18
		speed1 = 6000
	else
		level = 15		-- 15 rounds
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

	local sequenceDataDog = {
		{
			name = "run",
			frames = {15,10,5,24,23,26,25,20},
			time = 500,
			loopCount = 2
		},
		{
			name = "idle",
			frames = {1,2,3,4,6,7,8,9,11,12},
			time = 2000,
			loopCount = 0
		},
		{
			name = "happy",
			frames = {13,14,16,17,18,19,21,22},
			time = 1000,
			loop = 0
		}
	};
	local mySheetDog = images.getSheet( "Dog" )
	-- end animal sprite --
	-------------------------------------------------------------------------------------------------------
	-- background animation --
	local sequenceDataTree1 = {
		{
			name = "normal1",
			frames = {1,2,2,2,3,3,3,4,4,4,4,5,5,5,3,3,3,3,3,3,3,3,5,5,2,2,2,2,2,2,2,4,4,4,4,4,4},
			time = 4000,
			loopCount = 0
		}
	};
	local mySheetTree1 = images.getSheet( "Tree" )
	--end background animation --
	-------------------------------------------------------------------------------------------------------
	-- monument placeholders animation --
	local sequenceDataMonu = {
		{
			name = "normal1",
			frames = {9,10,11,12,13,14,15,16,17,5,6,7,8},
			time = 6000,
			loopCount = 0
		},
		{
			name = "idle",
			frames = {9},
			time = 1000,
			loopCount = 1
		},
		{
			name = "port_in",
			frames = {9,10,11,12,13,14,15,16,17,5,6,7,8,1,2,3,4,18,19,9},
			time = 700,
			loopCount = 1
		},
		{
			name = "port_out",
			frames = {19,18,4,3,2,1,8,7,6,5,17,16,15,14,13,12,11,10,9},
			time = 1000,
			loopCount = 1
		},
	};
	local mySheetMonu = images.getSheet( "Monu" )
	--end monument placeholders animation --
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
	-- top border
	local topBorder = images.get( sceneGroup, "Top Border" )
	topBorder.x = currentWidth/2
	topBorder.y = 0
	topBorder:setFillColor(1,1,1,0.7)

	-- background placeholder
	local background = images.get( sceneGroup, "Background" )
	background.x = display.contentCenterX
	background.y = display.contentCenterY

	-- bottom border
	local botBorder = images.get( sceneGroup, "Bottom Border" )
	botBorder.x = currentWidth/2
	botBorder.y = background.height+255
	botBorder:setFillColor(1,1,1,0.7)

	-- trees for background
	local tree1 = display.newSprite(sceneGroup,mySheetTree1,sequenceDataTree1)
	tree1:scale(0.55,0.55)
	--tree1:setFillColor(0,0,0,0.8)
	tree1.x = display.contentCenterX-110
	tree1.y = display.contentCenterY+60
	tree1:setSequence("normal")
	tree1:play()

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
	pauseButton:addEventListener("tap", pauseTap)
	infoButton:addEventListener("tap", replayTap)
	-- End event Pause/Replay --

	-- flag pole placeholder
	local pole = images.get( sceneGroup, "Pole" )
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
		sounds.play( "Cat FX" )
	end
	local function pushCat2()
		animal2:applyLinearImpulse(0,-0.75,animal2.x,animal2.y)
		sounds.play( "Cat FX" )
	end
	animal1:addEventListener("tap",pushCat1)
	animal2:addEventListener("tap",pushCat2)
	-- end physics test
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
			transition.to(obj, {y = temp - currentHeight/distance * num})
		end
		obj:setSequence("run")
		obj:play()
	end
	
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
	local animal3 = display.newSprite(sceneGroup,mySheetDog,sequenceDataDog)
	animal3:scale(0.18,0.18)
	animal3.x = road.x
	animal3.y = currentHeight - (animal3.height * 0.28)
	animal3:setSequence("idle")
	animal3:play()

	-- place holder for star
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
	local usedMonument = {}
	local textBox1 -- text box for option 1
	local textBox2 -- text box for option 2

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
		    y = pole.y * 1.32,
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
		local placeHolder = display.newSprite(sceneGroup,mySheetMonu,sequenceDataMonu)
		placeHolder:scale(0.5,0.5)
		if i % 2 == 0 then
			placeHolder.x = road.x - road.width - 10
		else
			placeHolder.x = road.x + road.width + 10
		end
		placeHolder.y = 150 + i * size - 20
		placeHolder:setFillColor(1,1,1,1)
		placeHolder:setSequence("normal1")
		placeHolder:play()
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

		sounds.play( "Flag Flapping", 1 )

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
		math.randomseed(os.time())
		local randomFlag = math.random(1,randomNum)
		local i = 1
		while usedFlag[i] do
			if usedFlag[i] == countryNames[randomFlag] then
				randomFlag = math.random(1,randomNum)
				i = 1
			else i = i + 1 end
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
			box1 = rightAnswer
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

		-- function for placing monument
		function monuments_placer(num,score)
			math.randomseed(os.time())
			local randMonument = math.random(1,14)
			local i = 1
			while usedMonument[i] do
				if randMonument == usedMonument[i].index then
					randMonument = math.random(1,14)
					i = 1
				else i = i + 1 end
			end
			-- place monument on top of the stands
			local function place_img(item,randMonument)
				local img = display.newImageRect( sceneGroup,
											   monumentAssets[randMonument],
											   currentWidth/18+35,
											   currentHeight/27+150
											 )
				img.x = item.x
				img.y = item.y-75
				-- insert to table start from 1
				local monument_item =  {index = randMonument, obj = img}
				table.insert(usedMonument,monument_item)
			end
			-- function to resume the stands animation
			local function resume_animation(obj)
				obj:setSequence("normal1")
				obj:play()
			end
			if num == 1  then
				if difficulty == 1 and score ~= 6 then
					mon_placeholders[6-score]:setSequence("port_in")
					mon_placeholders[6-score]:play()
					sounds.play( "Port In" )
					timer.performWithDelay(600,function()place_img(mon_placeholders[6-score],randMonument) return true end, 1)
				elseif difficulty == 2 and score % 2 == 0 and score ~= 12 and usedMonument[score/2] == nil then
					mon_placeholders[6-score/2]:setSequence("port_in")
					mon_placeholders[6-score/2]:play()
					sounds.play( "Port In" )
					timer.performWithDelay(600,function()place_img(mon_placeholders[6-score/2],randMonument) return true end, 1)
				elseif difficulty == 3 and score % 3 == 0 then
					mon_placeholders[6-score/3]:setSequence("port_in")
					mon_placeholders[6-score/3]:play()
					sounds.play( "Port In" )
					timer.performWithDelay(600,function()place_img(mon_placeholders[6-score/3],randMonument) return true end, 1)
				end
			elseif num == 2 and score == 0 and usedMonument[1] ~= nil then
				usedMonument[1].obj:removeSelf()
				usedMonument[1] = nil
				local item2 = mon_placeholders[5]
				item2:setSequence("port_out")
				item2:play()
				sounds.play( "Port Out" )
				timer.performWithDelay(1000,function()resume_animation(item2) return true end, 1)
			elseif num == 2 and score ~= 0 then
			    -- removing monuments based on different difficulty
				local temp = score
				if difficulty == 1 then temp = temp + 1
				elseif difficulty == 2 then temp = (score+1)/2
				elseif difficulty == 3 then temp = (score+1)/3 end
				
				if usedMonument[temp] ~= nil then
					usedMonument[temp].obj:removeSelf()
					usedMonument[temp] = nil
					temp = temp - 1
					local item2 = mon_placeholders[5-temp]
					item2:setSequence("port_out")
					item2:play()
					sounds.play( "Port Out" )
					timer.performWithDelay(1000,function()resume_animation(item2) return true end, 1)
				end
			end
		end
		-- end function for placing monument

		-- Event for textboxes --
		local function disableButtons()
			textBox1.enabled = false
			textBox2.enabled = false
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
				monuments_placer(1,count)
				animationStop(flag)
				table.insert(usedFlag,countryNames[randomFlag])
				sounds.play( "Ding FX" )
				animal1:setSequence("happy")
				animal1:play()
				moveUpDown(animal3,count)
			else
				textTap(textBox1,"Wrong!")
				animationStop(flag)
				minusCount()
				monuments_placer(2,count)
				sounds.play( "Lose FX" )
				animal1:setSequence("sad")
				animal1:play()
				moveUpDown(animal3,count)
			end
		end)
		-- Event listener for text box 2
		textBox2:clearEventListeners()
		textBox2:addEventListener("pretap", disableButtons)
		textBox2:addEventListener("tap", function()
			if randomBox ~= 1 then
				textTap(textBox2,"Correct!")
				count = count + 1;
				monuments_placer(1,count)
				animationStop(flag)
				table.insert(usedFlag,countryNames[randomFlag])
				sounds.play( "Ding FX" )
				animal2:setSequence("happy")
				animal2:play()
				moveUpDown(animal3,count)
			else
				textTap(textBox2,"Wrong!")
				animationStop(flag)
				minusCount()
				monuments_placer(2,count)
				sounds.play( "Lose FX" )
				animal2:setSequence("sad")
				animal2:play()
				moveUpDown(animal3,count)
			end
		end)
		flag:addEventListener("tap", function()
			runFlipAnimation(flag)
			return true
		end)
		-- prepare for memory dump
		animationStart(flag)
	end
	-------------------------------------------------------------------------------------------------------
	-- End event for textboxes --
	-------------------------------------------------------------------------------------------------------
	-- function to start the game
	local function contButtonTap()
		-- this will stop the animations
		transition.cancel()
		returnToMenu()
	end
	local function endgame2()
		local text = display.newText(sceneGroup,"You earned a wishing star", star.x+25,star.y-150,font,44)
		text:setFillColor(0,0,0)
		local contButton = Button:newImageButton{
			group = sceneGroup,
			image = images.get( sceneGroup, "Cont Button" ),
			imagePressed = images.get( sceneGroup, "Cont Button Pressed" ),
			x = star.x + 25,
			y = star.y + 150,
			width = images.width( "Cont Button" ),
			height = images.height( "Cont Button" ),
			alpha = 0.9
		}
		contButton:addEventListener("tap", contButtonTap)
	end

	local function endgame()
		star:setSequence("end")
		star:play()
		transition.fadeOut(pole,{time = 2000})
		transition.to(star,{
			time = 2000,
			y = pole.y-40,
			x = pole.x-17,
			xScale = 0.9,
			yScale = 1,
			onComplete = endgame2
			})
	end
	function startGame()
	    -- memories dump
		animal1:setSequence("idle")
		animal2:setSequence("idle")
		animal3:setSequence("idle")
		animal1:play()
		animal2:play()
		animal3:play()
		if textBox1 ~= nil then
			textBox1.enabled = true
		end
		if textBox2 ~= nil then
			textBox2.enabled = true
		end
		-- check to start new round
		if count ~= level then
			startRound()
		else
			textBox1:removeSelf()
			textBox2:removeSelf()
			textBox1 = nil
			textBox2 = nil
			animal1:setSequence("happy")
			animal2:setSequence("happy")
			animal3:setSequence("happy")
			animal1:play()
			animal2:play()
			animal3:play()
			sounds.play( "Win FX" )
			sounds.play( "Celebrate FX" )
			endgame()
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
		physics.setGravity( 0, 9.8 )

		startGame()
		timer.performWithDelay( 25, startMusic )
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
		physics.pause()
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
