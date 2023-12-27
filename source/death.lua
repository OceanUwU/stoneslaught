class("Death").extends()

function Death:init()
    self.sprite = playdate.graphics.sprite.new(playdate.graphics.image.new(1,1))
    self.sprite:moveTo(400/2, -240/2)
    self.sprite:setZIndex(1)
    self.sprite:add()
end

function Death:open(score, highScore)
    local img = playdate.graphics.image.new(280, 120)
	playdate.graphics.pushContext(img)
    playdate.graphics.setColor(playdate.graphics.kColorBlack)
    playdate.graphics.fillRect(0, 0, img.width, img.height)
    playdate.graphics.setColor(playdate.graphics.kColorWhite)
    playdate.graphics.fillRect(1, 1, img.width-1*2, img.height-1*2)
    playdate.graphics.setColor(playdate.graphics.kColorBlack)
    playdate.graphics.fillRect(3, 3, img.width-3*2, img.height-3*2)
    playdate.graphics.setColor(playdate.graphics.kColorWhite)
    playdate.graphics.fillRect(5, 5, img.width-5*2, img.height-5*2)
    local font<const> = playdate.graphics.getFont()
    font:drawTextAligned("You got stoneslaught!", img.width / 2, 14, kTextAlignment.center)
    font:drawTextAligned("Distance travelled:", 10, (img.height - font:getHeight()) / 2 + 2 - font:getHeight()/2 + 3, kTextAlignment.left)
    font:drawTextAligned(score .. "", img.width - 10, (img.height - font:getHeight()) / 2 + 2 - font:getHeight()/2 + 3, kTextAlignment.right)
    font:drawTextAligned("Furthest distance ever:", 10, (img.height - font:getHeight()) / 2 + 2 + font:getHeight()/2 + 3, kTextAlignment.left)
    font:drawTextAligned(highScore .. "", img.width - 10, (img.height - font:getHeight()) / 2 + 2 + font:getHeight()/2 + 3, kTextAlignment.right)
	playdate.graphics.popContext()
    self.sprite:setImage(img)
    self.moveTimer = playdate.timer.new(800, self.sprite.y, 240/2, playdate.easingFunctions.outQuad)
end

function Death:close()
    self.moveTimer = playdate.timer.new(800, self.sprite.y, -self.sprite.height/2, playdate.easingFunctions.outQuad)
end

function Death:update()
    if self.moveTimer ~= nil and self.moveTimer.value ~= self.moveTimer.endValue then
        self.sprite:moveTo(self.sprite.x, self.moveTimer.value)
    end
end