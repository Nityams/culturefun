local Preloader = {}

function Preloader:new( preloadCoroutine )
	local p = {}
	setmetatable( p, self )
	self.__index = self

	p.preloadCoroutine = preloadCoroutine

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
		timer.performWithDelay( 50, function() self:run() end )
	end
end

return Preloader
