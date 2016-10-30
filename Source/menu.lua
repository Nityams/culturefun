
local composer = require( "composer" )

local Button = require( "Source.button" )
local fonts = require( "Source.fonts" )
local musics = require( "Source.musics" )
local Preloader = require( "Source.preloader" )
local sounds = require( "Source.sounds" )
local util = require( "Source.util" )

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

sounds:defineSound( "Charm", "Assets/Sounds/Menu/Charm.mp3", 1.0 )
musics:defineMusic( "Menu Theme", "Assets/Sounds/Music/bensound-littleidea.mp3", 0.7, 5000 )

local function startMusic()
	-- This music will be turned off in difficultySelector.lua
	menuMusicChannel = musics:play( "Menu Theme" )
end


-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

function scene:preload()
	return Preloader:new(coroutine.create(function()
		Button.preload(); coroutine.yield()
		sounds:preloadSound( "Charm" ); coroutine.yield()
		sounds:preloadSound( "Charm" ); coroutine.yield()
		self.difficultySelector = require( "Source.difficultySelector" ); coroutine.yield()
		self.difficultySelector:preload(); coroutine.yield()
		--self.flatGame = require( "Source.flagGame" ); coroutine.yield()
		--self.foodIntro = require( "Source.foodIntro" ); coroutine.yield()
		--self.foodGame = require( "Source.foodGame" ); coroutine.yield()
	end))
end

-- create()
function scene:create( event )
	-- Code here runs when the scene is first created but has not yet appeared on screen

	local sceneGroup = self.view

	----------------
	-- Background --
	----------------

	local bgWhiteFill = display.newRect(
		sceneGroup,
		display.contentCenterX, display.contentCenterY,
		display.contentWidth, display.contentHeight
	)
	bgWhiteFill:setFillColor( 1, 1, 1 )

	local bgWorldMap = display.newImageRect(
		sceneGroup,
		"Assets/Images/Menu/MenuBackgroundV1Edit.png",
		display.contentWidth, display.contentHeight*1.3
	)
	bgWorldMap.x = display.contentCenterX
	bgWorldMap.y = display.contentCenterY
	bgWorldMap.alpha = 0.5

	self.logo = display.newImageRect(
		sceneGroup,
		"Assets/Images/Menu/MenuLogoV1Edit.png",
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

	self.flagButton = Button:newTextButton{
		parentGroup=sceneGroup,
		font=font, fontSize=44, fontColor={ 0.4 },
		text="Play Flag Game",
		x=200, y=display.contentCenterY + 50,
		paddingX=20, paddingY=5,
		fillColor={ 0.97 }, fillColorPressed={ 0.90 },
		borderWidth=3, borderColor={ 0.85 }
	}
	self.foodButton = Button:newTextButton{
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

	local function disableButtons()
		self.flagButton.enabled = false
		self.foodButton.enabled = false
	end
	self.flagButton:addEventListener( "pretap", disableButtons )
	self.foodButton:addEventListener( "pretap", disableButtons )
	self.flagButton:addEventListener( "tap", function() self:gotoFlagMinigame() end )
	self.foodButton:addEventListener( "tap", function() self:gotoFoodMinigame() end )
end


-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

		self.flagButton.enabled = true
		self.foodButton.enabled = true

		self.logo.rotation = 0
		self.spinning = false
		self.wantSpin = false
		self.canWantSpin = false

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen

		timer.performWithDelay( 25, startMusic )
		timer.performWithDelay( 25, removeMinigames )
		timer.performWithDelay( 25, function()
			if self.preloader == nil then
				self.preloader = self:preload()
			end
		end)
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


function scene:gotoMinigame( name, file, menu )
	self.preloader:stop()

	local sourcePath = "Source." .. file
	local nextScene = require( sourcePath )

	local params = {
		minigame = {
			name = name,
			sourcePath = sourcePath,
			preloadFn = function() return nextScene:preload() end
		},
		menuMusicChannel = menuMusicChannel
	}

	composer.gotoScene( "Source.difficultySelector", { params=params } )
end


function scene:gotoFlagMinigame()
	self:gotoMinigame( "Flag Game", "flagGame" )
end


function scene:gotoFoodMinigame()
	self:gotoMinigame( "Food Game", "foodIntro" )
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
	timer.performWithDelay( 0, function() sounds:play( "Charm" ) end )

	self.spinning = true
	self.wantSpin = false
	self.canWantSpin = false

	timer.performWithDelay(1000, function()
		self.canWantSpin = true
	end)

	--logo = display.newImageRect( sceneGroup, "Assets/Images/MenuLogoV1Edit.jpg", 400, 400)
	--logo.x = display.contentCenterX
	--logo.y = display.contentCenterY + 50
	--transition.to(logo, { rotation=-360, time=3000, onComplete=spinLogo} )
	transition.to(self.logo, {rotation=-360, time=2000, onComplete=function()
		self.logo.rotation = 0
		self.spinning = false
		self.canWantSpin = false
		if self.wantSpin then
			self:spinLogo()
		end
	end})
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
