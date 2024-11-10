local item_sounds = require("__base__.prototypes.item_sounds")
local item_tints = require("__base__.prototypes.item-tints")
local simulations = require("__base__.prototypes.factoriopedia-simulations")

require("prototypes.demolisher-furnace")
require("prototypes.demolisher-scale")
require("prototypes.tungsten-pipe")
require("prototypes.demolisher-pipe")
require("prototypes.fluid-smelting")

-- data:extend({
--     type = "item",
--     name = "starter-reactor-equipment",
--     icon = "__base__/graphics/icons/fission-reactor-equipment.png",
--     place_as_equipment_result = "fission-reactor-equipment",
--     subgroup = "equipment",
--     order = "a[energy-source]-b[fission-reactor]",
--     inventory_move_sound = item_sounds.reactor_inventory_move,
--     pick_sound = item_sounds.reactor_inventory_pickup,
--     drop_sound = item_sounds.reactor_inventory_move,
--     stack_size = 20,
--     weight = 0.25 * tons
-- })

starter_reactor_equipment = util.table.deepcopy(data.raw["armor"]["modular-armor"])
starter_reactor_equipment.name = "starter-reactor-equipment"

data:extend(
    {
        {
            type = "module-category",
            name = "space-grade"
        }
    })

data:extend(
    {
        {
            type = "module-category",
            name = "futuristic"
        }
    })

data:extend({{
  type = "module",
  name = "space-grade-module",
  localised_description = { "item-description.space-grade-module" },
  icon = "__rework__/graphics/icons/space-grade-module.png",
  subgroup = "module",
  color_hint = { text = "Q" },
  category = "space-grade",
  tier = 1,
  order = "d[quality]-a[quality-module-1]",
  inventory_move_sound = item_sounds.module_inventory_move,
  pick_sound = item_sounds.module_inventory_pickup,
  drop_sound = item_sounds.module_inventory_move,
  stack_size = 50,
  weight = 20 * kg,
  effect = { quality = 10.0, speed = 0.0 }
}})

data:extend({{
  type = "module",
  name = "futuristic-module",
  localised_description = { "item-description.futuristic-module" },
  icon = "__rework__/graphics/icons/futuristic-module.png",
  subgroup = "module",
  color_hint = { text = "Q" },
  category = "futuristic",
  tier = 1,
  order = "d[quality]-a[quality-module-1]",
  inventory_move_sound = item_sounds.module_inventory_move,
  pick_sound = item_sounds.module_inventory_pickup,
  drop_sound = item_sounds.module_inventory_move,
  stack_size = 50,
  weight = 20 * kg,
  effect = { quality = 20.0, speed = 0.0 }
}})

-- data.raw.quality["uncommon"].next_probability = 1.0


-- 
-- 
-- data.raw.quality["legendary"].hidden = true
-- data.raw.quality["legendary"].next = nil

data:extend(
  {
    {
      type = "quality",
      name = "quality-scrappy",
      level = 4,
      color = {43, 165, 61},
      order = "b",
      subgroup = "qualities",
      icon = "__quality__/graphics/icons/quality-uncommon.png",
      beacon_power_usage_multiplier = 5/6,
      mining_drill_resource_drain_multiplier = 5/6,
      science_pack_drain_multiplier = 99/100,
    },
    {
      type = "quality",
      name = "quality-space-grade",
      level = 2,
      color = {43, 165, 61},
      order = "b",
      subgroup = "qualities",
      icon = "__quality__/graphics/icons/quality-uncommon.png",
      beacon_power_usage_multiplier = 5/6,
      mining_drill_resource_drain_multiplier = 5/6,
      science_pack_drain_multiplier = 99/100,
    },
    {
      type = "quality",
      name = "quality-futuristic",
      level = 3,
      color = {25, 104, 178},
      order = "c",
      subgroup = "qualities",
      icon = "__quality__/graphics/icons/quality-rare.png",
      beacon_power_usage_multiplier = 4/6,
      mining_drill_resource_drain_multiplier = 4/6,
      science_pack_drain_multiplier = 98/100,
    },
  }
)
data:extend
({
  {
    type = "technology",
    name = "quality-test",
    icon_size = 256,
    icon = "__quality__/graphics/technology/epic-quality.png",
    icon_size = 256,
    effects =
    {
      {
        type = "unlock-quality",
        quality = "futuristic"
      },
      {
        type = "unlock-quality",
        quality = "space-grade"
      },
      {
        type = "unlock-quality",
        quality = "scrappy"
      }
    },
    prerequisites = { "logistic-science-pack" },
    unit =
    {
      count = 5000,
      ingredients =
      {
        { "automation-science-pack", 1 },
        { "logistic-science-pack", 1 },
      },
      time = 60
    }
  }
})

data:extend
({
  {
    type = "recipe",
    name = "space-grade-module",
    enabled = true,
    ingredients =
    {
      {type = "item", name = "electronic-circuit", amount = 5},
      {type = "item", name = "advanced-circuit", amount = 5},
    },
    energy_required = 15,
    results = {{type="item", name="space-grade-module", amount=1}}
  },
  {
    type = "recipe",
    name = "futuristic-module",
    enabled = true,
    ingredients =
    {
      {type = "item", name = "advanced-circuit", amount = 5},
      {type = "item", name = "processing-unit", amount = 5},
    },
    energy_required = 30,
    results = {{type="item", name="futuristic-module", amount=1}}
  },
})
