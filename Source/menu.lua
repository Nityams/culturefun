
local composer = require( "composer" )

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

local function removeMinigames()
	for i,game in ipairs(minigames)
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

	local flagButton = display.newText( sceneGroup, "Play Flag Game", display.contentCenterX, 150, native.systemFont, 44 )
	flagButton:setFillColor( 0.4, 0.4, 0.4 )
	local foodButton = display.newText( sceneGroup, "Play Food Game", display.contentCenterX, display.contentHeight - 150, native.systemFont, 44 )
	foodButton:setFillColor( 0.4, 0.4, 0.4 )
	local game3Button = display.newText( sceneGroup, "Play Game 3", 200, display.contentCenterY, native.systemFont, 44 )
	game3Button:setFillColor( 0.4, 0.4, 0.4 )
	local game4Button = display.newText( sceneGroup, "Play Game 4", display.contentWidth - 200, display.contentCenterY, native.systemFont, 44 )
	game4Button:setFillColor( 0.4, 0.4, 0.4 )

	flagButton:addEventListener( "tap", function()
		gotoMinigame( "flagGame" )
	end)
	foodButton:addEventListener( "tap", function()
		gotoMinigame( "foodGame" )
	end)
	game3Button:addEventListener( "tap", function()
		gotoMinigame( "game3" )
	end)
	game4Button:addEventListener( "tap", function()
		gotoMinigame( "game4" )
	end)
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
