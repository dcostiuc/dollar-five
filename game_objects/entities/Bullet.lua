local Entity = require("game_objects.entities.Entity")
local colors = require("colors")

--- @module dollarfive.Bullet
local Bullet = setmetatable({}, Entity)
Bullet.__index = Bullet
local super = Entity

function Bullet.new(direction, damage, speed, dimension, location, sprite)
    local self = Entity.new(damage, speed, dimension, location, sprite)
    self.direction = direction

    return setmetatable(self, Bullet)
end

function Bullet:hitWindow()
    local hitLeftBorder = self.location.x < 0
    local hitRightBorder = self.location.x + self.dimension.w > WINDOW_WIDTH
    local hitUpperBorder = self.location.y - self.dimension.h < 0
    local hitLowerBorder = self.location.y > WINDOW_HEIGHT

    return (hitLeftBorder or hitRightBorder or hitUpperBorder or hitLowerBorder)
end

-- function Bullet:move(xAmount, yAmount)
--     self.location.x = self.location.x + xAmount
--     self.location.y = self.location.y + yAmount
-- end

function Bullet:draw()
    love.graphics.setColor(colors.LIGHT_GREY)
    super.draw(self)
end

function Bullet:update(dt)
    local deltaX = 0
    local deltaY = 0
    -- print("dt: " .. dt)

    -- In the case the bullet is out of the window's bounds
    if self:hitWindow() then
        -- mark for future deletion
        self:markDead()
        return
    end

    -- Move a bit in the direction that the bullet was launched
    -- Note: no switch statements in Lua :(
    -- ! Consider changing elseifs to ifs so that direction could be diagonal etc.
    if self.direction.N then
        deltaY = self.speed * -1
    elseif self.direction.E then
        deltaX = self.speed
    elseif self.direction.S then
        deltaY = self.speed
    elseif self.direction.W then
        deltaX = self.speed * -1
    end

    -- print("deltaX: " .. deltaX)
    -- print("deltaY: " .. deltaY)
    -- print("\n")
    -- print("deltaX + (deltaX * dt): " .. (deltaX + (deltaX * dt)))
    -- print("deltaY + (deltaY * dt): " .. (deltaY + (deltaY * dt)))

    super.update(self, dt, deltaX, deltaY)
end

return Bullet
