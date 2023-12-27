class("Death").extends()

local aPrompt<const> = playdate.graphics.image.new("assets/img/aprompt")

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
    font:drawTextAligned("You got Stoneslaught!", img.width / 2, 14, kTextAlignment.center)
    font:drawTextAligned("Distance travelled:", 10, (img.height - font:getHeight()) / 2 + 2 - font:getHeight()/2 + 3, kTextAlignment.left)
    font:drawTextAligned(score .. "", img.width - 10, (img.height - font:getHeight()) / 2 + 2 - font:getHeight()/2 + 3, kTextAlignment.right)
    font:drawTextAligned("Furthest distance ever:", 10, (img.height - font:getHeight()) / 2 + 2 + font:getHeight()/2 + 3, kTextAlignment.left)
    font:drawTextAligned(highScore .. "", img.width - 10, (img.height - font:getHeight()) / 2 + 2 + font:getHeight()/2 + 3, kTextAlignment.right)
    local promptWidth = aPrompt.width + 10 + font:getTextWidth("Retry?")
    aPrompt:draw((img.width - promptWidth) / 2, img.height - aPrompt.height - 10)
    font:drawTextAligned("Retry?", (img.width + promptWidth) / 2, img.height - font:getHeight() - 10, kTextAlignment.right)
	playdate.graphics.popContext()
    self.sprite:setImage(img)
    self.moveTimer = playdate.timer.new(800, self.sprite.y, 240/2, playdate.easingFunctions.outQuad)
end

function Death:close()
    self.moveTimer = playdate.timer.new(800, self.sprite.y, -self.sprite.height/2, playdate.easingFunctions.outQuad)
end

function Death:update()
    if self.moveTimer ~= nil and self.moveTimer.value ~= self.sprite.y then
        self.sprite:moveTo(self.sprite.x, self.moveTimer.value)
    end
end