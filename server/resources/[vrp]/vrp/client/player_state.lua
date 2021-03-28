
-- periodic player state update

local state_ready = false

AddEventHandler("playerSpawned",function() -- delay state recording
  state_ready = false
  
  Citizen.CreateThread(function()
    Citizen.Wait(30000)
    state_ready = true
  end)
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(500)

    if IsPlayerPlaying(PlayerId()) and state_ready then
      vRPserver.updateHealth({tvRP.getHealth()})
    end
  end
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(30000)

    if IsPlayerPlaying(PlayerId()) and state_ready then
      local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1),true))
      vRPserver.ping({})
      vRPserver.updatePos({x,y,z})
      vRPserver.updateWeapons({tvRP.getWeapons()})
      vRPserver.updateCustomization({tvRP.getCustomization()})
    end
  end
end)

-- WEAPONS

-- def
local weapon_types = {
  "WEAPON_KNIFE",
  "WEAPON_SWITCHBLADE",
  "WEAPON_HATCHET",
  "WEAPON_MACHETE",
  "WEAPON_BAT",
  "WEAPON_CROWBAR",
  "WEAPON_GOLFCLUB",
  "WEAPON_WRENCH",
  "WEAPON_HAMMER",
  "WEAPON_KNUCKLE",
  "WEAPON_PISTOL",
  "WEAPON_SNSPISTOL",
  "WEAPON_HEAVYPISTOL",
  "WEAPON_PISTOL50",
  "WEAPON_DOUBLEACTION",
  "WEAPON_MICROSMG",
  "WEAPON_MINISMG",
  "WEAPON_MUSKET",
  "WEAPON_FLASHLIGHT",
  "WEAPON_NIGHTSTICK",
  "WEAPON_STUNGUN",
  "WEAPON_COMBATPISTOL",
  "WEAPON_SMG",
  "WEAPON_PUMPSHOTGUN",
  "WEAPON_HEAVYSNIPER",
  "WEAPON_SPECIALCARBINE_MK2"
}

function tvRP.getWeaponTypes()
  return weapon_types
end

function tvRP.getWeapons()
  local player = GetPlayerPed(-1)

  local ammo_types = {} -- remember ammo type to not duplicate ammo amount

  local weapons = {}
  for k,v in pairs(weapon_types) do
    local model = string.upper(v)
    local hash = GetHashKey(model)
    if HasPedGotWeapon(player,hash) then
      local weapon = {}
      weapons[v] = weapon

      local atype = Citizen.InvokeNative(0x7FEAD38B326B9F74, player, hash)
      if ammo_types[atype] == nil then
        ammo_types[atype] = true
        weapon.ammo = GetAmmoInPedWeapon(player,hash)
      else
        weapon.ammo = 0
      end
    
    weapons[model] = weapon
    end
  end

  return weapons
end

function tvRP.getAmmo()
  local player = GetPlayerPed(-1)
  local ammo = {}

  ammo[#ammo + 1] = {
    pistol = GetAmmoInPedWeapon(player,"WEAPON_PISTOL"),
    shotgun = GetAmmoInPedWeapon(player,"WEAPON_PUMPSHOTGUN"),
    lmg = GetAmmoInPedWeapon(player,"WEAPON_MG"),
    rifle = GetAmmoInPedWeapon(player,"WEAPON_CARBINERIFLE"),
    smg = GetAmmoInPedWeapon(player,"WEAPON_SMG"),
    sniper = GetAmmoInPedWeapon(player,"WEAPON_SNIPERRIFLE")
  }

  return ammo
end

-- replace weapons (combination of getWeapons and giveWeapons)
-- return previous weapons
function tvRP.replaceWeapons(weapons)
  local old_weapons = tvRP.getWeapons()
  tvRP.giveWeapons({weapons}, true)
  return old_weapons
end

function tvRP.giveWeapons(weapons,clear_before)
  local player = GetPlayerPed(-1)

  -- give weapons to player

  if clear_before then
    RemoveAllPedWeapons(player,true)
  end

  for k,weapon in pairs(weapons) do
    local hash = GetHashKey(k)
    local ammo = weapon.ammo or 0

    GiveWeaponToPed(player, hash, ammo, false)
  end
end

function tvRP.removeWeapons(weapons)
  local player = GetPlayerPed(-1)

  -- remove weapons from player

  for k,weapon in pairs(weapons) do
    local hash = GetHashKey(k)

    RemoveWeaponFromPed(player, hash)
  end
end

--[[
function tvRP.dropWeapon()
  SetPedDropsWeapon(GetPlayerPed(-1))
end
--]]

-- PLAYER CUSTOMIZATION

-- parse part key (a ped part or a prop part)
-- return is_proppart, index
local function parse_part(key)
  if type(key) == "string" and string.sub(key,1,1) == "p" then
    return true,tonumber(string.sub(key,2))
  else
    return false,tonumber(key)
  end
end

function tvRP.getDrawables(part)
  local isprop, index = parse_part(part)
  if isprop then
    return GetNumberOfPedPropDrawableVariations(GetPlayerPed(-1),index)
  else
    return GetNumberOfPedDrawableVariations(GetPlayerPed(-1),index)
  end
end

function tvRP.getDrawableTextures(part,drawable)
  local isprop, index = parse_part(part)
  if isprop then
    return GetNumberOfPedPropTextureVariations(GetPlayerPed(-1),index,drawable)
  else
    return GetNumberOfPedTextureVariations(GetPlayerPed(-1),index,drawable)
  end
end

function tvRP.getCustomization()
  local ped = GetPlayerPed(-1)

  local custom = {}

  custom.modelhash = GetEntityModel(ped)

  -- ped parts
  for i=0,20 do -- index limit to 20
    custom[i] = {GetPedDrawableVariation(ped,i), GetPedTextureVariation(ped,i), GetPedPaletteVariation(ped,i)}
  end

  -- props
  for i=0,10 do -- index limit to 10
    custom["p"..i] = {GetPedPropIndex(ped,i), math.max(GetPedPropTextureIndex(ped,i),0)}
  end

  return custom
end

-- partial customization (only what is set is changed)
function tvRP.setCustomization(custom) -- indexed [drawable,texture,palette] components or props (p0...) plus .modelhash or .model
  local exit = TUNNEL_DELAYED() -- delay the return values

  Citizen.CreateThread(function() -- new thread
    if custom then
      local ped = GetPlayerPed(-1)
      local mhash = nil

      -- model
      if custom.modelhash ~= nil then
        mhash = custom.modelhash
      elseif custom.model ~= nil then
        mhash = GetHashKey(custom.model)
      end

      if mhash ~= nil then
        local i = 0
        while not HasModelLoaded(mhash) and i < 10000 do
          RequestModel(mhash)
          Citizen.Wait(10)
        end

        if HasModelLoaded(mhash) then
          -- changing player model remove weapons, so save it
          local weapons = tvRP.getWeapons()
          SetPlayerModel(PlayerId(), mhash)
          tvRP.giveWeapons(weapons,true)
          SetModelAsNoLongerNeeded(mhash)
		  
      vRPserver.updateHealth({tvRP.getHealth()})
        end
      end

      ped = GetPlayerPed(-1)

      -- parts
      for k,v in pairs(custom) do
        if k ~= "model" and k ~= "modelhash" then
          local isprop, index = parse_part(k)
          if isprop then
            if v[1] < 0 then
              ClearPedProp(ped,index)
            else
              SetPedPropIndex(ped,index,v[1],v[2],v[3] or 2)
            end
          else
            SetPedComponentVariation(ped,index,v[1],v[2],v[3] or 2)
          end
        end
      end
    end

    exit({})
  end)
end
