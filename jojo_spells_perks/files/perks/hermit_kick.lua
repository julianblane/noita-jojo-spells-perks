dofile( "data/scripts/lib/utilities.lua" )
dofile( "data/scripts/lib/coroutines.lua" )

-- Player
local entity_id = GetUpdatedEntityID()

-- controller component
local controller = EntityGetFirstComponent( entity_id, "ControlsComponent" )
GamePrint("Stand added")

async(
	function()
		while true do 
			if( controller ~= nil ) then
				if(ComponentGetValue( controller, "mButtonDownKick" ) == "1") then
					-- Player position
					local x, y = EntityGetTransform( entity_id )

					-- direction
					local aim_x, aim_y = ComponentGetValueVector2( controller, "mAimingVectorNormalized" )

					shoot_projectile(entity_id, "files/projectiles/hermit.xml", x, y, aim_x, aim_y )

					-- Cooldown
					wait(60)
				end
			end
			wait(1)
		end
	end
)