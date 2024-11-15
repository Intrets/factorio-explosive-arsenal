local item_sounds = require("__base__.prototypes.item_sounds")
local item_tints = require("__base__.prototypes.item-tints")
local hit_effects = require("__base__.prototypes.entity.hit-effects")
local sounds = require("__base__.prototypes.entity.sounds")
local simulations = require("__base__.prototypes.factoriopedia-simulations")
require("__base__.prototypes.entity.entities")
require("util.picture")

data:extend({
    {
        type = "recipe",
        name = "dimensional-receiver",
        category = "electromagnetics",
        energy_required = 5,
        ingredients =
        {
            { type = "item",  name = "supercapacitor", amount = 8 },
            { type = "item",  name = "accumulator",    amount = 1 },
            { type = "fluid", name = "electrolyte",    amount = 80 },
        },
        results = { { type = "item", name = "dimensional-receiver", amount = 1 } },
        enabled = true
    },
    {
        type = "item",
        name = "dimensional-receiver",
        icon = "__rework__/graphics/dimensional-receiver/icon.png",
        subgroup = "environmental-protection",
        order = "b[lightning-collector]",
        inventory_move_sound = item_sounds.electric_large_inventory_move,
        pick_sound = item_sounds.electric_large_inventory_pickup,
        drop_sound = item_sounds.electric_large_inventory_move,
        place_result = "dimensional-receiver",
        stack_size = 20,
        default_import_location = "fulgora",
        random_tint_color = item_tints.iron_rust,
    },
    {
        type = "electric-energy-interface",
        name = "dimensional-receiver",
        icon = "__rework__/graphics/dimensional-receiver/icon.png",
        flags = { "placeable-neutral", "player-creation" },
        minable = { mining_time = 0.1, result = "dimensional-receiver" },
        max_health = 150,
        corpse = "accumulator-remnants",
        dying_explosion = "accumulator-explosion",
        collision_box = { { -1.8, -1.8 }, { 1.8, 1.8 } },
        selection_box = { { -2, -2 }, { 2, 2 } },
        damaged_trigger_effect = hit_effects.entity(),
        drawing_box_vertical_extension = 1.0,
        energy_source =
        {
            type = "electric",
            usage_priority = "secondary-input",
            buffer_capacity = "500MJ",
            input_flow_limit = "1500MW",
        },
        energy_usage = "1000MW",
        picture = rpicture.load_picture("dimensional-receiver", "sprite"),
    },
})

data:extend({
    {
        type = "recipe",
        name = "dimensional-accumulator",
        category = "electromagnetics",
        energy_required = 5,
        ingredients =
        {
            { type = "item",  name = "supercapacitor", amount = 8 },
            { type = "item",  name = "accumulator",    amount = 1 },
            { type = "fluid", name = "electrolyte",    amount = 80 },
        },
        results = { { type = "item", name = "dimensional-accumulator", amount = 1 } },
        enabled = true
    },
    {
        type = "item",
        name = "dimensional-accumulator",
        icon = "__space-age__/graphics/icons/lightning-collector.png",
        subgroup = "environmental-protection",
        order = "b[lightning-collector]",
        inventory_move_sound = item_sounds.electric_large_inventory_move,
        pick_sound = item_sounds.electric_large_inventory_pickup,
        drop_sound = item_sounds.electric_large_inventory_move,
        place_result = "dimensional-accumulator",
        stack_size = 20,
        default_import_location = "fulgora",
        random_tint_color = item_tints.iron_rust
    },
    {
        type = "accumulator",
        name = "dimensional-accumulator",
        icon = "__base__/graphics/icons/accumulator.png",
        flags = { "placeable-neutral", "player-creation" },
        minable = { mining_time = 0.1, result = "accumulator" },
        fast_replaceable_group = "accumulator",
        max_health = 150,
        corpse = "accumulator-remnants",
        dying_explosion = "accumulator-explosion",
        collision_box = { { -0.9, -0.9 }, { 0.9, 0.9 } },
        selection_box = { { -1, -1 }, { 1, 1 } },
        damaged_trigger_effect = hit_effects.entity(),
        drawing_box_vertical_extension = 0.5,
        energy_source =
        {
            type = "electric",
            buffer_capacity = "500000MJ",
            usage_priority = "primary-input",
            input_flow_limit = "500000MW",
            output_flow_limit = "0kW"
        },
        chargable_graphics =
        {
            picture = rpicture.load_picture("dimensional-accumulator", "sprite"),
            -- charge_animation = accumulator_charge(),
            charge_cooldown = 30,
            -- discharge_animation = accumulator_discharge(),
            discharge_cooldown = 60
            --discharge_light = {intensity = 0.7, size = 7, color = {r = 1.0, g = 1.0, b = 1.0}},
        },
        water_reflection = accumulator_reflection(),
        impact_category = "metal",
        open_sound = sounds.electric_large_open,
        close_sound = sounds.electric_large_close,
        working_sound =
        {
            main_sounds =
            {
                {
                    sound = { filename = "__base__/sound/accumulator-working.ogg", volume = 0.4, modifiers = volume_multiplier("main-menu", 1.44) },
                    match_volume_to_activity = true,
                    activity_to_volume_modifiers = { offset = 2, inverted = true },
                    fade_in_ticks = 4,
                    fade_out_ticks = 20
                },
                {
                    sound = { filename = "__base__/sound/accumulator-discharging.ogg", volume = 0.4, modifiers = volume_multiplier("main-menu", 1.44) },
                    match_volume_to_activity = true,
                    activity_to_volume_modifiers = { offset = 1 },
                    fade_in_ticks = 4,
                    fade_out_ticks = 20
                }
            },
            idle_sound = { filename = "__base__/sound/accumulator-idle.ogg", volume = 0.35 },
            max_sounds_per_type = 3,
            audible_distance_modifier = 0.5
        },

        circuit_connector = circuit_connector_definitions["accumulator"],
        circuit_wire_max_distance = default_circuit_wire_max_distance,

        default_output_signal = { type = "virtual", name = "signal-A" }
    },
})
