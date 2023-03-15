dofile("data/scripts/lib/mod_settings.lua") -- see this file for documentation on some of the features.

function mod_setting_bool_custom( mod_id, gui, in_main_menu, im_id, setting )
	local value = ModSettingGetNextValue( mod_setting_get_id(mod_id,setting) )
	local text = setting.ui_name .. " - " .. GameTextGet( value and "$option_on" or "$option_off" )

	if GuiButton( gui, im_id, mod_setting_group_x_offset, 0, text ) then
		ModSettingSetNextValue( mod_setting_get_id(mod_id,setting), not value, false )
	end

	mod_setting_tooltip( mod_id, gui, in_main_menu, setting )
end

function mod_setting_change_callback( mod_id, gui, in_main_menu, setting, old_value, new_value  )
	print( tostring(new_value) )
end

local mod_id = "wand_finder"
mod_settings_version = 1 
mod_settings = 
{
	{
		category_id = "group_of_settings",
		ui_name = "Wand Finder Settings",
		settings = {
			{
				id = "stat_show",
				ui_name = "Stat Display",
				ui_description = "What Stat to show/check",
				value_default = "deck_capacity",
				values = {
					{"deck_capacity","Capacity"},
					{"actions_per_round","Spells Per Cast"},
					{"reload_time","Recharge"},
					{"shuffle_deck_when_empty","Shuffle"},
					{"fire_rate_wait","Cast Delay"},
					{"spread_degrees","Spread"},
					{"speed_multiplier","Speed"},
					{"mana_charge_speed","Mana Charge Speed"},
					{"mana_max","Max Mana"},
					{"is_rare","Is Rare"}
				},
				scope = MOD_SETTING_SCOPE_RUNTIME,
			},
			{
				id = "search_offset_x",
				ui_name = "Offset X",
				ui_description = "Offset the search by X amount.",
				value_default = "0",
				text_max_length = 25,
				allowed_characters = "-0123456789",
				scope = MOD_SETTING_SCOPE_RUNTIME,
			},
			{
				id = "search_offset_y",
				ui_name = "Offset Y",
				ui_description = "Offset the search by Y amount.",
				value_default = "0",
				text_max_length = 25,
				allowed_characters = "-0123456789",
				scope = MOD_SETTING_SCOPE_RUNTIME,
			},
			{
				id = "search_skiper",
				ui_name = "Fast Search",
				ui_description = "Faster Search Feature. WARNING A LITTLE LAGGY",
				value_default = false,
				scope = MOD_SETTING_SCOPE_RUNTIME,
			},
			{
				id = "fill_list",
				ui_name = "Fill List",
				ui_description = "Will never ask for your input. WARNING VERY LAGGY! PRESS ESC TO STOP THIS BEFORE NEXT SEARCH BEGINS!",
				value_default = false,
				scope = MOD_SETTING_SCOPE_RUNTIME,
			},
			{
				id = "search_skippper",
				ui_name = "Fast Search Amount",
				ui_description = "USE WITH CATION. Amount of searchs Fast Search will do.",
				value_default = 10,
				value_min = 2,
				value_max = 20,
				value_display_formatting = " $0 Scans",
				scope = MOD_SETTING_SCOPE_RUNTIME,
			},
			{
				id = "wand_lvl",
				ui_name = "Wand Tier",
				ui_description = "What tier of wand",
				value_default = "10",
				values = {
					{"2","Tier 2"},
					{"3","Tier 3"},
					{"4","Tier 4"},
					{"5","Tier 5"},
					{"6","Tier 6"},
					{"10","Tier 10"},
				},
				scope = MOD_SETTING_SCOPE_RUNTIME,
			},
			{
				id = "unshuffle",
				ui_name = "Force Unshuffle",
				ui_description = "Unshuffle or not",
				value_default = true,
				scope = MOD_SETTING_SCOPE_RUNTIME,
			},
			{
				category_id = "sub_group_of_settings",
				ui_name = "Normal List",
				ui_description = "Multiple settings that randomly change the effect values.",
				foldable = true,
				_folded = true,
				settings = {
					{
						id = "norm_list_filt",
						ui_name = "Normal List Filter",
						ui_description = "Filters wands from entering the normal list",
						value_default = true,
					},
					{
						id = "norm_list_value",
						ui_name = "Filter Value",
						ui_description = "Controls the normal list",
						value_default = "26",
						text_max_length = 5,
						allowed_characters = "-.0123456789",
						scope = MOD_SETTING_SCOPE_RUNTIME,
					},
					{
						id = "norm_list_type",
						ui_name = "Filter Compare",
						ui_description = "How should we compare these values",
						value_default = "0",
						values = {
							{"0","Greater Than"},
							{"1","Less Than or Equal To"},
						},
						scope = MOD_SETTING_SCOPE_RUNTIME,
					},
				}
			},
			{
				category_id = "sub_group_of_settings",
				ui_name = "Better List",
				ui_description = "Multiple settings that randomly change the effect values.",
				foldable = true,
				_folded = true,
				settings = {
					{
						id = "checker_value",
						ui_name = "Better List Value",
						ui_description = "Controls the Better List",
						value_default = "26",
						text_max_length = 5,
						allowed_characters = "-.0123456789",
						scope = MOD_SETTING_SCOPE_RUNTIME,
					},
					{
						id = "checker_type",
						ui_name = "Better List Compare",
						ui_description = "How should we compare these values",
						value_default = "0",
						values = {
							{"0","Greater Than"},
							{"1","Less Than or Equal To"},
						},
						scope = MOD_SETTING_SCOPE_RUNTIME,
					},
				}
			}
		}
	}
}

function ModSettingsUpdate( init_scope )
	local old_version = mod_settings_get_version( mod_id )
	mod_settings_update( mod_id, mod_settings, init_scope )
end

function ModSettingsGuiCount()
	return mod_settings_gui_count( mod_id, mod_settings )
end

function ModSettingsGui( gui, in_main_menu )
	mod_settings_gui( mod_id, mod_settings, gui, in_main_menu )
end
