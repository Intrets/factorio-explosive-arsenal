data:extend({
    {
        type = "autoplace-control",
        name = "vulcanus_iron_ore",
        localised_name = { "", "[entity=iron-ore] ", { "entity-name.iron-ore" } },
        richness = true,
        order = "b-a",
        category = "resource"
    },
    {
        type = "noise-expression",
        name = "vulcanus_iron_ore_size",
        expression = "slider_rescale(control:vulcanus_iron_ore:size, 2)"
    },
    {
        type = "noise-expression",
        name = "vulcanus_iron_ore_region",
        -- parameters = {"seed", "count", "offset", "size", "freq", "favor_biome"},
        expression = "vulcanus_place_metal_spots(1001, 15 * 10, 2,\z
                        vulcanus_iron_ore_size * min(1.2, vulcanus_ore_dist) * 5,\z
                        control:vulcanus_iron_ore:frequency * 10,\z
                        vulcanus_mountains_resource_favorability) * (vulcanus_calcite_region + 0.2 < 0) * (vulcanus_coal_region + 0.2 < 0)"
    },
    {
        type = "noise-expression",
        name = "vulcanus_iron_ore_probability",
        expression =
        "(control:vulcanus_iron_ore:size > 0) * (1000 * ((1 + vulcanus_iron_ore_region) * random_penalty_between(0.9, 1, 1) - 1))"
    },
    {
        type = "noise-expression",
        name = "vulcanus_iron_ore_richness",
        expression = "vulcanus_iron_ore_region * random_penalty_between(0.9, 1, 1)\z
                  * 24000 * vulcanus_starting_area_multiplier\z
                  * control:vulcanus_iron_ore:richness / vulcanus_iron_ore_size"
    },

    {
        type = "autoplace-control",
        name = "vulcanus_copper_ore",
        localised_name = { "", "[entity=copper-ore] ", { "entity-name.copper-ore" } },
        richness = true,
        order = "b-a",
        category = "resource"
    },
    {
        type = "noise-expression",
        name = "vulcanus_copper_ore_size",
        expression = "slider_rescale(control:vulcanus_copper_ore:size, 2)"
    },
    {
        type = "noise-expression",
        name = "vulcanus_copper_ore_region",
        -- parameters = {"seed", "count", "offset", "size", "freq", "favor_biome"},
        expression = "vulcanus_place_metal_spots(1001, 15 * 10, 2,\z
                        vulcanus_copper_ore_size * min(1.2, vulcanus_ore_dist) * 5,\z
                        control:vulcanus_copper_ore:frequency * 10,\z
                        vulcanus_ashlands_resource_favorability) * (vulcanus_calcite_region + 0.2 < 0) * (vulcanus_coal_region + 0.2 < 0)"
    },
    {
        type = "noise-expression",
        name = "vulcanus_copper_ore_probability",
        expression =
        "(control:vulcanus_copper_ore:size > 0) * (1000 * ((1 + vulcanus_copper_ore_region) * random_penalty_between(0.9, 1, 1) - 1))"
    },
    {
        type = "noise-expression",
        name = "vulcanus_copper_ore_richness",
        expression = "vulcanus_copper_ore_region * random_penalty_between(0.9, 1, 1)\z
                  * 24000 * vulcanus_starting_area_multiplier\z
                  * control:vulcanus_copper_ore:richness / vulcanus_copper_ore_size"
    }
})
