import "rock"

class('Sky').extends()

local startX<const> = 84
local slots<const> = 24
local slotSize<const> = 10
local endX<const> = startX + slots * slotSize
local startingRockGapTime<const> = 0.5

function Sky:init()
    self.rocks = {}
    for i = 1, slots do
        self.rocks[i] = 0
    end

    --testing spawn timer
    Sky:start()
    self.n = 0
end

function Sky:start()
    playdate.resetElapsedTime()
    self.nextSpawn = 0
end

function Sky:update()
    --logic for spawning new rocks
    local t = playdate.getElapsedTime()
    if t > self.nextSpawn then
        local availableSlots = {}
        for i = 0, slots do
            if self.rocks[i] == 0 then
                table.insert(availableSlots, i)
            end
        end
        if #availableSlots > 0 then
            local slot = availableSlots[math.random(#availableSlots)]
            self.rocks[slot] = Rock(startX + slot * slotSize)
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
    for slot, rock in pairs(self.rocks) do
        if rock ~= 0 then
            rock:update()
            if rock.done then
                self.rocks[slot] = 0
            end
        end
    end
end