-- On-screen logger for when device log doesn't work
-- (happens with Corona 2016.2980, Xcode 8.1, and iOS 10.1)

local fonts = require( "Source.fonts" )

local font = fonts.neucha()

local screenLeft = 0
local screenRight = display.contentWidth
local screenTop = (display.contentHeight - display.viewableContentHeight) / 2
local screenBottom = (display.contentHeight + display.viewableContentHeight) / 2


local log = {
    msgs = {},
    last = 0,
    alive = 0
}


local function killMsg( idx )
    if log.msgs[idx] then
        log.msgs[idx]:removeSelf()
        log.msgs[idx] = nil
        log.alive = log.alive - 1
    end
end


function log.log( displayGroup, text )
    local msg = display.newText{
        parent = displayGroup,
        text = text,
        font = font,
        fontSize = 20,
        align = "right"
    }

    msg.anchorY = 1.0
    msg.anchorX = 1.0
    msg.x = screenRight - 50
    msg.y = screenBottom - 50
    msg:setFillColor( 0, 0, 0 )

    for _,oldMsg in pairs( log.msgs ) do
        oldMsg.y = oldMsg.y - 15 - msg.height
    end

    local idx = log.last + 1
    log.last = log.last + 1
    log.alive = log.alive + 1

    log.msgs[idx] = msg

    timer.performWithDelay( 4000, function()
        killMsg( idx )
    end)

    if log.alive > 20 then
        killMsg( log.last - 20 )
    end
end


return log
