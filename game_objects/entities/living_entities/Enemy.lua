local colors = require("colors")
local LivingEntity = require("game_objects.entities.living_entities.LivingEntity")

--- @module dollarfive.Enemy
local Enemy = setmetatable({}, LivingEntity)
Enemy.__index = Enemy
local super = LivingEntity

function Enemy.new(hp, armor, damage, speed, dimension, location, sprite)
    local self = LivingEntity.new(hp, armor, damage, speed, dimension, location, sprite)
    -- self.attributes = attributes

    self._playerLocation = nil

    -- ! Might want to refactor this
    -- ! like, just have a way of GetFactoryReference() working instead
    -- self._factory = game:passFactoryReference(self)

    return setmetatable(self, Enemy)
end

-- function Enemy:obtainPlayerLocationReference(playerLocation)
--     self._playerLocation = playerLocation
-- end

-- function Enemy:hitBy(entity)
--     -- Initial collision detection implementation for rectangles
--     local enterX = entity.location.x + entity.dimension.w >= self.location.x
--     local exitX = entity.location.x <= self.location.x + self.dimension.w

--     local enterY = entity.location.y + entity.dimension.h >= self.location.y
--     local exitY = entity.location.y <= self.location.y + self.dimension.h

--     return (enterX and exitX and enterY and exitY)
-- end

function Enemy:draw()
    love.graphics.setColor(colors.BLUE)
    super.draw(self)
end

function Enemy:update(dt)
    local deltaX = 0
    local deltaY = 0

    -- * This may be pointless/dead code apparently?
    -- if self:died() then
    --     self:markDead()
    --     return
    -- end

    if (self._playerLocation.x > self.location.x) then
        deltaX = self.speed
    elseif (self._playerLocation.x < self.location.x) then
        deltaX = self.speed * -1
    end

    if (self._playerLocation.y > self.location.y) then
        deltaY = self.speed
    elseif (self._playerLocation.y < self.location.y) then
        deltaY = self.speed * -1
    end

    super.update(self, dt, deltaX, deltaY)
end

return Enemy
