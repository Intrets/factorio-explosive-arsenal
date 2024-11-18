data:extend({
    {
        type = "recipe",
        name = "explosive-shotgun-shell",
        enabled = true,
        energy_required = 8,
        ingredients =
        {
            { type = "item", name = "shotgun-shell", amount = 2 },
            { type = "item", name = "copper-plate",  amount = 5 },
            { type = "item", name = "steel-plate",   amount = 2 },
            { type = "item", name = "explosives",    amount = 5 },
        },
        results = { { type = "item", name = "explosive-shotgun-shell", amount = 1 } }
    },
    {
        type = "projectile",
        name = "explosive-shotgun-pellet",
        flags = { "not-on-map" },
        hidden = true,
        collision_box = { { -0.05, -0.25 }, { 0.05, 0.25 } },
        acceleration = 0,
        direction_only = true,
        action =
        {
            type = "direct",
            action_delivery =
            {
                type = "instant",
                target_effects = {
                    {
                        type = "create-entity",
                        entity_name = "big-explosion"
                    },
                    {
                        type = "nested-result",
                        action =
                        {
                            type = "area",
                            radius = 6.5,
                            action_delivery =
                            {
                                type = "instant",
                                target_effects =
                                {
                                    {
                                        type = "damage",
                                        damage = { amount = 100, type = "explosion" }
                                    },
                                    {
                                        type = "create-entity",
                                        entity_name = "explosion"
                                    }
                                }
                            }
                        }
                    }
                }
            }
        },
        animation =
        {
            filename = "__base__/graphics/entity/piercing-bullet/piercing-bullet.png",
            draw_as_glow = true,
            width = 3,
            height = 50,
            priority = "high"
        }
    },
    {
        type = "ammo",
        name = "explosive-shotgun-shell",
        icon = "__base__/graphics/icons/piercing-shotgun-shell.png",
        ammo_category = "shotgun-shell",
        enabled = true,
        ammo_type =
        {
            cooldown_modifier = 0.3,
            target_type = "direction",
            clamp_position = true,
            action =
            {
                {
                    type = "direct",
                    action_delivery =
                    {
                        type = "instant",
                        source_effects =
                        {
                            {
                                type = "create-explosion",
                                entity_name = "explosion-gunshot"
                            }
                        }
                    }
                },
                {
                    type = "direct",
                    repeat_count = 10,
                    action_delivery =
                    {
                        type = "projectile",
                        projectile = "explosive-shotgun-pellet",
                        starting_speed = 10,
                        starting_speed_deviation = 0.1,
                        direction_deviation = 1.3,
                        range_deviation = 0.3,
                        max_range = 50
                    }
                }
            }
        },
        magazine_size = 10,
        subgroup = "ammo",
        order = "b[shotgun]-b[piercing]",
        inventory_move_sound = item_sounds.ammo_small_inventory_move,
        pick_sound = item_sounds.ammo_small_inventory_pickup,
        drop_sound = item_sounds.ammo_small_inventory_move,
        stack_size = 100,
        weight = 20 * kg
    },
})
