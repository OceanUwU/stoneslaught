import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/animation"
import "CoreLibs/timer"
import "CoreLibs/easing"
import "player"
import "sky"
import "title"

function setupGame()
    playdate.display.setRefreshRate(50)
    player = Player()
    sky = Sky()
    title = Title()
end

function startNewGame()
    playdate.resetElapsedTime()
    sky:start()
    player.score:updateScore(0)
    player.movable = true
    player:reset()
end

function endGame()
    sky.active = false
end

playdate.update = function()
    sky:update()
    player:update()
    title:update()

    playdate.graphics.sprite.update()
    playdate.timer.updateTimers()

    player:draw()
end

setupGame()