-- replace UIComponent, attributes, draw, GameObject --
---------------------------------------------------------

----- *TODO*

local GameObject = require("GameObject")

--- @module dollarfive.UIComponent
local UIComponent = {}
UIComponent.__index = UIComponent

function UIComponent.new(attributes)
    local self = GameObject.new()
    self.attributes = attributes

    return setmetatable(self, UIComponent)
end

function UIComponent:draw()
    -- TODO
end

return UIComponent
