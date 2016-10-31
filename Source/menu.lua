local composer = require( "composer" )
local physics = require ( "physics")

local Button = require( "Source.button" )
local fonts = require( "Source.fonts" )
local images = require( "Source.images" )
local musics = require( "Source.musics" )
local Preloader = require( "Source.preloader" )
local sounds = require( "Source.sounds" )
local util = require( "Source.util" )

physics.start()

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

images:defineImage( "Logo",  "Menu/MenuLogoV1Edit.png", 323, 319 )
images:defineImage( "Logo Pressed", "Menu/MenuLogoV1Edit-pressed.png", 323, 319 )
images:defineImage( "Plane 1" , "Menu/plane1.png" , 25, 25)
images:defineImage( "Plane 2" , "Menu/plane2.png" , 25, 25)
images:defineImage( "Plane 3" , "Menu/plane3.png" , 25, 25)
images:defineImage( "Plane 4" , "Menu/plane4.png" , 25, 25)
images:defineImage( "Plane 5" , "Menu/plane5.png" , 25, 25)
images:defineImage( "Santa" , "Menu/santa.png", 90 ,30)
images:defineImage( "Pizza", "Menu/pizza.png", 90,90)

sounds:defineSound( "Charm", "Assets/Sounds/Menu/Charm.mp3", 1.0 )

musics:defineMusic( "Menu Theme", "Assets/Sounds/Music/bensound-littleidea.mp3", 0.7, 5000 )


-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

function scene:preload()
	return Preloader:new(coroutine.create(function()
		Button.preload(); coroutine.yield()
		sounds:preloadSound( "Charm" ); coroutine.yield()
		self.difficultySelector = require( "Source.difficultySelector" ); coroutine.yield()
		self.difficultySelector:preload(); coroutine.yield()
	end))
end

-- create()
function scene:create( event )
	-- Code here runs when the scene is first created but has not yet appeared on screen

	local sceneGroup = self.view

	self.planesArray = {}
	self.eventsArray = {}
	-- event triggering
	self.counter = 0

	local bgGroup = display.newGroup()
	local doodadsGroup = display.newGroup()
	local uiGroup = display.newGroup()

	self.doodadsGroup = doodadsGroup

	sceneGroup:insert(bgGroup)
	sceneGroup:insert(doodadsGroup)
	sceneGroup:insert(uiGroup)

	----------------
	-- Background --
	----------------

	local bgWhiteFill = display.newRect(
		bgGroup,
		display.contentCenterX, display.contentCenterY,
		display.contentWidth, display.contentHeight
	)
	bgWhiteFill:setFillColor( 1, 1, 1 )

	local bgWorldMap = display.newImageRect(
		bgGroup,
		"Assets/Images/Menu/MenuBackgroundV1Edit.png",
		display.contentWidth, display.contentHeight*1.3
	)
	bgWorldMap.x = display.contentCenterX
	bgWorldMap.y = display.contentCenterY
	bgWorldMap.alpha = 0.5

	self.logo = Button:newImageButton{
		group = uiGroup,
		image = images:get( sceneGroup, "Logo" ),
		imagePressed = images:get( sceneGroup, "Logo Pressed" ),
		x = display.contentCenterX,
		y = display.contentCenterY + 50,
		width = images:width( "Logo" ),
		height = images:height( "Logo" )
	}

	---------------------------
	-- Background animations --
	---------------------------
	physics.pause()

	self:createPlanes()

	----------------
	-- Foreground --
	----------------
	local font = fonts.neucha()

	local titleOffsetY = (util.aspectRatio() > 4/3 and 200 or 150)
	local titleFontSize = (util.aspectRatio() > 4/3 and 110 or 140)

	titleText = display.newText(
		uiGroup,
		"Culture Fun",
		display.contentCenterX,
		titleOffsetY,
		font,
		titleFontSize
	)
	titleText:setFillColor( 0.4, 0.4, 0.4 )

	self.flagButton = Button:newTextButton{
		group=uiGroup,
		font=font, fontSize=44, fontColor={ 0.4 },
		text="Play Flag Game",
		x=200, y=display.contentCenterY + 50,
		paddingX=20, paddingY=5,
		fillColor={ 0.97 }, fillColorPressed={ 0.90 },
		borderWidth=3, borderColor={ 0.85 }
	}
	self.foodButton = Button:newTextButton{
		group=uiGroup,
		font=font, fontSize=44, fontColor={ 0.4 },
		text="Play Food Game",
		x=display.contentWidth - 200, y=display.contentCenterY + 50,
		paddingX=20, paddingY=5,
		fillColor={ 0.97 }, fillColorPressed={ 0.90 },
		borderWidth=3, borderColor={ 0.85 }
	}

	self.creditButton = Button:newTextButton{
		group=uiGroup,
		font=font, fontSize=20, fontColor={ 0.4 },
		text="Credit",
		x=display.contentWidth-130, y=display.contentHeight-140,
		paddingX=20, paddingY=5,
		fillColor={ 0.97 }, fillColorPressed={ 0.90 },
		borderWidth=3, borderColor={ 0.85 }
	}


	---------------
	-- Listeners --
	---------------

	self.logo:addEventListener( "tap", function(event)
		self:logoTapped(event)
	end)

	local function disableButtons()
		self.flagButton.enabled = false
		self.foodButton.enabled = false
		self.creditButton.enabled = false
	end
	self.flagButton:addEventListener( "pretap", disableButtons )
	self.foodButton:addEventListener( "pretap", disableButtons )
	self.creditButton:addEventListener( "pretap", disableButtons )
	self.flagButton:addEventListener( "tap", function() self:gotoFlagMinigame() end )
	self.foodButton:addEventListener( "tap", function() self:gotoFoodMinigame() end )
	self.creditButton:addEventListener( "tap", function() self:gotoCredit() end)
end

-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

		self.flagButton.enabled = true
		self.foodButton.enabled = true
		self.creditButton.enabled = true

		self.logo.rotation = 0
		self.spinning = false
		self.wantSpin = false
		self.canWantSpin = false

		physics.start()
		physics.setGravity(0,0)

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen
	    self.loopTimer = timer.performWithDelay(11000, function()
			self:removeOldPlanes()
			self:createPlanes()
		end, 0)
		timer.performWithDelay( 25, function() self:startMusic() end )
		timer.performWithDelay( 25, function() self:removeMinigames() end )
		timer.performWithDelay( 25, function()
			if self.preloader == nil then
				self.preloader = self:preload()
			end
		end)
	end
end


-- hide()
function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is on screen (but is about to go off screen)

		-- this cancels the loop generating planes
		timer.cancel(self.loopTimer)

	elseif ( phase == "did" ) then
		-- Code here runs immediately after the scene goes entirely off screen

		physics.pause()
	end
end


-- destroy()
function scene:destroy( event )

	local sceneGroup = self.view
	-- Code here runs prior to the removal of scene's view

end


function scene:gotoMinigame( name, file, menu )
	self.preloader:stop()

	local sourcePath = "Source." .. file
	local minigameScene = require( sourcePath )

	local params = {
		minigame = {
			name = name,
			sourcePath = sourcePath,
			preloadFn = function() return minigameScene:preload() end
		},
		menuMusicChannel = self.menuMusicChannel
	}
	composer.gotoScene( "Source.difficultySelector", { params=params } )
end


function scene:gotoFlagMinigame()
	self:gotoMinigame( "Flag Game", "flagGame" )
end


function scene:gotoFoodMinigame()
	self:gotoMinigame( "Food Game", "foodIntro" )
end

function scene:gotoCredit()
	-- When going to a minigame, the audio stops after selecting a difficulty,
	-- but let's stop it here for the credits.
	audio.fade( 500 )
	audio.stopWithDelay( 500 )

	composer.gotoScene( "Source.credit" )
end

function scene:logoTapped( event )
	if self.canWantSpin then
		self.wantSpin = true
	end

	if self.spinning then
		return
	end

	self:spinLogo()
end

function scene:spinLogo()
	self:maybeSpawnFunnies()

	timer.performWithDelay( 0, function() sounds:play( "Charm" ) end )

	self.spinning = true
	self.wantSpin = false
	self.canWantSpin = false

	timer.performWithDelay(1000, function()
		self.canWantSpin = true
	end)

	transition.to(self.logo, {rotation=-360, time=2000, onComplete=function()
		self.logo.rotation = 0
		self.spinning = false
		self.canWantSpin = false
		if self.wantSpin then
			self:spinLogo()
		end
	end})
end

function scene:removeOldPlanes()
	-- Remove out of screen planes
	for i = #self.planesArray, 1, -1 do
		local thisPlane = self.planesArray[i]

		if ( thisPlane.x < 100 or thisPlane.x > display.contentWidth + 100) then
			display.remove( thisPlane )
			table.remove(self.planesArray,i)
		end
	end
end

function scene:createPlanes()

	local plane1 = images:get( self.doodadsGroup, "Plane 1")
	plane1:rotate(90)
	plane1.x = 100
	plane1.y = 200
	plane1.alpha = 0.6
	physics.addBody(plane1, "dynamic", { radius = 30, bounce = 0.5})
	plane1:setLinearVelocity(50,0)

	local plane2 = images:get( self.doodadsGroup, "Plane 2")
	plane2:rotate(-90)
	plane2.x = display.contentWidth - 50
	plane2.y = 300
	plane2.alpha = 0.6
	physics.addBody(plane2, "dynamic", { radius = 30, bounce = 0.5})
	plane2:setLinearVelocity(-70,0)

	local plane3 = images:get( self.doodadsGroup, "Plane 3")
	plane3:rotate(90)
	plane3.x = 100
	plane3.y = 400
	plane3.alpha = 0.6
	physics.addBody(plane3, "dynamic", { radius = 30, bounce = 0.5})
	plane3:setLinearVelocity(80,0)

	local plane4 = images:get( self.doodadsGroup, "Plane 4")
	plane4:rotate(-90)
	plane4.x = display.contentWidth - 100
	plane4.y = 500
	plane4.alpha = 0.6
	physics.addBody(plane4, "dynamic", { radius = 30, bounce = 0.5})
	plane4:setLinearVelocity(-60,0)

	local plane5 = images:get( self.doodadsGroup, "Plane 5")
	plane5:rotate(90)
	plane5.x = 100
	plane5.y = 600
	plane5.alpha = 0.6
	physics.addBody(plane5, "dynamic", { radius = 30, bounce = 0.5})
	plane5:setLinearVelocity(40,0)

	table.insert(self.planesArray,plane1)
	table.insert(self.planesArray,plane2)
	table.insert(self.planesArray,plane3)
	table.insert(self.planesArray,plane4)
	table.insert(self.planesArray,plane5)
end

function scene:maybeSpawnFunnies()
	if self.counter < 8 then
		self.counter = self.counter + 1
		spawnFunnies()
	else
		self.counter = 0
	end
end

function scene:spawnFunnies()
	for i = #self.eventsArray, 1, -1 do
		local thisEvent = self.eventsArray[i]

		if ( thisEvent.x < 100 or thisEvent.x > display.contentWidth + 100) then
			display.remove( thisEvent )
			table.remove(self.eventsArray,i)
		end
	end
	-- trigger santa clause
	if self.counter == 2 then
		local santa = images:get( doodadsGroup, "Santa")
		santa:rotate(20)
		santa.x = math.random(0,300)
		santa.y = 0
		santa.alpha = 0.8
		physics.addBody(santa, "kinematic", { radius = 30, bounce = 0.8})
		santa:setLinearVelocity(math.random(50,100),math.random(50,100))
		table.insert(self.eventsArray,santa)
	-- trigger giant pizza
	elseif self.counter == 5 then
		local pizza = images:get(doodadsGroup, "Pizza")
		pizza.x = 0
		pizza.y = math.random(0,300)
		pizza.alpha = 0.8
		physics.addBody(pizza, "dynamic", {radius = 30, bounce = 0.8})
		pizza:setLinearVelocity(math.random(100,300),math.random(100, 150))
		pizza:applyTorque(math.random(-4,4))
		table.insert(self.eventsArray,pizza)
	end

end

function scene:removeMinigames()
	composer.removeScene( "Source.flagGame" )
	composer.removeScene( "Source.foodGame" )
end

function scene:startMusic()
	-- This music will be turned off in difficultySelector.lua
	self.menuMusicChannel = musics:play( "Menu Theme" )
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
