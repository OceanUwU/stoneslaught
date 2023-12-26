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

function startNewGame()
    playdate.resetElapsedTime()
    sky:start()
    player.score:updateScore(0)
    player:reset()
end

function endGame()
    sky.active = false
end

playdate.update = function()
    sky:update()
    player:update()

    playdate.graphics.sprite.update()
    playdate.timer.updateTimers()
end

setupGame()
startNewGame() --TODO: make title screen and move this there