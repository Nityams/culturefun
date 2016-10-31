local util = require( "Source.util" )

local images = {
    group = display.newGroup(),
    params = {},
    individualTextures = {},
    imageSheets = {}
}

function images:defineImage( name, path, width, height )
    self.params[name] = { path="Assets/Images/"..path, width=width, height=height }
end

function images:defineSheet( name, path, options )
    self.params[name] = { path="Assets/Images/"..path, options=options }
end

function images:width( name )
    return self.params[name].width
end

function images:height( name )
    return self.params[name].height
end

function images:loadImage( name )
    local path = self.params[name].path

    if self.individualTextures[path] == nil then
        print( "Loading Texture for " .. name .. " (" .. path .. ")" )
        self.individualTextures[path] = graphics.newTexture({
            type = "image",
            filename = path
        })
    end
end

function images:loadSheet( name )
    local path = self.params[name].path
    local options = self.params[name].options

    if self.imageSheets[name] == nil then
        print( "Loading ImageSheet for " .. name .. " (" .. path .. ")" )
        self.imageSheets[name] = graphics.newImageSheet( path, options )
    end

end

function images:get( group, name )
    local path = self.params[name].path
    local width = self.params[name].width
    local height = self.params[name].height

    self:loadImage( name )
    local texture = self.individualTextures[path]

    return display.newImageRect(
        group,
        texture.filename, texture.baseDir,
        width, height
    )
end

function images:getSheet( name )
    local path = self.params[name].path

    self:loadSheet( name )

    return self.imageSheets[name]
end

function images:print()
    for name,imageList in pairs(self.preloadedImages) do
        print( "\"" .. name .. "\" = " .. #self.preloadedImages[name] )
    end
    for name,imageList in pairs(self.imageSheets) do
        print( "\"" .. name .. "\" = " .. #self.imageSheets[name] )
    end
end

return images
