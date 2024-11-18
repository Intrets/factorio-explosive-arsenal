local item_sounds = require("__base__.prototypes.item_sounds")
local sounds = require("__base__.prototypes.entity.sounds")
local simulations = require("__base__.prototypes.factoriopedia-simulations")

data:extend({
    {
        type = "recipe",
        name = "shotgun-spidertron",
        enabled = true,
        energy_required = 10,
        ingredients =
        {
            { type = "item", name = "exoskeleton-equipment",     amount = 4 },
            { type = "item", name = "fission-reactor-equipment", amount = 2 },
            { type = "item", name = "shotgun",                   amount = 4 },
            { type = "item", name = "processing-unit",           amount = 16 },
            { type = "item", name = "low-density-structure",     amount = 150 },
            { type = "item", name = "radar",                     amount = 2 },
            { type = "item", name = "efficiency-module-3",       amount = 2 },
            { type = "item", name = "raw-fish",                  amount = 1 }
        },
        results = { { type = "item", name = "shotgun-spidertron", amount = 1 } }
    },
    {
        type = "item-with-entity-data",
        name = "shotgun-spidertron",
        icon = "__base__/graphics/icons/spidertron.png",
        icon_tintable = "__base__/graphics/icons/spidertron-tintable.png",
        icon_tintable_mask = "__base__/graphics/icons/spidertron-tintable-mask.png",
        subgroup = "transport",
        order = "b[personal-transport]-c[spidertron]-a[spider]",
        inventory_move_sound = item_sounds.spidertron_inventory_move,
        pick_sound = item_sounds.spidertron_inventory_pickup,
        drop_sound = item_sounds.spidertron_inventory_move,
        place_result = "shotgun-spidertron",
        weight = 1 * tons,
        stack_size = 1
    },
    {
        type = "gun",
        name = "spidertron-shotgun",
        icon = "__base__/graphics/icons/shotgun.png",
        subgroup = "gun",
        hidden = true,
        order = "z[spider]-a[rocket-launcher]",
        inventory_move_sound = item_sounds.ammo_large_inventory_move,
        pick_sound = item_sounds.ammo_large_inventory_pickup,
        drop_sound = item_sounds.ammo_large_inventory_move,
        attack_parameters =
        {
            type = "projectile",
            ammo_category = "shotgun-shell",
            cooldown = 2,
            movement_slow_down_factor = 0.6,
            projectile_creation_distance = 0.125,
            range = 15,
            min_range = 1,
            sound = sounds.shotgun,
            ammo_consumption_modifier = 0,
        },
        stack_size = 1
    },
})

function create_shotgun_spidertron(arguments)
    local scale = arguments.scale
    local leg_scale = scale * arguments.leg_scale
    local body_height = 1.5 * scale * leg_scale
    local spidertron_resistances =
    {
        {
            type = "fire",
            decrease = 15,
            percent = 100
        },
        {
            type = "physical",
            decrease = 15,
            percent = 100
        },
        {
            type = "impact",
            decrease = 50,
            percent = 100
        },
        {
            type = "explosion",
            decrease = 20,
            percent = 100
        },
        {
            type = "acid",
            decrease = 0,
            percent = 100
        },
        {
            type = "laser",
            decrease = 0,
            percent = 100
        },
        {
            type = "electric",
            decrease = 0,
            percent = 100
        }
    }
    local spidertron_leg_resistances = util.table.deepcopy(spidertron_resistances)
    spidertron_leg_resistances[4] = { type = "explosion", percent = 100 }

    data:extend(
        {
            {
                enabled = true,
                type = "spider-vehicle",
                name = arguments.name,
                collision_box = { { -1 * scale, -1 * scale }, { 1 * scale, 1 * scale } },
                sticker_box = { { -1.5 * scale, -1.5 * scale }, { 1.5 * scale, 1.5 * scale } },
                selection_box = { { -1 * scale, -1 * scale }, { 1 * scale, 1 * scale } },
                drawing_box_vertical_extension = 3 * scale,
                icon = "__base__/graphics/icons/spidertron.png",
                factoriopedia_simulation = arguments.factoriopedia_simulation,
                mined_sound = sounds.deconstruct_large(0.8),
                open_sound = { filename = "__base__/sound/spidertron/spidertron-door-open.ogg", volume = 0.45 },
                close_sound = { filename = "__base__/sound/spidertron/spidertron-door-close.ogg", volume = 0.4 },
                working_sound =
                {
                    sound = { filename = "__base__/sound/spidertron/spidertron-vox.ogg", volume = 0.35 },
                    activate_sound = { filename = "__base__/sound/spidertron/spidertron-activate.ogg", volume = 0.5 },
                    deactivate_sound = { filename = "__base__/sound/spidertron/spidertron-deactivate.ogg", volume = 0.5 },
                    match_speed_to_activity = true,
                    activity_to_speed_modifiers =
                    {
                        multiplier = 6.0,
                        minimum = 1.0,
                        offset = 0.93333333333
                    }
                },
                weight = 1,
                braking_force = 1,
                friction_force = 1,
                flags = { "placeable-neutral", "player-creation", "placeable-off-grid" },
                minable = { mining_time = 1, result = arguments.name },
                max_health = 3000000,
                resistances = util.table.deepcopy(spidertron_resistances),
                minimap_representation =
                {
                    filename = "__base__/graphics/entity/spidertron/spidertron-map.png",
                    flags = { "icon" },
                    size = { 128, 128 },
                    scale = 0.5
                },
                selected_minimap_representation =
                {
                    filename = "__base__/graphics/entity/spidertron/spidertron-map-selected.png",
                    flags = { "icon" },
                    size = { 128, 128 },
                    scale = 0.5
                },
                corpse = "spidertron-remnants",
                dying_explosion = "spidertron-explosion",
                energy_per_hit_point = 1,
                guns = { "spidertron-shotgun" , "spidertron-shotgun" , "spidertron-shotgun" , "spidertron-shotgun" },
                inventory_size = 80,
                equipment_grid = "spidertron-equipment-grid",
                trash_inventory_size = 20,
                height = body_height,
                alert_icon_shift = { 0, -body_height },
                torso_rotation_speed = 0.005,
                chunk_exploration_radius = 3,
                selection_priority = 60,
                graphics_set = spidertron_torso_graphics_set(scale),
                energy_source =
                {
                    type = "void"
                },
                movement_energy_consumption = "250kW",
                automatic_weapon_cycling = true,
                chain_shooting_cooldown_modifier = 0.5,
                spider_engine =
                {
                    legs =
                    {
                        { -- 1
                            leg = arguments.name .. "-leg-1",
                            mount_position = util.by_pixel(15 * scale, -22 * scale),
                            ground_position = { 2.25 * leg_scale, -2.5 * leg_scale },
                            walking_group = 1,
                            leg_hit_the_ground_trigger = get_leg_hit_the_ground_trigger()
                        },
                        { -- 2
                            leg = arguments.name .. "-leg-2",
                            mount_position = util.by_pixel(23 * scale, -10 * scale),
                            ground_position = { 3 * leg_scale, -1 * leg_scale },
                            walking_group = 2,
                            leg_hit_the_ground_trigger = get_leg_hit_the_ground_trigger()
                        },
                        { -- 3
                            leg = arguments.name .. "-leg-3",
                            mount_position = util.by_pixel(25 * scale, 4 * scale),
                            ground_position = { 3 * leg_scale, 1 * leg_scale },
                            walking_group = 1,
                            leg_hit_the_ground_trigger = get_leg_hit_the_ground_trigger()
                        },
                        { -- 4
                            leg = arguments.name .. "-leg-4",
                            mount_position = util.by_pixel(15 * scale, 17 * scale),
                            ground_position = { 2.25 * leg_scale, 2.5 * leg_scale },
                            walking_group = 2,
                            leg_hit_the_ground_trigger = get_leg_hit_the_ground_trigger()
                        },
                        { -- 5
                            leg = arguments.name .. "-leg-5",
                            mount_position = util.by_pixel(-15 * scale, -22 * scale),
                            ground_position = { -2.25 * leg_scale, -2.5 * leg_scale },
                            walking_group = 2,
                            leg_hit_the_ground_trigger = get_leg_hit_the_ground_trigger()
                        },
                        { -- 6
                            leg = arguments.name .. "-leg-6",
                            mount_position = util.by_pixel(-23 * scale, -10 * scale),
                            ground_position = { -3 * leg_scale, -1 * leg_scale },
                            walking_group = 1,
                            leg_hit_the_ground_trigger = get_leg_hit_the_ground_trigger()
                        },
                        { -- 7
                            leg = arguments.name .. "-leg-7",
                            mount_position = util.by_pixel(-25 * scale, 4 * scale),
                            ground_position = { -3 * leg_scale, 1 * leg_scale },
                            walking_group = 2,
                            leg_hit_the_ground_trigger = get_leg_hit_the_ground_trigger()
                        },
                        { -- 8
                            leg = arguments.name .. "-leg-8",
                            mount_position = util.by_pixel(-15 * scale, 17 * scale),
                            ground_position = { -2.25 * leg_scale, 2.5 * leg_scale },
                            walking_group = 1,
                            leg_hit_the_ground_trigger = get_leg_hit_the_ground_trigger()
                        }
                    },
                },
                is_military_target = true,
                allow_remote_driving = true,
            },
            make_spidertron_leg(arguments.name, leg_scale, arguments.leg_thickness, arguments.leg_movement_speed, 1, spidertron_leg_resistances),
            make_spidertron_leg(arguments.name, leg_scale, arguments.leg_thickness, arguments.leg_movement_speed, 2, spidertron_leg_resistances),
            make_spidertron_leg(arguments.name, leg_scale, arguments.leg_thickness, arguments.leg_movement_speed, 3, spidertron_leg_resistances),
            make_spidertron_leg(arguments.name, leg_scale, arguments.leg_thickness, arguments.leg_movement_speed, 4, spidertron_leg_resistances),
            make_spidertron_leg(arguments.name, leg_scale, arguments.leg_thickness, arguments.leg_movement_speed, 5, spidertron_leg_resistances),
            make_spidertron_leg(arguments.name, leg_scale, arguments.leg_thickness, arguments.leg_movement_speed, 6, spidertron_leg_resistances),
            make_spidertron_leg(arguments.name, leg_scale, arguments.leg_thickness, arguments.leg_movement_speed, 7, spidertron_leg_resistances),
            make_spidertron_leg(arguments.name, leg_scale, arguments.leg_thickness, arguments.leg_movement_speed, 8, spidertron_leg_resistances),
        })
end

create_shotgun_spidertron { name = "shotgun-spidertron",
    scale = 1,
    leg_scale = 1,     -- relative to scale
    leg_thickness = 1, -- relative to leg_scale
    leg_movement_speed = 10,
    factoriopedia_simulation = simulations.factoriopedia_spidertron }
