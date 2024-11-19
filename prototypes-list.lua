local prototypes_names = {
    "dimensional-roboport",
    "remote-charge",
    "explosive-shotgun-shells",
    "shotgun-spidertron",
    "cargo-pod-requires-landing-pad",
}

local function do_part(name, part)
    local full_name = "prototypes." .. name .. "." .. name .. "-" .. part
    local status, module = pcall(require, full_name)
    if status then
        assert(module)
        return module
    else
        local not_found_string = "module " .. full_name .. " not found;"
        local match_result = module:find(not_found_string, 1, true)
        if match_result == nil then
            assert(false, module)
        end

        return nil
    end
end

local function do_all_part(part)
    result = {}
    for _, name in pairs(prototypes_names) do
        local module = do_part(name, part)
        if module ~= nil then
            result[name] = module
        end
    end
    return result
end

return {
    do_data = function() return do_all_part("data") end,
    do_data_updates = function() return do_all_part("data-updates") end,
    do_data_final_fixes = function() return do_all_part("data-final-fixes") end,
    do_control = function() return do_all_part("control") end,
}
