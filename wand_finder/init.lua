function OnPlayerSpawned(pid)
	if GameHasFlagRun("EXTOL_WAND_FINDER_MOD_INIT") then return end
	GameAddFlagRun("EXTOL_WAND_FINDER_MOD_INIT")
	EntityAddComponent2( pid, "LuaComponent", {script_source_file="mods/wand_finder/wand_finder.lua", execute_every_n_frame=1} )
end