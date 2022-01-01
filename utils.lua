--- @module dollarfive.utils
local utils = {}

function utils.copy(table)
    -- Note: assumes argument passed in is a table
    --       and in particular, this only does shallow copying
    --       (only table's direct properties/key-value pairs etc.)
    --
    --  Also note that it doesn't do anything special with metatables
    --  (e.g. setting them etc.)
    newTable = {}

    -- Copy over all key-value pairs in table to newly-created newTable
    for key, value in pairs(table) do
        newTable[key] = value
    end

    return newTable
end

return utils
