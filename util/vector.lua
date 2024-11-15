local function pop_random(vector)
    if vector.end_index == 0 then
        return nil
    end

    local index = math.random(0, vector.end_index - 1)

    local result = vector.elements[index]

    if index ~= vector.end_index - 1 then
        vector.elements[index] = vector.elements[vector.end_index - 1]
    end

    vector.end_index = vector.end_index - 1
    vector.elements[vector.end_index] = nil

    return result
end

local function push_back(vector, value)
    local index = vector.end_index
    vector.elements[index] = value
    vector.end_index = index + 1

    return index
end

local function pop_back(vector)
    if vector.end_index == 0 then
        return nil
    end

    vector.end_index = vector.end_index - 1

    local result = vector.elements[vector.end_index]
    vector.elements[vector.end_index] = nil

    return result
end

local function make()
    return { end_index = 0, elements = {} }
end

local function is_empty(vector)
    return vector.end_index == 0
end

-- returns the moved element or nil if nothing was moved
local function remove(vector, index)
    vector.end_index = vector.end_index - 1

    local result = nil

    if index ~= vector.end_index then
        result = vector.elements[vector.end_index]
        vector.elements[index] = result
    end

    vector.elements[vector.end_index] = nil

    return result
end

local function filter(vector, f)
    local i = 0
    local end_index = vector.end_index
    local elements = vector.elements

    while i ~= end_index do
        local element = elements[i]

        if not f(element) then
            end_index = end_index - 1
            elements[i] = elements[end_index]
            elements[end_index] = nil
        else
            i = i + 1
        end
    end

    vector.end_index = end_index
end

rvector = {
    pop_random = pop_random,
    push_back = push_back,
    make = make,
    pop_back = pop_back,
    is_empty = is_empty,
    remove = remove,
    filter = filter,
}
