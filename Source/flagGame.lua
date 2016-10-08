
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
	--background music, loop infinite, fadein in 5s
    --local backgroundMusicChannel = audio.play(backgroundMusic,{channel1=1,loops=-1,fadein=5000})

	-- Code here runs when the scene is first created but has not yet appeared on screen
	-------------------------------------------------------------------------------------------------------
	-- Left side of screen --
	-------------------------------------------------------------------------------------------------------
	-- Front-end --
	-------------------------------------------------------------------------------------------------------
	local background = display.newImageRect( sceneGroup,
											 sceneBuild[1],
											 currentWidth, 
											 currentHeight 
										   )
	background.x = display.contentCenterX
	background.y = display.contentCenterY

	local collumn = display.newImageRect( sceneGroup,
										  sceneBuild[13],
										  currentWidth/8,
										  currentHeight )
	collumn.x = currentWidth * 2 / 3 
	collumn.y = currentHeight / 2

	local pauseButton = display.newImageRect( sceneGroup,
										      sceneBuild[10],
										      currentWidth/20, 
										      currentHeight/14
										    )
	pauseButton.x = currentWidth / 20 --50
	pauseButton.y = currentHeight / 5 --150

	local replayButton = display.newImageRect( sceneGroup, 
											   sceneBuild[11], 
											   currentWidth/20, 
											   currentHeight/14
											 )
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

	local pole = display.newImageRect( sceneGroup,
									   sceneBuild[2],
									   currentWidth/10,
									   currentHeight/1.8
									 )
	pole.x = currentWidth * 1 / 3
	pole.y = currentHeight - pole.height + 60

	local animal1 = display.newImageRect( sceneGroup, 
										  sceneBuild[3], 
										  currentWidth/10, 
										  currentHeight/7
										)
	animal1.x = pole.x / 2 
	animal1.y = currentHeight - (animal1.height * 1.5)
	animal1.xScale = -1
	local animal2 = display.newImageRect( sceneGroup,
										  sceneBuild[3], 
										  currentWidth/10, 
										  currentHeight/7
										)
	animal2.x = pole.x + pole.x / 2
	animal2.y = currentHeight - (animal1.height * 1.5)

	-- place holders for answer text 
	local optionBox1 = display.newImageRect( sceneGroup, 
											 sceneBuild[14],
											 currentWidth/5, 
											 currentHeight/12
										   )
	optionBox1.x = animal1.x
	optionBox1.y = animal1.y - currentHeight/8
	local optionBox2 = display.newImageRect( sceneGroup,
										     sceneBuild[14],
										     currentWidth/5, 
										     currentHeight/12
										   )
	optionBox2.x = animal2.x
	optionBox2.y = animal2.y - currentHeight/8
	-------------------------------------------------------------------------------------------------------
	-- end front-end --
	-------------------------------------------------------------------------------------------------------
	-- back-end --
	-------------------------------------------------------------------------------------------------------
	local function cleanUP(obj)
		obj:removeSelf()
	end
	local function animationStop(obj)
		transition.fadeOut(obj ,
		{
			time=5000
   	    })
	end
	local function animationEnd(obj)
		transition.to(obj ,
		{
			time = 20000,
		    y = pole.y * 1.3,
		    onComplete = cleanUP
		})
	end
	local function animationStart( obj )
		transition.to(obj,
		{
			time = 1000, 
			y = pole.y * 0.7,
			onComplete = animationEnd
		})
	end	

	-- random to choose the box 
	-- need an array to store used flags
	local randomFlag = math.random(1,10)
	local flag = display.newImageRect( sceneGroup, 
									   countryFiles[randomFlag],
									   currentWidth/7,
									   currentHeight/7
									 )
	flag.x = pole.x
	flag.y = pole.y * 1.2
	-- random between 2 boxes
	local randomBox = math.random(1,2) --countryNames[randomBox]
	local rightAnswer = countryNames[randomFlag]
	local wrongAnswer = nil
	local box1
	local box2
	-- loop to get wrong answer
	for i=1,11 do
		wrongAnswer = countryNames[math.random(1,13)]
		if  wrongAnswer ~= countryNames[randomFlag] then
			break
		end
	end
	-- random placer
	if randomBox == 1 then 
		box1 = rightAnswer
		box2 = wrongAnswer
	else
		box1 = wrongAnswer
		box2 = rightAnswer
	end
	-- text box to hold the answer texts
	local textBox1 = display.newText( sceneGroup, 
									  box1,
									  optionBox1.x, 
									  optionBox1.y, 
									  native.systemFont, 35 
									)

	local textBox2 = display.newText( sceneGroup, 
									  box2, 
									  optionBox2.x, 
									  optionBox2.y, 
									  native.systemFont, 35
									)

	-- color for the text 
	textBox1:setFillColor( 0, 0, 0 )
	textBox2:setFillColor( 0, 0, 0 )

	-- Event for textboxes --
	local function textTap( obj, value )
		obj:removeSelf()
		local textBox3 = display.newText( sceneGroup, 
										  value, 
										  obj.x, 
										  obj.y, 
										  native.systemFont, 44
										)
	end	

	textBox1:addEventListener("tap", function()
		if randomBox == 1 then
			textTap(textBox1,"Correct!")
			animationStop(flag)
		else
			textTap(textBox1,"Wrong!")
		end
	end)

	textBox2:addEventListener("tap", function()
		if randomBox ~= 1 then
			textTap(textBox2,"Correct!")
			animationStop(flag)
		else
			textTap(textBox2,"Wrong!")
		end
	end)

	animationStart(flag)
	-------------------------------------------------------------------------------------------------------
	-- End event for textboxes --
	-------------------------------------------------------------------------------------------------------
	-- end back-end --
	-------------------------------------------------------------------------------------------------------


	-------------------------------------------------------------------------------------------------------
	-- right side of screen --
	-------------------------------------------------------------------------------------------------------
	-- temporary 
	local temp = display.newImageRect(sceneGroup, 
									  sceneBuild[15],
									  currentWidth * 1 / 3, 
									  currentHeight-190
									 )
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
