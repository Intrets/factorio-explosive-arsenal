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

once = false
script.on_event(defines.events.on_tick, function(event)
    if not once then
        for _, player in pairs(game.players) do
            do_unlocks(player)
            -- add_starter_items(player)
        end
        once = true
    end
end)

script.on_event({ defines.events.on_built_entity, defines.events.on_robot_built_entity }, function(event)
    if event.entity.name == "demolisher-furnace" then
        event.entity.rotatable = false
    end
end)


script.on_event(defines.events.on_player_created, function(event)
    game.players[event.player_index].character_running_speed_modifier = 5
    game.players[event.player_index].character_crafting_speed_modifier = 5
    game.players[event.player_index].character_mining_speed_modifier = 5
    game.players[event.player_index].character_reach_distance_bonus = 5
end)

require("prototypes.remote-charge.remote-charge-control")

names = {}

function register_prototype_control(name)
    table.insert(names, name)
end

function load_prototype_controls()
    for _, name in pairs(names) do
        require("prototypes." .. name .. "." .. name .. "-control")
    end
end

register_prototype_control("remote-charge")

script.on_event("reload-script-controls", function(event)
    game.reload_mods()
end)

load_prototype_controls()
