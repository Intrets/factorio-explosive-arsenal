local item_sounds = require("__base__.prototypes.item_sounds")
local hit_effects = require("__base__.prototypes.entity.hit-effects")
local entities = require("__base__.prototypes.entity.entities")
local sounds = require("__base__.prototypes.entity.sounds")
local item_tints = require("__base__.prototypes.item-tints")

pictures = pipepictures()

for _, picture in pairs(pictures) do
    picture.tint = { r = 0.73, g = 0.2, b = 0.05, a = 1 }
end

data:extend({
    {
        type = "item",
        name = "demolisher-pipe",
        icon = "__rework__/graphics/icons/demolisher-pipe.png",
        subgroup = "energy-pipe-distribution",
        order = "a[pipe]-a[demolisher-pipe]",
        inventory_move_sound = item_sounds.metal_small_inventory_move,
        pick_sound = item_sounds.metal_small_inventory_pickup,
        drop_sound = item_sounds.metal_small_inventory_move,
        place_result = "demolisher-pipe",
        stack_size = 100,
        weight = 5 * kg,
        random_tint_color = item_tints.iron_rust
    },
    {
        type = "recipe",
        name = "demolisher-pipe",
        ingredients = { { type = "item", name = "demolisher-scale", amount = 1 } },
        results = { { type = "item", name = "demolisher-pipe", amount = 10 } },
        enabled = true
    },
    {
        type = "pipe",
        name = "demolisher-pipe",
        icon = "__rework__/graphics/icons/tungsten-pipe.png",
        flags = { "placeable-neutral", "player-creation" },
        minable = { mining_time = 0.1, result = "pipe" },
        collision_mask = { layers = { object = true, train = true, is_object = true, is_lower_object = true, ground_tile = true } },
        tile_buildability_rules =
        {
            { area = { { -1.4, -1.4 }, { 1.4, 1.4 } }, required_tiles = { layers = { lava_tile = true } }, colliding_tiles = { layers = {} } },
        },
        max_health = 500,
        corpse = "pipe-remnants",
        dying_explosion = "pipe-explosion",
        icon_draw_specification = { scale = 0.5 },
        resistances =
        {
            {
                type = "fire",
                percent = 100
            },
            {
                type = "impact",
                percent = 80
            }
        },
        fast_replaceable_group = "pipe",
        collision_box = { { -0.29, -0.29 }, { 0.29, 0.29 } },
        selection_box = { { -0.5, -0.5 }, { 0.5, 0.5 } },
        damaged_trigger_effect = hit_effects.entity(),
        fluid_box =
        {
            volume = 100,
            pipe_covers = pipecoverspictures(), -- in case a real pipe is connected to a ghost
            pipe_connections =
            {
                { direction = defines.direction.north, position = { 0, 0 } },
                { direction = defines.direction.east,  position = { 0, 0 } },
                { direction = defines.direction.south, position = { 0, 0 } },
                { direction = defines.direction.west,  position = { 0, 0 } }
            },
            hide_connection_info = true
        },
        impact_category = "metal",
        pictures = pictures,
        working_sound = sounds.pipe,
        open_sound = sounds.metal_small_open,
        close_sound = sounds.metal_small_close,

        horizontal_window_bounding_box = { { -0.25, -0.28125 }, { 0.25, 0.15625 } },
        vertical_window_bounding_box = { { -0.28125, -0.5 }, { 0.03125, 0.125 } }
    },
})
