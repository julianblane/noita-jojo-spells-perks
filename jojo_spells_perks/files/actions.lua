table.insert(actions,
{	
		id          = "JOJO_HERMIT_PURPLE",
		name 		= "Hermit Purple and Hamon",
		description = "Thorn-covered vines, that transmit shock-inducing hamon",
		sprite 		= "files/projectiles/hermit.png",
		sprite_unidentified = "files/projectiles/hermit.png",
		type 		= ACTION_TYPE_PROJECTILE,
		spawn_level                       = "3,4,5,6", -- TENTACLE
		spawn_probability                 = "1,1,1,1", -- TENTACLE
		price = 200,
		mana = 20,
		--max_uses = 40,
		custom_xml_file = "files/custom_cards/base_hamon.xml",
		action 		= function()
			add_projectile("files/projectiles/hermit.xml")
			c.fire_rate_wait = c.fire_rate_wait + 40
		end,
})