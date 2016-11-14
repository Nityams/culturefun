local util = {}

function util.aspectRatio()
	return display.actualContentWidth / display.actualContentHeight
end

function util.push( array, value )
	array[#array + 1] = value
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

function util.contains( left, right, top, bottom, x, y )
	return (left < x and x < right and
	        top  < y and y < bottom)
end

function util.isNaN( x )
	-- http://lua-users.org/wiki/InfAndNanComparisons
	return x ~= x
end

return util
