table.insert( perk_list, {
		id = "JOJO_HERMIT_HAMON_KICK",
		ui_name = "Hermit Purple and Hamon Kick",
		ui_description = "Use Hermit Purple and hamon alongside your kick.",
		ui_icon = "files/perks/perk_ui/hermit_hamon_kick.png",
		perk_icon = "files/perks/perk_icons/hermit_hamon_kick.png",
		func = function( entity_perk_item, entity_who_picked, item_name )
			EntityAddComponent( entity_who_picked, "LuaComponent", 
			{ 
				script_source_file = "files/perks/hermit_kick.lua",
				execute_on_added = "1",
				execute_every_n_frame = "-1",
				enable_coroutines = "1",
			} )
		end,
	})

table.insert( perk_list, {
		id = "JOJO_GENERIC_STAND",
		ui_name = "Stand Companion",
		ui_description = "A stand will appear and aid you in battle, wielding a wand like yours.",
		ui_icon = "files/perks/perk_ui/hermit_hamon_kick.png",
		perk_icon = "files/perks/perk_icons/hermit_hamon_kick.png",
		func = function( entity_perk_item, entity_who_picked, item_name )
			EntityAddComponent( entity_who_picked, "LuaComponent", 
			{ 
				script_source_file = "files/perks/generic_stand_companion.lua",
				execute_on_added = "1",
				execute_every_n_frame = "-1",
				enable_coroutines = "1",
			} )
		end,
	})