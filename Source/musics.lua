local musics = {
    configs = {},
    streams = {}
}

function musics:defineMusic( name, path, volume, fadeIn )
    self.configs[name] = { path=path, volume=volume, fadeIn=fadeIn }
end

function musics:loadMusic( name )
    local path = self.configs[name].path

    if self.streams[path] == nil then
        print( "Loading Music for " .. name .. " (" .. path .. ")" )
    	self.streams[path] = audio.loadStream( path )
    end
end

function musics:play( name )
    local config = self.configs[name]

    local path = config.path
    local volume = config.volume
    local fadeIn = config.fadeIn

    self:loadMusic( name )
    local stream = self.streams[path]

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

return musics
