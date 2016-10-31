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

	p:start()

	return p
end

function Preloader:start()
	timer.performWithDelay( 0, function() self:run() end )
end

function Preloader:stop()
	self.preloadCoroutine = nil
end

function Preloader:run()
	if self.preloadCoroutine and coroutine.status( self.preloadCoroutine ) == "suspended" then
		local before = system.getTimer()
		local after = before

		while after < before + 10 do
			self.numberDone = self.numberDone + 1
			coroutine.resume( self.preloadCoroutine )
			after = system.getTimer()
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
