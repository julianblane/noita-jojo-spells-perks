dofile("data/scripts/gun/procedural/gun_action_utils.lua");

function CleanWandActions( wand )
  local children = EntityGetAllChildren( wand );
  for i,v in ipairs( children ) do
    local comps = EntityGetAllComponents( v );
    for i, comp in ipairs( comps ) do
      if ComponentGetValue( comp, "action_id") ~= nil then
        EntityRemoveComponent(wand, comp)
      end
    end
  end
end

-- Special thanks to gokiburikin
-- Following code extracted from github.com/gokiburikin/gkbrkn_noita

function ComponentGetValueDefault( component_id, key, default )
  local value = ComponentGetValue( component_id, key );
  if value ~= nil and #value > 0 then
    return value;
  end
  return default;
end

function GetWandActions( wand )
  local actions = {};
  local children = EntityGetAllChildren( wand );
  for i,v in ipairs( children ) do
    local all_comps = EntityGetAllComponents( v );
    local action_id = nil;
    local permanent = false;
    for i, c in ipairs( all_comps ) do
      action_id = ComponentGetValueDefault( c, "action_id", action_id );
      permanent = ComponentGetValueDefault( c, "permanently_attached", permanent );
    end
    if action_id ~= nil then
      table.insert( actions, {action_id=action_id, permanent=permanent} );
    end
  end
  return actions;
end

function CopyWandActions( base_wand, copy_wand )
  local actions = GetWandActions( base_wand );
  for index,action_data in pairs( actions ) do
    if action_data.permanent ~= "1" then
      AddGunAction( copy_wand, action_data.action_id );
    else
      AddGunActionPermanent( copy_wand, action_data.action_id );
    end
  end
end