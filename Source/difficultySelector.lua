local composer = require( "composer" )

local Button = require( "Source.button" )
local fonts = require( "Source.fonts" )
local util = require( "Source.util" )

local scene = composer.newScene()

local font = fonts.neucha()
local titleOffsetY = (util.aspectRatio() > 4/3 and 250 or 175)


-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------


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

	local chooseText = display.newText(
		sceneGroup,
		"Choose game difficulty",
		display.contentCenterX, titleOffsetY + 115,
		font, 64
	)
	chooseText:setFillColor( 0.4, 0.4, 0.4 )

	self.easyButton = Button:new{
		parentGroup=sceneGroup,
		font=font, fontSize=44, fontColor={ 0.4 },
		text="Easy",
		x=display.contentCenterX - 250, y=display.contentCenterY + 115,
		paddingX=55, paddingY=15,
		fillColor={ 0.97 }, fillColorPressed={ 0.90 },
		borderWidth=3, borderColor={ 0.85 }
	}

	self.mediumButton = Button:new{
		parentGroup=sceneGroup,
		font=font, fontSize=44, fontColor={ 0.4 },
		text="Medium",
		x=display.contentCenterX, y=display.contentCenterY + 115,
		paddingX=30, paddingY=15,
		fillColor={ 0.97 }, fillColorPressed={ 0.90 },
		borderWidth=3, borderColor={ 0.85 }
	}

	self.hardButton = Button:new{
		parentGroup=sceneGroup,
		font=font, fontSize=44, fontColor={ 0.4 },
		text="Hard",
		x=display.contentCenterX + 250, y=display.contentCenterY + 115,
		paddingX=55, paddingY=15,
		fillColor={ 0.97 }, fillColorPressed={ 0.90 },
		borderWidth=3, borderColor={ 0.85 }
	}

	self.easyButton:addEventListener( "press", function()
		self.easyButton.enabled = false
		self.mediumButton.enabled = false
		self.hardButton.enabled = false
		self:gotoGame( 1 )
	end)
	self.mediumButton:addEventListener( "press", function()
		self.easyButton.enabled = false
		self.mediumButton.enabled = false
		self.hardButton.enabled = false
		self:gotoGame( 2 )
	end)
	self.hardButton:addEventListener( "press", function()
		self.easyButton.enabled = false
		self.mediumButton.enabled = false
		self.hardButton.enabled = false
		self:gotoGame( 3 )
	end)
end


-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase
	local minigame = event.params.minigame

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

		self.menuMusicChannel = event.params.menuMusicChannel
		self.minigameSourcePath = minigame.sourcePath

		self.nameText = display.newText(
			sceneGroup,
			minigame.name,
			display.contentCenterX, titleOffsetY,
			font, 96
		)
		self.nameText:setFillColor( 0.4, 0.4, 0.4 )

		self.easyButton.enabled = true
		self.mediumButton.enabled = true
		self.hardButton.enabled = true

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen

		if minigame.preloader then
			self.preloadCoroutine = minigame.preloader()
			timer.performWithDelay( 25, function() self:preload() end )
		end
	end
end


function scene:preload()
	if self.preloadCoroutine and coroutine.status( self.preloadCoroutine ) == "suspended" then
		coroutine.resume( self.preloadCoroutine )
		timer.performWithDelay( 25, function() self:preload() end )
	end
end


-- hide()
function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is on screen (but is about to go off screen)

		self.preloadCoroutine = nil

	elseif ( phase == "did" ) then
		-- Code here runs immediately after the scene goes entirely off screen

		self.nameText:removeSelf()
	end
end


-- destroy()
function scene:destroy( event )

	local sceneGroup = self.view
	-- Code here runs prior to the removal of scene's view

end

function scene:gotoGame( difficulty )
	-- Menu music that started in menu.lua... it's time to stop
	audio.fadeOut( 500, { channel=self.menuMusicChannel } )
	audio.stopWithDelay( 500, { channel=self.menuMusicChannel } )

	composer.setVariable( "difficulty", difficulty )
	composer.gotoScene( self.minigameSourcePath )
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
