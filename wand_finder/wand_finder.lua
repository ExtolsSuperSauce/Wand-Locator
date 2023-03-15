dofile_once("data/scripts/gun/procedural/gun_procedural.lua")
local show_stat = ModSettingGet("wand_finder.stat_show")
local function better_check(gun_stats)
	local value_to_check = tonumber(ModSettingGet("wand_finder.checker_value"))
	local to_do = tonumber(ModSettingGet("wand_finder.checker_type"))
	if to_do == 0 and gun_stats[show_stat] > value_to_check then
		table.insert(list_of_better_finds,gun_stats)
		better_found = true
	elseif to_do == 1 and gun_stats[show_stat] <= value_to_check then
		table.insert(list_of_better_finds,gun_stats)
		better_found = true
	end
end
local function norm_check(gun_stats)
	local value_to_check = tonumber(ModSettingGet("wand_finder.norm_list_value"))
	local to_do = tonumber(ModSettingGet("wand_finder.norm_list_type"))
	local send = false
	if to_do == 0 and gun_stats[show_stat] > value_to_check then
		send = true
	elseif to_do == 1 and gun_stats[show_stat] <= value_to_check then
		send = true
	end
	return send
end
list_of_errors = list_of_errors or {}
list_of_better_finds = list_of_better_finds or {}
better_found = better_found or false
error_bool = error_bool or false
list_bool = list_bool or false
better_bool = better_bool or false
list_of_finds = list_of_finds or {}
gui = gui or GuiCreate()
local gui_x, gui_y = GuiGetScreenDimensions(gui)
GuiStartFrame(gui)
local button_text = "wand list"
if list_bool then
	button_text = "<"..button_text
else
	button_text = ">"..button_text
end
local list_clicked = GuiButton( gui, 421, gui_x - 60, 328, button_text)
if list_clicked then
	if list_bool then
		list_bool = false
	else
		list_bool = true
	end
end
page_handler = page_handler or 0
if list_bool then
	if error_bool then
		if (page_handler + 1) * 35 < #list_of_errors then
			local end_page = GuiButton( gui, 426, gui_x/2 + 50, 328, "->>")
			if end_page then page_handler = math.floor(#list_of_errors/35) end
		elseif page_handler > 0 then
			local end_page = GuiButton( gui, 426, gui_x/2 + 50, 328, "<<-")
			if end_page then page_handler = 0 end
		end
		local list_count = 0
		for i, gun in ipairs(list_of_errors) do
			local page_wait = i <= page_handler * 35
			if not page_wait then
				if i > (page_handler + 1) * 35 then
					local next_page = GuiButton( gui, 422, gui_x/2 + 32, 328, "->")
					if next_page then page_handler = page_handler + 1 end
					break
				end
				list_count = list_count + 1
				local gun_info = gun["pos_x"] .. ", " .. gun["pos_y"]
				local gun_tier = gun["tier"]
				GuiText( gui, gui_x /2, 40 + (list_count * 8), "Pos: " .. gun_info .. " Tier: " .. gun_tier)
				local load_click = GuiButton( gui, 429 + i, gui_x/2 - 18, 40 + (list_count * 8), "[x]")
				if load_click then
					local temp_tier = 0
					if gun["tier"] < 10 then
						temp_tier = "0" .. gun["tier"]
					else
						temp_tier = 10
					end
					if gun["is_unshuf"] then
						local spawned = EntityLoad( "data/entities/items/wand_unshuffle_" .. temp_tier .. ".xml",gun["pos_x"], gun["pos_y"])
						local player = GetUpdatedEntityID()
						local px, py = EntityGetTransform(player)
						EntityApplyTransform(spawned, px,py)
					else
						local spawned = EntityLoad( "data/entities/items/wand_level_" .. temp_tier .. ".xml",gun["pos_x"], gun["pos_y"])
						local player = GetUpdatedEntityID()
						local px, py = EntityGetTransform(player)
						EntityApplyTransform(spawned, px,py)
					end
				end
			end
		end
	elseif better_bool then
		if (page_handler + 1) * 35 < #list_of_better_finds then
			local end_page = GuiButton( gui, 426, gui_x/2 + 50, 328, "->>")
			if end_page then page_handler = math.floor(#list_of_better_finds/35) end
		elseif page_handler > 0 then
			local end_page = GuiButton( gui, 426, gui_x/2 + 50, 328, "<<-")
			if end_page then page_handler = 0 end
		end
		local list_count = 0
		for i, gun in ipairs(list_of_better_finds) do
			local page_wait = i <= page_handler * 35
			if not page_wait then
				if i > (page_handler + 1) * 35 then
					local next_page = GuiButton( gui, 422, gui_x/2 + 32, 328, "->")
					if next_page then page_handler = page_handler + 1 end
					break
				end
				list_count = list_count + 1
				local gun_info = gun["pos_x"] .. ", " .. gun["pos_y"] .. " Stat: " .. gun[show_stat]
				GuiText( gui, gui_x /2, 40 + (list_count * 8), gun_info)
				local load_click = GuiButton( gui, 429 + i, gui_x/2 - 18, 40 + (list_count * 8), "[x]")
				if load_click then
					local temp_tier = 0
					if gun["tier"] < 10 then
						temp_tier = "0" .. gun["tier"]
					else
						temp_tier = 10
					end
					if gun["is_unshuf"] then
						local spawned = EntityLoad( "data/entities/items/wand_unshuffle_" .. temp_tier .. ".xml",gun["pos_x"], gun["pos_y"])
						local player = GetUpdatedEntityID()
						local px, py = EntityGetTransform(player)
						EntityApplyTransform(spawned, px,py)
					else
						local spawned = EntityLoad( "data/entities/items/wand_level_" .. temp_tier .. ".xml",gun["pos_x"], gun["pos_y"])
						local player = GetUpdatedEntityID()
						local px, py = EntityGetTransform(player)
						EntityApplyTransform(spawned, px,py)
					end
				end
			end
		end
	else
		if (page_handler + 1) * 35 < #list_of_finds then
			local end_page = GuiButton( gui, 426, gui_x/2 + 50, 328, "->>")
			if end_page then page_handler = math.floor(#list_of_finds/35) end
		elseif page_handler > 0 then
			local end_page = GuiButton( gui, 426, gui_x/2 + 50, 328, "<<-")
			if end_page then page_handler = 0 end
		end
		local list_count = 0
		for i, gun in ipairs(list_of_finds) do
			local page_wait = i <= page_handler * 35
			if not page_wait then
				if i > (page_handler + 1) * 35 then
					local next_page = GuiButton( gui, 422, gui_x/2 + 32, 328, "->")
					if next_page then page_handler = page_handler + 1 end
					break
				end
				list_count = list_count + 1
				local gun_info = gun["pos_x"] .. ", " .. gun["pos_y"] .. " Stat: " .. gun[show_stat]
				GuiText( gui, gui_x /2, 40 + (list_count * 8), gun_info)
				local load_click = GuiButton( gui, 429 + i, gui_x/2 - 18, 40 + (list_count * 8), "[x]")
				if load_click then
					local temp_tier = 0
					if gun["tier"] < 10 then
						temp_tier = "0" .. gun["tier"]
					else
						temp_tier = 10
					end
					if gun["is_unshuf"] then
						local spawned = EntityLoad( "data/entities/items/wand_unshuffle_" .. temp_tier .. ".xml",gun["pos_x"], gun["pos_y"])
						local player = GetUpdatedEntityID()
						local px, py = EntityGetTransform(player)
						EntityApplyTransform(spawned, px,py)
					else
						local spawned = EntityLoad( "data/entities/items/wand_level_" .. temp_tier .. ".xml",gun["pos_x"], gun["pos_y"])
						local player = GetUpdatedEntityID()
						local px, py = EntityGetTransform(player)
						EntityApplyTransform(spawned, px,py)
					end
				end
			end
		end
	end
	if page_handler > 0 then
		local last_page = GuiButton( gui, 423, gui_x/2 + 8, 328, "<-")
		if last_page then page_handler = page_handler - 1 end
	end
	local refresh_button = GuiImageButton( gui, 424, gui_x/2, 32, "Refresh", "mods/wand_finder/refresh.png" )
	if refresh_button then
		waiting = false
		search_count = 0
		list_of_finds = {}
		pos_x = 0
		pos_y = 0
		search_skip = 0
		O_O_check = false
		wands_found = 0
		page_handler = 0
	end
	local better_image = "mods/wand_finder/better.png"
	local list_text = "BETTER WAND LIST"
	if better_bool then
		better_image = "mods/wand_finder/back.png"
		list_text = "BACK TO ALL WANDS"
	elseif better_found then
		better_image = "mods/wand_finder/better_found.png"
		list_text = "BETTER WAND FOUND!"
	end
	local better_button = GuiImageButton( gui, 425, gui_x/2, 15, list_text, better_image )
	if better_button and not better_bool then
		better_bool = true
		error_bool = false
		better_found = false
		page_handler = 0
	elseif better_button then
		better_bool = false
	end
	local bug_sprite = "mods/wand_finder/bugged.png"
	if error_bool then
		local rnd = Random(0,10)
		bug_sprite = "mods/wand_finder/bugged" .. rnd .. ".png"
	end
	local error_button = GuiImageButton( gui, 600, gui_x/2 + 60, 32, "ERROR WANDS", bug_sprite  )
	if error_button and not error_bool then
		better_bool = false
		error_bool = true
		page_handler = 0
	elseif error_button then
		error_bool = false
	end
end
pos_x, pos_y = pos_x or 0, pos_y or 0
local fast_search = ModSettingGet("wand_finder.search_skiper")
local fast_counter = math.floor(ModSettingGet("wand_finder.search_skippper") + 0.5)
wands_found = wands_found or 0
if fast_search and wands_found < fast_counter then
	waiting = false
elseif wands_found > fast_counter - 1 then
	waiting = true
end
waiting = waiting or false
if waiting then
	if #list_of_finds > 1700000 then
		GuiText( gui, gui_x/2, gui_y - 20, "LIST IS FULL! REFRESH & CHANGE OFFSET" )
	else
		local wait_text = "CLICK FOR NEXT SCAN"
		local clicked = GuiButton( gui, 420, gui_x/2, gui_y - 20, wait_text)
		if clicked then
			wands_found = 0
			waiting = false
		end
	end
	return
end
search_count = search_count or 8
search_skip = search_skip or 0
local mod_set_offset_x, mod_set_offset_y = tonumber(ModSettingGet("wand_finder.search_offset_x")), tonumber(ModSettingGet("wand_finder.search_offset_y"))
local state = 0
local amount = search_count / 4
local search_x, search_y = amount/2+mod_set_offset_x,amount/2+mod_set_offset_y
local tier_of_wand = tonumber(ModSettingGet("wand_finder.wand_lvl"))
local force_unshuffle = ModSettingGet("wand_finder.unshuffle")
O_O_check = O_O_check or false
if not O_O_check then
	O_O_check = true
	SetRandomSeed( mod_set_offset_x, mod_set_offset_y )
	local cost = tier_of_wand * 20
	if tier_of_wand >= 10 then
		tier_of_wand = 11
		if force_unshuffle then
			cost = 180
		end
	end
	local gun = get_gun_data( cost, tier_of_wand, force_unshuffle )
	if gun ~= nil then
		if ModSettingGet("wand_finder.norm_list_filt") then
			local good_enough = norm_check(gun)
			if good_enough then
				gun["pos_x"] = mod_set_offset_x
				gun["pos_y"] = mod_set_offset_y
				gun["tier"] = tier_of_wand
				gun["is_unshuf"] = force_unshuffle
				table.insert(list_of_finds,gun)
				better_check(gun)
			end
		else
			gun["pos_x"] = mod_set_offset_x
			gun["pos_y"] = mod_set_offset_y
			gun["tier"] = tier_of_wand
			gun["is_unshuf"] = force_unshuffle
			table.insert(list_of_finds,gun)
			better_check(gun)
		end
	end
end
for i = 1, search_count - 1 do
	if #list_of_finds > 1700000 then
		wands_found = wands_found + 100
		waiting = true
		return
	end
	SetRandomSeed( search_x, search_y )
	if search_skip == i then
		GamePrint("ERROR WAND AT: " .. search_x .. ", " .. search_y)
		local error_gun = {["pos_x"]=search_x,["pos_y"]=search_y,["tier"]=tier_of_wand}
		table.insert(list_of_errors,error_gun)
	end
	if search_skip < i then
		search_skip = i
		local cost = tier_of_wand * 20
		if tier_of_wand >= 10 then
			tier_of_wand = 11
			if force_unshuffle then
				cost = 180
			end
		end
		local gun = get_gun_data( cost, tier_of_wand, force_unshuffle )
		if gun ~= nil then
			if ModSettingGet("wand_finder.norm_list_filt") then
				local good_enough = norm_check(gun)
				if good_enough then
					gun["pos_x"] = search_x
					gun["pos_y"] = search_y
					gun["tier"] = tier_of_wand
					gun["is_unshuf"] = force_unshuffle
					table.insert(list_of_finds,gun)
					better_check(gun)
				end
			else
				gun["pos_x"] = search_x
				gun["pos_y"] = search_y
				gun["tier"] = tier_of_wand
				gun["is_unshuf"] = force_unshuffle
				table.insert(list_of_finds,gun)
				better_check(gun)
			end
		end
	end
	local loop = i % amount
	if loop == 1 then
		state = state + 1
	end
	if state == 1 then
		search_y = search_y - 1
	elseif state == 2 then
		search_x = search_x - 1
	elseif state == 3 then
		search_y = search_y + 1
	else
		search_x = search_x + 1
	end
end
if fast_search then
	if not ModSettingGet("wand_finder.fill_list") then
		wands_found = wands_found + 1
	end
else
	waiting = true
end
search_skip = 0
search_count = search_count + 8