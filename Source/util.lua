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


--
-- nextFrame
--

local fakeObject = {}

local metatable = {}
setmetatable(fakeObject, metatable)

metatable.__index = function(table, key) return 0 end
metatable.__newindex = function(table, key, value)
	if value == 1 then
		local state = key
		state.callback()

		-- Prevent a second call.
		transition.cancel( state.transitionHandle )
	end
end

local timing = {}

-- Exploit the fact that Corona's transition.to() only fires once per frame,
-- and that the first time it will fire will be after the current frame.
function util.nextFrame( callback )
	local state = {
		callback = callback
	}
	local transitionHandle = transition.to( fakeObject, {
		time=1000/60,
		[state]=1
	} )
	state.transitionHandle = transitionHandle
end


return util
