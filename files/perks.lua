table.insert( perk_list, {
		id = "JOJO_HERMIT_KICK",
		ui_name = "Hermit Purple Kick",
		ui_description = "Use hermit purple alongside your kick",
		ui_icon = "data/ui_gfx/gun_actions/tentacle.png",
		perk_icon = "data/ui_gfx/gun_actions/tentacle.png",
		func = function( entity_perk_item, entity_who_picked, item_name )
			EntityAddComponent( entity_who_picked, "LuaComponent", 
			{ 
				script_source_file = "files/perks/hermit_kick.lua",
				execute_every_n_frame = "1",
			} )
		end,
	})