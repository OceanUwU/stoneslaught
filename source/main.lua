import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/animation"
import "CoreLibs/timer"
import "player"

function setupGame()
    player = Player()
end

setupGame()

playdate.update = function()
    player:update()

    playdate.graphics.sprite.update()
    playdate.timer.updateTimers()
end