local function pop_random(vector)
    if vector.end_index == 1 then
        return nil
    end

    local index = math.random(1, vector.end_index - 1)

    local result = vector[index]

    if index ~= vector.end_index - 1 then
        vector[index] = vector[vector.end_index - 1]
    end

    vector.end_index = vector.end_index - 1
    vector[vector.end_index] = nil

    return result
end

local function push_back(vector, value)
    vector[vector.end_index] = value
    vector.end_index = vector.end_index + 1
end

local function pop_back(vector)
    if vector.end_index == 1 then
        return nil
    end

    vector.end_index = vector.end_index - 1

    local result = vector[vector.end_index]
    vector[vector.end_index] = nil

    return result
end

local function make()
    return { end_index = 1 }
end

local function is_empty(vector)
    return vector.end_index == 1
end

rvector = {
    pop_random = pop_random,
    push_back = push_back,
    make = make,
    pop_back = pop_back,
    is_empty = is_empty,
}
