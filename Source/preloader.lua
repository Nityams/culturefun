local EventListener = require( "Source.eventListener" )

local Preloader = {}

function Preloader:new( preloadCoroutine, total )
	local p = {}
	setmetatable( p, self )
	self.__index = self

	p.preloadCoroutine = preloadCoroutine

	p.completed = 0
	p.total = total
	p.emitsProgressEvents = (total ~= nil)

	p.eventListener = EventListener:new()

	p:start()

	return p
end

function Preloader:start()
	timer.performWithDelay( 75, function() self:run() end )
end

function Preloader:stop()
	self.preloadCoroutine = nil
end

function Preloader:run()
	if self.preloadCoroutine and coroutine.status( self.preloadCoroutine ) == "suspended" then
		coroutine.resume( self.preloadCoroutine )

		self.completed = self.completed + 1
		if self.total then
			self.eventListener:dispatchEvent( "progress", self.completed / self.total )
		end

		timer.performWithDelay( 25, function() self:run() end )
	end
end

function Preloader:addEventListener( eventName, handlerFn )
	self.eventListener:addEventListener( eventName, handlerFn )
end

return Preloader
