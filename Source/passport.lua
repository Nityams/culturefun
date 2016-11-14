local composer = require( "composer" )

local Button = require( "Source.button" )
local countries = require( "Source.Countries" )
local geo = require( "Source.geo" )
local images = require( "Source.images" )
local Pin = require( "Source.pin" )
local ScrollZoomController = require( "Source.scrollZoomController" )
local util = require( "Source.util" )


-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

local scene = composer.newScene()

local screenLeft = 0
local screenRight = display.contentWidth
local screenTop = (display.contentHeight - display.viewableContentHeight) / 2
local screenBottom = (display.contentHeight + display.viewableContentHeight) / 2
local screenWidth = screenRight - screenLeft
local screenHeight = screenBottom - screenTop

images.defineImage( "Close Button", "Scene/9.png", display.contentWidth/20, display.contentHeight/14 )
images.defineImage( "Close Button Pressed", "Scene/9-pressed.png", display.contentWidth/20, display.contentHeight/14 )

images.defineImage( "Map", "Passport/blank_map.png", 1920, 1920 )

local MAP_HEIGHT = 6.0070481862  -- height of Miller projection cylinder
local MAP_EQUATOR = 0.6114583333  -- percent from top

local MAP_WIDTH = 341.9194386243  -- degrees Longitude
local MAP_PRIME_MERIDIAN = 0.4666666667  -- percent from left

local MIN_ZOOM = 0.9
local MAX_ZOOM = 5


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

	local sceneGroup = self.view

	local whiteFill = display.newRect(
		sceneGroup,
		display.contentCenterX, display.contentCenterY,
		screenWidth, screenHeight
	)
	whiteFill:setFillColor( 1, 1, 1 )

	self.map = images.get( sceneGroup, "Map" )
	self.map.x = display.contentCenterX
	self.map.y = display.contentCenterY

	local defaultScale = screenWidth / self.map.width
	local minScale = defaultScale * MIN_ZOOM
	local maxScale = defaultScale * MAX_ZOOM

	local returnButton = Button:newImageButton{
		group = sceneGroup,
		image = images.get( sceneGroup, "Close Button" ),
		imagePressed = images.get( sceneGroup, "Close Button Pressed" ),
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

	local scrollZoom = ScrollZoomController:new{
		object = self.map,
		minScale = minScale, maxScale = maxScale,
		defaultScale = defaultScale,
		minX = screenLeft,
		maxX = screenRight,
		minY = screenTop - (screenWidth - screenHeight) / 2,
		maxY = screenBottom + (screenWidth - screenHeight) / 2
	}

	self.map:addEventListener( "touch", function( e )
		return scrollZoom:handleTouch( e )
	end)
	whiteFill:addEventListener( "touch", function( e )
		return scrollZoom:handleTouch( e )
	end)
	scrollZoom:addEventListener( "move", function()
		self:repositionPins()
	end)

	self:repositionPins()
end


-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen

		system.activate( "multitouch" )

	end
end


-- hide()
function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is on screen (but is about to go off screen)

		system.deactivate( "multitouch" )

	elseif ( phase == "did" ) then
		-- Code here runs immediately after the scene goes entirely off screen

	end
end


-- destroy()
function scene:destroy( event )

	local sceneGroup = self.view
	-- Code here runs prior to the removal of scene's view

end


function scene:addPins( countries )
	-- Add the new countries
	for i = 1,#countries do
		local country = countries[i]
		if country.coordinates then
			local pin = makePin( self.view, country, lat, lon )
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
