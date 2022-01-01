local GameObject = require("GameObject")

--- @module dollarfive.Shop
local Shop = setmetatable({}, GameObject)
Shop.__index = Shop

function Shop.new(dimension, location, sprite, stockSize, itemTypeCounts)
    local self = GameObject.new(location, dimension, sprite)
    self.stockSize = stockSize or 0
    self.itemTypeCounts = itemTypeCounts or {0, 0, 0}

    return setmetatable(self, Shop)
end

function Shop:generateStock()
    -- TODO
    -- Randomly fill in remaining items with any item type
    amountToFill = stockSize - sumOf(itemTypeCounts)
    -- ...
end

function Shop:sell(item)
    -- TODO?
end

function Shop:update(dt)
    -- TODO
end

function Game:draw()
    -- TODO
end

return Shop
