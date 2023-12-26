class('Rock').extends()

local img<const> = playdate.graphics.image.new("assets/img/rock")
local sinkTime = 0.8 * 1000

function Rock:init(x)
    self.done = false
    self.x = x
    self.falling = false
    self.fallVel = 2

    self.sprite = playdate.graphics.sprite.new(img)
    self.sprite:setImage(img, math.random(0, 3))
    self.sprite:setCollideRect(1, 1, self.sprite.width - 2, self.sprite.height - 2)
    self.sprite:add()
    self.y = -self.sprite.height/2
    self.sinkTimer = playdate.timer.new(sinkTime, self.y, self.y + self.sprite.height)
    self.fallSound = playdate.sound.sampleplayer.new("assets/audio/rock" .. math.random(1,5))
end

function Rock:update()
    if self.falling then
        self.y = self.y + math.floor(self.fallVel)
        self.fallVel = self.fallVel + 0.2
        if self.y >= 240 + self.sprite.height / 2 then
            self.done = true
            self.fallSound:play()
        end
    else
        self.y = self.sinkTimer.value
        if self.y >= self.sinkTimer.endValue then
            self.falling = true
        end
    end
    self.sprite:moveTo(self.x, self.y)
end