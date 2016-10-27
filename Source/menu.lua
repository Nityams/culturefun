
local composer = require( "composer" )

local Button = require( "Source.button" )
local fonts = require( "Source.fonts" )
local musics = require( "Source.musics" )
local util = require( "Source.util" )

local foodIntro = require( "Source.foodIntro" )

local scene = composer.newScene()


-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

local menuMusicChannel

local function removeMinigames()
	composer.removeScene( "Source.flagGame" )
	composer.removeScene( "Source.foodGame" )
end

local function gotoMinigame( name, file, menu )
	local sourcePath = "Source." .. file

	local params = {
		minigame = {
			name = name,
			sourcePath = sourcePath,
			preloader = function()
				local nextScene = require( sourcePath )
				if nextScene.preload then
					return nextScene:preload()
				end
			end
		},
		menuMusicChannel = menuMusicChannel
	}

	composer.gotoScene( "Source.difficultySelector", { params=params } )
end

local function gotoFlagMinigame()
	gotoMinigame( "Flag Game", "flagGame" )
end

local function gotoFoodMinigame()
	gotoMinigame( "Food Game", "foodIntro" )
end

local function startMusic()
	-- This music will be turned off in difficultySelector.lua
	menuMusicChannel = musics:play( "Menu Theme" )
end

musics:defineMusic( "Menu Theme", "Assets/Sounds/Music/bensound-littleidea.mp3", 0.7, 5000 )


-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )
	-- Code here runs when the scene is first created but has not yet appeared on screen

	local sceneGroup = self.view


	----------------
	-- Background --
	----------------

	local fill = display.newRect(
		sceneGroup,
		display.contentCenterX, display.contentCenterY,
		display.contentWidth, display.contentHeight
	)
	fill:setFillColor( 1, 1, 1 )

	local background = display.newImageRect(
		sceneGroup,
		"Assets/Images/MenuBackgroundV1Edit.jpg",
		display.contentWidth, display.contentHeight
	)
	background.x = display.contentCenterX
	background.y = display.contentCenterY

	-- To de-emphasize the background, reduce its opacity. Once the background
	-- image has been edited in Photoshop to make it less eye-catching, try
	-- removing this line and seeing if that works.
	background.alpha = 0.75

	self.logo = display.newImageRect(
		sceneGroup,
		"Assets/Images/MenuLogoV1Edit.jpg",
		323, 319
	)
	self.logo.x = display.contentCenterX
	self.logo.y = display.contentCenterY + 50


	----------------
	-- Foreground --
	----------------

	local font = fonts.neucha()

	local titleOffsetY = (util.aspectRatio() > 4/3 and 200 or 150)
	local titleFontSize = (util.aspectRatio() > 4/3 and 110 or 140)

	titleText = display.newText(
		sceneGroup,
		"Culture Fun",
		display.contentCenterX,
		titleOffsetY,
		font,
		titleFontSize
	)
	titleText:setFillColor( 0.4, 0.4, 0.4 )

	self.flagButton = Button:new{
		parentGroup=sceneGroup,
		font=font, fontSize=44, fontColor={ 0.4 },
		text="Play Flag Game",
		x=200, y=display.contentCenterY + 50,
		paddingX=20, paddingY=5,
		fillColor={ 0.97 }, fillColorPressed={ 0.90 },
		borderWidth=3, borderColor={ 0.85 }
	}
	self.foodButton = Button:new{
		parentGroup=sceneGroup,
		font=font, fontSize=44, fontColor={ 0.4 },
		text="Play Food Game",
		x=display.contentWidth - 200, y=display.contentCenterY + 50,
		paddingX=20, paddingY=5,
		fillColor={ 0.97 }, fillColorPressed={ 0.90 },
		borderWidth=3, borderColor={ 0.85 }
	}


	---------------
	-- Listeners --
	---------------

	self.logo:addEventListener( "tap", function(event)
		self:logoTapped(event)
		return true
	end)

	self.flagButton:addEventListener( "press", function()
		self.flagButton.enabled = false
		self.foodButton.enabled = false
		gotoFlagMinigame()
	end)
	self.foodButton:addEventListener( "press", function()
		self.flagButton.enabled = false
		self.foodButton.enabled = false
		gotoFoodMinigame()
	end)

	self.spinning = false
	self.wantSpin = false
	self.canWantSpin = false
end


function scene:logoTapped( event )
	if self.canWantSpin then
		self.wantSpin = true
	end

	if self.spinning then
		return
	end

	self:spinLogo()
end

function scene:spinLogo()
	self.spinning = true
	self.wantSpin = false
	self.canWantSpin = false

	timer.performWithDelay(2000, function()
		self.canWantSpin = true
	end)

	--logo = display.newImageRect( sceneGroup, "Assets/Images/MenuLogoV1Edit.jpg", 400, 400)
	--logo.x = display.contentCenterX
	--logo.y = display.contentCenterY + 50
	--transition.to(logo, { rotation=-360, time=3000, onComplete=spinLogo} )
	transition.to(self.logo, {rotation=-360, time=3000, onComplete=function()
		self.logo.rotation = 0
		self.spinning = false
		self.canWantSpin = false
		if self.wantSpin then
			self:spinLogo()
		end
	end})
end


-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

		self.flagButton.enabled = true
		self.foodButton.enabled = true

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen

		timer.performWithDelay( 25, startMusic )
		timer.performWithDelay( 25, removeMinigames )
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
