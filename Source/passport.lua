local composer = require( "composer" )

local Button = require( "Source.button" )
local countries = require( "Source.countries" )
local images = require( "Source.images" )


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

images.defineImage( "Map", "Passport/blank_map.png", screenWidth, screenWidth )
images.defineImage( "Pin", "Passport/pin.png", 39, 58 )

local MAP_HEIGHT = 6.0070481862  -- height of Miller projection cylinder
local MAP_EQUATOR = 0.6114583333  -- percent from top

local MAP_WIDTH = 341.9194386243  -- degrees Longitude
local MAP_PRIME_MERIDIAN = 0.4666666667  -- percent from left


-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )
	-- Code here runs when the scene is first created but has not yet appeared on screen

	local sceneGroup = self.view

	local whiteFill = display.newRect( sceneGroup, 0, 0, display.contentWidth, display.contentHeight )
	whiteFill.x = display.contentCenterX
	whiteFill.y = display.contentCenterY
	whiteFill:setFillColor( 1, 1, 1 )

	local map = images.get( sceneGroup, "Map" )
	map.x = display.contentCenterX
	map.y = display.contentCenterY

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

	for i = 1,#countries do
		local country = countries[i]
		if country.coordinates then
			self:addPin( country, lat, lon )
		end
	end
end


-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

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

	end
end


-- destroy()
function scene:destroy( event )

	local sceneGroup = self.view
	-- Code here runs prior to the removal of scene's view

end


local function degreesToRadians( x )
	return x * math.pi / 180
end

local function millerProjection( lat )
	-- https://en.wikipedia.org/wiki/Miller_cylindrical_projection
	local rads = degreesToRadians( lat )
	local y = 5/4 * math.log( math.tan( 1/4*math.pi + 2/5*rads ) )
	return y
end

local function convertMillerToMap( y )
	-- Output value 0.0 means the top of the map, 1.0 means the bottom.

	-- y ranges from -2.30341 to +2.30341
	--    0 is the equator
	--   -2.30341 is the south pole
	--   +2.30341 is the north pole

	-- Our map's height is MAP_HEIGHT units, and the equator is MAP_EQUATOR
	-- percent down the map.

	return -y / MAP_HEIGHT + MAP_EQUATOR
end

local function convertLogitudeToMap( lon )
	-- Output value 0.0 means the left side of the map, 1.0 means right.

	-- lon ranges from -180 to 180
	--    0 is the prime meridian
	--   -180 is a meridian that goes through the Pacific Ocean
	--   +180 is the same meridian

	-- Our map's width covers MAP_WIDTH degrees of longitude, and the prime
	-- meridian is MAP_PRIME_MERIDIAN percent over from the left.

	return lon / MAP_WIDTH + MAP_PRIME_MERIDIAN
end


function scene:addPin( country )
	local coords = country.coordinates

	-- Our map uses Miller projection. To place our pins in the right spot we'll
	-- need to use the same projection.
	local millerY = millerProjection( coords.lat )

	local mapX = convertLogitudeToMap( coords.lon )
	local mapY = convertMillerToMap( millerY )

	local mapWidth = screenWidth
	local mapHeight = screenWidth
	local mapLeft = screenLeft
	local mapTop = screenTop + (screenHeight - screenWidth) / 2

	local image = images.get( self.view, "Pin" )
	image.anchorY = 1.0  -- Make image.y be for the bottom of the image.
	image.x = mapLeft + mapX * mapWidth
	image.y = mapTop + mapY * mapHeight
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
