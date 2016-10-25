local fonts = {}

local function loadFont( path )
  if fonts[path] == nil then
    fonts[path] = native.newFont(path)
  end

  return fonts[path]
end

fonts.neucha = function()
    return loadFont( "Assets/Fonts/neucha.otf" )
end

return fonts
