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

local planeImages = {
	"Plane 1",
	"Plane 2",
	"Plane 3",
	"Plane 4",
	"Plane 5"
}

local desiredPlanesOnscreen = 25


-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

function scene:preload()
	return Preloader:new(coroutine.create(function()
		require( "Source.difficultySelector" ):preload(); coroutine.yield()
		Button.preload(); coroutine.yield()
		sounds:preloadSound( "Charm" ); coroutine.yield()
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
		physics.setGravity( 0, 0 )

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen

		if self.preloader == nil then
			self.preloader = self:preload()
		end

		timer.performWithDelay( 25, function() self:startMusic() end )
		timer.performWithDelay( 25, function() self:removeMinigames() end )

	    self.loopTimer = timer.performWithDelay(1000, function()
			self:removeOldDoodads()
			self:createPlanes()
		end, 0)

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

function scene:removeOldDoodads()
	-- Remove out of screen planes

	local top = -25
	local right = display.contentWidth + 25
	local left = -25
	local bottom = display.contentHeight + 25

	print( "left", left )
	print( "right", right )
	print( "top", top )
	print( "bottom", bottom )

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
		timer.performWithDelay( 100 * i, function() self:createPlane() end )
	end
end

-- (A .. B)^2 < b^2 * a^2
-- (ax * bx + ay * by)^2 < b^2 * a^2
-- (ax * bx)^2 + 2*ax*bx*ay*by + (ay * by)^2 < b^2 * a^2
-- ax^2 + 2*ax*bx + bx^2 + 2*ax*bx*ay*by + ay^2 + 2*ay*by + by^2 < b^2 * a^2
-- ax^2 + 2*ax*bx + bx^2 + 2*ax*bx*ay*by + ay^2 + 2*ay*by + by^2 < (bx^2 + by^2)^2 * (ax^2 + ay^2)^2
-- ax^2 + 2*ax*bx + bx^2 + 2*ax*bx*ay*by + ay^2 + 2*ay*by + by^2 < bx^4 + 2*bx^2*by^2 + by^4 * ax^4 + 2*ax^2*ay^2 + ay^4

function scene:createPlane()
	local attempts = 1

	local top = 0
	local right = display.contentWidth
	local left = 0
	local bottom = display.contentHeight

	if self.nextPlaneImage == nil then
		self.nextPlaneImage = 1
	end

	local imageName = planeImages[self.nextPlaneImage]

	local plane = images:get( self.doodadsGroup, imageName )
	plane.alpha = 0
	transition.to( plane, {time=500, alpha=0.6} )

	plane.speed = math.random( 50, 80 )

	plane.start = math2.randomPointWithin( left + 50, right - 50, top + 50, bottom - 50 )
	plane.finish = math2.randomPointOnBorder( left - 25, right + 25, top - 25, bottom + 25 )
	plane.x = plane.start.x
	plane.y = plane.start.y
	local collision = self:planeWillIntersectWithAnother( plane )

	while collision do
		attempts = attempts + 1
		if attempts > 10 then
			print( "Failed to create plane -- too many failed attempts" )
			plane:removeSelf()
			return
		end

		-- Try another point.
		plane.start = math2.randomPointWithin( left + 25, right - 25, top + 25, bottom - 25 )
		plane.finish = math2.randomPointOnBorder( left - 25, right + 25, top - 25, bottom + 25 )
		plane.x = plane.start.x
		plane.y = plane.start.y
		collision = self:planeWillIntersectWithAnother( plane )
	end

	local pathVector = plane.finish - plane.start
	local heading = math.atan2( pathVector.y, pathVector.x )

	plane.rotation = 180 * heading / math.pi + 90

	physics.addBody( plane, "dynamic", { radius = 30, bounce = 0.5 } )
	plane:setLinearVelocity(
		plane.speed * math.cos( heading ),
		plane.speed * math.sin( heading )
	)

	table.insert( self.planesArray, plane )

	self.nextPlaneImage = (self.nextPlaneImage % #planeImages) + 1
end

function scene:planeWillIntersectWithAnother( plane )
	local onScreenTime = (plane.finish - plane.start):magnitude() / plane.speed

	for i = 1, #self.planesArray do
		local other = self.planesArray[i]

		local timeUntilCollision = self:timeUntilPlaneCollision( plane, other )

		if 0 <= timeUntilCollision and timeUntilCollision <= onScreenTime then
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

	if not willCollide then
		return -1
	else
		return time
	end
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
	local santa = images:get( self.doodadsGroup, "Santa")
	santa:rotate(20)
	santa.x = math.random(0,300)
	santa.y = 0
	santa.alpha = 0.8
	physics.addBody(santa, "kinematic", { radius = 30, bounce = 0.8})
	santa:setLinearVelocity(math.random(50,100),math.random(50,100))
	table.insert(self.eventsArray,santa)
end

function scene:spawnPizza()
	-- trigger giant pizza
	local pizza = images:get(self.doodadsGroup, "Pizza")
	pizza.x = 0
	pizza.y = math.random(0,300)
	pizza.alpha = 0.8
	physics.addBody(pizza, "dynamic", {radius = 30, bounce = 0.8})
	pizza:setLinearVelocity(math.random(100,300),math.random(100, 150))
	pizza:applyTorque(math.random(-4,4))
	table.insert(self.eventsArray,pizza)
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
