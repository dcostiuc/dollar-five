-- replace LivingEntity, hp, takeDamage, Entity --
---------------------------------------------------------
local Entity = require("game_objects.entities.Entity")

--- @module dollarfive.LivingEntity
local LivingEntity = setmetatable({}, Entity)
LivingEntity.__index = LivingEntity

function LivingEntity.new(hp, armor, damage, speed, dimension, location, sprite)
    local self = Entity.new(damage, speed, dimension, location, sprite)
    self.hp = hp or 1
    self.armor = armor or 0

    -- print("self.location.x:")
    -- print(self.location.x)

    return setmetatable(self, LivingEntity)
end

function LivingEntity:died()
    return self.hp == 0
end

function LivingEntity:attack(livingEntity, amount)
    livingEntity:takeDamage(amount or livingEntity.damage)
end

function LivingEntity:takeDamage(amount)
    print("[LivingEntity:takeDamage] amount = " .. amount)
    self.hp = self.hp - amount
end

function LivingEntity:heal(amount)
    self.hp = self.hp + amount
end

function LivingEntity:hitBy(entity)
    -- Initial collision detection implementation for rectangles
    local enterX = entity.location.x + entity.dimension.w >= self.location.x
    local exitX = entity.location.x <= self.location.x + self.dimension.w

    local enterY = entity.location.y + entity.dimension.h >= self.location.y
    local exitY = entity.location.y <= self.location.y + self.dimension.h

    return (enterX and exitX and enterY and exitY)
end

return LivingEntity
