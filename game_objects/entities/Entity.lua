-- replace Entity, speed, kill, GameObject --
---------------------------------------------------------
local GameObject = require("game_objects.GameObject")

--- @module dollarfive.Entity
local Entity = setmetatable({}, GameObject)
Entity.__index = Entity

function Entity.new(damage, speed, dimension, location, sprite)
    local self = GameObject.new(dimension, location, sprite)
    self.damage = damage or 0
    self.speed = speed or 1

    self.isDead = false

    -- self.location.x = 5
    -- print("[Entity.new] self.location:")
    -- print(self.location)
    -- print("[Entity.new] self.location.x:")
    -- print(self.location.x)

    return setmetatable(self, Entity)
end

function Entity:markDead()
    self.isDead = true
end

function Entity:kill()
    -- TODO
    -- ? use this?
    self.hp = 0
end

-- function Entity:despawn()
--     -- TODO?
-- end

function Entity:obtainPlayerLocationReference(playerLocation)
    self._playerLocation = playerLocation
end

function Entity:move(xAmount, yAmount)
    self.location.x = self.location.x + xAmount
    self.location.y = self.location.y + yAmount
end

function Entity:draw()
    love.graphics.rectangle("fill", self.location.x, self.location.y, self.dimension.w, self.dimension.h)
end

function Entity:update(dt, deltaX, deltaY)
    self:move(deltaX + (deltaX * dt), deltaY + (deltaY * dt)) -- * consider removing the dt stuff
end

return Entity
