-- replace Activatable, attributes, activate, Parent --
---------------------------------------------------------
local Parent = require("Parent")

----- *TODO*

--- @module dollarfive.Activatable
local Activatable = {}
Activatable.__index = Activatable

-- function Activatable.new(attributes)
--     local self = {
--         attributes = attributes
--     }

--     return setmetatable(self, Activatable)
-- end

function Activatable.new(attributes)
    local self = Parent.new()
    self.attributes = attributes

    return setmetatable(self, Activatable)
end

function Activatable:activate()
    -- TODO
end

return Activatable
