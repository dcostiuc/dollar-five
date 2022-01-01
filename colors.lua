--- @module dollarfive.colors
local colors = {}

-- For better or for worse the newest version of LOVE's API works with 0 to 1
-- rather than 0 to 255
local MAX = 255

colors.BLACK = {0, 0, 0}
colors.DARK_GREY = {0.3, 0.3, 0.3}
colors.GREY = {0.5, 0.5, 0.5}
colors.LIGHT_GREY = {0.3, 0.3, 0.3}
colors.WHITE = {1, 1, 1}

colors.RED = {1, 0, 0}
colors.GREEN = {0, 1, 0}
colors.BLUE = {0, 0, 1}

colors.YELLOW = {1, 1, 0}

colors.SHOP_LIGHT_BROWN = {215 / MAX, 169 / MAX, 169 / MAX}

colors.TEST_RED = {1, 0, 0, 0.5}
colors.TEST_YELLOW = {1, 1, 0, 0.5}
-- colors.

return colors
