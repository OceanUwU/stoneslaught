class('Score').extends(playdate.graphics.sprite)

function Score:init(goalX, goalY)
    self.score = 0
    self.highScore = 0
    self.goalX = goalX
    self.goalY = goalY

    self:setImage(playdate.graphics.image.new(48, 32))
    self:moveTo(self.goalX, self.goalY - 40)
    self:add()
    self:updateScore(self.score)
end

function Score:updateScore(score)
    self.score = score
    if self.score > self.highScore then
        self.highScore = self.score
    end
    
    --render
    local img = playdate.graphics.image.new(self.width, self.height)
	playdate.graphics.pushContext(img)
    local font<const> = playdate.graphics.getFont()
    font:drawTextAligned(self.score + 1 .. "", self.width / 2, (self.height - font:getHeight()) / 2 + 2, kTextAlignment.center)
	playdate.graphics.popContext()
    self:setImage(img)
end