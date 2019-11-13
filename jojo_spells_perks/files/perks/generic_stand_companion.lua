dofile( "data/scripts/lib/utilities.lua" )
dofile( "data/scripts/lib/coroutines.lua" )
dofile( "files/scripts/wand_utils.lua" )
dofile( "data/scripts/gun/procedural/gun_action_utils.lua" )

-- Player
local entity_id = GetUpdatedEntityID()

-- controller component
local controller = EntityGetFirstComponent( entity_id, "ControlsComponent" )
GamePrint("Stand companion added")

local inventory = EntityGetFirstComponent(entity_id, "Inventory2Component") -- Thanks to Horscht for the help here

local stand = nil
local stand_wand = nil
local stand_health = nil

async(
  function()
    while true do 
      -- Player pos
      local x, y = EntityGetTransform( entity_id )

      if stand == nil then
        -- If player has a valid wand
        local active_wand = ComponentGetValueInt(inventory, "mActualActiveItem")
        if EntityHasTag(active_wand, "wand") then
          -- Spawn position
          y = y - 5

          stand = EntityLoad("files/entities/standghost.xml", x, y)
          GetGameEffectLoadTo( stand, "CHARM", true )

          local stand_hitbox = EntityGetFirstComponent(stand, "HitboxComponent")
          EntityRemoveComponent(stand, stand_hitbox)

          stand_wand = EntityLoad("data/entities/items/wand_level_01.xml", x, y)
          CleanWandActions(stand_wand)

          -- Give spells to the stand wand
          CopyWand(active_wand, stand_wand, false, true)

          -- Add no reload spell
          AddGunAction(stand_wand, "recharge")
        end 
      else
        -- Remove the stand + wand if the wand has no parent
        if EntityGetParent(stand_wand) == 0 then 
          EntityKill(stand)
          stand = nil
          EntityKill(stand_wand)
          stand_wand = nil
        else 
          -- Check if the stand is too far away
          local sx, sy = EntityGetTransform (stand)
          local distance = get_distance(x, y, sx, sy)     
          if distance > 200 then
            EntityKill(stand)
            stand = nil
            stand_wand = nil
          end
        end
      end
      wait(20)
    end
  end
) 