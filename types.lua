


-- Note: turns out you really need to work around a lot of things in Lua, since constructs such as typedef or struct or enum isn't part of the language :(



-- Point = {
--     x = int or float,
--     y = int or float
-- }
--
--
-- Dimension = {
--     w = int or float,
--     h = int or float
-- }
--
--
-- ItemTypeCount = { -- int >= 0
--     general = int,
--     weapon = int,
--     special = int
-- }
--
--
--
-- Stage = {
--     -- boolean is only true
--     -- One of
--     TITLE = nil or boolean,
--     SHOP = nil or boolean,
--     LEVEL = nil or boolean
-- }
--
--
-- GameState = {
--     IS_RUNNING = boolean
-- }
--
--
-- Color = {
--     -- 0 <= int <= 1
--     r = int,
--     g = int,
--     b = int,
--     a = int -- (optional)
-- }
--
--
-- Direction = {
--     -- At least 1 is true,
--     -- At most 2 are true
--     N = boolean,
--     E = boolean,
--     S = boolean,
--     W = boolean
-- }
