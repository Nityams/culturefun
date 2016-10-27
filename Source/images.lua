local util = require( "Source.util" )

local images = {
    group = display.newGroup(),
    params = {},
    preloadedImages = {}
}

function images:defineImage( name, path, width, height )
    self.params[name] = { path="Assets/Images/"..path, width=width, height=height }
end

function images:defineSheet( name, path, options )
    self.params[name] = { path="Assets/Images/"..path, options=options }
end

function images:preload( name, count )
    count = count or 1

    local path = self.params[name].path

    print( "Preloading ImageRect for " .. path )

    if self.preloadedImages[path] == nil then
        self.preloadedImages[path] = {}
    end

    for i = 1,count do
        local imageRect = self:make( self.group, name )
        imageRect.isVisible = false
        util.push( self.preloadedImages[path], imageRect )
    end
end

function images:preloadSheet( name )
    local path = self.params[name].path

    print( "Preloading ImageSheet for " .. path )

    if self.preloadedImages[path] == nil then
        self.preloadedImages[path] = {}
    end

    local imageSheet = self:makeSheet( name )
    util.push( self.preloadedImages[path], imageSheet )
end

function images:make( group, name )
    local params = self.params[name]
    return display.newImageRect(
        group,
        params.path,
        params.width, params.height
    )
end

function images:makeSheet( name )
    local params = self.params[name]
    return graphics.newImageSheet( params.path, params.options )
end

function images:hasReady( path )
    return self.preloadedImages[path] ~= nil and #self.preloadedImages[path] > 0
end

function images:get( group, name )
    local path = self.params[name].path

    local imageRect

    -- Do we have one already?
    if self:hasReady(path) then
        print( "Using preloaded ImageRect for " .. path )
        imageRect = util.pop( self.preloadedImages[path] )
        imageRect.isVisible = true
        group:insert( imageRect )
    else
        print( "Making new ImageRect for " .. path )
        imageRect = self:make( group, name )
    end

    return imageRect
end

function images:getSheet( name )
    local path = self.params[name].path

    local imageSheet

    -- Do we have one already?
    if self:hasReady(path) then
        print( "Using preloaded ImageSheet for " .. path )
        imageSheet = util.pop( self.preloadedImages[path] )
    else
        print( "Making new ImageSheet for " .. path )
        imageSheet = self:makeSheet( name )
    end

    return imageSheet
end

function images:print()
    for name,imageList in pairs(self.preloadedImages) do
        print( "\"" .. name .. "\" = " .. #self.preloadedImages[path] )
    end
end

return images
