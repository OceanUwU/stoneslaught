class("Title").extends()

function Title:init()
    self.sprite = playdate.graphics.sprite.new(playdate.graphics.image.new("assets/img/title"))
    self.sprite:moveTo(400/2, 240/2)
    self.sprite:add()
    self.done = false
end

function Title:update()
    if self.done then return end
    if self.scrollTimer == nil then
        if playdate.buttonIsPressed(playdate.kButtonA) then
            self.scrollTimer = playdate.timer.new(1500, self.sprite.y, -240/2,  playdate.easingFunctions.outQuad)
            startNewGame()
        end
    else
        self.sprite:moveTo(self.sprite.x, self.scrollTimer.value)
        if self.scrollTimer.value <= self.scrollTimer.endValue then
            self.sprite:remove()
            self.done = true
        end
    end
end