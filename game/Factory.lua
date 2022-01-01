local AttackComponent = require("components.AttackComponent")
local Bullet = require("game_objects.entities.Bullet")
local Coin = require("game_objects.Coin")
local Enemy = require("game_objects.entities.living_entities.Enemy")
local Item = require("game_objects.items.Item")
local utils = require("utils")

--- @module dollarfive.Factory
--- also an "EntityManager"
local Factory = {}
Factory.__index = Factory

-- Set static variables
Factory._bullets = {}
Factory._enemies = {}
Factory._coins = {}

Factory.maxEnemyCount = 0
Factory.currentEnemyCount = 0

-- function Factory.new()
--     local  = {
--         _bullets = {}
--     }

--     return setmetatable(, Factory)
-- end

-- Set static methods
local function _insert(entity, entities)
    local isInserted = false

    for idx = 1, #entities do
        if entities[idx].isDead and not isInserted then
            entities[idx] = entity
            isInserted = true
        end
    end

    if not isInserted then
        entities[#entities + 1] = entity
    end
end

function Factory.setMaxEnemyCount(enemyCap)
    Factory.maxEnemyCount = enemyCap
end

function Factory.spawnCoin(value, speed, location, playerLocation)
    print("Spawned new coin!")

    local newCoin = Coin.new(value, 0, speed, {w = 15, h = 15}, location, nil)
    newCoin:obtainPlayerLocationReference(playerLocation)

    _insert(newCoin, Factory._coins)
end

function Factory.destroyCoin(coin)
    -- Factory.currentEnemyCount = Factory.currentEnemyCount - 1
    coin:markDead()
end

function Factory.spawnBullet(direction, location)
    local newBullet = Bullet.new(direction, 1, 15, {w = 15, h = 15}, location, nil)
    _insert(newBullet, Factory._bullets)
end

function Factory.spawnBob(location, playerLocation)
    print("new Bob's location: " .. "x: " .. location.x .. " y: " .. location.y)

    local newBob = Enemy.new(3, 0, 2, 2, {w = 40, h = 40}, location, nil)
    newBob:obtainPlayerLocationReference(playerLocation)

    Factory.currentEnemyCount = Factory.currentEnemyCount + 1

    _insert(newBob, Factory._enemies)
end

function Factory.spawnPistol(location)
    --
    local newPistol = Item.new(1, {w = 35, h = 10}, location, nil)

    -- * Consider using SetAttack()?
    newPistol.attackComponent =
        AttackComponent.new(
        function()
            Factory.spawnBullet(
                utils.copy(game:getPlayerReference()._previousDirection),
                utils.copy(game:getPlayerReference().location)
            )
        end
    )

    return newPistol
end

function Factory.drawEntities(entities)
    for i, entity in ipairs(entities) do
        if not entity.isDead then
            entity:draw()
        end
    end
end

function Factory.updateEntities(dt, entities)
    -- DEBUG
    -- if entities == Factory._enemies then
    --     print(#entities)
    -- end

    for i, entity in ipairs(entities) do
        if not entity.isDead then
            entity:update(dt)
        end
    end
end

function Factory.draw()
    -- Draw everything that the Factory owns

    --      Draw Bullets
    Factory.drawEntities(Factory._bullets)

    --      Draw Enemies
    Factory.drawEntities(Factory._enemies)

    --      Draw Coins
    Factory.drawEntities(Factory._coins)
end

function Factory.update(dt)
    -- Update logic for everything that the Factory owns

    --      Update logic for all bullets
    Factory.updateEntities(dt, Factory._bullets)

    --      Update logic for all enemies
    Factory.updateEntities(dt, Factory._enemies)

    --      Update logic for all coins
    Factory.updateEntities(dt, Factory._coins)
end

return Factory
