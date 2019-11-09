dofile( "data/scripts/lib/utilities.lua" )

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
local models = EntityGetComponent( entity_id, "ControlsComponent" )

if( models ~= nil ) then
	for i,model in ipairs(models) do
		if(tonumber( ComponentGetValue( model, "mButtonDownKick" )) == 1) then
			-- Cooldown?
			-- if script_wait_frames( entity_id, 5 ) then  return  end
			
			-- Player position
			local x, y = EntityGetTransform( entity_id )

			-- direction
			local vel_x, vel_y = ComponentGetValue( model, "mAimingVectorNormalized" )
			
			vel_x = x
			vel_y = y

			shoot_projectile(entity_id, "files/projectiles/hermit.xml", x, y, vel_x, vel_y )
		end
	end
end
