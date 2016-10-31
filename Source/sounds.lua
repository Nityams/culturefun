local sounds = {
    params = {},
    sounds = {}
}

function sounds.defineSound( name, path, volume )
    sounds.params[name] = { path=path, volume=volume }
end

function sounds.loadSound( name )
    local path = sounds.params[name].path

    if sounds.sounds[path] == nil then
        print( "Loading Sound for " .. name .. " (" .. path .. ")" )
    	sounds.sounds[path] = audio.loadSound( path )
    end

    return sounds.sounds[path]
end

function sounds.play( name )
    local path = sounds.params[name].path
    local volume = sounds.params[name].volume

    sounds.loadSound( name )

    local sound = sounds.sounds[path]
	local channel = audio.play( sound )
	audio.setVolume( volume, { channel=channel } )
end

return sounds
