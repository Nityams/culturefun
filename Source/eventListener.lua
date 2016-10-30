local util = require( "Source.util" )

local EventListener = {}

function EventListener:new()
	-- el inherits from EventListener
	local el = {
		listeners = {}
	}
	setmetatable( el, self )
	self.__index = self

	return el
end

function EventListener:addEventListener( eventName, handlerFn )
	if self.listeners[eventName] == nil then
		self.listeners[eventName] = {}
	end
	util.push( self.listeners[eventName], handlerFn )
end

function EventListener:dispatchEvent( eventName, eventDetails )
	local listeners = self.listeners[eventName]
	if listeners ~= nil then
		for i = 1,#listeners do
			listeners[i]( eventDetails )
		end
	end
end

function EventListener:clear()
	self.listeners = {}
end

return EventListener
