
local composer = require( "composer" )
local util = require( "Source.util" )
local Button = require( "Source.button" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

local minigames = {
	"Source.flagGame",
	"Source.foodGame",
	"Source.game3",
	"Source.game4"
};

local backgroundMusic
local backgroundMusicChannel

local function removeMinigames()
	for i,game in ipairs(minigames) do
		composer.removeScene( game )
	end
end

local function gotoMinigame( name )
	local minigameSourceFile = "Source." .. name
	composer.gotoScene( minigameSourceFile )
end


-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen

	local background = display.newRect( sceneGroup, display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight )
	background:setFillColor( 1, 1, 1 )

	local logo = display.newImageRect( sceneGroup, "Assets/Images/How_In_The_World.png", 323, 319 )
	logo.x = display.contentCenterX
	logo.y = display.contentCenterY

	local font = native.newFont( "Assets/Fonts/neucha.otf" )

	local flagButton = Button:new{
		parentGroup=sceneGroup,
		font=font, fontSize=44, fontColor={ 0.4 },
		text="Play Flag Game",
		x=200, y=display.contentCenterY,
		paddingX=20, paddingY=5,
		fillColor={ 0.97 }, borderWidth=3, borderColor={ 0.85 }
	}
	local foodButton = Button:new{
		parentGroup=sceneGroup,
		font=font, fontSize=44, fontColor={ 0.4 },
		text="Play Food Game",
		x=display.contentWidth - 200, y=display.contentCenterY,
		paddingX=20, paddingY=5,
		fillColor={ 0.97 }, borderWidth=3, borderColor={ 0.85 }
	}

	flagButton:addEventListener( "press", function()
		gotoMinigame( "flagGame" )
	end)
	foodButton:addEventListener( "press", function()
		gotoMinigame( "foodIntro" )
	end)

	local titleOffsetY = (util.aspectRatio() > 4/3 and 175 or 75)
	titleText = display.newText( sceneGroup, "Culture Fun", 200, titleOffsetY, font, 72 )
	titleText:setFillColor( 0.4, 0.4, 0.4 )

	if backgroundMusic == nil then
		backgroundMusic = audio.loadStream( "Assets/Sounds/Music/Monkey-Drama.mp3" )
	end

end


local function musicComplete()
	audio.setVolume( 1, { channel=backgroundMusicChannel } )
end


-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen

		removeMinigames()

	    backgroundMusicChannel = audio.play(backgroundMusic, { loops=-1, fadein=5000, onComplete=musicComplete } )

	end
end


-- hide()
function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is on screen (but is about to go off screen)

		audio.fadeOut( { channel=backgroundMusicChannel, time=500 } )

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
