local colors = require("colors")
local utils = require("utils")

local LivingEntity = require("game_objects.entities.living_entities.LivingEntity")

--- @module dollarfive.Player
local Player = setmetatable({}, LivingEntity)
Player.__index = Player

function Player.new(money, inventory, selectedItem, hp, armor, damage, speed, dimension, location, sprite)
    local self = LivingEntity.new(hp, armor, damage, speed, dimension, location, sprite)
    self.money = money or 0
    self.inventory = inventory or {}
    self._selectedItem = selectedItem or nil
    self._selectedItemIndex = 0

    --
    -- Internal/super-private variables that should definitely NOT be accessed
    -- outside of Game
    self._direction = {N = false, E = false, S = false, W = false}
    self._previousDirection = {N = false, E = true, S = false, W = false} -- let East be default direction for shooting
    self._isAttacking = false
    self._factory = nil -- ! eventually get rid of this approach
    self._selectedItem = nil

    -- print("self.location.x:")
    -- print(self.location.x)

    return setmetatable(self, Player)
end

function Player:_resetDirection(directions)
    -- print("Resetting direction...")
    for direction, value in pairs(directions) do
        -- print("Previous Direction Value: " .. tostring(self._direction[direction]))
        directions[direction] = false
    end
end

function Player:_setDirection(directions, directionToSet)
    for direction, value in pairs(directions) do
        if direction == directionToSet then
            directions[direction] = true
        else
            directions[direction] = false
        end
    end
end

function Player:activateItem(selectedItem)
    -- TODO
end

function Player:pickUpCoin(coin)
    self.money = self.money + coin.value
end

function Player:draw()
    -- print("\nPlayer:draw(): \n")
    -- for k, v in pairs(Player) do
    --     print(k)
    -- end

    love.graphics.setColor(colors.TEST_RED)
    love.graphics.rectangle("fill", self.location.x, self.location.y, self.dimension.w, self.dimension.h)
end

-- function Player:move(xAmount, yAmount)
--     self.location.x = self.location.x + xAmount
--     self.location.y = self.location.y + yAmount
-- end

function Player:attack()
    -- TODO
    -- self._isAttacking = true

    -- For a basic weapon (e.g. Pistol)
    -- Just shoot a bullet in the direction the player is facing
    -- print("player's _direction \n ")
    -- print("self._direction.N: " .. tostring(self._direction.N))
    -- print("self._direction.E: " .. tostring(self._direction.E))
    -- print("self._direction.S: " .. tostring(self._direction.S))
    -- print("self._direction.W: " .. tostring(self._direction.W))

    -- ! changed _direction to _previousDirection
    self._selectedItem:attack()
    -- self._factory.spawnBullet(utils.copy(self._previousDirection), utils.copy(self.location))
end

function Player:update(dt)
    self:_resetDirection(self._direction)
    local deltaX = 0
    local deltaY = 0

    if self:died() then
        self:markDead()
    end

    -- print("player's _direction (after reset) \n ")
    -- print("self._direction.N: " .. tostring(self._direction.N))
    -- print("self._direction.E: " .. tostring(self._direction.E))
    -- print("self._direction.S: " .. tostring(self._direction.S))
    -- print("self._direction.W: " .. tostring(self._direction.W))

    -- Handle keyboard input for WASD/Arrow Key Movement and Shooting
    if love.keyboard.isDown("left", "a") then
        deltaX = self.speed * -1
        self._direction.W = true

        -- * Could probably do this better
        self:_setDirection(self._previousDirection, "W")
    end
    -- elseif love.keyboard.isDown("right", "d") then
    --     deltaX = self.speed
    --     self._direction.E = true

    --     -- * Could probably do this better
    --     self:_setDirection(self._previousDirection, "E")
    -- elseif love.keyboard.isDown("up", "w") then
    --     deltaY = self.speed * -1
    --     self._direction.N = true

    --     -- * Could probably do this better
    --     self:_setDirection(self._previousDirection, "N")
    -- elseif love.keyboard.isDown("down", "s") then
    --     deltaY = self.speed
    --     self._direction.S = true

    --     -- * Could probably do this better
    --     self:_setDirection(self._previousDirection, "S")
    -- end

    if love.keyboard.isDown("right", "d") then
        deltaX = self.speed
        self._direction.E = true

        -- * Could probably do this better
        self:_setDirection(self._previousDirection, "E")
    end

    if love.keyboard.isDown("up", "w") then
        deltaY = self.speed * -1
        self._direction.N = true

        -- * Could probably do this better
        self:_setDirection(self._previousDirection, "N")
    end
    -- elseif love.keyboard.isDown("down", "s") then
    --     deltaY = self.speed
    --     self._direction.S = true

    --     -- * Could probably do this better
    --     self:_setDirection(self._previousDirection, "S")
    -- end

    if love.keyboard.isDown("down", "s") then
        deltaY = self.speed
        self._direction.S = true

        -- * Could probably do this better
        self:_setDirection(self._previousDirection, "S")
    end

    -- if love.keyboard.isDown("space") then
    --     self:attack()
    -- end

    -- Make any diagonal movement slightly slower, since otherwise
    -- it appears to be slightly faster
    if
        (love.keyboard.isDown("down", "s") or love.keyboard.isDown("up", "w")) and
            (love.keyboard.isDown("left", "a") or love.keyboard.isDown("right", "d"))
     then
        deltaX = deltaX * 0.75
        deltaY = deltaY * 0.75
    end

    -- Handle any specific switches to an item in the player's inventory
    for i = 1, 9 do
        if love.keyboard.isDown(tostring(i)) then
            self._selectedItemIndex = 1
        end
    end

    -- Update what the reference is to the selected item, in case it changed
    self._selectedItem = self.inventory[self._selectedItemIndex]

    -- print("player's _direction (after handling) \n ")
    -- print("self._direction.N: " .. tostring(self._direction.N))
    -- print("self._direction.E: " .. tostring(self._direction.E))
    -- print("self._direction.S: " .. tostring(self._direction.S))
    -- print("self._direction.W: " .. tostring(self._direction.W))

    -- Move the player
    self:move(deltaX + (deltaX * dt), deltaY + (deltaY * dt))
end

function Player:addToInventory(item)
    table.insert(self.inventory, item)

    if self._selectedItemIndex == 0 and self._selectedItem == nil then
        self._selectedItemIndex = self._selectedItemIndex + 1
    -- self._selectedItem = self.inventory[self._selectedItemIndex]
    end
end

function Player:removeFromInventory(item)
    -- * TODO
    -- table.insert(self.inventory, item)
    -- if self._selectedItemIndex == 0 and self._selectedItem == nil then
    --     self._selectedItemIndex = self._selectedItemIndex + 1
    --     self._selectedItem = self.inventory[self._selectedItemIndex]
    -- end
end

return Player
