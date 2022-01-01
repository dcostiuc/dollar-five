local Factory = require("game.Factory")
local Level = require("game.Level")
local colors = require("colors")
local utils = require("utils")

--- @module dollarfive.Game
local Game = {}
Game.__index = Game

function Game.new(player, hitRate, currentStage, windowWidth, windowHeight)
    local self = {
        _player = player, -- ? sensible default value
        hitRate = hitRate, -- ? sensible default value?
        currentStage = currentStage or {TITLE = true},
        windowWidth = windowWidth,
        windowHeight = windowHeight,
        stage = nil,
        --
        -- Internal/super-private variables that should definitely NOT be accessed
        -- outside of Game
        _gameState = {IS_RUNNING = false},
        _factory = Factory -- In this case we use the class itself and static methods/attributes
    }

    self._factory.setMaxEnemyCount(3)
    self._timer = 0

    return setmetatable(self, Game)
end

function Game:checkPlayer()
    if self._player.isDead then
        --self:pause()
        love.timer.sleep(1)
        self.currentStage = {SHOP = true}
    end
end

function Game:spawnEnemies()
    if (self._factory.currentEnemyCount < self._factory.maxEnemyCount) then
        self._factory.spawnBob(
            {x = love.math.random(0, self.windowWidth), y = love.math.random(0, self.windowHeight)},
            self._player.location
        )
    end
end

function Game:testCollisions()
    for i, enemy in ipairs(self._factory._enemies) do
        -- Check if any bullets have hit the current enemy
        for j, bullet in ipairs(self._factory._bullets) do
            if not enemy.isDead then
                if not bullet.isDead and enemy:hitBy(bullet) then
                    enemy:takeDamage(bullet.damage)
                    bullet:markDead()

                    if enemy:died() then
                        self._factory.currentEnemyCount = self._factory.currentEnemyCount - 1
                        enemy:markDead()
                        self._factory.spawnCoin(1, 3, utils.copy(enemy.location), self._player.location)
                    end
                end
            end
        end

        -- Check if current enemy has hit the player with their body
        if not enemy.isDead and self._player:hitBy(enemy) then
            if math.floor(self._timer) % 2 == 0 then --! will prob need to play around with this
                enemy:attack(self._player, enemy.damage)
                self._timer = self._timer + 1
            end
        end
    end

    for i, coin in ipairs(self._factory._coins) do
        -- Check if any coins have touched the player (or vice-versa)
        if not coin.isDead and self._player:hitBy(coin) then
            self._player:pickUpCoin(coin)
            self._factory.destroyCoin(coin)
        end
    end
end

function Game:start()
    self._gameState.IS_RUNNING = true

    --* Equip the player with a basic pistol weapon, for now
    self._player:addToInventory(self._factory.spawnPistol(nil))

    if (self.currentStage.TITLE) then
        -- Any initialization for Title Screen
        -- TODO
    elseif (self.currentStage.SHOP) then
        -- Any initialization for Shop
        self.stage = Level.new(colors.SHOP_LIGHT_BROWN, {w = self.windowWidth, h = self.windowHeight})
    elseif (self.currentStage.LEVEL) then
        -- Any initialization for Level
        self.stage = Level.new(colors.BLACK, {w = self.windowWidth, h = self.windowHeight})
    end

    --self:draw()
end

function Game:pause()
    self._gameState.IS_RUNNING = false
end

function Game:transition(nextStage)
    -- TODO
end

function Game:draw()
    -- if self._gameState.IS_RUNNING then
    -- Depending on currentStage: draw background, player etc.
    if (self.currentStage.TITLE) then
        -- Draw Title Screen
        -- TODO
    elseif (self.currentStage.SHOP) then
        -- TODO

        -- Draw Shop
        --      Draw Background
        self.stage:drawBackground()

        --      Draw Player
        self._player:draw()
    elseif (self.currentStage.LEVEL) then
        -- Draw Level
        --      Draw Background
        self.stage:drawBackground()

        --      Draw Player
        self._player:draw()

        --      Draw other stuff "owned" by factory
        self._factory.draw()
    end
    -- else
    -- Game is Paused
    -- Draw related pause screen or freeze current frame etc.
    -- TODO
    -- end
end

function Game:update(dt)
    self._timer = self._timer + dt -- Update internal timer

    -- Resetting this after a really big number just in case
    if self._timer > 20000000 then
        self._timer = 0 -- * might want to consider also having like a "timePassed" or something
    end

    if self._gameState.IS_RUNNING then
        -- Depending on currentStage: update player, factory's entities etc.
        if (self.currentStage.TITLE) then
            -- Draw Title Screen
            -- TODO
        elseif (self.currentStage.SHOP) then
            -- Draw Shop
            -- TODO

            --      Update logic for player
            --      (i.e. movement and shooting)
            self._player:update(dt)
        elseif (self.currentStage.LEVEL) then
            -- Update logic in Level
            -- --      Update Background??
            -- self.stage:drawBackground()

            --      Check if player is still alive
            self:checkPlayer()

            -- print("Current FPS: " .. tostring(love.timer.getFPS()))

            -- print("self._timer: " .. self._timer)
            -- print("math.floor(self._timer): " .. math.floor(self._timer))

            --      Possibly spawn enemies if more are needed
            if math.ceil(self._timer) % 3 == 0 then
                self:spawnEnemies()
                self._timer = self._timer + 1
            end

            --      Update logic for player
            --      (i.e. movement and shooting)
            self._player:update(dt)

            --      Update other stuff "owned" by factory
            self._factory.update(dt)

            --      Interaction logic between bullets and enemies and players
            -- *think of a better way to do this (rn it's O(nm))
            self:testCollisions()
        end
    else
        -- Game is Paused
        -- Don't do any any logic updates to keep game frozen
        -- TODO
    end
end

function Game:enterArenaDoor()
    -- TODO
    -- Start the actual "game" by transitioning to Level state
    love.timer.sleep(1)
    self.currentStage = {LEVEL = true}
end

-- ! Eventually get rid of this and patch up the appropriate code places
function Game:passFactoryReference(player)
    player._factory = self._factory
end

function Game:getFactoryReference()
    return self._factory
end

function Game:getPlayerReference()
    return self._player
end

return Game
