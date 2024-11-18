local names = {
    [defines.events.on_achievement_gained] = "on_achievement_gained",
    [defines.events.on_ai_command_completed] = "on_ai_command_completed",
    [defines.events.on_area_cloned] = "on_area_cloned",
    [defines.events.on_biter_base_built] = "on_biter_base_built",
    [defines.events.on_brush_cloned] = "on_brush_cloned",
    [defines.events.on_build_base_arrived] = "on_build_base_arrived",
    [defines.events.on_built_entity] = "on_built_entity",
    [defines.events.on_cancelled_deconstruction] = "on_cancelled_deconstruction",
    [defines.events.on_cancelled_upgrade] = "on_cancelled_upgrade",
    [defines.events.on_character_corpse_expired] = "on_character_corpse_expired",
    [defines.events.on_chart_tag_added] = "on_chart_tag_added",
    [defines.events.on_chart_tag_modified] = "on_chart_tag_modified",
    [defines.events.on_chart_tag_removed] = "on_chart_tag_removed",
    [defines.events.on_chunk_charted] = "on_chunk_charted",
    [defines.events.on_chunk_deleted] = "on_chunk_deleted",
    [defines.events.on_chunk_generated] = "on_chunk_generated",
    [defines.events.on_combat_robot_expired] = "on_combat_robot_expired",
    [defines.events.on_console_chat] = "on_console_chat",
    [defines.events.on_console_command] = "on_console_command",
    [defines.events.on_cutscene_cancelled] = "on_cutscene_cancelled",
    [defines.events.on_cutscene_finished] = "on_cutscene_finished",
    [defines.events.on_cutscene_started] = "on_cutscene_started",
    [defines.events.on_cutscene_waypoint_reached] = "on_cutscene_waypoint_reached",
    [defines.events.on_entity_cloned] = "on_entity_cloned",
    [defines.events.on_entity_color_changed] = "on_entity_color_",
    [defines.events.on_entity_damaged] = "on_entity_damaged",
    [defines.events.on_entity_died] = "on_entity_died",
    [defines.events.on_entity_logistic_slot_changed] = "on_entity_logistic_slot_changed",
    [defines.events.on_entity_renamed] = "on_entity_renamed",
    [defines.events.on_entity_settings_pasted] = "on_entity_settings_pasted",
    [defines.events.on_entity_spawned] = "on_entity_spawned",
    [defines.events.on_equipment_inserted] = "on_equipment_inserted",
    [defines.events.on_equipment_removed] = "on_equipment_removed",
    [defines.events.on_force_cease_fire_changed] = "on_force_cease_fire_",
    [defines.events.on_force_created] = "on_force_created",
    [defines.events.on_force_friends_changed] = "on_force_friends_",
    [defines.events.on_force_reset] = "on_force_reset",
    [defines.events.on_forces_merged] = "on_forces_merged",
    [defines.events.on_forces_merging] = "on_forces_merging",
    [defines.events.on_game_created_from_scenario] = "on_game_created_from_scenario",
    [defines.events.on_gui_checked_state_changed] = "on_gui_checked_state_",
    [defines.events.on_gui_click] = "on_gui_click",
    [defines.events.on_gui_closed] = "on_gui_closed",
    [defines.events.on_gui_confirmed] = "on_gui_confirmed",
    [defines.events.on_gui_elem_changed] = "on_gui_elem_changed	",
    [defines.events.on_gui_hover] = "on_gui_hover",
    [defines.events.on_gui_leave] = "on_gui_leave",
    [defines.events.on_gui_location_changed] = "on_gui_location_",
    [defines.events.on_gui_opened] = "on_gui_opened",
    [defines.events.on_gui_selected_tab_changed] = "on_gui_selected_tab_",
    [defines.events.on_gui_selection_state_changed] = "on_gui_selection_state_",
    [defines.events.on_gui_switch_state_changed] = "on_gui_switch_state_",
    [defines.events.on_gui_text_changed] = "on_gui_text_",
    [defines.events.on_gui_value_changed] = "on_gui_value_",
    [defines.events.on_land_mine_armed] = "on_land_mine_armed",
    [defines.events.on_lua_shortcut] = "on_lua_shortcut",
    [defines.events.on_marked_for_deconstruction] = "on_marked_for_deconstruction",
    [defines.events.on_marked_for_upgrade] = "on_marked_for_upgrade",
    [defines.events.on_market_item_purchased] = "on_market_item_purchased",
    [defines.events.on_mod_item_opened] = "on_mod_item_opened",
    [defines.events.on_object_destroyed] = "on_object_destroyed",
    [defines.events.on_permission_group_added] = "on_permission_group_added",
    [defines.events.on_permission_group_deleted] = "on_permission_group_deleted",
    [defines.events.on_permission_group_edited] = "on_permission_group_edited",
    [defines.events.on_permission_string_imported] = "on_permission_string_imported",
    [defines.events.on_picked_up_item] = "on_picked_up_item",
    [defines.events.on_player_alt_reverse_selected_area] = "on_player_alt_reverse_selected_area",
    [defines.events.on_player_alt_selected_area] = "on_player_alt_selected_area",
    [defines.events.on_player_ammo_inventory_changed] = "on_player_ammo_inventory_",
    [defines.events.on_player_armor_inventory_changed] = "on_player_armor_inventory_",
    [defines.events.on_player_banned] = "on_player_banned",
    [defines.events.on_player_built_tile] = "on_player_built_tile",
    [defines.events.on_player_cancelled_crafting] = "on_player_cancelled_crafting",
    [defines.events.on_player_changed_force] = "on_player_changed_force",
    [defines.events.on_player_changed_position] = "on_player_changed_position",
    [defines.events.on_player_changed_surface] = "on_player_changed_surface",
    [defines.events.on_player_cheat_mode_disabled] = "on_player_cheat_mode_disabled",
    [defines.events.on_player_cheat_mode_enabled] = "on_player_cheat_mode_enabled",
    [defines.events.on_player_clicked_gps_tag] = "on_player_clicked_gps_tag",
    [defines.events.on_player_configured_blueprint] = "on_player_configured_blueprint",
    [defines.events.on_player_controller_changed] = "on_player_controller_",
    [defines.events.on_player_crafted_item] = "on_player_crafted_item",
    [defines.events.on_player_created] = "on_player_created",
    [defines.events.on_player_cursor_stack_changed] = "on_player_cursor_stack_",
    [defines.events.on_player_deconstructed_area] = "on_player_deconstructed_area",
    [defines.events.on_player_demoted] = "on_player_demoted",
    [defines.events.on_player_died] = "on_player_died",
    [defines.events.on_player_display_density_scale_changed] = "on_player_display_density_scale_",
    [defines.events.on_player_display_resolution_changed] = "on_player_display_resolution_",
    [defines.events.on_player_display_scale_changed] = "on_player_display_scale_",
    [defines.events.on_player_driving_changed_state] = "on_player_driving_changed_state",
    [defines.events.on_player_dropped_item] = "on_player_dropped_item",
    [defines.events.on_player_fast_transferred] = "on_player_fast_transferred",
    [defines.events.on_player_flipped_entity] = "on_player_flipped_entity",
    [defines.events.on_player_flushed_fluid] = "on_player_flushed_fluid",
    [defines.events.on_player_gun_inventory_changed] = "on_player_gun_inventory_",
    [defines.events.on_player_input_method_changed] = "on_player_input_method_",
    [defines.events.on_player_joined_game] = "on_player_joined_game",
    [defines.events.on_player_kicked] = "on_player_kicked",
    [defines.events.on_player_left_game] = "on_player_left_game",
    [defines.events.on_player_locale_changed] = "on_player_locale_",
    [defines.events.on_player_main_inventory_changed] = "on_player_main_inventory_",
    [defines.events.on_player_mined_entity] = "on_player_mined_entity",
    [defines.events.on_player_mined_item] = "on_player_mined_item",
    [defines.events.on_player_mined_tile] = "on_player_mined_tile",
    [defines.events.on_player_muted] = "on_player_muted",
    [defines.events.on_player_pipette] = "on_player_pipette",
    [defines.events.on_player_placed_equipment] = "on_player_placed_equipment",
    [defines.events.on_player_promoted] = "on_player_promoted",
    [defines.events.on_player_removed] = "on_player_removed",
    [defines.events.on_player_removed_equipment] = "on_player_removed_equipment",
    [defines.events.on_player_repaired_entity] = "on_player_repaired_entity",
    [defines.events.on_player_respawned] = "on_player_respawned",
    [defines.events.on_player_reverse_selected_area] = "on_player_reverse_selected_area",
    [defines.events.on_player_rotated_entity] = "on_player_rotated_entity",
    [defines.events.on_player_selected_area] = "on_player_selected_area",
    [defines.events.on_player_set_quick_bar_slot] = "on_player_set_quick_bar_slot",
    [defines.events.on_player_setup_blueprint] = "on_player_setup_blueprint",
    [defines.events.on_player_toggled_alt_mode] = "on_player_toggled_alt_mode",
    [defines.events.on_player_toggled_map_editor] = "on_player_toggled_map_editor",
    [defines.events.on_player_trash_inventory_changed] = "on_player_trash_inventory_",
    [defines.events.on_player_unbanned] = "on_player_unbanned",
    [defines.events.on_player_unmuted] = "on_player_unmuted",
    [defines.events.on_player_used_capsule] = "on_player_used_capsule",
    [defines.events.on_player_used_spidertron_remote] = "on_player_used_spidertron_remote",
    [defines.events.on_post_entity_died] = "on_post_entity_died",
    [defines.events.on_pre_build] = "on_pre_build",
    [defines.events.on_pre_chunk_deleted] = "on_pre_chunk_deleted",
    [defines.events.on_pre_entity_settings_pasted] = "on_pre_entity_settings_pasted",
    [defines.events.on_pre_ghost_deconstructed] = "on_pre_ghost_deconstructed",
    [defines.events.on_pre_ghost_upgraded] = "on_pre_ghost_upgraded",
    [defines.events.on_pre_permission_group_deleted] = "on_pre_permission_group_deleted",
    [defines.events.on_pre_permission_string_imported] = "on_pre_permission_string_imported",
    [defines.events.on_pre_player_crafted_item] = "on_pre_player_crafted_item",
    [defines.events.on_pre_player_died] = "on_pre_player_died",
    [defines.events.on_pre_player_left_game] = "on_pre_player_left_game",
    [defines.events.on_pre_player_mined_item] = "on_pre_player_mined_item",
    [defines.events.on_pre_player_removed] = "on_pre_player_removed",
    [defines.events.on_pre_player_toggled_map_editor] = "on_pre_player_toggled_map_editor",
    [defines.events.on_pre_robot_exploded_cliff] = "on_pre_robot_exploded_cliff",
    [defines.events.on_pre_scenario_finished] = "on_pre_scenario_finished",
    [defines.events.on_pre_script_inventory_resized] = "on_pre_script_inventory_resized",
    [defines.events.on_pre_surface_cleared] = "on_pre_surface_cleared",
    [defines.events.on_pre_surface_deleted] = "on_pre_surface_deleted",
    [defines.events.on_redo_applied] = "on_redo_applied",
    [defines.events.on_research_cancelled] = "on_research_cancelled",
    [defines.events.on_research_finished] = "on_research_finished",
    [defines.events.on_research_moved] = "on_research_moved",
    [defines.events.on_research_reversed] = "on_research_reversed",
    [defines.events.on_research_started] = "on_research_started",
    [defines.events.on_resource_depleted] = "on_resource_depleted",
    [defines.events.on_robot_built_entity] = "on_robot_built_entity",
    [defines.events.on_robot_built_tile] = "on_robot_built_tile",
    [defines.events.on_robot_exploded_cliff] = "on_robot_exploded_cliff",
    [defines.events.on_robot_mined] = "on_robot_mined",
    [defines.events.on_robot_mined_entity] = "on_robot_mined_entity",
    [defines.events.on_robot_mined_tile] = "on_robot_mined_tile",
    [defines.events.on_robot_pre_mined] = "on_robot_pre_mined",
    [defines.events.on_rocket_launch_ordered] = "on_rocket_launch_ordered",
    [defines.events.on_rocket_launched] = "on_rocket_launched",
    [defines.events.on_runtime_mod_setting_changed] = "on_runtime_mod_setting_",
    [defines.events.on_script_inventory_resized] = "on_script_inventory_resized",
    [defines.events.on_script_path_request_finished] = "on_script_path_request_finished",
    [defines.events.on_script_trigger_effect] = "on_script_trigger_effect",
    [defines.events.on_sector_scanned] = "on_sector_scanned",
    [defines.events.on_segment_entity_created] = "on_segment_entity_created",
    [defines.events.on_selected_entity_changed] = "on_selected_entity_changed",
    [defines.events.on_space_platform_built_entity] = "on_space_platform_built_entity",
    [defines.events.on_space_platform_built_tile] = "on_space_platform_built_tile",
    [defines.events.on_space_platform_changed_state] = "on_space_platform_changed_state",
    [defines.events.on_space_platform_mined_entity] = "on_space_platform_mined_entity",
    [defines.events.on_space_platform_mined_item] = "on_space_platform_mined_item",
    [defines.events.on_space_platform_mined_tile] = "on_space_platform_mined_tile",
    [defines.events.on_space_platform_pre_mined] = "on_space_platform_pre_mined",
    [defines.events.on_spider_command_completed] = "on_spider_command_completed",
    [defines.events.on_string_translated] = "on_string_translated",
    [defines.events.on_surface_cleared] = "on_surface_cleared",
    [defines.events.on_surface_created] = "on_surface_created",
    [defines.events.on_surface_deleted] = "on_surface_deleted",
    [defines.events.on_surface_imported] = "on_surface_imported",
    [defines.events.on_surface_renamed] = "on_surface_renamed",
    [defines.events.on_technology_effects_reset] = "on_technology_effects_reset",
    [defines.events.on_tick] = "on_tick",
    [defines.events.on_train_changed_state] = "on_train_changed_state",
    [defines.events.on_train_created] = "on_train_created",
    [defines.events.on_train_schedule_changed] = "on_train_schedule_",
    [defines.events.on_trigger_created_entity] = "on_trigger_created_entity",
    [defines.events.on_trigger_fired_artillery] = "on_trigger_fired_artillery",
    [defines.events.on_undo_applied] = "on_undo_applied",
    [defines.events.on_unit_added_to_group] = "on_unit_added_to_group",
    [defines.events.on_unit_group_created] = "on_unit_group_created",
    [defines.events.on_unit_group_finished_gathering] = "on_unit_group_finished_gathering",
    [defines.events.on_unit_removed_from_group] = "on_unit_removed_from_group",
    [defines.events.on_worker_robot_expired] = "on_worker_robot_expired",
    [defines.events.script_raised_built] = "script_raised_built",
    [defines.events.script_raised_destroy] = "script_raised_destroy",
    [defines.events.script_raised_revive] = "script_raised_revive",
    [defines.events.script_raised_set_tiles] = "script_raised_set_tiles",
    [defines.events.script_raised_teleported] = "script_raised_teleported",
}

local filtered_events = {
    [defines.events.on_tick] = true,
    [defines.events.on_chunk_generated] = true,
    [defines.events.on_surface_created] = true,
    [defines.events.on_entity_damaged] = true,
    [defines.events.on_segment_entity_created] = true,
    [defines.events.on_chunk_charted] = true,
    [defines.events.on_player_changed_position] = true,
    [defines.events.on_entity_spawned] = true,
    [defines.events.on_entity_died] = true,
    [defines.events.on_selected_entity_changed] = true,
}

local debug_string = ""


local function test()
    if #debug_string ~= 0 then
        game.print(game.tick .. ": " .. debug_string, { skip = defines.print_skip.never })
        debug_string = ""
    end
end


local function enable_catch_all_events()
    for _, event_index in pairs(defines.events) do
        rework_control.on_event("catching all events", event_index, function(event)
            if event_index == defines.events.on_robot_mined then
                a = 1
            end
            if not filtered_events[event_index] then
                local name = names[event_index]
                if #name == 0 then
                    debug_string = debug_string .. "UNKNOWN" .. ", "
                else
                    debug_string = debug_string .. name .. ", "
                end
            end
        end)
    end

    rework_control.on_event("catching all events", defines.events.on_tick, function(event)
        test()
    end)
end

local function disable_catch_all_events()
    rework_control.remove_on_event("catching all events", defines.events.on_tick)
    for _, event_index in pairs(defines.events) do
        rework_control.remove_on_event("catching all events", event_index)
    end
end

local enabled = false

rework_control.on_event(
    "run reset test",
    "toggle-debug-catch-all-events",
    function(event)
        if enabled then
            disable_catch_all_events()
            enabled = false
        game.print("disabled")
        else
            enable_catch_all_events()
            enabled = true
        game.print("enabled")
        end
    end)
