local item_sounds = require("__base__.prototypes.item_sounds")
local hit_effects = require("__base__.prototypes.entity.hit-effects")
local sounds = require("__base__.prototypes.entity.sounds")

data.extend({
    {
        type = "item",
        name = "demolisher-furnace",
        icon = "__base__/graphics/icons/stone-furnace.png",
        subgroup = "smelting-machine",
        order = "a[stone-furnace]",
        inventory_move_sound = item_sounds.brick_inventory_move,
        pick_sound = item_sounds.brick_inventory_pickup,
        drop_sound = item_sounds.brick_inventory_move,
        place_result = "demolisher-furnace",
        stack_size = 50
    },
    {
        type = "recipe",
        name = "demolisher-furnace",
        ingredients = { { type = "item", name = "stone", amount = 5 }, { type = "item", name = "demolisher-scale", amount = 1 } },
        results = { { type = "item", name = "demolisher-furnace", amount = 1 } }
    },
    {
        type = "assembling-machine",
        name = "demolisher-furnace",
        icon = "__base__/graphics/icons/stone-furnace.png",
        flags = { "placeable-neutral", "placeable-player", "player-creation" },
        minable = { mining_time = 0.2, result = "demolisher-furnace" },
        collision_mask = { layers = { object = true, train = true, is_object = true, is_lower_object = true } },
        tile_buildability_rules =
        {
            { area = { { -1.4, 0.6 }, { 1.4, 1.4 } }, required_tiles = { layers = { ground_tile = true } }, colliding_tiles = { layers = { water_tile = true } } },
            { area = { { -1.5, -1 }, { 1.5, 0 } },    required_tiles = { layers = { lava_tile = true } },   colliding_tiles = { layers = {} } },
        },
        tile_width = 3,
        tile_height = 3,
        fast_replaceable_group = "furnace",
        next_upgrade = nil,
        max_health = 200,
        corpse = "stone-furnace-remnants",
        dying_explosion = "stone-furnace-explosion",
        repair_sound = sounds.manual_repair,
        mined_sound = sounds.deconstruct_bricks(0.8),
        open_sound = sounds.machine_open,
        close_sound = sounds.machine_close,
        allowed_effects = { "speed", "consumption", "pollution", "productivity" },
        crafting_categories = { "fluid-smelting" },
        module_slots = 2,
        impact_category = "stone",
        icon_draw_specification = { scale = 0.66, shift = { 0, -0.1 } },
        working_sound =
        {
            sound = { filename = "__base__/sound/furnace.ogg", volume = 0.6, modifiers = { volume_multiplier("main-menu", 1.5), volume_multiplier("tips-and-tricks", 1.4) } },
            fade_in_ticks = 4,
            fade_out_ticks = 20,
            audible_distance_modifier = 0.4
        },
        resistances =
        {
            {
                type = "fire",
                percent = 90
            },
            {
                type = "explosion",
                percent = 30
            },
            {
                type = "impact",
                percent = 30
            }
        },
        collision_box = { { -1.2, -1.2 }, { 1.2, 1.2 } },
        selection_box = { { -1.5, -1.5 }, { 1.5, 1.5 } },
        result_inventory_size = 1,
        energy_usage = "1kW",
        crafting_speed = 1,
        source_inventory_size = 1,
        energy_source = { type = "void" },
        graphics_set =
        {
            animation =
            {
                layers =
                {
                    {
                        filename = "__rework__/graphics/entity/demolisher-furnace/demolisher-furnace.png",
                        priority = "extra-high",
                        width = 227,
                        height = 219,
                        shift = util.by_pixel(-0.25, 6),
                        scale = 0.5
                    },
                    {
                        filename = "__base__/graphics/entity/stone-furnace/stone-furnace-shadow.png",
                        priority = "extra-high",
                        width = 164,
                        height = 74,
                        draw_as_shadow = true,
                        shift = util.by_pixel(14.5, 13),
                        scale = 0.5
                    }
                }
            },
            working_visualisations =
            {
                {
                    fadeout = true,
                    effect = "flicker",
                    animation =
                    {
                        layers =
                        {
                            {
                                filename = "__base__/graphics/entity/stone-furnace/stone-furnace-fire.png",
                                priority = "extra-high",
                                line_length = 8,
                                width = 41,
                                height = 100,
                                frame_count = 48,
                                draw_as_glow = true,
                                shift = util.by_pixel(-0.75, 5.5),
                                scale = 0.5
                            },
                            {
                                filename = "__rework__/graphics/entity/demolisher-furnace/demolisher-furnace-light.png",
                                blend_mode = "additive",
                                width = 159,
                                height = 216,
                                repeat_count = 48,
                                draw_as_glow = true,
                                shift = util.by_pixel(0, 5),
                                scale = 0.5,
                            },
                        }
                    }
                },
                {
                    fadeout = true,
                    effect = "flicker",
                    animation =
                    {
                        filename = "__base__/graphics/entity/stone-furnace/stone-furnace-ground-light.png",
                        blend_mode = "additive",
                        width = 116,
                        height = 110,
                        repeat_count = 48,
                        draw_as_light = true,
                        shift = util.by_pixel(-1, 44),
                        scale = 0.5,
                    },
                },
            },
            water_reflection =
            {
                pictures =
                {
                    filename = "__base__/graphics/entity/stone-furnace/stone-furnace-reflection.png",
                    priority = "extra-high",
                    width = 16,
                    height = 16,
                    shift = util.by_pixel(0, 35),
                    variation_count = 1,
                    scale = 5
                },
                rotate = false,
                orientation_to_variation = false
            }
        },
        fluid_boxes =
        {
            {
                production_type = "output",
                pipe_picture = util.empty_sprite(),
                pipe_covers = pipecoverspictures(),
                always_draw_covers = false,
                volume = 100,
                pipe_connections = { { flow_direction = "output", direction = defines.direction.north, position = { 0, -1 } } }
            }
        },
    },
})
