local sounds = {
    params = {},
    sounds = {}
}

function sounds:defineSound( name, path, volume )
    self.params[name] = { path=path, volume=volume }
end

function sounds:preloadSound( name )
    local path = self.params[name].path
    print( "Preloading Sound for " .. name .. " (" .. path .. ")" )
    self:getSound( path )
end

function sounds:play( name )
    local path = self.params[name].path
    local volume = self.params[name].volume
    local sound = self:getSound( path )
	local channel = audio.play( sound )
	audio.setVolume( volume, { channel=channel } )
end

function sounds:getSound( path )
    if self.sounds[path] == nil then
    	self.sounds[path] = audio.loadSound( path )
    end

    return self.sounds[path]
end

return sounds
