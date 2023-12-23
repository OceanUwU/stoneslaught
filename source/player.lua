class('Player').extends()

local states<const> = {idle = 1, run = 2, jumping = 3, dead = 4}
local animFrameTime<const> = 40
local unFlipped<const> = playdate.graphics.kImageUnflipped
local flipped<const> = playdate.graphics.kImageFlippedX
local baseY<const> = 240 - 12
local moveSpeed<const> = 6

function Player:init()
    self.flip = unFlipped
    self:startLevel()

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
    self.sprite:moveTo(200, 120)
    self.sprite:add()
    self.sprite.update = function() self.sprite:setImage(self.anims[self.state]:image(), self.flip) end
end

function Player:startLevel()
    self.state = states.idle
    self.x = 20
end

function Player:update()
    local left = playdate.buttonIsPressed(playdate.kButtonLeft)
    local right = playdate.buttonIsPressed(playdate.kButtonRight)
    if (right and not left) then
        self.x = self.x + moveSpeed
        self.state = states.run
        self.flip = unFlipped
    elseif (left and not right) then
        self.x = self.x - moveSpeed
        self.state = states.run
        self.flip = flipped
    else
        self.state = states.idle
    end

    self.y = baseY - math.abs(math.sin(playdate.getElapsedTime() * 7)) * 5

    self.sprite:moveTo(self.x, self.y)
end