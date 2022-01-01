-- replace NPC, attributes, func, LivingEntity --
---------------------------------------------------------
local LivingEntity = require("LivingEntity")

----- *TODO*

--- @module dollarfive.NPC
local NPC = {}
NPC.__index = NPC

function NPC.new(attributes)
    local self = LivingEntity.new()
    self.attributes = attributes

    return setmetatable(self, NPC)
end

function NPC:func()
    -- TODO
end

return NPC
