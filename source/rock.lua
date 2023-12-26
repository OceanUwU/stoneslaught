class('Rock').extends()

local img<const> = playdate.graphics.image.new("assets/img/rock")
local sinkTime = 0.8 * 1000

function Rock:init(x)
    self.done = false
    self.x = x
    self.falling = false

    self.sprite = playdate.graphics.sprite.new(img)
    self.sprite:setImage(img, math.random(0, 3))
    self.sprite:add()
    self.y = -self.sprite.height/2
    self.sinkTimer = playdate.timer.new(sinkTime, self.y, self.y + self.sprite.height)
end

function Rock:update()
    if self.falling then
        self.y = self.y + 4
        if self.y >= 240 + self.sprite.height / 2 then
            self.done = true
        end
    else
        self.y = self.sinkTimer.value
        if self.y >= self.sinkTimer.endValue then
            self.falling = true
        end
    end
    self.sprite:moveTo(self.x, self.y)
end