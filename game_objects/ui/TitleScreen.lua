-- replace TitleScreen, attributes, show, UIComponent --
---------------------------------------------------------
local UIComponent = require("UIComponent")

--- @module dollarfive.TitleScreen
local TitleScreen = {}
TitleScreen.__index = TitleScreen

function TitleScreen.new(attributes)
    local self = UIComponent.new()
    self.attributes = attributes

    return setmetatable(self, TitleScreen)
end

function TitleScreen:show()
    -- TODO
end

function TitleScreen:startGame()
    -- TODO
end

function TitleScreen:quit()
    -- TODO
end

return TitleScreen
