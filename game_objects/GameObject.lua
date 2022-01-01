-- Boilerplate for class-like code borrowed/inspired from
-- https://stackoverflow.com/questions/37106865/lua-which-way-to-do-class-table-and-instantiation
-- and http://hisham.hm/2014/01/02/how-to-write-lua-modules-in-a-post-module-world/
-- and various snippets from https://www.lua.org/pil/16.2.html and similar chapters

local AttackComponent = require("components.AttackComponent")

--- @module dollarfive.GameObject
local GameObject = {}
GameObject.__index = GameObject

-- Account = {balance = 0}

function GameObject.new(dimension, location, sprite)
    local self = {
        dimension = dimension, -- see Dimension type in types.lua
        location = location or {x = 0, y = 0}, -- see Point type in types.lua
        sprite = sprite or "placeholder.png" -- ? change to {sprite object?}
        -- UI-related etc.
        -- Sound-stuff too etc.
    }

    self.attackComponent = nil

    -- self.location.x = 5
    -- print("[GameObject.new] self.location:")
    -- print(self.location)
    -- print("[GameObject.new] self.location.x:")
    -- print(self.location.x)

    return setmetatable(self, GameObject)
end

function GameObject:draw()
    -- TODO?
end

function GameObject:update() -- with dt param?
    -- TODO?
end

function GameObject:play(soundClip)
    -- TODO?
end

function GameObject:setAttack(attackFunction)
    if self.attackComponent == nil then
        self.attackComponent = AttackComponent.new(attackFunction)
    else
        self._attackComponent = attackFunction
    end
end

return GameObject
