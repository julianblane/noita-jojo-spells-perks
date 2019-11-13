dofile( "data/scripts/gun/procedural/gun_action_utils.lua" )

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

function CopyComponentMembers( base_component, copy_component )
    if base_component ~= nil and copy_component ~= nil then
        for key,value in pairs( ComponentGetMembers( base_component ) ) do
            ComponentSetValue( copy_component, key, value );
        end
    end
end

function CopyListedComponentMembers( base_component, copy_component, ... )
    if base_component ~= nil and copy_component ~= nil then
        for index,key in pairs( {...} ) do
            ComponentSetValue( copy_component, key, ComponentGetValue( base_component, key ) );
        end
    end
end

function CopyComponentObjectMembers( base_component, copy_component, component_object_name )
    if base_component ~= nil and copy_component ~= nil then
        for object_key in pairs( ComponentObjectGetMembers( base_component, component_object_name ) ) do
            ComponentObjectSetValue( copy_component, component_object_name, object_key, ComponentObjectGetValue( base_component, component_object_name, object_key ) );
        end
    end
end

function FindFirstComponentThroughTags( entity_id, ... )
    return FindComponentThroughTags( entity_id, ...)[1];
end

function FindComponentThroughTags( entity_id, ... )
    local matching_components = EntityGetAllComponents( entity_id );
    local valid_components = {};
    for _,tag in pairs( {...} ) do
        for index,component in pairs( matching_components ) do
            if ComponentGetValue( component, tag ) ~= "" and ComponentGetValue( component, tag ) ~= nil then
                table.insert( valid_components, component );
            end
        end
        matching_components = valid_components;
        valid_components = {};
    end
    return matching_components;
end

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

function CopyWand( base_wand, copy_wand, copy_sprite, copy_actions )
    local base_ability_component = FindFirstComponentThroughTags( base_wand, "charge_wait_frames" );
    local copy_ability_component = FindFirstComponentThroughTags( copy_wand, "charge_wait_frames" );
    CopyComponentMembers( base_ability_component, copy_ability_component );
    CopyComponentObjectMembers( base_ability_component, copy_ability_component, "gun_config" );
    CopyComponentObjectMembers( base_ability_component, copy_ability_component, "gunaction_config" );
    if copy_sprite ~= false then
        CopyListedComponentMembers( FindFirstComponentThroughTags( base_wand, "z_index", "image_file" ), FindFirstComponentThroughTags( copy_wand, "z_index", "image_file" ), "image_file","offset_x","offset_y");
        local base_hotspot = EntityGetFirstComponent( base_wand, "HotspotComponent", "shoot_pos" );
        GamePrint(tostring(base_hotspot));
    end
    if copy_actions ~= false then
        CopyWandActions( base_wand, copy_wand );
    end
end