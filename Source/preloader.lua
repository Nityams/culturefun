local EventListener = require( "Source.eventListener" )

local Preloader = {}

function Preloader:new( preloadCoroutine, total )
	local p = {}
	setmetatable( p, self )
	self.__index = self

	p.preloadCoroutine = preloadCoroutine

	p.numberDone = 0
	p.numberTotal = total
	p.completed = false

	p.emitsProgressEvents = (p.numberTotal ~= nil)

	p.eventListener = EventListener:new()

	return p
end

function Preloader:start()
	self:run()
end

function Preloader:stop()
	self.preloadCoroutine = nil
end

function Preloader:hasMore()
	return coroutine.status( self.preloadCoroutine ) == "suspended"
end

function Preloader:run()
	if self.preloadCoroutine and self:hasMore() then
		local before = system.getTimer()
		local after = before

		while after < before + 10 and self:hasMore() do
			coroutine.resume( self.preloadCoroutine )
			self.numberDone = self.numberDone + 1
			after = system.getTimer()
			print( "before " .. before .. " after " .. after .. " numberDone " .. self.numberDone )
		end

		if self.numberTotal then
			self.eventListener:dispatchEvent( "progress", self.numberDone / self.numberTotal )

			if self.numberDone > self.numberTotal and not self.completed then
				self.completed = true
				self.eventListener:dispatchEvent( "done" )
			end
		end

		timer.performWithDelay( 25, function() self:run() end )
	end
end

function Preloader:addEventListener( eventName, handlerFn )
	self.eventListener:addEventListener( eventName, handlerFn )
end

return Preloader
