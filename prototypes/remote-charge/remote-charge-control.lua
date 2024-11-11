require("util.math")

local detonation_list = {}
local detonation_index = 1
local detonation_list_end = 0

local detonation_time_interval_milliseconds = { min = 30, max = 120 }
local detonation_timer = 0
local get_detonation_trigger = function()
    return math.random(detonation_time_interval_milliseconds.min,
        detonation_time_interval_milliseconds.max)
end
local detonation_trigger = 300

script.on_event(defines.events.on_player_used_capsule, function(event)
    local player = game.players[event.player_index]
    if player == nil then return end

    local surface = player.surface
    if surface == nil then return end

    local area = {}
    local entities = surface.find_entities_filtered {
        area = rmath.bounding_box_from_position_and_size(
            event.position,
            rmath.vec2(200, 200)
        ),
        name = "remote-charge"
    }

    total = 0
    detonation_list = {}
    detonation_index = 1
    detonation_list_end = 1
    for _, remote_charge in pairs(entities) do
        detonation_list[detonation_list_end] = remote_charge
        detonation_list_end = detonation_list_end + 1
        detonation_trigger = get_detonation_trigger()
        detonation_timer = 0
    end

    table.sort(detonation_list, function(left, right) return left.unit_number < right.unit_number end)

    -- if detonation_list_end > 2 then
    --     for i = 1, detonation_list_end - 2 do
    --         local new_i = math.random(i + 1, detonation_list_end - 1)

    --         local swap = detonation_list[new_i]
    --         detonation_list[new_i] = detonation_list[i]
    --         detonation_list[i] = swap
    --     end
    -- end
end)

script.on_event(defines.events.on_tick, function(event)
    if detonation_list_end ~= detonation_index then
        detonation_timer = detonation_timer + 16.6666
        if detonation_timer > detonation_trigger then
            detonation_timer = detonation_timer - detonation_trigger
            detonation_trigger = get_detonation_trigger()

            local try_detonate = function(index)
                if index == detonation_list_end then
                    return false
                end

                local remote_charge = detonation_list[index]

                if not remote_charge.valid then
                    return false
                end

                remote_charge.surface.create_entity {
                    name = "remote-charge-explosion-dummy-capsule",
                    position = remote_charge.position,
                    force = "neutral",
                    target = remote_charge
                }
                remote_charge.destroy()

                return true
            end

            for i = detonation_index, detonation_list_end do
                if try_detonate(i) then
                    detonation_index = i
                    return
                end
            end

            if detonation_index == detonation_list_end then
                detonation_list = {}
                detonation_index = 1
                detonation_list_end = 1
            end
        end
    end
end)

script.on_event(defines.events.on_entity_damaged, function(event)
    a = 1
end)
