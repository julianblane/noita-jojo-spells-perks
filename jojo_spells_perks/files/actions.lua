table.insert(actions,
{	
		id          = "JOJO_HERMIT_PURPLE",
		name 		= "Hermit purple",
		description = "$actiondesc_tentacle",
		spawn_requires_flag = "card_unlocked_tentacle",
		sprite 		= "data/ui_gfx/gun_actions/tentacle.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/tentacle_unidentified.png",
		type 		= ACTION_TYPE_PROJECTILE,
		spawn_level                       = "3,4,5,6", -- TENTACLE
		spawn_probability                 = "1,1,1,1", -- TENTACLE
		price = 200,
		mana = 20,
		--max_uses = 40,
		custom_xml_file = "data/entities/misc/custom_cards/tentacle.xml",
		action 		= function()
			add_projectile("files/projectiles/hermit.xml")
			c.fire_rate_wait = c.fire_rate_wait + 40
		end,
})

