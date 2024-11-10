data:extend{
    {
      type = "recipe",
      subgroup = "vulcanus-processes",
      name = "stone-from-lava",
      order = "a[melting]-a[lava-c]",
      enabled = false,
      allow_productivity = true,
      category = "metallurgy",
      energy_required = 16,
      icons = {
        {
          icon = "__space-age__/graphics/icons/fluid/lava.png",
          icon_size = 64
        },
        {
          icon = "__base__/graphics/icons/stone.png",
          icon_size = 64,
          scale = 0.5,
          shift = {18, 18}
        }        
      },
      ingredients = {
        {
            amount = 500,
            name = "lava",
            type = "fluid"
          },
      },
      results = {{type = "item", name = "stone", amount = 15}},
    }
}