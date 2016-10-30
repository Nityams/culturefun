local musics = {
    configs = {},
    streams = {}
}

function musics:defineMusic( name, path, volume, fadeIn )
    self.configs[name] = { path=path, volume=volume, fadeIn=fadeIn }
end

function musics:preloadMusic( name )
    local path = self.configs[name].path
    print( "Preloading Music for " .. name .. " (" .. path .. ")" )
    self:getMusic( path )
end

function musics:play( name )
    local config = self.configs[name]

    local path = config.path
    local volume = config.volume
    local fadeIn = config.fadeIn

    local stream = self:getMusic( path )

    audio.rewind( stream )
	local channel = audio.play( stream, { loops=-1 } )

    if fadeIn then
    	audio.setVolume( 0, { channel=channel } )
    	audio.fade( { channel=channel, time=fadeIn, volume=volume } )
    else
    	audio.setVolume( volume, { channel=channel } )
    end

    return channel
end

function musics:getMusic( path )
    if self.streams[path] == nil then
    	self.streams[path] = audio.loadStream( path )
    end

    return self.streams[path]
end

return musics
