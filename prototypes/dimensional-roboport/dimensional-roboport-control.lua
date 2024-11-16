require("util.table")
require("util.math")
require("util.vector")

local dimensional_builder_range = 30

local dimensional_receiver_table = nil
local dimensional_accumulator_table = nil
local ghosts_table = nil
local item_request_proxy_table = nil

rework_control.add_setup(
    "dimensional receivers",
    function()
        dimensional_receiver_table = rework_control.track_entities("dimensional receivers", "dimensional-receiver")
        dimensional_accumulator_table = rework_control.track_entities("dimensional accumulators", "dimensional-accumulator")
        ghosts_table = rework_control.track_entities("ghosts", "entity-ghost")
        item_request_proxy_table = rework_control.track_entities("request proxies", "item-request-proxy", true)
    end
)

local gui = nil
local gui_value = nil
local redo_count = nil
local undo_count = nil

function add_test_label(gui, name, initial_value)
    local element = gui[name]

    if element == nil then
        element = gui.add {
            type = "label",
            name = name,
            label = initial_value
        }
    end

    return element
end

function add_test_frame(gui, name)
    local element = gui[name]

    if element == nil then
        element = gui.add {
            type = "frame",
            name = name,
            direction = "vertical",
            caption = name
        }
    end

    return element
end

rework_control.on_event(
    "dimensional roboport testing",
    defines.events.on_tick,
    function(event)
        -- local player = game.players[1]
        -- if gui == nil then
        --     local screen = player.gui.screen
        --     gui = add_test_frame(screen, "test")
        --     gui_value = add_test_label(gui, "test-value", "0")
        --     redo_count = add_test_label(gui, "red_count", "0")
        --     undo_count = add_test_label(gui, "undo_count", "0")
        -- end

        -- local invalids = 0
        -- for _, ghost in pairs(ghosts_table[1].elements) do
        --     if not ghost[1].valid then
        --         invalids = invalids + 1
        --     end
        -- end

        -- gui_value.caption = "" .. ghosts_table[1].end_index .. ", " .. invalids
        -- redo_count.caption = "123"
        -- undo_count.caption = "123"

        -- redo_count.caption = "redo: " .. player.undo_redo_stack.get_redo_item_count()
        -- undo_count.caption = "undo: " .. player.undo_redo_stack.get_undo_item_count()
        -- -- local test1 = player.undo_redo_stack.get_redo_item(1)
        -- local test2 = player.undo_redo_stack.get_undo_item(1)

        local powered_surfaces = {}

        local accumulator_charged = false

        -- local proxies = game.surfaces[1].find_entities_filtered{name = "item-request-proxy"}
        a=1

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
