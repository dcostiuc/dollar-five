--- @module dollarfive.AttackComponent
local AttackComponent = {}
AttackComponent.__index = AttackComponent

function AttackComponent.new(attackFunction)
    local self = {}

    self._attackFunction = attackFunction

    return setmetatable(self, AttackComponent)
end

function AttackComponent:attack()
    self._attackFunction()
end

return AttackComponent
