data:extend({
    {
        type = "recipe-category",
        name = "fluid-smelting"
    },
    {
        type = "fluid",
        name = "molten-steel",
        icon = "__rework__/graphics/icons/molten-steel.png",
        subgroup = "fluid",
        order = "b[new-fluid]-b[vulcanus]-b[molten-steel]",
        default_temperature = 1100,
        max_temperature = 2000,
        heat_capacity = "0.01kJ",
        base_color = { 0, 0.1, 0.23 },
        flow_color = { 0.1, 0.34, 0.46 },
        auto_barrel = false
    },
    {
        type = "recipe",
        name = "molten-iron-crude",
        category = "fluid-smelting",
        subgroup = "vulcanus-processes",
        order = "a[melting]-b[iron-plate]",
        enabled = true,
        ingredients =
        {
            { type = "item", name = "iron-ore", amount = 1 },
            { type = "item", name = "calcite",  amount = 1 },
        },
        energy_required = 0.2,
        results =
        {
            { type = "item", name = "iron-plate", amount = 1 },
        },
        allow_productivity = true,
        hide_from_signal_gui = false,
        main_product = "iron-plate"
    },
    {
        type = "recipe",
        name = "molten-iron-2",
        category = "fluid-smelting",
        subgroup = "vulcanus-processes",
        order = "a[melting]-b[molten-iron]",
        enabled = true,
        ingredients =
        {
            { type = "item", name = "iron-ore", amount = 1 },
            { type = "item", name = "calcite",  amount = 1 },
        },
        energy_required = 0.2,
        results =
        {
            { type = "fluid", name = "molten-iron", amount = 20 },
        },
        allow_productivity = true,
        hide_from_signal_gui = false,
        main_product = "molten-iron"
    },
    {
        type = "recipe",
        name = "molten-copper-crude",
        category = "fluid-smelting",
        subgroup = "vulcanus-processes",
        order = "a[melting]-b[copper-plate]",
        enabled = true,
        ingredients =
        {
            { type = "item", name = "copper-ore", amount = 1 },
            { type = "item", name = "calcite",    amount = 1 },
        },
        energy_required = 0.2,
        results =
        {
            { type = "item", name = "copper-plate", amount = 1 },
        },
        allow_productivity = true,
        hide_from_signal_gui = false,
        main_product = "copper-plate"
    },
    {
        type = "recipe",
        name = "molten-copper-2",
        category = "fluid-smelting",
        subgroup = "vulcanus-processes",
        order = "a[melting]-b[molten-copper]",
        enabled = true,
        ingredients =
        {
            { type = "item", name = "copper-ore", amount = 1 },
            { type = "item", name = "calcite",    amount = 1 },
        },
        energy_required = 0.2,
        results =
        {
            { type = "fluid", name = "molten-copper", amount = 20 },
        },
        allow_productivity = true,
        hide_from_signal_gui = false,
        main_product = "molten-copper"
    },
    {
        type = "recipe",
        name = "molten-steel-crude",
        category = "fluid-smelting",
        subgroup = "vulcanus-processes",
        order = "a[melting]-b[steel-plate]",
        enabled = true,
        ingredients =
        {
            { type = "item", name = "iron-ore", amount = 2 },
            { type = "item", name = "calcite",  amount = 1 },
            { type = "item", name = "coal",     amount = 1 },
        },
        energy_required = 0.2,
        results =
        {
            { type = "item", name = "steel-plate", amount = 1 },
        },
        allow_productivity = true,
        hide_from_signal_gui = false,
        main_product = "steel-plate"
    },
    {
        type = "recipe",
        name = "molten-steel",
        category = "fluid-smelting",
        subgroup = "vulcanus-processes",
        order = "a[melting]-b[molten-steel]",
        enabled = true,
        ingredients =
        {
            { type = "item", name = "iron-ore", amount = 1 },
            { type = "item", name = "calcite",  amount = 1 },
            { type = "item", name = "carbon",   amount = 1 },
        },
        energy_required = 0.2,
        results =
        {
            { type = "fluid", name = "molten-steel", amount = 20 },
        },
        allow_productivity = true,
        hide_from_signal_gui = false,
        main_product = "molten-steel"
    },
    {
        type = "recipe",
        name = "casting-steel-2",
        category = "metallurgy",
        subgroup = "vulcanus-processes",
        order = "b[casting]-c[casting-steel]",
        icon = "__space-age__/graphics/icons/casting-steel.png",
        enabled = true,
        ingredients =
        {
            { type = "fluid", name = "molten-steel", amount = 30, fluidbox_multiplier = 10 }
        },
        energy_required = 3.2,
        allow_decomposition = false,
        results = { { type = "item", name = "steel-plate", amount = 1 } },
        allow_productivity = true
    },
    {
        type = "recipe",
        name = "stone-from-lava",
        icon = "__space-age__/graphics/icons/fluid/molten-copper-from-lava.png",
        category = "fluid-smelting",
        subgroup = "vulcanus-processes",
        order = "a[melting]-a[lava-a]",
        auto_recycle = false,
        enabled = true,
        ingredients =
        {
          {type = "item", name = "calcite", amount = 1},
        },
        energy_required = 1,
        results =
        {
          {type = "item", name = "stone", amount = 30},
        },
        allow_productivity = true
      },
})
