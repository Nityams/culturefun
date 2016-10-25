local EventListener = {}

function EventListener:new()
	-- el inherits from EventListener
	local el = {}
	setmetatable( el, self )
	self.__index = self

	return el
end

function EventListener:addEventListener( eventName, handlerFn )
	if self[eventName] == nil then
		self[eventName] = {}
	end
	table.insert( self[eventName], handlerFn )
end

function EventListener:dispatchEvent( eventName, eventDetails )
	if self[eventName] ~= nil then
		for _,handlerFn in ipairs( self[eventName] ) do
			handlerFn( eventDetails )
		end
	end
end

function EventListener:clear()
	self = {}
end

return EventListener
