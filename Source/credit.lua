local composer = require( "composer" )

local Button = require( "Source.button" )
local images = require( "Source.images" )
local musics = require( "Source.musics" )
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

images.defineImage( "Credit", "Credits/credit_2.png", display.contentWidth, display.contentHeight-150 )
images.defineImage( "Close Button", "FlagGame/Scene/9.png", display.contentWidth/20, display.contentHeight/14 )
images.defineImage( "Close Button Pressed", "FlagGame/Scene/9-pressed.png", display.contentWidth/20, display.contentHeight/14 )
images.defineSheet( "Screen", "Credits/sprite.png", {
	width = 712,
	height = 558,
	numFrames = 2,
	sheetContentWidth = 1424,
	sheetContentHeight = 558
})
local sequenceDataScreen = {
		{
			name = "normal1",
			frames = {1,2},
			time = 500,
			loopCount = 0
		}
	};
local mySheetScreen = images.getSheet( "Screen" )

musics.defineMusic( "Credits Theme", "Assets/Sounds/Music/A-Night-Of-Dizzy-Spells.mp3", 1, 5000 )

local function gotoMenu()
	composer.gotoScene("Source.menu")
end

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )
	-- Code here runs when the scene is first created but has not yet appeared on screen
	local sceneGroup = self.view

	local whiteFill = display.newRect( sceneGroup, display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight )
	whiteFill:setFillColor( 1, 1, 1 )

	self.neighborhood = images.get( sceneGroup, "Credit" )

	local returnButton = Button:newImageButton{
		group = sceneGroup,
		image = images.get( sceneGroup, "Close Button" ),
		imagePressed = images.get( sceneGroup, "Close Button Pressed" ),
		x = 50,
		y = screenTop + 50,
		width = images.width( "Close Button" ),
		height = images.height( "Close Button" ),
		alpha = 0.9
	}
	returnButton:addEventListener( "tap", gotoMenu )

	local screen = display.newSprite(sceneGroup,mySheetScreen,sequenceDataScreen)
	screen:scale(0.55,0.55)
	screen.x = display.contentCenterX+9
	screen.y = display.contentCenterY-23
	screen:setSequence("normal1")
	screen:play()
end


-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)
		musics.play("Credits Theme")

		self.neighborhood.alpha = 0
		transition.to( self.neighborhood, { time=800, alpha=1 } )

		self.neighborhood.x = display.contentCenterY+128
		self.neighborhood.y = display.contentCenterX-110


	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen
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
