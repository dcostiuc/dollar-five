if os.getenv("LOCAL_LUA_DEBUGGER_VSCODE") == "1" then
    require("lldebugger").start()
end

-- Imports
local Player = require("game_objects.entities.living_entities.Player")
local Game = require("game.Game")

-- Constants
WINDOW_WIDTH = 0
WINDOW_HEIGHT = 0

-- Main Variables
local player

-- * Note: making this global instead
-- local game

local function main()
    WINDOW_WIDTH = love.graphics.getWidth()
    WINDOW_HEIGHT = love.graphics.getHeight()

    -- Create test player
    local STARTING_MONEY = 0
    local STARTING_INVENTORY = {}
    local STARTING_HP = 10
    local STARTING_ARMOR = 0
    local STARTING_DAMAGE = 0
    local STARTING_SPEED = 10
    local PLAYER_DIMENSION = {w = 50, h = 50}
    local PLAYER_LOCATION = {
        x = (WINDOW_WIDTH / 2) - PLAYER_DIMENSION.w,
        y = (WINDOW_HEIGHT / 2) - PLAYER_DIMENSION.h
    }
    local PLAYER_SPRITE = "placeholder.png"

    player =
        Player.new(
        STARTING_MONEY,
        STARTING_INVENTORY,
        1, -- selectedItem
        STARTING_HP,
        STARTING_ARMOR,
        STARTING_DAMAGE,
        STARTING_SPEED,
        PLAYER_DIMENSION,
        PLAYER_LOCATION,
        PLAYER_SPRITE
    )

    -- for key, value in pairs(player) do
    --     print(key)
    -- end

    -- Create actual game
    local HITRATE = 1 -- * currently not used/implemented
    local STARTING_STAGE = {
        TITLE = nil,
        SHOP = nil --[[true --* Uncomment to continue working on the Shop --]],
        LEVEL = true
    }

    game = Game.new(player, HITRATE, STARTING_STAGE, WINDOW_WIDTH, WINDOW_HEIGHT)
    game:passFactoryReference(player)
    -- game:passFactoryReference(Enemy)

    -- Start game
    game:start()
end

-- Initial setup of variables initialization/start of game
function love.load()
    main()
    -- TODO?
end

-- Any controller/logic changes
function love.update(dt)
    -- TODO
    --- Update logic for player and all other entities
    game:update(dt)
    --
    -- player:attack() --  Debugging
end

function love.keypressed(key)
    -- Special handling for player shooting, so that key repeats don't
    -- spawn a bunch of bullets at once etc.
    -- *To be potentially refactored/fixed further later
    -- Other player handling can be found within player:update(dt)
    if key == "space" then
        player:attack()
    end
end

-- All continuous graphics drawing code
function love.draw()
    -- TODO
    game:draw()
end

-- function love.run()
--     if love.load then
--         love.load(love.arg.parseGameArguments(arg), arg)
--     end

--     -- We don't want the first frame's dt to include time taken by love.load.
--     if love.timer then
--         love.timer.step()
--     end

--     local dt = 0

--     -- Main loop time.
--     return function()
--         -- Process events.
--         if love.event then
--             love.event.pump()
--             for name, a, b, c, d, e, f in love.event.poll() do
--                 if name == "quit" then
--                     if not love.quit or not love.quit() then
--                         return a or 0
--                     end
--                 end
--                 love.handlers[name](a, b, c, d, e, f)
--             end
--         end

--         -- Update dt, as we'll be passing it to update
--         if love.timer then
--             dt = love.timer.step()
--         end

--         -- Call update and draw
--         if love.update then
--             love.update(dt)
--         end -- will pass 0 if love.timer is disabled

--         if love.graphics and love.graphics.isActive() then
--             love.graphics.origin()
--             -- love.graphics.clear(love.graphics.getBackgroundColor())

--             if love.draw then
--                 love.draw()
--             end

--             love.graphics.present()
--         end

--         if love.timer then
--             love.timer.sleep(0.001)
--         end
--     end
-- end

--
--
--
--
--
--
--
--
--

--
-- function love.load()
--     image = love.graphics.newImage("cake.png")
--     num = 0
--     love.graphics.setNewFont(12)
--     -- love.graphics.setColor(0, 0, 0)
--     -- love.graphics.setBackgroundColor(255, 255, 255)
-- end

-- function love.update(dt)
--     if love.keyboard.isDown("up") then
--         num = num + 100 * dt -- this would increment num by 100 per second
--     end
-- end

-- function love.draw()
--     love.graphics.push()
--     love.graphics.scale(0.5, 0.5) -- reduce everything by 50% in both X and Y coordinates
--     love.graphics.print("Scaled text", 50, 50)
--     love.graphics.pop()
--     love.graphics.print("Normal text", 50, 50)
-- end
--
--
--
--
--
-- print(GameObject)

-- for key, value in pairs(gameobject) do
--     formatted = string.format("Key: %q \n", key)
--     io.write(formatted)
--     print(value)
-- end
