local composer = require( "composer" )
local physics = require ( "physics")

local Button = require( "Source.button" )
local fonts = require( "Source.fonts" )
local images = require( "Source.images" )
local musics = require( "Source.musics" )
local Preloader = require( "Source.preloader" )
local sounds = require( "Source.sounds" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

images:defineImage( "Credit", "Credits/credit.png", display.contentWidth, display.contentHeight-150 )
images:defineImage( "Close Button", "Scene/11.png", display.contentWidth/20, display.contentHeight/14 )
images:defineImage( "Close Button Pressed", "Scene/11-pressed.png", display.contentWidth/20, display.contentHeight/14 )
musics:defineMusic( "Flag Theme", "Assets/Sounds/Music/Fate-Stay-Night.mp3", 0.8, 5000 )

local function gotoMenu()
	composer.gotoScene("Source.menu")
end
local function removeGame()
	composer.removeScene("Source.menu")
end

local function moveImage(obj)
	transition.to(obj,{
			time = 14000,
			y = display.contentCenterY,
			x = display.contentCenterX,
			})
end


-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

function scene:preload()
	return Preloader:new(coroutine.create(function()
		images:preload( "Neighborhood" ); coroutine.yield()
	end))
end

-- create()
function scene:create( event )
	-- Code here runs when the scene is first created but has not yet appeared on screen
	removeGame()
	local sceneGroup = self.view

	local whiteFill = display.newRect( sceneGroup, display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight )
	whiteFill:setFillColor( 1, 1, 1 )

	self.neighborhood = images:get( sceneGroup, "Credit" )
	self.neighborhood.x = display.contentCenterY+400
	self.neighborhood.y = display.contentCenterX+400

	moveImage(self.neighborhood)

	local returnButton = Button:newImageButton{
		group = sceneGroup,
		image = images:get( sceneGroup, "Close Button" ),
		imagePressed = images:get( sceneGroup, "Close Button Pressed" ),
		x = display.contentWidth / 20,
		y = display.contentHeight / 5,
		width = images:width( "Close Button" ),
		height = images:height( "Close Button" ),
		alpha = 0.5
	}
	returnButton:addEventListener( "tap", gotoMenu )
end


-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)
		musics:play("Flag Theme")
		self.neighborhood.alpha = 0
		transition.to( self.neighborhood, { time=800, alpha=1, onComplete=bellsound } )

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
