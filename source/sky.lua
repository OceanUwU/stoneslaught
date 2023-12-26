import "rock"

class('Sky').extends()

local startX<const> = 40
local slots<const> = 22
local slotSize<const> = 14
local endX<const> = startX + slots * slotSize
local startingRockGapTime<const> = 0.5

function Sky:init()
    self.active = false
    self.descendingRocks = {}
    for i = 1, slots do
        self.descendingRocks[i] = 0
    end
    self.fallingRocks = {}

    --testing spawn timer
    self:start()
    self.n = 0
end

function Sky:start()
    self.active = true
    self.nextSpawn = 0
    playdate.resetElapsedTime()
end

function Sky:update()
    --logic for spawning new rocks
    local t = playdate.getElapsedTime()
    if self.active and t > self.nextSpawn then
        local availableSlots = {}
        for i = 0, slots do
            if self.descendingRocks[i] == 0 then
                table.insert(availableSlots, i)
            end
        end
        if #availableSlots > 0 then
            local slot = availableSlots[math.random(#availableSlots)]
            self.descendingRocks[slot] = Rock(startX + slot * slotSize)
        end
        local timeToNextOne = startingRockGapTime
        if t > 0 then 
            timeToNextOne = (-math.pow(t, 2) + 200 * t) / (2 * math.pow(t, 2) + 200 * t) * startingRockGapTime
        end
        if timeToNextOne > 0 then
            self.nextSpawn = self.nextSpawn + timeToNextOne
        end
        self.n = self.n + 1
        print(self.n, t)
    end

    --update rocks
    for i, rock in pairs(self.fallingRocks) do
        rock:update()
        if rock.done then
            table.remove(self.fallingRocks, i)
            rock.sprite:remove()
        end
    end
    for slot, rock in pairs(self.descendingRocks) do
        if rock ~= 0 then
            rock:update()
            if rock.falling then
                table.insert(self.fallingRocks, rock)
                self.descendingRocks[slot] = 0
            end
        end
    end
end