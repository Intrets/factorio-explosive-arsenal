require("util.table")
require("util.math")
require("util.vector")

local dimensional_builder_range = 30

local dimensional_receiver_table = nil
local dimensional_accumulator_table = nil
local ghosts_table = nil

rework_control.add_setup(
    "dimensional receivers",
    function()
        dimensional_receiver_table = rework_control.track_entities("dimensional receivers", "dimensional-receiver")
        dimensional_accumulator_table = rework_control.track_entities("dimensional accumulators", "dimensional-accumulator")
        ghosts_table = rework_control.track_entities("ghosts", "entity-ghost")
    end
)

local gui = nil
local gui_value = nil

rework_control.on_event(
    "dimensional roboport testing",
    defines.events.on_tick,
    function(event)
        -- local player = game.players[1]
        -- if gui == nil then
        --     if player.gui.screen["test"] ~= nil then
        --         gui = player.gui.screen["test"]
        --         gui_value = gui["test-value"]
        --     else
        --         gui = player.gui.screen.add {
        --             type = "frame",
        --             name = "test",
        --             direction = "vertical",
        --             caption = "hello",
        --         }
        --         gui_value = gui.add {
        --             type = "label",
        --             name = "test-value",
        --             caption = "0",
        --         }
        --     end
        -- end

        -- local invalids = 0
        -- for _, ghost in pairs(ghosts_table[1].elements) do
        --     if not ghost[1].valid then
        --         invalids = invalids + 1
        --     end
        -- end

        -- gui_value.caption = "" .. ghosts_table[1].end_index .. ", " .. invalids

        local powered_surfaces = {}

        local accumulator_charged = false

        local process_dimensional_accumulator = function(accumulator_info)
            local accumulator = accumulator_info[1]
            if accumulator.valid then
                if accumulator.energy >= 5000000000 then
                    accumulator_charged = true
                end
                accumulator_charged = true

                accumulator.energy = 0
                return true
            else
                return false
            end
        end

        for surface_index, accumulators in pairs(dimensional_accumulator_table) do
            rvector.filter(accumulators, process_dimensional_accumulator)
        end


        if accumulator_charged then
            local process_dimensional_receiver = function(receiver_info)
                local receiver = receiver_info[1]
                if receiver.valid then
                    if receiver.energy >= receiver.power_usage then
                        powered_surfaces[receiver.surface_index] = true
                    end
                    return true
                else
                    return false
                end
            end

            for surface_index, receivers in pairs(dimensional_receiver_table) do
                rvector.filter(receivers, process_dimensional_receiver)
            end

            for surface_index, ghosts in pairs(ghosts_table) do
                local end_index = ghosts.end_index
                if powered_surfaces[surface_index] ~= nil and end_index ~= 0 then
                    local spawn_chances = 10
                    local spawns = 1

                    local logistic_network = game.surfaces[surface_index].find_closest_logistic_network_by_position({ 0, 0 }, "player")

                    if logistic_network ~= nil then
                        for i = 1, 100 do
                            local current_index = (ghosts.current_index or 0) % end_index

                            local ghost_info = ghosts.elements[current_index]

                            if ghost_info ~= nil then
                                local ghost = ghost_info[1]


                                if ghost.valid then
                                    local items = ghost.ghost_prototype.items_to_place_this

                                    for _, _item in pairs(items) do
                                        local item = { name = _item.name, count = 1, quality = ghost.quality }

                                        local result = logistic_network.get_item_count(item)
                                        if result ~= 0 and logistic_network.remove_item(item) ~= 0 then
                                            local entity_position = ghost.position
                                            local lightning_position = rmath.sub_vec2(entity_position, rmath.vec2(0, 25))
                                            local collisions, created_entity, item_request_proxy = ghost.revive { raise_revive = true }
                                            if created_entity ~= nil then
                                                game.surfaces[surface_index].create_entity { name = "lightning", position = lightning_position }
                                                rework_control.remove_by_index(ghosts, current_index)
                                                spawns = spawns - 1
                                                if spawns == 0 then
                                                    goto stop
                                                end
                                            end

                                            spawn_chances = spawn_chances - 1
                                            if spawn_chances == 0 then
                                                goto stop
                                            end

                                            break
                                        end
                                    end

                                    spawn_chances = spawn_chances - 1
                                    if spawn_chances == 0 then
                                        goto stop
                                    end

                                    ghosts.current_index = current_index - 1
                                else
                                    rework_control.remove_by_index(ghosts, current_index)
                                end
                            end

                            ghosts.current_index = current_index - 1
                        end
                        ::stop::
                    end
                end
            end
        end
    end
)
