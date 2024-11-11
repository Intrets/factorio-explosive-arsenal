data:extend({
    {
        type = "fluid",
        name = "concrete-fluid",
        icon = "__rework__/graphics/icons/concrete-fluid.png",
        subgroup = "fluid",
        order = "b[new-fluid]-b[concrete-fluid]",
        default_temperature = 20,
        max_temperature = 100,
        heat_capacity = "0.01kJ",
        base_color = { 0.3, 0.3, 0.3 },
        flow_color = { 0.3, 0.3, 0.3 },
        auto_barrel = false
    },
    {
        type = "recipe",
        name = "concrete-fluid",
        category = "crafting-with-fluid",
        enabled = true,
        ingredients =
        {
            { type = "item",  name = "calcite", amount = 1 },
            { type = "item",  name = "stone",   amount = 1 },
            { type = "fluid", name = "water",   amount = 100 }

        },
        energy_required = 0.2,
        results =
        {
            { type = "fluid", name = "concrete-fluid", amount = 1 },
        },
        allow_productivity = true,
        hide_from_signal_gui = false,
        main_product = "concrete-fluid"
    },
})
