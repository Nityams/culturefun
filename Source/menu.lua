
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

local minigames = {
	"Source.flagGame",
	"Source.foodGame"
};

local menuMusic

local function removeMinigames()
	for i,game in ipairs(minigames) do
		composer.removeScene( game )
	end
end

local function gotoMinigame( name, file )
	local sourcePath = "Source." .. file

	composer.setVariable( "minigameName", name )
	composer.setVariable( "minigameSourceFile", sourcePath )

	local nextScene = require( sourcePath )

	local params = {
		preloader = nextScene.preload
	}

	composer.gotoScene( "Source.difficultySelector", { params=params } )
end

local function gotoFlagMinigame()
	gotoMinigame( "Flag Game", "flagGame" )
end

local function gotoFoodMinigame()
	gotoMinigame( "Food Game", "foodIntro" )
end

musics:defineMusic( "Menu Theme", "Assets/Sounds/Music/Monkey-Drama.mp3", 0.7, 5000 )

local function startMusic()
	-- This music will be turned off in difficultySelector.lua
	local channel = musics:play( "Menu Theme" )
	composer.setVariable( "menuMusicChannel", channel )
end


-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )
	-- Code here runs when the scene is first created but has not yet appeared on screen

	local sceneGroup = self.view


	local background = display.newRect(
		sceneGroup,
		display.contentCenterX, display.contentCenterY,
		display.contentWidth, display.contentHeight
	)
	background:setFillColor( 1, 1, 1 )

	local logo = display.newImageRect(
		sceneGroup,
		"Assets/Images/How_In_The_World.png", 323, 319
	)
	logo.x = display.contentCenterX
	logo.y = display.contentCenterY + 50


	local font = fonts.neucha()

	local titleOffsetY = (util.aspectRatio() > 4/3 and 200 or 150)
	local titleFontSize = (util.aspectRatio() > 4/3 and 96 or 104)

	titleText = display.newText(
		sceneGroup,
		"Culture Fun",
		display.contentCenterX,
		titleOffsetY,
		font,
		titleFontSize
	)
	titleText:setFillColor( 0.4, 0.4, 0.4 )

	local flagButton = Button:new{
		parentGroup=sceneGroup,
		font=font, fontSize=44, fontColor={ 0.4 },
		text="Play Flag Game",
		x=200, y=display.contentCenterY + 50,
		paddingX=20, paddingY=5,
		fillColor={ 0.97 }, fillColorPressed={ 0.90 },
		borderWidth=3, borderColor={ 0.85 }
	}
	local foodButton = Button:new{
		parentGroup=sceneGroup,
		font=font, fontSize=44, fontColor={ 0.4 },
		text="Play Food Game",
		x=display.contentWidth - 200, y=display.contentCenterY + 50,
		paddingX=20, paddingY=5,
		fillColor={ 0.97 }, fillColorPressed={ 0.90 },
		borderWidth=3, borderColor={ 0.85 }
	}

	flagButton:addEventListener( "press", gotoFlagMinigame )
	foodButton:addEventListener( "press", gotoFoodMinigame )
end


-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

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
