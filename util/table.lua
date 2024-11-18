local function shuffle(table, end_index)
    if end_index > 2 then
        for i = 1, end_index - 2 do
            local new_i = math.random(i + 1, end_index - 1)

            local swap = table[new_i]
            table[new_i] = table[i]
            table[i] = swap
        end
    end
end

local function table_get_or_init_f(table, key, f)
    local result = table[key]
    if result ~= nil then
        return result
    else
        local value = f()
        table[key] = value
        return value
    end
end

local function table_get_or_init(table, key, value)
    local result = table[key]
    if result ~= nil then
        return result
    else
        table[key] = value
        return value
    end
end

local function table_get_or_init_table(table, key)
    local result = table[key]

    if result == nil then
        result = {}
        table[key] = result 
    end

    return result
end

rtable = rtable or {}
rtable.shuffle = shuffle
rtable.table_get_or_init = table_get_or_init
rtable.table_get_or_init_f = table_get_or_init_f
rtable.table_get_or_init_table = table_get_or_init_table
rtable.make = function() return {} end
