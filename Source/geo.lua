local geo = {}


local function degreesToRadians( x )
	return x * math.pi / 180
end

function geo.millerProjection( lat )
	-- https://en.wikipedia.org/wiki/Miller_cylindrical_projection
	local rads = degreesToRadians( lat )
	local y = 5/4 * math.log( math.tan( 1/4*math.pi + 2/5*rads ) )
	return y
end

function geo.convertMillerToMap( mapHeight, mapEquator, y )
	-- y ranges from -2.30341 to +2.30341
	--    0 is the equator
	--   -2.30341 is the south pole
	--   +2.30341 is the north pole

	-- Our map's height is mapHeight units, and the equator is mapEquator
	-- percent down the map.

	-- Output value 0.0 means the top of the map, 1.0 means the bottom.
	return -y / mapHeight + mapEquator
end

function geo.convertLogitudeToMap( mapWidth, mapPrimeMeridian, lon )
	-- lon ranges from -180 to 180
	--    0 is the prime meridian
	--   -180 is a meridian that goes through the Pacific Ocean
	--   +180 is the same meridian

	-- Our map's width covers mapWidth degrees of longitude, and the prime
	-- meridian is mapPrimeMeridian percent over from the left.

	-- Output value 0.0 means the left side of the map, 1.0 means the right.
	return lon / mapWidth + mapPrimeMeridian
end


return geo
