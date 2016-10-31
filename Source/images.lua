local util = require( "Source.util" )

local images = {
    group = display.newGroup(),
    params = {},
    individualTextures = {},
    imageSheets = {}
}

function images.defineImage( name, path, width, height )
    images.params[name] = { path="Assets/Images/"..path, width=width, height=height }
end

function images.defineSheet( name, path, options )
    images.params[name] = { path="Assets/Images/"..path, options=options }
end

function images.width( name )
    return images.params[name].width
end

function images.height( name )
    return images.params[name].height
end

function images.loadImage( name, usedNow )
    local path = images.params[name].path

    if images.individualTextures[path] == nil then
        print( "Loading Texture for " .. name .. " (" .. path .. ")" )
        images.individualTextures[path] = graphics.newTexture({
            type = "image",
            filename = path
        })

        if not usedNow then
            -- Force Corona to do processing required on first ImageRect
            -- creation. An optimizing for when pre-loading images.
            local group = display.newGroup()
            local firstCopy = images.get( group, name )
            firstCopy:removeSelf()
        end
    end
end

function images.loadSheet( name )
    local path = images.params[name].path
    local options = images.params[name].options

    if images.imageSheets[name] == nil then
        print( "Loading ImageSheet for " .. name .. " (" .. path .. ")" )
        images.imageSheets[name] = graphics.newImageSheet( path, options )
    end

end

function images.get( group, name )
    local path = images.params[name].path
    local width = images.params[name].width
    local height = images.params[name].height

    images.loadImage( name, true )
    local texture = images.individualTextures[path]

    return display.newImageRect(
        group,
        texture.filename, texture.baseDir,
        width, height
    )
end

function images.getSheet( name )
    local path = images.params[name].path

    images.loadSheet( name )

    return images.imageSheets[name]
end

return images
