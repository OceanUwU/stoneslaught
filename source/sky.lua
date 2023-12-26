import "rock"

class('Sky').extends()

function Sky:init()
    self.rocks = {}
end

function Sky:update()
    for _,v in pairs(self.rocks) do
        v:update()
    end
end