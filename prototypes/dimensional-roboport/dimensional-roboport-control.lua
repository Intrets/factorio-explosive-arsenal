require("util.table")
require("util.math")
require("util.vector")

local dimensional_builder_range = 30

rework_control.on_event(
    "dimensional roboport",
    defines.events.on_surface_created,
    function(event)
        storage.dimensional_builder_surface_storage[event.surface_index] = {}
    end
)

rework_control.on_event(
    "dimensional roboport",
    defines.events.on_surface_deleted,
    function(event)
        local new_storage = {}
        for key, surface_storage in pairs(storage.dimensional_builder_surface_storage) do
            if key ~= event.surface_index then
                new_storage[key] = surface_storage
            end
        end

        storage.dimensional_builder_surface_storage = new_storage
    end
)


local function get_dimensional_builder(surface, position)
    local surface_storage = storage.dimensional_builder_surface_storage[surface.index]

    local builder_points = surface.find_entities_filtered { name = "roboport", area = rmath.bounding_box_from_position_and_size(position, rmath.vec2(dimensional_builder_range * 2, dimensional_builder_range * 2)) }

    if builder_points[1] ~= nil then
        return rtable.table_get_or_init(surface_storage, builder_points[1].unit_number, rvector.make())
    else
        return nil
    end
end

local function add_ghost_to_builder(ghost, builder)
    rvector.push_back(builder, ghost)
end

rework_control.on_init("dimensional roboport",
    function()
        storage.dimensional_builder_surface_storage = {}
    end
)

rework_control.on_event(
    "dimensional roboport on build",
    defines.events.on_built_entity,
    function(event)
        if event.entity.type == "entity-ghost" then
            local builder = get_dimensional_builder(event.entity.surface, event.entity.position)
            if builder ~= nil then
                add_ghost_to_builder(event.entity, builder)
            end

            -- table.insert(storage.test, event.entity)
        end
    end
)

rework_control.on_event(
    "dimensional roboport testing",
    defines.events.on_tick,
    function(event)
        local accumulators = game.surfaces[2].find_entities_filtered { name = "dimensional-accumulator" }
        local trigger_count = 0
        if accumulators[1] ~= nil then
            local accumulator = accumulators[1]
            trigger_count = math.floor(accumulator.energy / 5000000000)
            accumulator.energy = 0
        end

        for i = 1, trigger_count do
            for surface_index, surface_builders in pairs(storage.dimensional_builder_surface_storage) do
                for _, builder in pairs(surface_builders) do
                    if builder.end_index ~= 1 then
                        a = 1
                    end

                    while not rvector.is_empty(builder) do
                        local ghost = rvector.pop_random(builder)
                        if ghost ~= nil and ghost.valid then
                            local entity_position = ghost.position
                            local lightning_position = rmath.sub_vec2(entity_position, rmath.vec2(0, 25))
                            local collisions, created_entity, item_request_proxy = ghost.revive()

                            if created_entity ~= nil then
                                game.surfaces[surface_index].create_entity { name = "lightning", position = lightning_position }
                                goto stop
                            end
                        end
                    end
                end
            end
        end

        ::stop::
    end
)
