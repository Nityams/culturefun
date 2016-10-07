
local composer = require( "composer" )

local scene = composer.newScene()


-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

local function returnToMenu()
	composer.gotoScene( "Source.menu" )
end



-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
local setbackground
local callCharacters
local setfoods
local callGreetings

local currentWidth
local currentHeight
local sceneGroup
local character_one
-- create()
function scene:create( event )
	sceneGroup = self.view
	currentWidth = display.contentWidth
	currentHeight = display.contentHeight
	-- `Code here runs when the scene is first created but has not yet appeared on screen

	--
setbackground()
setfoods()
callCharacters()
end

function setbackground()
	local background = display.newImageRect(sceneGroup, "Assets/Images/FoodGame/Background.png",currentWidth, currentHeight )
	background.x = display.contentCenterX
	background.y = display.contentCenterY
end

function setfoods()
end

function callCharacters()
	character_one = display.newImage("Assets/Images/foodGame/boy.png")
	character_one.y = display.contentCenterY
	character_one.x = 0
	transition.to(character_one,{time = 500, x = display.contentCenterX/2.5, onComplete = callGreetings})
end
function callGreetings()
	local dialogBox = display.newImage("Assets/Images/foodGame/americanDialog.png")
	dialogBox.xScale = 0.3
	dialogBox.yScale = 0.3
	dialogBox.y = display.contentCenterY - display.contentCenterY/1.8
	dialogBox.x = character_one.x
end

-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen

		-- In two seconds return to the menu
		--timer.performWithDelay( 2000, returnToMenu )
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
