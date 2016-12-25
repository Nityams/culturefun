local composer = require( "composer" )
local physics = require ( "physics")

local Button = require( "Source.button" )
local fonts = require( "Source.fonts" )
local images = require( "Source.images" )
local math2 = require( "Source.math2" )
local musics = require( "Source.musics" )
local Preloader = require( "Source.preloader" )
local sounds = require( "Source.sounds" )
local util = require( "Source.util" )
local vector = require( "Source.vector" )
local wallet = require( "Source.wallet" )

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

physics.start()

local scene = composer.newScene()

local screenLeft = 0
local screenRight = display.contentWidth
local screenTop = (display.contentHeight - display.viewableContentHeight) / 2
local screenBottom = (display.contentHeight + display.viewableContentHeight) / 2

images.defineImage( "Logo",  "Menu/MenuLogoV1Edit.png", 323, 319 )
images.defineImage( "Logo Pressed", "Menu/MenuLogoV1Edit-pressed.png", 323, 319 )
images.defineImage( "Plane 1" , "Menu/plane1.png" , 25, 25)
images.defineImage( "Plane 2" , "Menu/plane2.png" , 25, 25)
images.defineImage( "Plane 3" , "Menu/plane3.png" , 25, 25)
images.defineImage( "Plane 4" , "Menu/plane4.png" , 25, 25)
images.defineImage( "Plane 5" , "Menu/plane5.png" , 25, 25)
images.defineImage( "Santa" , "Menu/santa.png", 90 ,30)
images.defineImage( "Pizza", "Menu/pizza.png", 90,90)

sounds.defineSound( "Charm", "Assets/Sounds/Menu/Charm.mp3", 1.0 )
sounds.defineSound( "SantaFX", "Assets/Sounds/Menu/SantaFX.mp3", 0.6)
sounds.defineSound( "ufoFX", "Assets/Sounds/Menu/ufoFX.mp3", 0.8)

musics.defineMusic( "Menu Theme", "Assets/Sounds/Music/bensound-littleidea.mp3", 0.7, 5000 )

local planeImages = {
	"Plane 1",
	"Plane 2",
	"Plane 3",
	"Plane 4",
	"Plane 5"
}

local desiredPlanesOnscreen = 5


-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

function scene:preload()
	return Preloader:new(coroutine.create(function()
		require( "Source.difficultySelector" ):preload():start(); coroutine.yield()
		Button.preload(); coroutine.yield()
		sounds.loadSound( "Charm" ); coroutine.yield()
	end), 3)
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
		image = images.get( sceneGroup, "Logo" ),
		imagePressed = images.get( sceneGroup, "Logo Pressed" ),
		x = display.contentCenterX,
		y = display.contentCenterY + 50,
		width = images.width( "Logo" ),
		height = images.height( "Logo" )
	}

	----------------
	-- Foreground --
	----------------

	local font = fonts.neucha()

	local titleOffsetY = (util.aspectRatio() > 4/3 and 200 or 150)
	local titleFontSize = (util.aspectRatio() > 4/3 and 110 or 140)

	titleText = display.newText(
		uiGroup,
		"How In The World?",
		display.contentCenterX,
		titleOffsetY,
		font,
		titleFontSize
	)
	titleText:setFillColor( 0.4, 0.4, 0.4 )

	self.flagButton = Button:newTextButton{
		group=uiGroup,
		font=font, fontSize=44, fontColor={ 0.4 },
		text="Name That Flag",
		x=200, y=display.contentCenterY + 50,
		paddingX=20, paddingY=5,
		fillColor={ 0.97 }, fillColorPressed={ 0.90 },
		borderWidth=3, borderColor={ 0.85 }
	}
	self.foodButton = Button:newTextButton{
		group=uiGroup,
		font=font, fontSize=44, fontColor={ 0.4 },
<<<<<<< HEAD
		text="Foods & Flags",
=======
		text="Food & Flags",
>>>>>>> origin/master
		x=display.contentWidth - 200, y=display.contentCenterY + 50,
		paddingX=20, paddingY=5,
		fillColor={ 0.97 }, fillColorPressed={ 0.90 },
		borderWidth=3, borderColor={ 0.85 }
	}

	self.passportButton = Button:newTextButton{
		group=uiGroup,
		font=font, fontSize=20, fontColor={ 0.4 },
		text="My Passort",
		x=128, y=display.contentHeight-140,
		paddingX=20, paddingY=5,
		fillColor={ 0.97 }, fillColorPressed={ 0.90 },
		borderWidth=3, borderColor={ 0.85 }
	}
	self.resetButton = Button:newTextButton{
		group=uiGroup,
		font=font, fontSize=14, fontColor={ 0.4 },
		text="Reset Earned Coins",
		x=display.contentCenterX, y=display.contentHeight-140,
		paddingX=20, paddingY=5,
		fillColor={ 0.97 }, fillColorPressed={ 0.90 },
		borderWidth=3, borderColor={ 0.85 }
	}
	self.creditButton = Button:newTextButton{
		group=uiGroup,
		font=font, fontSize=20, fontColor={ 0.4 },
		text="Credits",
		x=display.contentWidth-111, y=display.contentHeight-140,
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
		self.passportButton.enabled = false
		self.resetButton.enabled = false
		self.creditButton.enabled = false
	end
	self.flagButton:addEventListener( "pretap", disableButtons )
	self.foodButton:addEventListener( "pretap", disableButtons )
	self.passportButton:addEventListener( "pretap", disableButtons )
	self.creditButton:addEventListener( "pretap", disableButtons )
	self.flagButton:addEventListener( "tap", function() self:gotoFlagMinigame() end )
	self.foodButton:addEventListener( "tap", function() self:gotoFoodMinigame() end )
	self.passportButton:addEventListener( "tap", function() self:gotoPassport() end)
	self.resetButton:addEventListener( "tap", function() self:resetCoins() end)
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
		self.passportButton.enabled = true
		self.resetButton.enabled = true
		self.creditButton.enabled = true

		self.logo.rotation = 0
		self.spinning = false
		self.wantSpin = false
		self.canWantSpin = false



	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen
		physics.start()
		physics.setGravity( 0, 0 )

		timer.performWithDelay( 25, function() self:startMusic() end )
		timer.performWithDelay( 25, function() self:removeMinigames() end )

		if self.preloader == nil then
			timer.performWithDelay( 25, function()
				self.preloader = self:preload()
				self.preloader:addEventListener( "done", function()
					if composer.getSceneName( "current" ) == "Source.menu" then
						self:startPlaneTimer()
					end
				end)
				self.preloader:start()
			end)
		else
			self:startPlaneTimer()
		end

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
		physics.stop()


		if self.spinTransition then
			transition.cancel( self.spinTransition )
			self.spinTransition = nil
		end

		self:removeAllDoodads()
	end
end


-- destroy()
function scene:destroy( event )

	local sceneGroup = self.view
	-- Code here runs prior to the removal of scene's view

end


function scene:gotoMinigame( name, file )
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
	self:gotoMinigame( "Name That Flag", "flagGame" )
end


function scene:gotoFoodMinigame()
	self:gotoMinigame( "Foods & Flags", "foodIntro" )
end

function scene:gotoPassport()
	composer.gotoScene( "Source.passport" )
end

function scene:gotoCredit()
	-- When going to a minigame, the audio stops after selecting a difficulty,
	-- but let's stop it here for the credits.
	audio.fade( 500 )
	audio.stopWithDelay( 500 )

	composer.setVariable( "Menu music still playing", false )

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

	timer.performWithDelay( 0, function() sounds.play( "Charm" ) end )

	self.spinning = true
	self.wantSpin = false
	self.canWantSpin = false

	timer.performWithDelay(1000, function()
		self.canWantSpin = true
	end)

	self.spinTransition = transition.to(self.logo, {rotation=-360, time=2000, onComplete=function()
		self.logo.rotation = 0
		self.spinning = false
		self.canWantSpin = false
		if self.wantSpin then
			self:spinLogo()
		end
	end})
end

function scene:startPlaneTimer()
    self.loopTimer = timer.performWithDelay(100, function()
		self:removeOldDoodads()
		self:createPlanes()
	end, 0)
end

function scene:removeAllDoodads()
	for i = 1,#self.planesArray do
		self.planesArray[i]:removeSelf()
	end
	for i = 1,#self.eventsArray do
		self.eventsArray[i]:removeSelf()
	end
	self.planesArray = {}
	self.eventsArray = {}
end

function scene:removeOldDoodads()
	-- Remove out of screen planes

	local top = screenTop - 25
	local right = screenRight + 25
	local left = screenLeft - 25
	local bottom = screenBottom + 25

	for i = #self.planesArray, 1, -1 do
		local thisPlane = self.planesArray[i]

		if not util.contains( left, right, top, bottom, thisPlane.x, thisPlane.y ) then
			display.remove( thisPlane )
			table.remove(self.planesArray,i)
		end
	end

	for i = #self.eventsArray, 1, -1 do
		local thisEvent = self.eventsArray[i]

		if not util.contains( left, right, top, bottom, thisEvent.x, thisEvent.y ) then
			display.remove( thisEvent )
			table.remove(self.eventsArray,i)
		end
	end

end

function scene:createPlanes()
	local toCreate = desiredPlanesOnscreen - #self.planesArray
	for i = 1,toCreate do
		timer.performWithDelay( 50 * i, function()
			if composer.getSceneName( "current" ) ~= "Source.menu" then
				-- Happens if the player leaves the scene within these 50ms.
				return
			end
			if #self.planesArray < desiredPlanesOnscreen then
				self:createPlane()
			end
		end)
	end
end

function scene:createPlane()
	if self.nextPlaneImage == nil then
		self.nextPlaneImage = 1
	end

	local imageName = planeImages[self.nextPlaneImage]

	local speed = math.random( 50, 80 )
	local plane = self:createFlyingObject( imageName, speed, true, false )

	if plane then
		self.nextPlaneImage = (self.nextPlaneImage % #planeImages) + 1

		plane.alpha = 0
		transition.to( plane, {time=500, alpha=0.6} )

		local pathVector = plane.finish - plane.start
		local heading = math.atan2( pathVector.y, pathVector.x )

		plane.rotation = 180 * heading / math.pi + 90

		physics.addBody( plane, "dynamic", { radius = 30, bounce = 0.5 } )
		plane:setLinearVelocity(
			plane.speed * math.cos( heading ),
			plane.speed * math.sin( heading )
		)

		table.insert( self.planesArray, plane )
	end
end

function scene:createFlyingObject( imageName, speed, insideScreen, wantCollision )
	local attempts = 0

	local top = screenTop
	local right = screenRight
	local left = screenLeft
	local bottom = screenBottom

	local plane = images.get( self.doodadsGroup, imageName )
	plane.speed = speed

	local okay = false

	while not okay do
		attempts = attempts + 1
		if attempts > 20 then
			print( "Failed to create " .. imageName .. " -- too many failed attempts" )
			plane:removeSelf()
			return nil
		end

		-- Try a new configuration.
		if insideScreen then
			plane.start = math2.randomPointWithin( left + 50, right - 50, top + 50, bottom - 50 )
		else
			plane.start = math2.randomPointOnBorder( left - 25, right + 25, top - 25, bottom + 25 )
		end
		plane.finish = math2.randomPointOnBorder( left - 25, right + 25, top - 25, bottom + 25 )
		plane.x = plane.start.x
		plane.y = plane.start.y

		okay = self:isGoodFlyingObject( plane, wantCollision )
	end

	return plane
end

function scene:isGoodFlyingObject( plane, wantCollision )
	local collision = self:planeWillIntersectWithAnother( plane )
	local onScreenTime = (plane.finish - plane.start):magnitude() / plane.speed
	return wantCollision == collision and
		   onScreenTime > 3.0
end

function scene:planeWillIntersectWithAnother( plane )
	local onScreenTime = (plane.finish - plane.start):magnitude() / plane.speed

	for i = 1, #self.planesArray do
		local other = self.planesArray[i]

		local willCollide, timeUntilCollision = self:timeUntilPlaneCollision( plane, other )

		if willCollide and (0 <= timeUntilCollision and timeUntilCollision <= onScreenTime) then
			return true
		end
	end

	return false
end

function scene:timeUntilPlaneCollision( first, second )
	local firstPosition = vector.new( first.x, first.y )
	local secondPosition = vector.new( second.x, second.y )

	local firstVelocity = (first.finish - first.start):withMagnitude( first.speed )

	local dx, dy = second:getLinearVelocity()
	local secondVelocity = vector.new( dx, dy )

	local willCollide
	local time

	willCollide, time = math2.whenTwoCirclesCollide(
		firstPosition,
		firstPosition + firstVelocity,
		secondPosition,
		secondPosition + secondVelocity,
		30, 30  -- Radii of the planes
	)

	return willCollide, time
end

function scene:maybeSpawnFunnies()
	if self.counter < 8 then
		self.counter = self.counter + 1
	else
		self.counter = 0
	end

	if self.counter == 2 then
		self:spawnSanta()
	elseif self.counter == 5 then
		self:spawnPizza()
	end
end

function scene:spawnSanta()
	-- trigger santa clause
	local speed = math.random( 75, 150 )
	local santa = self:createFlyingObject( "Santa", speed, false, true )

	if not santa then
		-- Couldn't find a path that collided with anyone.
		return
	end

	santa.rotation = 20
	santa.alpha = 0.8

	local pathVector = santa.finish - santa.start
	local heading = math.atan2( pathVector.y, pathVector.x )

	physics.addBody( santa, "kinematic", { radius = 30, bounce = 0.8 } )
	santa:setLinearVelocity(
		santa.speed * math.cos( heading ),
		santa.speed * math.sin( heading )
	)
	timer.performWithDelay( 100, function() sounds.play( "SantaFX" ) end )
	table.insert( self.eventsArray, santa )
end

function scene:spawnPizza()
	-- trigger giant pizza
	local speed = math.random( 150, 250 )
	local pizza = self:createFlyingObject( "Pizza", speed, false, true )

	if not pizza then
		-- Couldn't find a path that collided with anyone.
		return
	end

	pizza.rotation = 20
	pizza.alpha = 0.8

	local pathVector = pizza.finish - pizza.start
	local heading = math.atan2( pathVector.y, pathVector.x )

	physics.addBody( pizza, "dynamic", { radius = 30, bounce = 0.8 } )
	pizza:setLinearVelocity(
		pizza.speed * math.cos( heading ),
		pizza.speed * math.sin( heading )
	)
	pizza:applyTorque(math.random(-4,4))

	timer.performWithDelay( 100, function() sounds.play( "ufoFX" ) end )
	table.insert( self.eventsArray, pizza )
end

function scene:removeMinigames()
	composer.removeScene( "Source.flagGame" )
	composer.removeScene( "Source.foodGame" )
end

function scene:startMusic()
	local stillPlaying = composer.getVariable( "Menu music still playing" )
	if not stillPlaying then
		composer.setVariable( "Menu music still playing", true )

		-- This music will be turned off in difficultySelector.lua
		self.menuMusicChannel = musics.play( "Menu Theme" )
	end
end

function scene:resetCoins()
	wallet.resetCoins()
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
