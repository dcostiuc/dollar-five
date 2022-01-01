-- replace Display, text, func, UIComponent --
---------------------------------------------------------
local UIComponent = require("UIComponent")

----- *TODO*

--- @module dollarfive.Display
local Display = {}
Display.__index = Display

function Display.new(text, image)
    local self = UIComponent.new()
    self.text = text
    self.image = image

    return setmetatable(self, Display)
end

function Display:func()
    -- TODO
end

return Display
