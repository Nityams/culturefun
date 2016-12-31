local musics = {
    configs = {},
    streams = {}
}

function musics.defineMusic( name, path, volume, fadeIn )
    musics.configs[name] = { path=path, volume=volume, fadeIn=fadeIn }
end

function musics.loadMusic( name )
    local path = musics.configs[name].path

    if musics.streams[path] == nil then
        print( "Loading Music for " .. name .. " (" .. path .. ")" )
    	musics.streams[path] = audio.loadStream( path )
    end
end

function musics.play( name )
    local config = musics.configs[name]

    local path = config.path
    local volume = config.volume
    local fadeIn = config.fadeIn

    musics.loadMusic( name )
    local stream = musics.streams[path]

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
-- New UPDATED
function musics.stop()
  audio.stop()
end

return musics
