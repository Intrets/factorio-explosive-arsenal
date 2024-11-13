local item_sounds = require("__base__.prototypes.item_sounds")
local item_tints = require("__base__.prototypes.item-tints")
local hit_effects = require("__base__.prototypes.entity.hit-effects")
local sounds = require("__base__.prototypes.entity.sounds")
local simulations = require("__base__.prototypes.factoriopedia-simulations")
require("__base__.prototypes.entity.entities")

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
            picture = accumulator_picture(),
            charge_animation = accumulator_charge(),
            charge_cooldown = 30,
            discharge_animation = accumulator_discharge(),
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

data:extend({
    {
        type = "item",
        name = "dimensional-roboport",
        icon = "__base__/graphics/icons/roboport.png",
        subgroup = "logistic-network",
        order = "c[signal]-a[dimensional-roboport]",
        inventory_move_sound = item_sounds.roboport_inventory_move,
        pick_sound = item_sounds.roboport_inventory_pickup,
        drop_sound = item_sounds.roboport_inventory_move,
        place_result = "dimensional-roboport",
        stack_size = 1,
        weight = 1000 * kg,
        random_tint_color = item_tints.iron_rust
    },
    {
        type = "recipe",
        name = "dimensional-roboport",
        enabled = true,
        energy_required = 5,
        ingredients =
        {
            { type = "item", name = "steel-plate",      amount = 45 },
            { type = "item", name = "iron-gear-wheel",  amount = 45 },
            { type = "item", name = "advanced-circuit", amount = 45 }
        },
        results = { { type = "item", name = "dimensional-roboport", amount = 1 } }
    },
    {
        type = "roboport",
        name = "dimensional-roboport",
        icon = "__base__/graphics/icons/roboport.png",
        flags = { "placeable-player", "player-creation" },
        fast_replaceable_group = "roboport",
        minable = { mining_time = 0.1, result = "dimensional-roboport" },
        max_health = 500,
        corpse = "roboport-remnants",
        dying_explosion = "roboport-explosion",
        collision_box = { { -1.7, -1.7 }, { 1.7, 1.7 } },
        selection_box = { { -2, -2 }, { 2, 2 } },
        damaged_trigger_effect = hit_effects.entity(),
        resistances =
        {
            {
                type = "fire",
                percent = 60
            },
            {
                type = "impact",
                percent = 30
            }
        },
        energy_source =
        {
            type = "electric",
            usage_priority = "secondary-input",
            input_flow_limit = "5MW",
            buffer_capacity = "100MJ"
        },
        recharge_minimum = "40MJ",
        energy_usage = "50kW",
        -- per one charge slot
        charging_energy = "500kW",
        logistics_radius = 0,
        construction_radius = 55,
        charge_approach_distance = 5,
        robot_slots_count = 7,
        material_slots_count = 7,
        stationing_offset = { 0, 0 },
        charging_offsets =
        {
            { -1.5, -1 }, { 1.5, -1 }, { 1.5, 1 }, { -1.5, 1 }
        },
        base =
        {
            layers =
            {
                {
                    filename = "__base__/graphics/entity/roboport/roboport-base.png",
                    width = 228,
                    height = 277,
                    shift = util.by_pixel(2, -2.25),
                    scale = 0.5
                },
                {
                    filename = "__base__/graphics/entity/roboport/roboport-shadow.png",
                    width = 294,
                    height = 201,
                    draw_as_shadow = true,
                    shift = util.by_pixel(28.5, 9.25),
                    scale = 0.5
                }
            }
        },
        base_patch =
        {
            filename = "__base__/graphics/entity/roboport/roboport-base-patch.png",
            priority = "medium",
            width = 138,
            height = 100,
            shift = util.by_pixel(1.5, -5),
            scale = 0.5
        },
        base_animation =
        {
            filename = "__base__/graphics/entity/roboport/roboport-base-animation.png",
            priority = "medium",
            width = 83,
            height = 59,
            frame_count = 8,
            animation_speed = 0.5,
            shift = util.by_pixel(-17.75, -71.25),
            scale = 0.5
        },
        door_animation_up =
        {
            filename = "__base__/graphics/entity/roboport/roboport-door-up.png",
            priority = "medium",
            width = 97,
            height = 38,
            frame_count = 16,
            shift = util.by_pixel(-0.25, -39.5),
            scale = 0.5
        },
        door_animation_down =
        {
            filename = "__base__/graphics/entity/roboport/roboport-door-down.png",
            priority = "medium",
            width = 97,
            height = 41,
            frame_count = 16,
            shift = util.by_pixel(-0.25, -19.75),
            scale = 0.5
        },
        recharging_animation =
        {
            filename = "__base__/graphics/entity/roboport/roboport-recharging.png",
            draw_as_glow = true,
            priority = "high",
            width = 37,
            height = 35,
            frame_count = 16,
            scale = 1.5,
            animation_speed = 0.5,
        },
        impact_category = "metal",
        open_sound = { filename = "__base__/sound/open-close/roboport-open.ogg", volume = 0.5 },
        close_sound = { filename = "__base__/sound/open-close/roboport-close.ogg", volume = 0.4 },
        working_sound =
        {
            sound = { filename = "__base__/sound/roboport-working.ogg", volume = 0.4 },
            max_sounds_per_type = 3,
            audible_distance_modifier = 0.75
        },
        recharging_light = { intensity = 0.2, size = 3, color = { 0.5, 0.5, 1 } },
        request_to_open_door_timeout = 15,
        spawn_and_station_height = 0.3,
        stationing_render_layer_swap_height = 0.87,

        draw_logistic_radius_visualization = true,
        draw_construction_radius_visualization = true,

        open_door_trigger_effect = sounds.roboport_door_open,
        close_door_trigger_effect = sounds.roboport_door_close,

        circuit_connector = circuit_connector_definitions["roboport"],
        circuit_wire_max_distance = default_circuit_wire_max_distance,

        default_available_logistic_output_signal = { type = "virtual", name = "signal-X" },
        default_total_logistic_output_signal = { type = "virtual", name = "signal-Y" },
        default_available_construction_output_signal = { type = "virtual", name = "signal-Z" },
        default_total_construction_output_signal = { type = "virtual", name = "signal-T" },
        default_roboport_count_output_signal = { type = "virtual", name = "signal-R" },

        water_reflection =
        {
            pictures =
            {
                filename = "__base__/graphics/entity/roboport/roboport-reflection.png",
                priority = "extra-high",
                width = 28,
                height = 28,
                shift = util.by_pixel(0, 65),
                variation_count = 1,
                scale = 5
            },
            rotate = false,
            orientation_to_variation = false
        }
    },
})
