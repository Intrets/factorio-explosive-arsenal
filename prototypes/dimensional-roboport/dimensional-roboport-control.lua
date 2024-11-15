require("util.table")
require("util.math")
require("util.vector")

local dimensional_builder_range = 30

local dimensional_receiver_table = nil
local dimensional_accumulator_table = nil
local ghosts_table = nil

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

        local process_dimensional_accumulator = function(accumulator)
            if accumulator.valid then
                if accumulator.energy >= 5000000000 then
                    accumulator_charged = true
                end
                accumulator_charged = true

                accumulator.energy = 0
                return true
            else
                return false
            end
        end

        for surface_index, accumulators in pairs(dimensional_accumulator_table) do
            rvector.filter(accumulators, process_dimensional_accumulator)
        end


        if accumulator_charged then
            local process_dimensional_receiver = function(receiver)
                if receiver.valid then
                    if receiver.energy >= receiver.power_usage then
                        powered_surfaces[receiver.surface_index] = true
                    end
                    return true
                else
                    return false
                end
            end

            for surface_index, receivers in pairs(dimensional_receiver_table) do
                rvector.filter(receivers, process_dimensional_receiver)
            end

            for surface_index, ghosts in pairs(ghosts_table) do
                if powered_surfaces[surface_index] ~= nil and ghosts.end_index ~= 0 then
                    local end_index = ghosts.end_index
                    local current_index = (ghosts.current_index or 0) % end_index
                    local elements = ghosts.elements

                    local count = math.min(end_index - 1, 10)

                    for i = 0, count do
                        local ghost = elements[current_index]

                        if ghost.valid then
                            local entity_position = ghost.position
                            local lightning_position = rmath.sub_vec2(entity_position, rmath.vec2(0, 25))
                            local collisions, created_entity, item_request_proxy = ghost.revive()
                            if created_entity ~= nil then
                                game.surfaces[surface_index].create_entity { name = "lightning", position = lightning_position }

                                end_index = end_index - 1
                                elements[i] = elements[end_index]
                                elements[end_index] = nil
                            else
                                current_index = current_index + 1
                            end
                        else
                            end_index = end_index - 1
                            elements[i] = elements[end_index]
                            elements[end_index] = nil
                        end

                        current_index = current_index % end_index
                    end

                    ghosts.end_index = end_index
                    ghosts.current_index = current_index
                end
            end
        end
    end
)
