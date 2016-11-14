local util = {}

function util.aspectRatio()
	return display.actualContentWidth / display.actualContentHeight
end

function util.push( array, value )
	array[#array + 1] = value
	return #array
end

function util.pop( array )
	local value = array[#array]
	array[#array] = nil
	return value
end

function util.size( table )
	local count = 0

	for _ in pairs( table ) do
		count = count + 1
	end

	return count
end

function util.nextFrame( callback )
	timer.performWithDelay( 1000/16, callback )
end

function util.transition( time, easing, callback )
	-- Call callback( x ) where x goes from 0.0 to 1.0 over `time` milliseconds.
	-- Use a particular easing method, if specified.

	if callback == nil then
		-- Two argument version: util.transition( time, callback )
		callback = easing
		easing = nil
	end

	local mt = {}
	local t = {}
	setmetatable( t, mt )

	mt.__index = function( obj, key )
		return 0.0
	end
	mt.__newindex = function( obj, key, value )
		callback( value )
	end

	local function onComplete()
		callback( 1.0 )
	end

	return transition.to( t, {
		time = time,
		transition = easing,
		x = 1.0,
		onComplete = onComplete
	} )
end

function util.contains( left, right, top, bottom, x, y )
	return (left < x and x < right and
	        top  < y and y < bottom)
end

function util.isNaN( x )
	-- http://lua-users.org/wiki/InfAndNanComparisons
	return x ~= x
end

return util
