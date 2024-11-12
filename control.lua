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

local function add_on_event(name, events, f)
    local function do_event(event)
        if event_table[event] == nil then
            event_table[event] = {}

            script.on_event(event, function(e)
                for _, callback in pairs(event_table[event]) do
                    callback(e)
                end
            end)
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

rework_control = {
    on_event = add_on_event
}

rework_control.on_event(
    "set player stats",
    defines.events.on_player_created,
    function(event)
        game.players[event.player_index].character_running_speed_modifier = 5
        game.players[event.player_index].character_crafting_speed_modifier = 5
        game.players[event.player_index].character_mining_speed_modifier = 5
        game.players[event.player_index].character_reach_distance_bonus = 5
    end)

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
    "reload script controls",
    "reload-script-controls",
    function(event)
        game.reload_mods()
    end)

require("prototypes-list").do_control()
