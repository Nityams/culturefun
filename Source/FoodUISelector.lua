local composer = require( "composer" )

local Button = require( "Source.button" )
local fonts = require( "Source.fonts" )
local images = require( "Source.images" )
local Preloader = require( "Source.preloader" )
local util = require( "Source.util" )

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

local scene = composer.newScene()

local font = fonts.neucha()
local titleOffsetY = (util.aspectRatio() > 4/3 and 250 or 175)

local screenLeft = 0
local screenRight = display.contentWidth
local screenTop = (display.contentHeight - display.viewableContentHeight) / 2
local screenBottom = (display.contentHeight + display.viewableContentHeight) / 2

images.defineImage(
  "World Map Blurred",
  "Menu/MenuBackgroundV1Edit_Blurred.png",
  display.contentWidth, display.contentHeight*1.3
)
images.defineImage( "Close Button", "FlagGame/Scene/9.png", display.contentWidth/20, display.contentHeight/14 )
images.defineImage( "Close Button Pressed", "FlagGame/Scene/9-pressed.png", display.contentWidth/20, display.contentHeight/14 )

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

function scene:preload()
  return Preloader:new(coroutine.create(function()
        images.loadImage( "World Map Blurred" ); coroutine.yield()
        images.loadImage( "Close Button" ); coroutine.yield()
        images.loadImage( "Close Button Pressed" ); coroutine.yield()
      end))
end

-- create()
function scene:create( event )
  -- Code here runs when the scene is first created but has not yet appeared on screen

  local sceneGroup = self.view

  local bgWhiteFill = display.newRect(
    sceneGroup,
    display.contentCenterX, display.contentCenterY,
    display.contentWidth, display.contentHeight
  )
  bgWhiteFill:setFillColor( 1, 1, 1 )

  local bgWorldMap = images.get( sceneGroup, "World Map Blurred" )
  bgWorldMap.x = display.contentCenterX
  bgWorldMap.y = display.contentCenterY
  bgWorldMap.alpha = 0.5

  local chooseText = display.newText(
    sceneGroup,
    "Choice Interface Type",
    display.contentCenterX, titleOffsetY + 115,
    font, 64
  )
  chooseText:setFillColor( 0.4, 0.4, 0.4 )

  self.easyButton = Button:newTextButton{
    group=sceneGroup,
    font=font, fontSize=44, fontColor={ 0.4 },
    text="UI - 1",
    x=display.contentCenterX - display.contentCenterX/4, y=display.contentCenterY + 115,
    paddingX=55, paddingY=15,
    fillColor={ 0.97 }, fillColorPressed={ 0.90 },
    borderWidth=3, borderColor={ 0.85 }
  }
  self.mediumButton = Button:newTextButton{
    group=sceneGroup,
    font=font, fontSize=44, fontColor={ 0.4 },
    text="UI - 2",
    x=display.contentCenterX+display.contentCenterX/4, y=display.contentCenterY + 115,
    paddingX=30, paddingY=15,
    fillColor={ 0.97 }, fillColorPressed={ 0.90 },
    borderWidth=3, borderColor={ 0.85 }
  }
  -- self.hardButton = Button:newTextButton{
  --   group=sceneGroup,
  --   font=font, fontSize=44, fontColor={ 0.4 },
  --   text="Nothing here",
  --   x=display.contentCenterX + 250, y=display.contentCenterY + 115,
  --   paddingX=55, paddingY=15,
  --   fillColor={ 0.97 }, fillColorPressed={ 0.90 },
  --   borderWidth=3, borderColor={ 0.85 }
  -- }

  local returnButton = Button:newImageButton{
    group = sceneGroup,
    image = images.get( sceneGroup, "Close Button" ),
    imagePressed = images.get( sceneGroup, "Close Button Pressed" ),
    x = 50,
    y = screenTop + 50,
    width = images.width( "Close Button" ),
    height = images.height( "Close Button" ),
    alpha = 0.5
  }

  local function disableButtons()
    self.easyButton.enabled = false
    self.mediumButton.enabled = false
    -- self.hardButton.enabled = false
  end
  self.easyButton:addEventListener( "pretap", disableButtons )
  self.mediumButton:addEventListener( "pretap", disableButtons )
  -- self.hardButton:addEventListener( "pretap", disableButtons )
  self.easyButton:addEventListener( "tap", function() self:gotoGame( 1 ) end)
  self.mediumButton:addEventListener( "tap", function() self:gotoGame( 2 ) end)
  -- self.hardButton:addEventListener( "tap", function() self:gotoGame( 3 ) end)

  returnButton:addEventListener( "tap", function()
      composer.gotoScene("Source.menu")
    end)
end

-- show()
function scene:show( event )

  local sceneGroup = self.view
  local phase = event.phase
  -- local minigame = event.params.minigame

  if ( phase == "will" ) then
    -- Code here runs when the scene is still off screen (but is about to come on screen)

    -- self.menuMusicChannel = event.params.menuMusicChannel
    -- self.minigameSourcePath = minigame.sourcePath
    --
    -- self.nameText = display.newText(
    --   sceneGroup,
    --   minigame.name,
    --   display.contentCenterX, titleOffsetY,
    --   font, 96
    -- )
    -- self.nameText:setFillColor( 0.4, 0.4, 0.4 )

    self.easyButton.enabled = true
    self.mediumButton.enabled = true
    -- self.hardButton.enabled = true

    -- local alreadyPreloaded = composer.getVariable( "Have preloaded " .. minigame.name )
    --
    -- if minigame.preloadFn and not alreadyPreloaded then
    --   composer.setVariable( "Have preloaded " .. minigame.name, true )
    --   self:startPreloading( minigame.preloadFn )
    -- end

  elseif ( phase == "did" ) then
    -- Code here runs when the scene is entirely on screen

    if self.preloader then
      timer.performWithDelay( 1000/16, function() self.preloader:start() end )
    end

  end
end

-- hide()
function scene:hide( event )

  local sceneGroup = self.view
  local phase = event.phase

  if ( phase == "will" ) then
    -- Code here runs when the scene is on screen (but is about to go off screen)

  elseif ( phase == "did" ) then
    -- Code here runs immediately after the scene goes entirely off screen

  --  self.nameText:removeSelf()

    if self.loadingText then
      self.loadingText:removeSelf()
      self.loadingText = nil
    end
  end
end

-- destroy()
function scene:destroy( event )

  local sceneGroup = self.view
  -- Code here runs prior to the removal of scene's view

end

function scene:gotoGame(UINum )
  if self.preloader then
    self.preloader:stop()
  end

  -- Menu music that started in menu.lua... it's time to stop
  audio.fadeOut( 500, { channel=self.menuMusicChannel } )
  audio.stopWithDelay( 500, { channel=self.menuMusicChannel } )

  composer.setVariable( "Menu music still playing", false )

  --composer.setVariable( "difficulty", difficulty )
  if UINum == 1 then
    composer.gotoScene("Source.foodGame_UI1")
  else
    composer.gotoScene("Source.foodGame_UI2")
  end
end

function scene:startPreloading( preloadFn )
  self.preloader = preloadFn()

  if self.preloader.emitsProgressEvents then
    self.loadingText = display.newText(
      self.view,
      "Loading...",
      display.contentCenterX, screenBottom - 100,
      font, 24
    )
    self.loadingText:setFillColor( 0.4, 0.4, 0.4 )

    self.preloader:addEventListener( "done", function()
        if self.loadingText then
          self.loadingText:removeSelf()
          self.loadingText = nil
        end
      end)
  end
end

-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------

return scene
