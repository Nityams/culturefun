
local composer = require( "composer" )
local util = require( "Source.util" )
local Button = require( "Source.button" )
local fonts = require( "Source.fonts" )

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
	composer.setVariable( "minigameName", name )
	composer.setVariable( "minigameSourceFile", "Source." .. file )
	composer.gotoScene( "Source.difficultySelector" )
end

local function gotoFlagMinigame()
	gotoMinigame( "Flag Game", "flagGame" )
end

local function gotoFoodMinigame()
	gotoMinigame( "Food Game", "foodIntro" )
end

local function startMusic()
	if menuMusic == nil then
		menuMusic = audio.loadStream( "Assets/Sounds/Music/Monkey-Drama.mp3" )
	end
    local menuMusicChannel = audio.play(menuMusic, { loops=-1 } )
	audio.setVolume( 0, { channel=menuMusicChannel } )
	audio.fade( { channel=menuMusicChannel, time=5000, volume=0.7 } )
	composer.setVariable( "menuMusicChannel", menuMusicChannel )  -- Turned off in difficultySelector.lua
end


-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen


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

		timer.performWithDelay( 0, startMusic )
		timer.performWithDelay( 0, removeMinigames )
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
