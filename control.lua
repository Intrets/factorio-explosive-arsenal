require("util.table")
require("util.vector")
require("util")

function do_unlocks2(unlocks_map, technologies, technology)
    technology.researched = true

    for index, pre in pairs(technology.prerequisites) do
        pre_name = pre.name
        if unlocks_map[pre_name] == nil then
            unlocks_map[pre_name] = technology.name
            t = technologies[pre_name]
            do_unlocks2(unlocks_map, technologies, t)
        end
    end
end

function do_unlocks(player)
    local technologies = player.force.technologies
    local unlocks_map = {}

    for name, t in pairs(technologies) do
        count = 0

        for index, ingredient in pairs(t.research_unit_ingredients) do
            if ingredient.name == "automation-science-pack" then
                count = count + 1
            elseif ingredient.name == "logistic-science-pack" then
                count = count + 1
            else
                a = 1
                goto continue
            end
        end

        if count == 1 or count == 2 then
            do_unlocks2(unlocks_map, technologies, t)
        end
        ::continue::
    end
end

function add_starter_items(player)
    player.insert { name = "assembling-machine-1", count = 10 }
    player.insert { name = "assembling-machine-2", count = 10 }
    player.insert { name = "assembling-machine-3", count = 10 }
    player.insert { name = "inserter", count = 10 }
    player.insert { name = "boiler", count = 10 }
    player.insert { name = "steam-engine", count = 10 }
    player.insert { name = "medium-electric-pole", count = 10 }
    player.insert { name = "transport-belt", count = 200 }
    player.insert { name = "underground-belt", count = 20 }
    player.insert { name = "splitter", count = 20 }
    player.insert { name = "electric-mining-drill", count = 20 }
    player.insert { name = "pumpjack", count = 20 }
    player.insert { name = "offshore-pump", count = 5 }
    player.insert { name = "pipe", count = 100 }
    player.insert { name = "pipe-to-ground", count = 100 }
    player.insert { name = "personal-roboport-equipment", count = 1 }
    player.insert { name = "construction-robot", count = 50 }

    player.insert { name = "modular-armor", count = 1 }
    local armor = player.get_inventory(defines.inventory.character_armor).find_item_stack("modular-armor")
    local grid = armor.grid
    grid.put { name = "personal-roboport-equipment" }
end

local event_table = {}
local setup_table = {}

local function add_setup(name, f)
    setup_table[name] = f
end

local do_setup = true
local development_do_init = true

local function run_setup()
    if do_setup then
        do_setup = false
        for _, f in pairs(setup_table) do
            f()
        end
    end
end

local function remove_on_event(name, events)
    local function remove_event(event)
        local event_storage = event_table[event]
        if event_storage ~= nil then
            event_storage[name] = nil
            if next(event_storage) == nil then
                event_table[event] = nil
                script.on_event(event, nil)
            end
        end
    end

    if type(events) == "table" then
        for _, event in pairs(events) do
            remove_event(event)
        end
    else
        remove_event(events)
    end
end

local function add_on_event(name, events, f)
    local function do_event(event)
        if event_table[event] == nil then
            event_table[event] = {}

            if event == defines.events.on_tick then
                if development_mode then
                    script.on_event(event, function(e)
                        if development_do_init then
                            development_do_init = false
                            for _, callback in pairs(event_table["on_init"]) do
                                callback()
                            end

                            local callbacks = event_table[defines.events.on_surface_created]
                            if callbacks ~= nil then
                                for _, callback in pairs(callbacks) do
                                    for _, surface in pairs(game.surfaces) do
                                        callback {
                                            surface_index = surface.index,
                                            name = defines.events.on_surface_created,
                                            tick = 0,
                                        }
                                    end
                                end
                            end
                        end

                        run_setup()

                        for _, callback in pairs(event_table[event]) do
                            callback(e)
                        end
                    end)
                else
                    script.on_event(event, function(e)
                        run_setup()

                        for _, callback in pairs(event_table[event]) do
                            callback(e)
                        end
                    end)
                end
            else
                script.on_event(event, function(e)
                    for _, callback in pairs(event_table[event]) do
                        callback(e)
                    end
                end)
            end
        end

        event_table[event][name] = f
    end

    if type(events) == "table" then
        for _, event in pairs(events) do
            do_event(event)
        end
    else
        do_event(events)
    end
end

development_mode = true

local function add_on_configuration_changed(name, f)
    local event = "on_configuration_changed"

    if event_table[event] == nil then
        event_table[event] = {}

        script[event](function(e)
            for _, callback in pairs(event_table[event]) do
                callback(e)
            end
        end)
    end

    event_table[event][name] = f
end

local function add_on_init(name, f)
    if development_mode then
        add_on_configuration_changed(name, f)
    end

    local event = "on_init"

    if event_table[event] == nil then
        event_table[event] = {}

        script[event](function(e)
            for _, callback in pairs(event_table[event]) do
                callback(e)
            end
        end)
    end

    event_table[event][name] = f
end

local function init_entity_storage()
    return { surfaces = {}, names = {}, register_on_destroy = false }
end

local storage_entity_tracking_table = nil
local entity_indices = nil
local on_destroy_registrations = nil

add_on_init(
    "init storage entity tracking table reference",
    function()
        storage_entity_tracking_table = rtable.table_get_or_init_f(storage, "entity_tracking_table", rtable.make)
        entity_indices = rtable.table_get_or_init_f(storage, "entity_indices", rtable.make)
        on_destroy_registrations = rtable.table_get_or_init_f(storage, "on_destroy_registrations", rtable.make)
    end)

local function get_track_entities_storage(entity_type)
    return rtable.table_get_or_init_f(storage_entity_tracking_table, entity_type, init_entity_storage)
end

local function stop_track_entities_storage(entity_type)
    storage_entity_tracking_table[entity_type] = nil
end

local function lookup_track_entities_table(entity_type)
    return storage_entity_tracking_table[entity_type]
end

local function track_entities(name, entity_type, register_on_destroy)
    local tracking_storage = get_track_entities_storage(entity_type)
    tracking_storage.names[name] = true
    tracking_storage.register_on_destroy = register_on_destroy or false
    return tracking_storage.surfaces
end

local function stop_track_entities(name, entity_type)
    local tracking_storage = get_track_entities_storage(entity_type)
    tracking_storage.names[name] = nil

    if #tracking_storage.names == 0 then
        stop_track_entities_storage(entity_type)
    end
end

local function remove_by_index(entities_table, index)
    local entity_info = entities_table.elements[index]
    local unit_number = entity_info[2]

    local moved = rvector.remove(entities_table, index)
    if moved ~= nil then
        entity_indices[moved[2]][1] = index
    end

    entity_indices[unit_number] = nil
end

rework_control = {
    on_event = add_on_event,
    remove_on_event = remove_on_event,
    on_init = add_on_init,
    track_entities = track_entities,
    stop_track_entities = stop_track_entities,
    add_setup = add_setup,
    remove_by_index = remove_by_index,
}

local function register_entity(entity)
    local tracking = lookup_track_entities_table(entity.name)
    if tracking ~= nil then
        local unit_number = entity.unit_number
        if entity_indices[unit_number] == nil then
            local entities_table = rtable.table_get_or_init_f(tracking.surfaces, entity.surface_index, rvector.make)

            local index = rvector.push_back(entities_table, { entity, entity.unit_number })
            entity_indices[unit_number] = { index, entity.surface_index }
            entities_table.current_index = entities_table.end_index - 1

            if tracking.register_on_destroy then
                local registration_number, _, _ = script.register_on_object_destroyed(entity)
                on_destroy_registrations[registration_number] = { entity.name, entity.unit_number }
            end
        end
    end
end

local function unregister_entity_type_unit_number(entity_type, unit_number)
    local index_info = entity_indices[unit_number]

    if index_info ~= nil then
        entity_indices[unit_number] = nil

        local tracking = lookup_track_entities_table(entity_type)

        if tracking ~= nil then
            if index_info ~= nil then
                local index = index_info[1]
                local surface_index = index_info[2]

                local entities_table = rtable.table_get_or_init_f(tracking.surfaces, surface_index, rvector.make)

                local moved = rvector.remove(entities_table, index)
                if moved ~= nil then
                    entity_indices[moved[2]][1] = index
                end
            end
        end
    end
end

local function unregister_entity(entity)
    unregister_entity_type_unit_number(entity.name, entity.unit_number)
end


rework_control.on_event(
    "track entities",
    { defines.events.on_built_entity, defines.events.on_robot_built_entity, defines.events.script_raised_revive },
    function(event)
        local entity = event.entity
        register_entity(entity)
    end)

rework_control.on_event(
    "track entities",
    { defines.events.on_player_mined_entity, defines.events.on_robot_mined_entity, defines.events.on_entity_died },
    function(event)
        local entity = event.entity
        unregister_entity(entity)
    end)

rework_control.on_event(
    "track entities",
    { defines.events.on_pre_ghost_deconstructed },
    function(event)
        local entity = event.ghost
        unregister_entity(entity)
    end)

rework_control.on_event(
    "track entities",
    { defines.events.on_object_destroyed },
    function(event)
        local registration_number = event.registration_number

        local registration_info = on_destroy_registrations[registration_number]

        if registration_info ~= nil then
            local entity_type = registration_info[1]
            local unit_number = registration_info[2]

            unregister_entity_type_unit_number(entity_type, unit_number)

            on_destroy_registrations[registration_number] = nil
        end
        a = 1
        -- local entity = event.ghost
        -- unregister_entity(entity)
    end)



function validate_tracking_state()
    local surface_storage = {}
    storage.entity_indices = {}
    entity_indices = storage.entity_indices

    for _, surface in pairs(game.surfaces) do
        surface_storage[surface.index] = rvector.make()
    end

    for key, entity_storage in pairs(storage_entity_tracking_table) do
        if next(entity_storage.names) == nil then
            storage_entity_tracking_table[key] = nil
        else
            entity_storage.surfaces = util.table.deepcopy(surface_storage)
        end
    end

    for _, surface in pairs(game.surfaces) do
        for entity_type, entity_storage in pairs(storage_entity_tracking_table) do
            local entities = surface.find_entities_filtered { name = entity_type }

            local entities_storage = entity_storage.surfaces[surface.index]
            for _, entity in pairs(entities) do
                local index = rvector.push_back(entities_storage, { entity, entity.unit_number })
                entity_indices[entity.unit_number] = { index, entity.surface_index }
            end
        end
    end
end

function clear_state()
    validate_tracking_state()
    -- for k1, tracking in pairs(storage_entity_tracking_table) do
    --     for k2, _ in pairs(tracking.surfaces) do
    --         storage_entity_tracking_table[k1].surfaces[k2] = rvector.make()
    --     end
    -- end
end

rework_control.add_setup("validate tracking state", validate_tracking_state)

-- rework_control.on_event(
--     "track entities",
--     { defines.events.on_entity_died },
--     function(event)
--         a = 1
--         -- entity_tracking_table()[event.entity.name][event.entity.unit_number] = nil
--     end)

-- rework_control.on_event(
--     "set player stats",
--     defines.events.on_player_created,
--     function(event)
--         game.players[event.player_index].character_running_speed_modifier = 5
--         game.players[event.player_index].character_crafting_speed_modifier = 5
--         game.players[event.player_index].character_mining_speed_modifier = 5
--         game.players[event.player_index].character_reach_distance_bonus = 5
--     end)

rework_control.on_event(
    "prevent demolisher furnace rotation",
    { defines.events.on_built_entity, defines.events.on_robot_built_entity },
    function(event)
        if event.entity.name == "demolisher-furnace" then
            event.entity.rotatable = false
        end
    end)

once = false
rework_control.on_event(
    "do unlocks",
    defines.events.on_tick,
    function(event)
        if not once then
            for _, player in pairs(game.players) do
                do_unlocks(player)
                -- add_starter_items(player)
            end
            once = true
        end
    end)

rework_control.on_event(
    "ghost workaround",
    defines.events.on_script_trigger_effect,
    function(event)
        register_entity(event.cause_entity)
    end)

rework_control.on_event(
    "reload script controls",
    "reload-script-controls",
    function(event)
        game.reload_mods()
    end)

require("prototypes-list").do_control()

rework_control.on_event(
    "run reset test",
    "run-reset-test",
    function(event)
        clear_state()
    end)

require("catching_all_events")
