data.raw.quality["normal"].next = "space-grade"

local space_grade = table.deepcopy(data.raw.quality["uncommon"])
space_grade.name = "space-grade"
space_grade.localised_name = "space grade"
space_grade.next_probability = 0
space_grade.next = nil
data.raw.quality["space-grade"] = space_grade

-- local futuristic = table.deepcopy(data.raw.quality["rare"])
-- futuristic.name = "futuristic"
-- futuristic.localised_name = "futuristic"
-- futuristic.next_probability = 0.001
-- futuristic.next = nil
-- data.raw.quality["futuristic"] = futuristic

-- local scrappy = table.deepcopy(data.raw.quality["epic"])
-- scrappy.name = "scrappy"
-- scrappy.localised_name = "scrappy"
-- scrappy.next_probability = 0.0
-- scrappy.next = nil
-- data.raw.quality["scrappy"] = scrappy

data.raw.quality["uncommon"] = nil
data.raw.quality["rare"] = nil
data.raw.quality["epic"] = nil
data.raw.quality["legendary"] = nil

data.raw.module["quality-module"] = nil
data.raw.module["quality-module-2"] = nil
data.raw.module["quality-module-3"] = nil
data.raw.recipe["quality-module"] = nil
data.raw.recipe["quality-module-2"] = nil
data.raw.recipe["quality-module-3"] = nil
data.raw.recipe["quality-module-recycling"] = nil
data.raw.recipe["quality-module-2-recycling"] = nil
data.raw.recipe["quality-module-3-recycling"] = nil
data.raw.technology["quality-module"] = nil
data.raw.technology["quality-module-2"] = nil
data.raw.technology["quality-module-3"] = nil
data.raw.technology["epic-quality"] = nil
data.raw.technology["legendary-quality"] = nil

data.raw["tips-and-tricks-item"]["quality"] = nil
data.raw["tips-and-tricks-item"]["quality-modules"] = nil
data.raw["tips-and-tricks-item"]["quality-factoriopedia"] = nil
data.raw["tips-and-tricks-item"]["quality-probabilities"] = nil

data.raw["produce-achievement"]["crafting-with-quality"] = nil
data.raw["module-transfer-achievement"]["make-it-better"] = nil
data.raw["produce-achievement"]["my-modules-are-legendary"] = nil
data.raw["equip-armor-achievement"]["look-at-my-shiny-rare-armor"] = nil
data.raw["use-item-achievement"]["todays-fish-is-trout-a-la-creme"] = nil
data.raw["place-equipment-achievement"]["no-room-for-more"] = nil

small_demolisher_corpse = data.raw["simple-entity"]["small-demolisher-corpse"]
medium_demolisher_corpse = data.raw["simple-entity"]["medium-demolisher-corpse"]
big_demolisher_corpse = data.raw["simple-entity"]["big-demolisher-corpse"]

small_demolisher_corpse.minable.results = { [1] = { type = "item", name = "demolisher-scale", amount_min = 1, amount_max = 1 } }
medium_demolisher_corpse.minable.results = { [1] = { type = "item", name = "demolisher-scale", amount_min = 1, amount_max = 1 } }
big_demolisher_corpse.minable.results = { [1] = { type = "item", name = "demolisher-scale", amount_min = 1, amount_max = 1 } }

local foundry = data.raw["assembling-machine"]["foundry"]

foundry.collision_mask = { layers = { object = true, train = true, is_object = true, is_lower_object = true } }
foundry.tile_buildability_rules =
{
    { area = { { -0.4, 0.4 }, { -0.4, 0.4 } }, required_tiles = { layers = { ground_tile = true } }, colliding_tiles = { layers = { water_tile = true } } },
}

table.insert(data.raw.recipe["foundry"].ingredients, { type = "item", name = "demolisher-scale", amount = 2 })

function add_surface_condition(recipe, condition)
    if recipe.surface_conditions == nil then
        recipe.surface_conditions = {}
    end

    table.insert(recipe.surface_conditions, condition)
end

function disable_recipe(recipe_name)
    data.raw["recipe"][recipe_name].hidden = true
    data.raw["recipe"][recipe_name].hidden_in_factoriopedia = true
end

disable_recipe("casting-steel")
disable_recipe("molten-iron-from-lava")
disable_recipe("molten-iron")
disable_recipe("molten-copper-from-lava")
disable_recipe("molten-copper")

add_surface_condition(data.raw["recipe"]["iron-plate"], { property = "atmospheric-contamination", max = 10 })
add_surface_condition(data.raw["recipe"]["copper-plate"], { property = "atmospheric-contamination", max = 10 })
add_surface_condition(data.raw["recipe"]["steel-plate"], { property = "atmospheric-contamination", max = 10 })

data.raw["planet"]["vulcanus"].surface_properties["atmospheric-contamination"] = 1200

data.raw["planet"]["vulcanus"].map_gen_settings.property_expression_names["entity:iron-ore:probability"] = "vulcanus_iron_ore_probability"
data.raw["planet"]["vulcanus"].map_gen_settings.property_expression_names["entity:iron-ore:richness"] = "vulcanus_iron_ore_richness"
data.raw["planet"]["vulcanus"].map_gen_settings.autoplace_controls["vulcanus_iron_ore"] = {}
data.raw["planet"]["vulcanus"].map_gen_settings.autoplace_settings.entity.settings["iron-ore"] = {}

data.raw["planet"]["vulcanus"].map_gen_settings.property_expression_names["entity:copper-ore:probability"] = "vulcanus_copper_ore_probability"
data.raw["planet"]["vulcanus"].map_gen_settings.property_expression_names["entity:copper-ore:richness"] = "vulcanus_copper_ore_richness"
data.raw["planet"]["vulcanus"].map_gen_settings.autoplace_controls["vulcanus_copper_ore"] = {}
data.raw["planet"]["vulcanus"].map_gen_settings.autoplace_settings.entity.settings["copper-ore"] = {}