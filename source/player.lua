import "score"

class('Player').extends()

local states<const> = {idle = 1, run = 2, jumping = 3, dead = 4}
local animFrameTime<const> = 40
local unFlipped<const> = playdate.graphics.kImageUnflipped
local flipped<const> = playdate.graphics.kImageFlippedX
local baseY<const> = 240 - 12
local goalX<const> = 400 - 20
local moveSpeed<const> = 6

function Player:init()
    self.flip = unFlipped
    self.state = states.idle

    local imgTable = playdate.graphics.imagetable.new("assets/img/player")
    self.anims = {}
    for k,v in pairs(states) do
        self.anims[v] = playdate.graphics.animation.loop.new(animFrameTime, imgTable, true);
    end
    self.anims[states.idle].startFrame = 1
    self.anims[states.idle].endFrame = 1
    self.anims[states.run].startFrame = 2
    self.anims[states.run].endFrame = 5
    self.anims[states.jumping].startFrame = 6
    self.anims[states.jumping].endFrame = 7
    self.anims[states.dead].startFrame = 8
    self.anims[states.dead].endFrame = 8

    self.sprite = playdate.graphics.sprite.new(self.anims[self.state]:image())
    self.sprite:add()
    self.sprite.update = function() self.sprite:setImage(self.anims[self.state]:image(), self.flip) end

    self.goalSprite = playdate.graphics.sprite.new(playdate.graphics.image.new("assets/img/goal"))
    self.goalSprite:moveTo(goalX, baseY + self.sprite.height * 1.5 - self.goalSprite.height)
    self.goalSprite:add()

    self.score = Score(self.goalSprite.x, self.goalSprite.y)
    self:reset()
end

function Player:reset()
    self.state = states.idle
    self.x = 20
    self.y = baseY
end

function Player:startLevel()
    self.score:updateScore(self.score.score + 1)
    self:reset()
end

function Player:winLevel()
    self.x = goalX
    self.state = states.jumping
    self.jumpStart = playdate.getElapsedTime()
end

function Player:update()
    if self.state == states.jumping then 
        self.y = baseY - (1 - math.pow(2 * (playdate.getElapsedTime() - self.jumpStart) / 0.8 - 1, 2)) * 50
        if self.y > baseY then self:startLevel() end
    elseif self.state == states.dead then
        self.y = baseY
    else
        self.y = baseY - math.abs(math.sin(playdate.getElapsedTime() * 7)) * 5
        if playdate.buttonIsPressed(playdate.kButtonRight) then
            self.x = self.x + moveSpeed
            self.state = states.run
            self.flip = unFlipped
            if self.x >= goalX then self:winLevel() end
        elseif playdate.buttonIsPressed(playdate.kButtonLeft) then
            self.x = self.x - moveSpeed
            if self.x < 8 then self.x = 8 end
            self.state = states.run
            self.flip = flipped
        else
            self.state = states.idle
        end
    end

    self.sprite:moveTo(self.x, self.y)
end