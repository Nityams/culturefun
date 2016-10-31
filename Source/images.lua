local util = require( "Source.util" )

local images = {
    group = display.newGroup(),
    params = {},
    preloadedImages = {},
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

function images:preload( name, count )
    count = count or 1

    local path = self.params[name].path

    --print( "Preloading ImageRect for " .. name .. " (" .. path .. ")" )

    if self.preloadedImages[name] == nil then
        self.preloadedImages[name] = {}
    end

    -- Just ensure we have `count` of them. Only add as many as are necessary.
    count = count - #self.preloadedImages[name]

    for i = 1,count do
        local imageRect = self:make( self.group, name )
        imageRect.isVisible = false
        util.push( self.preloadedImages[name], imageRect )
    end
end

function images:loadSheet( name )
    local path = self.params[name].path
    local options = self.params[name].options

    if self.imageSheets[name] then
        return
    end

    --print( "Preloading ImageSheet for " .. name .. " (" .. path .. ")" )

    self.imageSheets[name] = graphics.newImageSheet( path, options )
end

function images:make( group, name )
    local params = self.params[name]
    return display.newImageRect(
        group,
        params.path,
        params.width, params.height
    )
end

function images:hasReady( name )
    return self.preloadedImages[name] ~= nil and #self.preloadedImages[name] > 0
end

function images:get( group, name )
    local path = self.params[name].path

    local imageRect

    -- Do we have one already?
    if self:hasReady(name) then
        --print( "Using preloaded ImageRect for " .. name )
        imageRect = util.pop( self.preloadedImages[name] )
        imageRect.isVisible = true
        group:insert( imageRect )
    else
        --print( "Making new ImageRect for " .. name )
        imageRect = self:make( group, name )
    end

    return imageRect
end

function images:getSheet( name )
    local path = self.params[name].path

    -- Do we have it already?
    if self.imageSheets[name] then
        --print( "Using preloaded ImageSheet for " .. name )
    else
        --print( "Making new ImageSheet for " .. name )
        self:loadSheet( name )
    end

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
