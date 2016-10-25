local composer = require( "composer" )
local Button = require( "Source.button" )
local fonts = require( "Source.fonts" )
local util = require( "Source.util" )

local scene = composer.newScene()

local font = fonts.neucha()
local titleOffsetY = (util.aspectRatio() > 4/3 and 250 or 75)

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

local function returnToMenu()
	composer.gotoScene( "Source.menu" )
end

local function gotoGame( difficulty )
	composer.setVariable( "difficulty", difficulty )
	local minigameSourceFile = composer.getVariable( "minigameSourceFile" )
	composer.gotoScene( minigameSourceFile )
end

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )
	-- Code here runs when the scene is first created but has not yet appeared on screen

	local sceneGroup = self.view

	local background = display.newRect( sceneGroup, display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight )
	background:setFillColor( 1, 1, 1 )

	local chooseText = display.newText( sceneGroup, "Choose game difficulty", display.contentCenterX, titleOffsetY + 115, font, 64 )
	chooseText:setFillColor( 0.4, 0.4, 0.4 )

	local easyButton = Button:new{
		parentGroup=sceneGroup,
		font=font, fontSize=44, fontColor={ 0.4 },
		text="Easy",
		x=display.contentCenterX - 250, y=display.contentCenterY + 115,
		paddingX=55, paddingY=15,
		fillColor={ 0.97 }, fillColorPressed={ 0.90 },
		borderWidth=3, borderColor={ 0.85 }
	}

	local mediumButton = Button:new{
		parentGroup=sceneGroup,
		font=font, fontSize=44, fontColor={ 0.4 },
		text="Medium",
		x=display.contentCenterX, y=display.contentCenterY + 115,
		paddingX=30, paddingY=15,
		fillColor={ 0.97 }, fillColorPressed={ 0.90 },
		borderWidth=3, borderColor={ 0.85 }
	}

	local hardButton = Button:new{
		parentGroup=sceneGroup,
		font=font, fontSize=44, fontColor={ 0.4 },
		text="Hard",
		x=display.contentCenterX + 250, y=display.contentCenterY + 115,
		paddingX=55, paddingY=15,
		fillColor={ 0.97 }, fillColorPressed={ 0.90 },
		borderWidth=3, borderColor={ 0.85 }
	}

	easyButton:addEventListener( "press", function() gotoGame( 1 ) end )
	mediumButton:addEventListener( "press", function() gotoGame( 2 ) end )
	hardButton:addEventListener( "press", function() gotoGame( 3 ) end )
end


-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

		local minigameName = composer.getVariable( "minigameName" )

		self.nameText = display.newText(
			sceneGroup,
			minigameName,
			display.contentCenterX, titleOffsetY,
			font, 96
		)
		self.nameText:setFillColor( 0.4, 0.4, 0.4 )


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


-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------

return scene
