local item_sounds = require("__base__.prototypes.item_sounds")

data.extend({
    {
        type = "item",
        name = "demolisher-scale",
        icon = "__rework__/graphics/icons/demolisher-scale.png",
        subgroup = "raw-resource",
        order = "a[raw-resource]-b[demolisher-scale]",
        inventory_move_sound = item_sounds.metal_small_inventory_move,
        pick_sound = item_sounds.metal_small_inventory_pickup,
        drop_sound = item_sounds.metal_small_inventory_move,
        stack_size = 1,
        weight = 100 * kg,
    }
})
