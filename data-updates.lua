require("prototypes-list").do_data_updates()

local disabled_recipes = {
    ["recycler"] = true,
    ["small-electric-pole"] = true,
    ["automation-science-pack"] = true,
    ["logistic-science-pack"] = true,
    ["quality-module-1"] = true,
    ["quality-module-2"] = true,
    ["quality-module-3"] = true,
}

local unlocks_map = {}

for name, t in pairs(data.raw.technology) do
    count = 0

    if t.unit ~= nil then
        local new_ingredients = {}
        local empty = true

        for index, ingredient in pairs(t.unit.ingredients) do
            if ingredient[1] ~= "automation-science-pack" and ingredient[1] ~= "logistic-science-pack" then
                table.insert(new_ingredients, ingredient)
                empty = false
            end
        end

        t.unit.ingredients = new_ingredients
    end
end

for name, technology in pairs(data.raw.technology) do
    if technology.effects ~= nil then
        for index, effect in pairs(technology.effects) do
            if effect.type == "unlock-recipe" then
                if disabled_recipes[effect.recipe] ~= nil then
                    table.remove(technology.effects, index)
                end
            end
        end
    end
end

local entity_types = { "furnace", "assembling-machine", "mining-drill", "inserter", "lab", "offshore-pump", "solar-panel",
    "accumulator", "reactor", "boiler", "generator", "beacon", "electric-pole", "roboport", "radar", "rocket-silo",
    "lamp", "chest", "container", "logistic-container" }

local types = {
    "recipe", "item", "tool"
}

for name, _ in pairs(disabled_recipes) do
    for _, prototype_type in pairs(types) do
        local p = data.raw[prototype_type][name]

        if p ~= nil then
            p.hidden_in_factoriopedia = true

            local entity = p.place_result

            if entity ~= nil then
                for _, entity_type in pairs(entity_types) do
                    local prototype = data.raw[entity_type][entity]
                    if prototype ~= nil then
                        prototype.hidden_in_factoriopedia = true
                        break
                    end
                end
            end
        end
    end
end

a = 1
-- data.raw["assembling-machine"]["assembling-machine-3"].fixed_quality = "quality-futuristic"
-- data.raw["assembling-machine"]["assembling-machine-2"].effect_receiver = { base_effect = { quality = 10 } }
-- data.raw["assembling-machine"]["assembling-machine-3"].effect_receiver = { base_effect = { quality = -10 } }


local assembling_machine_3 = data.raw["assembling-machine"]["assembling-machine-3"]

if assembling_machine_3.allowed_module_categories == nil then
    assembling_machine_3.allowed_module_categories = {}
end

table.insert(assembling_machine_3.allowed_module_categories, "space-grade")

local assembling_machine_2 = data.raw["assembling-machine"]["assembling-machine-2"]

if assembling_machine_2.allowed_module_categories == nil then
    assembling_machine_2.allowed_module_categories = {}
end

table.insert(assembling_machine_2.allowed_module_categories, "futuristic")

