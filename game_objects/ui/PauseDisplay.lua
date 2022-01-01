-- replace PauseDisplay, playerItems, func, Parent --
---------------------------------------------------------
-- local Parent = require("Parent")

----- *TODO*

--- @module dollarfive.PauseDisplay
local PauseDisplay = {}
PauseDisplay.__index = PauseDisplay

-- function PauseDisplay.new(playerItems)
--     local self = {
--         playerItems = playerItems
--     }

--     return setmetatable(self, PauseDisplay)
-- end

function PauseDisplay.new(playerItems)
    local self = Parent.new()
    self.playerItems = playerItems

    return setmetatable(self, PauseDisplay)
end

function PauseDisplay:func()
    -- TODO
end

return PauseDisplay
