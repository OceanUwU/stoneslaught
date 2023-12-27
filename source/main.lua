import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/animation"
import "CoreLibs/timer"
import "CoreLibs/easing"
import "player"
import "sky"
import "title"
import "death"

function setupGame()
    playdate.display.setRefreshRate(50)
    player = Player()
    sky = Sky()
    title = Title()
    death = Death()
    startSound = playdate.sound.sampleplayer.new("assets/audio/start")
end

function startNewGame()
    playdate.resetElapsedTime()
    sky:start()
    player.score:updateScore(0)
    player.movable = true
    player:reset()
    startSound:play()
    death:close()
end

function endGame()
    death:open(player.score.score, player.score.highScore)
    sky.active = false
end

playdate.update = function()
    sky:update()
    player:update()
    title:update()
    death:update()

    playdate.graphics.sprite.update()
    playdate.timer.updateTimers()

    player:draw()
end

setupGame()