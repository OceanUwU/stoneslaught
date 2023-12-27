class("Death").extends()

function Death:init()
    self.sprite = playdate.graphics.sprite.new(playdate.graphics.image.new(1,1))
    self.sprite:moveTo(400/2, -400)
    self.sprite:add()

end

function Death:open(score, highScore)
    local img = playdate.graphics.image.new(playdate.graphics.image.new(200, 120))
	playdate.graphics.pushContext(img)
    local font<const> = playdate.graphics.getFont()
    
	playdate.graphics.popContext()
    self:setImage(img)
end

function Death:close()
    self.moveTimer = playdate.timer.new(800, self.sprite.y, -self.sprite.height/2,  playdate.easingFunctions.outQuad)
end

function Death:update()
    if self.moveTimer ~= nil and self.moveTimer.value ~= self.moveTimer.endValue then
        self.sprite:moveTo(self.sprite.x, self.moveTimer.value)
    end
end