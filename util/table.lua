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

local function table_get_or_init(table, key, value)
    table[key] = table[key] or value
    return table[key]
end

rtable = rtable or {}
rtable.shuffle = shuffle
rtable.table_get_or_init = table_get_or_init
