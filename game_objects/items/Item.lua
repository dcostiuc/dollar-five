-- replace Item, cost, apply, GameObject --
---------------------------------------------------------
local GameObject = require("game_objects.GameObject")

----- *TODO*

--- @module dollarfive.Item
local Item = {}
Item.__index = Item

function Item.new(cost, dimension, location, sprite)
    local self = GameObject.new(location, dimension, sprite)
    self.cost = cost
    -- self.attackComponent = nil

    return setmetatable(self, Item)
end

-- Apply any static/while-in-inventory bonuses to player
function Item:applyStaticEffect()
    -- TODO
end

-- Remove ("un-apply") any static/while-in-inventory bonuses to player
function Item:remove()
    -- TODO
end

function Item:attack()
    if self.attackComponent then
        self.attackComponent:attack()
    end
end

return Item
