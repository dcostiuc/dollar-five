local Entity = require "game_objects.entities.Entity"
local colors = require "colors"

--- @module dollarfive.Coin
local Coin = setmetatable({}, Entity)
Coin.__index = Coin
local super = Entity

function Coin.new(value, damage, speed, dimension, location, sprite)
    local self = Entity.new(damage, speed, dimension, location, sprite)
    self.value = value or 0

    self._playerLocation = nil
    self._pickUpRange = 200

    return setmetatable(self, Coin)
end

function Coin:draw()
    love.graphics.setColor(colors.YELLOW)
    super.draw(self)
end

function Coin:update(dt)
    local deltaX = 0
    local deltaY = 0
    -- print("dt: " .. dt)

    -- In the case the bullet is out of the window's bounds
    -- if self:pickUp() then
    --     -- mark for future deletion
    --     self:markDead()
    --     return
    -- end

    -- If coin is within range of player, go towards player like a magnet
    if
        (self.location.x - self._pickUpRange <= self._playerLocation.x and
            self._playerLocation.x <= self.location.x + self._pickUpRange and
            self.location.y - self._pickUpRange <= self._playerLocation.y and
            self._playerLocation.y <= self.location.y + self._pickUpRange)
     then
        if (self._playerLocation.x > self.location.x) or (self._playerLocation.x < self.location.x) then
            deltaX = (self._playerLocation.x - self.location.x) * dt * self.speed
        end

        if (self._playerLocation.y > self.location.y) or (self._playerLocation.y < self.location.y) then
            deltaY = (self._playerLocation.y - self.location.y) * dt * self.speed
        end
    end
    -- print("deltaX: " .. deltaX)
    -- print("deltaY: " .. deltaY)
    -- print("\n")
    -- print("deltaX + (deltaX * dt): " .. (deltaX + (deltaX * dt)))
    -- print("deltaY + (deltaY * dt): " .. (deltaY + (deltaY * dt)))

    super.update(self, dt, deltaX, deltaY)
end

return Coin
