local sounds = {
    paths = {},
    sounds = {}
}

function sounds:getSound( path )
    if self.sounds[path] == nil then
    	self.sounds[path] = audio.loadSound( path )
    end

    return self.sounds[path]
end

function sounds:defineSound( name, path )
    self.paths[name] = path
end

function sounds:play( name, volume )
    local path = self.paths[name]
    local sound = self:getSound( path )
	local channel = audio.play( sound )
	audio.setVolume( 1, { channel=channel } )
end

return sounds
