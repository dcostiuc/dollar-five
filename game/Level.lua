local GameObject = require("game_objects.GameObject")
local colors = require("colors")

----- *TODO*

--- @module dollarfive.Level
local Level = {}
Level.__index = Level

function Level.new(backgroundColour, dimension, location, sprite)
    local self = GameObject.new(dimension, location, sprite)
    self.backgroundColour = backgroundColour

    return setmetatable(self, Level)
end

function Level:drawBackground()
    love.graphics.setColor(self.backgroundColour)
    love.graphics.rectangle("fill", 0, 0, self.dimension.w, self.dimension.h)
end

return Level
