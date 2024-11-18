require("util.table")
require("util.math")
require("util.vector")

local dimensional_builder_range = 30

local dimensional_receiver_table = nil
local dimensional_accumulator_table = nil
local ghosts_table = nil
local item_request_proxy_table = nil
local entities_with_upgrades_table = nil

local dummy = nil

rework_control.add_setup(
    "dimensional receivers",
    function()
        dimensional_receiver_table = rework_control.track_entities("dimensional receivers", "dimensional-receiver")
        dimensional_accumulator_table = rework_control.track_entities("dimensional accumulators", "dimensional-accumulator")
        ghosts_table = rework_control.track_entities("ghosts", "entity-ghost")
        item_request_proxy_table = rework_control.track_entities("request proxies", "item-request-proxy", true)
        entities_with_upgrades_table = rework_control.track_upgrades("upgrades")

        dummy = game.surfaces[1].create_entity { name = "character", position = { 0, 0 }, force = game.players[1].force }
        a = 1
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

local function play_dimensional_effect(position, surface_index)
    local lightning_position = rmath.sub_vec2(position, rmath.vec2(0, 25))
    game.surfaces[surface_index].create_entity { name = "lightning", position = lightning_position }
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

        -- local proxies = game.surfaces[1].find_entities_filtered { name = "transport-belt" }
        -- local belt=proxies[1]
        -- local position_test =  belt.position
        -- local test = game.surfaces[1].find_entities_filtered{area = rmath.bounding_box_from_position_and_size(position_test, rmath.vec2(5,5))}
        a = 1

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

            -- local testing = game.surfaces[1].find_entities_filtered { name = "item-request-proxy" }
            aa = 1
            -- if testing[1] ~= nil then
            --     -- testing[1].insert_plan = {}
            --     testing[1].insert_plan[1].items.in_inventory[1].count = 1
            --     local copy = testing[1].insert_plan
            --     copy[1].items.in_inventory[1].count = 1
            --     testing[1].insert_plan = copy
            --     b = 1
        end

        local spawns = 1

        for surface_index, entities_with_upgrades in pairs(entities_with_upgrades_table) do
            local end_index = entities_with_upgrades.end_index

            if powered_surfaces[surface_index] ~= nil and end_index ~= 0 then
                local spawn_chances = 10

                local logistic_network = game.surfaces[surface_index].find_closest_logistic_network_by_position({ 0, 0 }, "player")

                if logistic_network ~= nil then
                    for i = 1, 100 do
                        local current_index = (entities_with_upgrades.current_index or 0) % end_index

                        local entity_with_upgrade_info = entities_with_upgrades.elements[current_index]

                        if entity_with_upgrade_info ~= nil then
                            local entity_with_upgrade = entity_with_upgrade_info[1]
                            if entity_with_upgrade.valid then
                                local upgrade_target, quality = entity_with_upgrade.get_upgrade_target()
                                if upgrade_target ~= nil then
                                    local items = upgrade_target.items_to_place_this

                                    for _, _item in pairs(items) do
                                        local item = { name = _item.name, count = 1, quality = quality }

                                        -- local result = logistic_network.get_item_count(item)
                                        -- if result ~= 0 and logistic_network.remove_item(item) ~= 0 then
                                        if true then
                                            local entity_position = entity_with_upgrade.position
                                            -- local collisions, created_entity, item_request_proxy = ghost.revive { raise_revive = true }
                                            -- entity_with_upgrade.cancel_upgrade(entity_with_upgrade.force)
                                            local result = game.surfaces[surface_index].create_entity {
                                                name = upgrade_target.name,
                                                position = entity_position,
                                                quality = item.quality,
                                                force = entity_with_upgrade.force,
                                                fast_replace = true,
                                                player = game.players[1],
                                                character = dummy,
                                            }
                                            game.players[1].undo_redo_stack.remove_undo_action(1,3)
                                            game.players[1].undo_redo_stack.remove_undo_action(1,2)
                                            -- game.players[1].undo_redo_stack.remove_undo_item(2)
                                            a = 1
                                            local created_entity = true
                                            if created_entity ~= nil then
                                                play_dimensional_effect(entity_position, surface_index)
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
                                end
                            else
                                -- assert(false)
                                -- rework_control.remove_by_index(proxies, current_index)
                            end
                        end

                        entities_with_upgrades.current_index = current_index - 1
                    end
                    ::stop::
                end
            end
        end

        for surface_index, proxies in pairs(item_request_proxy_table) do
            local end_index = proxies.end_index

            if powered_surfaces[surface_index] ~= nil and end_index ~= 0 then
                local spawn_chances = 10

                local logistic_network = game.surfaces[surface_index].find_closest_logistic_network_by_position({ 0, 0 }, "player")

                if logistic_network ~= nil then
                    for i = 1, 100 do
                        local current_index = (proxies.current_index or 0) % end_index

                        local proxy_info = proxies.elements[current_index]

                        if proxy_info ~= nil then
                            local proxy = proxy_info[1]

                            if proxy.valid then
                                local entity_target = proxy.proxy_target

                                local insert_plans = proxy.insert_plan

                                for insert_plan_index, insert_plan in pairs(insert_plans) do
                                    local item = insert_plan.id

                                    local available = logistic_network.get_item_count(item)
                                    if available > 0 then
                                        local item_inventory_positions = insert_plan.items

                                        if item_inventory_positions.in_inventory ~= nil then
                                            for index, inventory_position in pairs(item_inventory_positions.in_inventory) do
                                                local inventory_index = inventory_position.inventory

                                                -- 0 indexed: https://forums.factorio.com/viewtopic.php?f=7&t=118217
                                                local stack_index = inventory_position.stack + 1

                                                local item_count = inventory_position.count or 1

                                                local item_inserted = false
                                                local item_stack_target = entity_target.get_inventory(inventory_index)[stack_index]
                                                if not item_stack_target.valid_for_read then -- empty stack
                                                    item_stack_target.set_stack(item)
                                                    item_inserted = true
                                                else -- items in the slot
                                                    if item_stack_target.name == item.name then
                                                        item_stack_target.count = item_stack_target.count + 1
                                                        item_inserted = true
                                                    end
                                                end
                                                a = 1

                                                if item_inserted then
                                                    logistic_network.remove_item(item)

                                                    if item_count == 1 then
                                                        table.remove(item_inventory_positions.in_inventory, index)
                                                        if #item_inventory_positions.in_inventory == 0 then
                                                            table.remove(insert_plans, insert_plan_index)
                                                        end
                                                    else
                                                        item_inventory_positions.in_inventory[index].count = item_count - 1
                                                    end

                                                    play_dimensional_effect(entity_target.position, surface_index)

                                                    proxy.insert_plan = insert_plans

                                                    goto stop
                                                end
                                            end
                                        end
                                    end
                                end
                            else
                                rework_control.remove_by_index(proxies, current_index)
                            end
                        end

                        proxies.current_index = current_index - 1
                    end
                    ::stop::
                end
                a = 1
            end
        end

        for surface_index, ghosts in pairs(ghosts_table) do
            local end_index = ghosts.end_index
            if powered_surfaces[surface_index] ~= nil and end_index ~= 0 then
                local spawn_chances = 10

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
                                        local collisions, created_entity, item_request_proxy = ghost.revive { raise_revive = true }
                                        if created_entity ~= nil then
                                            play_dimensional_effect(entity_position, surface_index)
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
    end)
