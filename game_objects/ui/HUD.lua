-- replace HUD, elements, func, UIComponent --
---------------------------------------------------------
local UIComponent = require("UIComponent")

----- *TODO*

--- @module dollarfive.HUD
local HUD = {}
HUD.__index = HUD

function HUD.new(elements)
    local self = UIComponent.new()
    self.elements = elements -- array of Elements

    return setmetatable(self, HUD)
end

function HUD:func()
    -- TODO
end

return HUD
