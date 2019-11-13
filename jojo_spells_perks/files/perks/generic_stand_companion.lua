dofile( "data/scripts/lib/utilities.lua" )
dofile( "data/scripts/lib/coroutines.lua" )
dofile( "files/scripts/wand_utils.lua" )

-- Player
local entity_id = GetUpdatedEntityID()

-- controller component
local controller = EntityGetFirstComponent( entity_id, "ControlsComponent" )
GamePrint("Stand companion added")

local inventory = EntityGetFirstComponent(entity_id, "Inventory2Component") -- Thanks to Horscht for the help here

local stand = nil

async(
  function()
    while true do 
      if stand == nil then
        GamePrint("Checking for threats")
        -- A threat.
        
        -- Spawn position
        local x, y = EntityGetTransform( entity_id )
        y = y - 5

        stand = EntityLoad("files/entities/standghost.xml", x, y)
        GetGameEffectLoadTo( stand, "CHARM", true )

        local stand_wand = EntityLoad("data/entities/items/wand_level_03.xml", x, y)
        CleanWandActions(stand_wand)

        local active_wand = ComponentGetValueInt(inventory, "mActualActiveItem")

        -- Give spells to the stand wand
        CopyWandActions(active_wand, stand_wand) 
      else
        GamePrint("Checking for distance and health")
        
        if not EntityIsAlive(stand) then
          stand = nil
        end
      end
      wait(20)
    end
  end
) 

 