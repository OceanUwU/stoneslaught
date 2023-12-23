import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/animation"
import "CoreLibs/timer"

local pd<const> = playdate
local gfx<const> = pd.graphics

import "player"

function setupGame()
    local font<const> = gfx.getFont()
    local greeting<const> = "Hello, Basic Configuration! Ocean time!"
    local w<const> = font:getTextWidth(greeting)
    local h<const> = font:getHeight()
    local x<const> = (400 - w) / 2
    local y<const> = (240 - h) / 2
    player = Player()
    gfx.drawText(greeting, x, y)
end

setupGame()

function pd.update()
    player:update()

    gfx.sprite.update()
    pd.timer.updateTimers()
end