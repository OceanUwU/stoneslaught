import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/animation"
import "CoreLibs/timer"
import "player"
import "sky"

function setupGame()
    playdate.display.setRefreshRate(50)
    player = Player()
    sky = Sky()
end

setupGame()

playdate.update = function()
    player:update()
    sky:update()

    playdate.graphics.sprite.update()
    playdate.timer.updateTimers()
end