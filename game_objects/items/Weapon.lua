-- replace Weapon, attributes, attack, Parent --
---------------------------------------------------------
-- local Parent = require("Parent")

----- *TODO*

--- @module dollarfive.Weapon
local Weapon = {}
Weapon.__index = Weapon

-- function Weapon.new(attributes)
--     local self = {
--         attributes = attributes
--     }

--     return setmetatable(self, Weapon)
-- end

function Weapon.new(attributes)
    local self = Parent.new()
    self.attributes = attributes

    return setmetatable(self, Weapon)
end

function Weapon:attack()
    -- TODO?
end

return Weapon
