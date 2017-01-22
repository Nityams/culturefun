local composer = require( "composer" )

local Button = require( "Source.button" )
local countries = require( "Source.Countries" )
local fonts = require( "Source.fonts" )
local geo = require( "Source.geo" )
local images = require( "Source.images" )
local Pin = require( "Source.pin" )
local ScrollZoomController = require( "Source.scrollZoomController" )
local util = require( "Source.util" )
local wallet = require( "Source.wallet" )


-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

local scene = composer.newScene()

local font = fonts.neucha()

local screenLeft = 0
local screenRight = display.contentWidth
local screenTop = (display.contentHeight - display.viewableContentHeight) / 2
local screenBottom = (display.contentHeight + display.viewableContentHeight) / 2
local screenWidth = screenRight - screenLeft
local screenHeight = screenBottom - screenTop

images.defineImage( "Close Button", "FlagGame/Scene/9.png", display.contentWidth/20, display.contentHeight/14 )
images.defineImage( "Close Button Pressed", "FlagGame/Scene/9-pressed.png", display.contentWidth/20, display.contentHeight/14 )

images.defineImage( "Map", "Passport/blank_map.png", 1920, 1920 )

local MAP_HEIGHT = 6.0070481862  -- height of Miller projection cylinder
local MAP_EQUATOR = 0.6114583333  -- percent from top

local MAP_WIDTH = 341.9194386243  -- degrees Longitude
local MAP_PRIME_MERIDIAN = 0.4666666667  -- percent from left

local MIN_ZOOM = 1.0
local MAX_ZOOM = 5.0


local function makePin( displayGroup, country )
	local coords = country.coordinates

	-- Our map uses Miller projection. To place our pins in the right spot we'll
	-- need to use the same projection.
	local millerY = geo.millerProjection( coords.lat )

	local mapX = geo.convertLogitudeToMap( MAP_WIDTH, MAP_PRIME_MERIDIAN, coords.lon )
	local mapY = geo.convertMillerToMap( MAP_HEIGHT, MAP_EQUATOR, millerY )

	return Pin:new( displayGroup, mapX, mapY )
end


-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )
	-- Code here runs when the scene is first created but has not yet appeared on screen

	local scnGrp = self.view

	local whiteFill = display.newRect(
		scnGrp,
		display.contentCenterX, display.contentCenterY,
		screenWidth, screenHeight
	)
	whiteFill:setFillColor( 1, 1, 1 )

	self.map = images.get( scnGrp, "Map" )
	self.map.x = display.contentCenterX
	self.map.y = display.contentCenterY

	local defaultScale = screenWidth / self.map.width
	local minScale = defaultScale * MIN_ZOOM
	local maxScale = defaultScale * MAX_ZOOM

	local returnButton = Button:newImageButton{
		group = scnGrp,
		image = images.get( scnGrp, "Close Button" ),
		imagePressed = images.get( scnGrp, "Close Button Pressed" ),
		x = 50,
		y = screenTop + 50,
		width = images.width( "Close Button" ),
		height = images.height( "Close Button" ),
		alpha = 0.5
	}
	returnButton:addEventListener( "tap", function()
		composer.gotoScene("Source.menu")
	end)

	self.pins = {}
	self:addPins( countries )

	self.scrollZoom = ScrollZoomController:new{
		object = self.map,
		minScale = minScale, maxScale = maxScale,
		defaultScale = defaultScale
	}

	local handleTouch = function( e )
		return self.scrollZoom:handleTouch( e )
	end
	local handleMouse = function( e )
		return self.scrollZoom:handleMouse( e )
	end

	self.map:addEventListener( "touch", handleTouch )
	whiteFill:addEventListener( "touch", handleTouch )
	self.map:addEventListener( "mouse", handleMouse )
	whiteFill:addEventListener( "mouse", handleMouse )

	self.scrollZoom:addEventListener( "move", function()
		self:repositionPins()
	end)

	self:repositionPins()
end


-- show()
function scene:show( event )

	local scnGrp = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)
		print("Went to will of show")
		self:makeCoinsDisplay()
		self:addPins( countries )
	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen

		system.activate( "multitouch" )

	end
end


-- hide()
function scene:hide( event )

	local scnGrp = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is on screen (but is about to go off screen)
		print("Went to Will of Hide")
		self:addPins( countries )
		system.deactivate( "multitouch" )

	elseif ( phase == "did" ) then
		-- Code here runs immediately after the scene goes entirely off screen


		self:destroyCoinDisplay()

	end
end


-- destroy()
function scene:destroy( event )

	local scnGrp = self.view
	-- Code here runs prior to the removal of scene's view

end

-- Note: Wallet value must be less than or equal to
-- 4000 considering there's less than 8 groups
function scene:addPins( countries )
	--wallet.setCoins(1900)
	j = wallet.getCoins() / 500
	print("Money Got: ".. j)
	local tempChecker = "Mexico"
	-- Add the new countries
	if (j <= 2 and j >= 1) then
		tempChecker = "Peru"
	end
	if (j <= 3 and j >= 2) then
		tempChecker = "Morocco"
	end
	if (j <= 4 and j >= 3) then
		tempChecker = "Portugal"
	end
	if (j <= 5 and j >= 4) then
		tempChecker = "Vatican City"
	end
	if (j <= 6 and j >= 5) then
		tempChecker = "Ukraine"
	end
	if (j <= 7 and j >= 6) then
		tempChecker = "Mongolia"
	end
	if (j <= 8 and j >= 7) then
		tempChecker = "Malaysia"
	end

	for i = 1,#countries do
		local country = countries[i]
		if (country.name == tempChecker) then break end
		if (country.coordinates)then
			local pin = makePin( self.view, country, lat, lon )
			pin.country = country
			pin:addEventListener( "tap", function()
				self:openDialog( country )
			end)
			util.push( self.pins, pin )
		end
	end

	-- Graphically re-order the pins
	local function byLatitude( a, b )
		return a.y < b.y
	end

	table.sort( self.pins, byLatitude )

	for i = 1,#self.pins do
		self.pins[i]:insertInto( self.view )
	end
end


function scene:repositionPins()
	local mapWidth = self.map.width * self.map.xScale
	local mapHeight = self.map.height * self.map.yScale
	local mapTop = self.map.y - mapHeight / 2
	local mapLeft = self.map.x - mapWidth / 2

	for i = 1,#self.pins do
		local pin = self.pins[i]
		pin:reposition( mapTop, mapLeft, mapWidth, mapHeight )
	end
end


function scene:makeCoinsDisplay()
	print("coins here....".. wallet.getCoins())
	self:addPins( countries )
	j = wallet.getCoins() % 500
	self.currencyText = display.newText{
		parent = scnGrp,
		text = "" .. j .. " coins",
		x = screenRight - 25,
		y = screenTop + 15,
		font = font,
		fontSize = 44
	}
	self.currencyText.anchorX = 1.0
	self.currencyText.anchorY = 0.0
	self.currencyText:setFillColor( 0.4 )

	local temp = "next area: " .. 500 - j
	x = wallet.getCoins() / 500
	if (x == 8) then
		temp = "No New Area For Now!"
	end

	self.nextAreaText = display.newText{
		parent = scnGrp,
		text = temp,
		x = self.currencyText.x,
		y = self.currencyText.y + self.currencyText.height,
		font = font,
		fontSize = 28
	}
	self.nextAreaText.anchorX = 1.0
	self.nextAreaText.anchorY = 0.0
	self.nextAreaText:setFillColor( 0.4 )
	print("coins here again....".. wallet.getCoins())
end


function scene:destroyCoinDisplay()
	self.currencyText:removeSelf()
	self.currencyText = nil
	self.nextAreaText:removeSelf()
	self.nextAreaText = nil
end


function scene:openDialog( country )
	self.scrollZoom.enabled = false
	for i = 1,#self.pins do
		local pin = self.pins[i]
		pin.enabled = false
	end

	self.dbg = display.newRect(
		self.view,
		display.contentCenterX, display.contentCenterY,
		400, 300
	)
	self.dbg:setFillColor( 0.70, 0.90, 0.90 )

	self.dname = display.newText{
		parent = self.view,
		text = country.name,
		x = self.dbg.x - self.dbg.width / 2 + 25,
		y = self.dbg.y - self.dbg.height / 2 + 25,
		width = self.dbg.width - 50,
		font = font,
		fontSize = 36
	}
	self.dname.anchorX = 0.0
	self.dname.anchorY = 0.0
	self.dname:setFillColor( 0.4 )

	if country.fun_fact then
		local fun_fact = country.fun_fact

		if type( fun_fact ) == "table" then
			-- fun_fact is an array of fun facts... choose one
			fun_fact = util.sample( fun_fact )
		end

		self.dfact = display.newText{
			parent = self.view,
			text = fun_fact,
			x = self.dname.x,
			y = self.dname.y + self.dname.height,
			width = self.dbg.width -  50,
			font = font,
			fontSize = 24
		}
		self.dfact.anchorX = 0.0
		self.dfact.anchorY = 0.0
		self.dfact:setFillColor( 0.4 )
	end

	--timer.performWithDelay( 2000, function()
	timer.performWithDelay( 4000, function()
		self:closeDialog()
	end)
end


function scene:closeDialog()
	self.scrollZoom.enabled = true
	for i = 1,#self.pins do
		local pin = self.pins[i]
		pin.enabled = true
	end

	self.dbg:removeSelf()
	self.dbg = nil

	self.dname:removeSelf()
	self.dname = nil

	if self.dfact then
		self.dfact:removeSelf()
		self.dfact = nil
	end
end


function scene:addFlag( x, y )
	local flagIndex = self:findUnusedFlag()

	local imagePath = countryFiles[flagIndex]

	local flag = display.newImageRect(
		self.view,
		imagePath,
		7/4 * 75, 75  -- Our flags are 7:4 aspect ratio
	)
	flag.x = x
	flag.y = y
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
