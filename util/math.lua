local function vec2(x, y)
    return { ["x"] = x, ["y"] = y }
end

local function add_vec2(v1, v2)
    return vec2(v1.x + v2.x, v1.y + v2.y)
end

local function sub_vec2(v1, v2)
    return vec2(v1.x - v2.x, v1.y - v2.y)
end

local function mult_vec2_scalar(v1, s)
    return vec2(v1.x * s, v1.y * s)
end

local function bounding_box_from_position_and_size(pos, size)
    local half_extent = mult_vec2_scalar(size, 0.5)
    return { left_top = sub_vec2(pos, half_extent), right_bottom = add_vec2(pos, half_extent) }
end

rmath = {
    vec2 = vec2,
    add_vec2 = add_vec2,
    sub_vec2 = sub_vec2,
    mult_vec2_scalar = mult_vec2_scalar,
    bounding_box_from_position_and_size = bounding_box_from_position_and_size
}
