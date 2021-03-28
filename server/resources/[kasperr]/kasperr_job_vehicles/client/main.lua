--[[
  __  __           _            _                 _  __                         _____  
 |  \/  |         | |          | |               | |/ /                        |  __ \ 
 | \  / | __ _  __| | ___      | |__  _   _      | ' / __ _ ___ _ __   ___ _ __| |__) |
 | |\/| |/ _` |/ _` |/ _ \     | '_ \| | | |     |  < / _` / __| '_ \ / _ \ '__|  _  / 
 | |  | | (_| | (_| |  __/     | |_) | |_| |     | . \ (_| \__ \ |_) |  __/ |  | | \ \ 
 |_|  |_|\__,_|\__,_|\___|     |_.__/ \__, |     |_|\_\__,_|___/ .__/ \___|_|  |_|  \_\
                                       __/ |                   | |                     
                                      |___/                    |_|                     

  Author: Kasper Rasmussen
  Steam: https://steamcommunity.com/id/kasperrasmussen
]]

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "kasperr_job_vehicles")

kasperr = nil

Citizen.CreateThread(function()
	while kasperr == nil do
		TriggerEvent('kasperr_base:getBaseObjects', function(obj) kasperr = obj end)
		Citizen.Wait(0)
	end
end)

local show = false
local cooldown = 0
local nearGarage = false

function openGui(garageID)
  if show == false then
    SetNuiFocus(true, true)
    SendNUIMessage({
      show = true,
      garage = Config.Garages[garageID],
      garageID = garageID
    })
  end
end

function closeGui()
  show = false
  SetNuiFocus(false)
  SendNUIMessage({show = false})
end

function notification(text)
  SetNotificationTextEntry("STRING")
  AddTextComponentString(text)
  DrawNotification(false, false)
end

RegisterNetEvent("kasperr_job_vehicles:openGui")
AddEventHandler("kasperr_job_vehicles:openGui", function(garageID)
	openGui(garageID)
end)

RegisterNetEvent("kasperr_job_vehicles:notification")
AddEventHandler("kasperr_job_vehicles:notification", function(text)
	notification(text)
end)

RegisterNUICallback(
  "close",
  function(data)
    closeGui()
end)

RegisterNUICallback(
  "getVehicle",
  function(data)
    closeGui()
    kasperr.TriggerServerCallback('kasperr_job_vehicles:checkBeforeSpawn', function(result)
      if result.status == true then
        spawn(result.data.vehicleID, result.data.garageID, result.data.registration)
      else
        exports['mythic_notify']:SendAlert('inform', result.notification, 2500)
      end
    end, data)
end)

RegisterNUICallback(
  "vehicleDetails",
  function(data, cb)
    if Config.Garages[data.garageID].vehicles[data.vehicleID].model ~= nil then
      local model = Config.Garages[data.garageID].vehicles[data.vehicleID].model
      local maxspeed_mph = GetVehicleMaxSpeed(model) * 3.6
      SendNUIMessage({
        details = true,
        displayname = Config.Garages[data.garageID].vehicles[data.vehicleID].displayname,
        model = Config.Garages[data.garageID].vehicles[data.vehicleID].model,
        maxspeed = math.floor(math.floor(maxspeed_mph+.5)*1.609344),
        billed = Config.Garages[data.garageID].vehicles[data.vehicleID].billed
      })
    end
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    if (NearGarage()) then
      if IsControlJustPressed(1, 51) then
        if show then
          closeGui()
        else
          if cooldown > 0 then
            exports['mythic_notify']:SendAlert('inform', 'Vent venligst ' .. cooldown .. ' sekunder', 2500)
          else
            cooldown = Config.AntiSpamCooldown
            local nearestGarage = NearGarage()
            if nearestGarage ~= nil then
              if IsPedSittingInAnyVehicle(GetPlayerPed(-1)) and Config.Garages[nearestGarage].despawn_at_open_menu_coords == true then
                kasperr.TriggerServerCallback('kasperr_job_vehicles:getAccess', function(result)
                  if result == true then
                    TriggerEvent("vrp_garages:kasperr_store", false, true)
                  else
                    exports['mythic_notify']:SendAlert('inform', 'Du har ikke adgang til dette', 2500)
                  end
                end, nearestGarage)
              else
                kasperr.TriggerServerCallback('kasperr_job_vehicles:getAccess', function(result)
                  if result == true then
                    openGui(nearestGarage)
                  else
                    exports['mythic_notify']:SendAlert('inform', 'Du har ikke adgang til dette', 2500)
                  end
                end, nearestGarage)
              end
            end
          end
        end
      end
    else
      if (show) then
        closeGui()
      end
    end
  end
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    if (NearDespawn()) then
      if IsControlJustPressed(1, 51) then
        if show then
          closeGui()
        else
          if cooldown > 0 then
            exports['mythic_notify']:SendAlert('inform', 'Vent venligst ' .. cooldown .. ' sekunder', 2500)
          else
            cooldown = Config.AntiSpamCooldown
            if IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then
              kasperr.TriggerServerCallback('kasperr_job_vehicles:getAccess', function(result)
                if result == true then
                  TriggerEvent("vrp_garages:kasperr_store", false, true)
                  Despawn()
                else
                  exports['mythic_notify']:SendAlert('inform', 'Du har ikke adgang til dette', 2500)
                end
              end, NearDespawn())
            else
              exports['mythic_notify']:SendAlert('inform', 'Du skal sidde i dit køretøj', 2500)
            end
          end
        end
      end
    end
  end
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    local pos = GetEntityCoords(GetPlayerPed(-1), true)
    for _, item in pairs(Config.Garages) do
      if(Vdist(pos.x, pos.y, pos.z, item.open_menu_location[1], item.open_menu_location[2], item.open_menu_location[3]+1) < 15.0)then
        DrawMarker(36, item.open_menu_location[1], item.open_menu_location[2], item.open_menu_location[3] - 1, 0, 0, 0, 0, 0, 0, 1.5, 1.5, 1.5001, Config.Color[1], Config.Color[2], Config.Color[3],165, false, false, 0,true)
        if GetDistanceBetweenCoords(item.open_menu_location[1], item.open_menu_location[2], item.open_menu_location[3], GetEntityCoords(GetPlayerPed(-1))) < 3 then
          if IsPedSittingInAnyVehicle(GetPlayerPed(-1)) and item.despawn_at_open_menu_coords == true then
            DrawText3Ds(item.open_menu_location[1], item.open_menu_location[2], item.open_menu_location[3], "[~b~E~s~] for at indsætte køretøjet")
          else
            DrawText3Ds(item.open_menu_location[1], item.open_menu_location[2], item.open_menu_location[3], "[~b~E~s~] for at tilgå garagen")
          end
        end
      end
    end
  end
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    local pos = GetEntityCoords(GetPlayerPed(-1), true)
    for _, item in pairs(Config.Garages) do
      if #item.vehicle_despawn_location > 0 then
        if(Vdist(pos.x, pos.y, pos.z, item.vehicle_despawn_location[1], item.vehicle_despawn_location[2], item.vehicle_despawn_location[3]+1) < 15.0)then
          DrawMarker(27, item.vehicle_despawn_location[1], item.vehicle_despawn_location[2], item.vehicle_despawn_location[3] - 1, 0, 0, 0, 0, 0, 0, 3.0001, 3.0001, 1.5001, Config.Color[1], Config.Color[2], Config.Color[3],165, false, false, 0,true)
          if GetDistanceBetweenCoords(item.vehicle_despawn_location[1], item.vehicle_despawn_location[2], item.vehicle_despawn_location[3], GetEntityCoords(GetPlayerPed(-1))) < 3 then
            DrawText3Ds(item.vehicle_despawn_location[1], item.vehicle_despawn_location[2], item.vehicle_despawn_location[3]+1, "[~b~E~s~] for at indsætte køretøjet")
          end
        end
      end
    end
  end
end)

Citizen.CreateThread(function()
  for k, v in ipairs(Config.Garages) do
    if v.showBlip == true then
      local blip = AddBlipForCoord(v.open_menu_location[1], v.open_menu_location[2], v.open_menu_location[3])
      SetBlipSprite(blip, v.blipID)
      SetBlipScale(blip, 0.8)
      SetBlipAsShortRange(blip, true)
      BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(tostring(v.name))
      EndTextCommandSetBlipName(blip)
      SetBlipColour(blip, Config.BlipColor)
    end
  end
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(1000)
    if cooldown > 0 then 
      cooldown = cooldown - 1
    end
  end
end)

AddEventHandler("onResourceStop", function(resource)
  if resource == GetCurrentResourceName() then
    closeGui()
  end
end)