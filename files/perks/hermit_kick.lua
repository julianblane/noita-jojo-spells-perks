dofile( "data/scripts/lib/utilities.lua" )
dofile( "data/scripts/lib/coroutines.lua" )

-- Useful:
-- ControlsComponent
-- mAimingVector                                                   -                               ""
-- mAimingVectorNormalized                                         -                               "Aiming vector normalized to unit sphere."
-- mAimingVectorNonZeroLatest
-- mButtonDownKick                                                 0 [0, 1]                        ""
-- mButtonFrameKick

-- Player
local entity_id = GetUpdatedEntityID()

-- controller component
local controller = EntityGetFirstComponent( entity_id, "ControlsComponent" )
-- local world = EntityGetFirstComponent( entity_id, "WorldStateComponent" )
GamePrint("Stand added")

async(
	function()
		while true do 
			if( controller ~= nil ) then
				if(ComponentGetValue( controller, "mButtonDownKick" ) == "1") then
					-- Player position
					local x, y = EntityGetTransform( entity_id )

					-- direction
					local vel_x, vel_y = ComponentGetValue( controller, "mAimingVectorNormalized" )
					
					vel_x = x
					vel_y = y

					shoot_projectile(entity_id, "files/projectiles/hermit.xml", x, y, vel_x, vel_y )
					
					-- Cooldown
					wait(60)
				end
			end
			wait(1)
		end
	end
)

--[[
function HermitKick()
	while true do 
		GamePrint("Checking for kick")
		if( controller ~= nil ) then
			if(ComponentGetValue( controller, "mButtonDownKick" ) == "1") then
				-- Player position
				local x, y = EntityGetTransform( entity_id )

				-- direction
				local vel_x, vel_y = ComponentGetValue( controller, "mAimingVectorNormalized" )
				
				vel_x = x
				vel_y = y

				shoot_projectile(entity_id, "files/projectiles/hermit.xml", x, y, vel_x, vel_y )
			end
		end
		GamePrint("Waiting")  
		wait(1)
		GamePrint("Waited")
	end
	GamePrint("This shouldn't happen.")
end

local co_kick = async(HermitKick()) 
]]--