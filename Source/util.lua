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

return util
