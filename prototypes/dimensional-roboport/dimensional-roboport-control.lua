require("util.table")
require("util.math")
require("util.vector")

local dimensional_builder_range = 30

local dimensional_receiver_table = nil
local dimensional_accumulator_table = nil
local ghosts_table = nil

local function process_dimensional_accumulator(entity)
    if entity.energy >= 5000000000 then
        entity.energy = 0
        return true
    else
        entity.energy = 0
        return false
    end
end

local function process_dimensional_receiver(entity)
    return entity.energy >= entity.power_usage
end

rework_control.add_setup(
    "dimensional receivers",
    function()
        dimensional_receiver_table = rework_control.track_entities("dimensional receivers", "dimensional-receiver")
        dimensional_accumulator_table = rework_control.track_entities("dimensional accumulators", "dimensional-accumulator")
        ghosts_table = rework_control.track_entities("ghosts", "entity-ghost")
    end
)

rework_control.on_event(
    "dimensional roboport testing",
    defines.events.on_tick,
    function(event)
        local powered_surfaces = {}

        local accumulator_charged = false

        for surface_index, accumulators in pairs(dimensional_accumulator_table) do
            for key, accumulator in pairs(accumulators) do
                if accumulator.valid then
                    if process_dimensional_accumulator(accumulator) then
                        accumulator_charged = true
                    end
                else
                    accumulators[key] = nil
                end
            end
        end

        if accumulator_charged then
            for surface_index, receivers in pairs(dimensional_receiver_table) do
                for key, receiver in pairs(receivers) do
                    if receiver.valid then
                        if process_dimensional_receiver(receiver) then
                            powered_surfaces[surface_index] = true
                        end
                    else
                        receivers[key] = nil
                    end
                end
            end

            for surface_index, ghosts in pairs(ghosts_table) do
                if powered_surfaces[surface_index] ~= nil then
                    for key, ghost in pairs(ghosts) do
                        if ghost.valid then
                            local entity_position = ghost.position
                            local lightning_position = rmath.sub_vec2(entity_position, rmath.vec2(0, 25))
                            local collisions, created_entity, item_request_proxy = ghost.revive()
                            if created_entity ~= nil then
                                game.surfaces[surface_index].create_entity { name = "lightning", position = lightning_position }
                                goto stop
                            end
                        else
                            ghosts[key] = nil
                        end
                    end
                end
            end
        end
        ::stop::
    end
)
