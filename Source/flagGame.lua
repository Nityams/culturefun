
local composer = require( "composer" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

local countryNames = {
	"Egypt",
	"Honduras",
	"Hungary",
	"Madagascar",
	"Mexico",
	"Mongolia",
	"Morocco",
	"New Zealand",
	"Peru",
	"Philippines",
	"Russia",
	"South Africa",
	"Switzerland",
	"Taiwan",
	"Ukraine",
	"United Kingdom",
	"United States",
	"Vietnam"
};

local countryFiles = {
	"Assets/Images/Flags/Egypt_Flag.png",  -- a few of these images have a large white border that needs to be cropped; they came this way
	"Assets/Images/Flags/Honduras_Flag.png",
	"Assets/Images/Flags/Hungary_Flag.png",
	"Assets/Images/Flags/Madagascar_Flag.png",
	"Assets/Images/Flags/Mexico_Flag.png",
	"Assets/Images/Flags/Mongolia_Flag.png",
	"Assets/Images/Flags/Morocco_Flag.png",
	"Assets/Images/Flags/New_Zealand_Flag.png",
	"Assets/Images/Flags/Peru_Flag.png",
	"Assets/Images/Flags/Philippines_Flag.png",
	"Assets/Images/Flags/Russia_Flag.png",
	"Assets/Images/Flags/South_Africa_Flag.png",
	"Assets/Images/Flags/Switzerland_Flag.png",
	"Assets/Images/Flags/Taiwan_Flag.png",
	"Assets/Images/Flags/Ukraine_Flag.png",
	"Assets/Images/Flags/United_Kingdom_Flag.png",
	"Assets/Images/Flags/United_States_Flag.png",
	"Assets/Images/Flags/Vietnam_Flag.png",
	"Assets/Images/Flags/1.png"
};

local sceneBuild ={
	"Assets/Images/Scene/1.png",
	"Assets/Images/Scene/2.png",
	"Assets/Images/Scene/3.png",
	"Assets/Images/Scene/4.png",
	"Assets/Images/Scene/5.png",
	"Assets/Images/Scene/6.png",
	"Assets/Images/Scene/7.png",
	"Assets/Images/Scene/8.png",
	"Assets/Images/Scene/9.png",
	"Assets/Images/Scene/10.png",
	"Assets/Images/Scene/11.png",
	"Assets/Images/Scene/12.png",
	"Assets/Images/Scene/col.png", -- 13
	"Assets/Images/Scene/textBox.png",
	"Assets/Images/Scene/rightTemp.png"


};

local audioFiles = {
	"Assets/Sounds/More-Monkey-Island-Band_Looping.mp3"	
};

local function returnToMenu()
	composer.gotoScene( "Source.menu" )
end



-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )
	-- !! need to work on the ratio for the resolutions
	local sceneGroup = self.view
	local currentWidth = display.contentWidth
	local currentHeight = display.contentHeight
	local backgroundMusic = audio.loadStream(audioFiles[1])
	-- background music, loop infinite, fadein in 5s
	-- local backgroundMusicChannel = audio.play(backgroundMusic,{channel1=1,loops=-1,fadein=5000})
	function checkContain(set, element)
		for i, set.length do
			if (set[i] == element) then return true end
		end 
		return false
	end 


	-- Code here runs when the scene is first created but has not yet appeared on screen
	-------------------------------------------------------------------------------------------------------
	-- Left side of screen --
	-------------------------------------------------------------------------------------------------------
	local background = display.newImageRect( sceneGroup, sceneBuild[1], currentWidth, currentHeight )
	background.x = display.contentCenterX
	background.y = display.contentCenterY

	local collumn = display.newImageRect( sceneGroup, sceneBuild[13],currentWidth/8,currentHeight)
	collumn.x = currentWidth * 2 / 3 
	collumn.y = currentHeight / 2

	local pauseButton = display.newImageRect( sceneGroup, sceneBuild[10], currentWidth/20, currentHeight/14)
	pauseButton.x = currentWidth / 20 --50
	pauseButton.y = currentHeight / 5 --150

	local replayButton = display.newImageRect( sceneGroup, sceneBuild[11], currentWidth/20, currentHeight/14)
	replayButton.x = pauseButton.x + currentWidth / 16
	replayButton.y = pauseButton.y

	-- Event for Pause/Replay -- NEED IMPLEMENTATION
	local function buttonTap()
		-- do something
		temp = nil
	end
	pauseButton:addEventListener("tap", function()
		buttonTap(pauseButton)
	end)
	-- End event Pause/Replay --

	local pole = display.newImageRect( sceneGroup, sceneBuild[2],currentWidth/10,currentHeight/1.8)
	pole.x = currentWidth * 1 / 3
	pole.y = currentHeight - pole.height + 60

    -- !! NEED IMPLEMENTATION to choose the flags --
	local flag = display.newImageRect( sceneGroup, countryFiles[8],currentWidth/7,currentHeight/7)
	flag.x = pole.x
	flag.y = pole.y * 1.2

	-- TESTING
	local function cleanUP(obj)
		obj:removeSelf()
	end
	local function animating1(obj)
		transition.to(obj,{time = 20000, y = pole.y * 1.3,onComplete = cleanUP})
	end
	local function animating2( obj )
		transition.to(obj,{time = 1000, y = pole.y * 0.7,onComplete = animating1})
	end	
	animating2(flag)
	-- END TESTING

	local fox1 = display.newImageRect( sceneGroup, sceneBuild[3], currentWidth/10, currentHeight/7)
	fox1.x = pole.x / 2 
	fox1.y = currentHeight - (fox1.height * 1.5)
	fox1.xScale = -1

	local fox2 = display.newImageRect( sceneGroup, sceneBuild[3], currentWidth/10, currentHeight/7)
	fox2.x = pole.x + pole.x / 2
	fox2.y = currentHeight - (fox1.height * 1.5)

	local optionBox1 = display.newImageRect( sceneGroup, sceneBuild[14],currentWidth/5, currentHeight/12)
	optionBox1.x = fox1.x
	optionBox1.y = fox1.y - 100

	local optionBox2 = display.newImageRect( sceneGroup, sceneBuild[14],currentWidth/5, currentHeight/12)
	optionBox2.x = fox2.x
	optionBox2.y = fox2.y - 100	

	local textBox1 = display.newText( sceneGroup, "Country 1", optionBox1.x, optionBox1.y, native.systemFont, 44)

	local textBox2 = display.newText( sceneGroup, "Country 2", optionBox2.x, optionBox2.y, native.systemFont, 44)

	-- color for the text 
	textBox1:setFillColor( 0, 0, 0 )
	textBox2:setFillColor( 0, 0, 0 )

	-- Event for textboxes --
	local function textTap( obj )
		obj:removeSelf()
		local textBox1 = display.newText( sceneGroup, "Correct", obj.x, obj.y, native.systemFont, 44)
	end	

	textBox1:addEventListener("tap", function()
		textTap(textBox1)
	end)

	textBox2:addEventListener("tap", function()
		textTap(textBox2)
	end)
	-- End event for textboxes --



	-------------------------------------------------------------------------------------------------------
	-- right side of screen --
	-------------------------------------------------------------------------------------------------------
	-- temporary 
	local temp = display.newImageRect(sceneGroup, sceneBuild[15],currentWidth * 1 / 3, currentHeight-190)
	temp.x = collumn.x + collumn.x / 4
	temp.y = currentHeight/2

	-- check the resolution here 
	--display.newText( sceneGroup, "Width: "..currentWidth, display.contentCenterX, display.contentCenterY, native.systemFont, 44 )
	--display.newText( sceneGroup, "Height: "..currentHeight, display.contentCenterX, display.contentCenterY+100, native.systemFont, 44 )
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
