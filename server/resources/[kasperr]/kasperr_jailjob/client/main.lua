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
vRPclient = Tunnel.getInterface("vRP", "kasperr_jailjob")

local show = false
local cooldown = 0
local Destination = nil
local lastBlip = nil
local isJailed = false

function openGui()
  if show == false then
    SetNuiFocus(true, true)
    SendNUIMessage({show = true})
  end
end

function closeGui()
  show = false
  SetNuiFocus(false)
  SendNUIMessage({show = false})
end

RegisterNUICallback("close", function(data)
  closeGui()
end)

RegisterNUICallback("startjob", function(data)
  startjob(math.random(#Config.Jobs))
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    local pos = GetEntityCoords(GetPlayerPed(-1), true)
    if(Vdist(pos.x, pos.y, pos.z, Config.Coords[1], Config.Coords[2], Config.Coords[3]+1) < 3.0)then
      if IsControlJustPressed(1, 51) then
        if cooldown > 0 then
          print("Vent venligst " .. cooldown .. " sekunder")
        else
          cooldown = Config.AntiSpamCooldown
          openGui()
        end
      end
    end
    if Destination ~= nil then
      if(Vdist(pos.x, pos.y, pos.z, Destination[1], Destination[2], Destination[3]+1) < 3.0)then
        if IsControlJustPressed(1, 51) then
          if cooldown > 0 then
            print("Vent venligst " .. cooldown .. " sekunder")
          else
            cooldown = Config.AntiSpamCooldown
            stopjob()
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
    if(Vdist(pos.x, pos.y, pos.z, Config.Coords[1], Config.Coords[2], Config.Coords[3]+1) < 15.0)then
      DrawMarker(27, Config.Coords[1], Config.Coords[2], Config.Coords[3] - 0.90, 0, 0, 0, 0, 0, 0, 3.0001, 3.0001, 1.5001, 0, 180, 249,165, false, false, 0,true)
      if GetDistanceBetweenCoords(Config.Coords[1], Config.Coords[2], Config.Coords[3], GetEntityCoords(GetPlayerPed(-1))) < 3 then
        DrawText3Ds(Config.Coords[1], Config.Coords[2], Config.Coords[3]+1, "[~g~E~s~] for at begynde arbejdet")
      end
    end
    if Destination ~= nil then
      if(Vdist(pos.x, pos.y, pos.z, Destination[1], Destination[2], Destination[3]+1) < 15.0)then
        DrawMarker(27, Destination[1], Destination[2], Destination[3] - 0.90, 0, 0, 0, 0, 0, 0, 3.0001, 3.0001, 1.5001, 0, 180, 249,165, false, false, 0,true)
        if GetDistanceBetweenCoords(Destination[1], Destination[2], Destination[3], GetEntityCoords(GetPlayerPed(-1))) < 3 then
          DrawText3Ds(Destination[1], Destination[2], Destination[3]+1, "[~g~E~s~] for at aflevere pakken")
        end
      end
    end
  end
end)

Citizen.CreateThread(function()
  local blip = AddBlipForCoord(Config.Coords[1], Config.Coords[2], Config.Coords[3])
  SetBlipSprite(blip, 478)
  SetBlipScale(blip, 0.8)
  SetBlipAsShortRange(blip, true)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString(tostring(Config.Title))
  EndTextCommandSetBlipName(blip)
  SetBlipColour(blip, 10)
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(5000)
    TriggerServerEvent("kasperr_jailjob:isJailed")
  end
end)

Citizen.CreateThread(function()
  while true do
    if isJailed then
      local active = true
      DisablePlayerFiring(GetPlayerPed(-1), isJailed) -- Disable weapon firing
      DisableControlAction(0,24,isJailed) -- disable attack
      DisableControlAction(0,25,isJailed) -- disable aim
      DisableControlAction(0,47,isJailed) -- disable weapon
      DisableControlAction(0,58,isJailed) -- disable weapon
      DisableControlAction(0,263,isJailed) -- disable melee
      DisableControlAction(0,264,isJailed) -- disable melee
      DisableControlAction(0,257,isJailed) -- disable melee
      DisableControlAction(0,140,isJailed) -- disable melee
      DisableControlAction(0,141,isJailed) -- disable melee
      DisableControlAction(0,142,isJailed) -- disable melee
      DisableControlAction(0,143,isJailed) -- disable melee
      DisableControlAction(0,75,isJailed) -- disable exit vehicle
      DisableControlAction(27,75,isJailed) -- disable exit vehicle
      DisableControlAction(0,22,isJailed) -- disable jump
    end
    Citizen.Wait(0)
  end
end)

RegisterNetEvent("kasperr_jailjob:notification")
AddEventHandler("kasperr_jailjob:notification", function(text)
	notification(text)
end)

RegisterNetEvent("kasperr_jailjob:setJailed")
AddEventHandler("kasperr_jailjob:setJailed", function(response)
  isJailed = response
end)

function DrawText3Ds(x,y,z, text)
  local onScreen,_x,_y=World3dToScreen2d(x,y,z)
  local px,py,pz=table.unpack(GetGameplayCamCoords())
  
  SetTextScale(0.35, 0.35)
  SetTextFont(4)
  SetTextProportional(1)
  SetTextColour(255, 255, 255, 215)
  SetTextEntry("STRING")
  SetTextCentre(1)
  AddTextComponentString(text)
  DrawText(_x,_y)
  local factor = (string.len(text)) / 370
  DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end

function startjob(id)
  Destination = Config.Jobs[id].DestinationCoords
  loadAnimDict("anim@heists@box_carry@")
  local prop = "hei_prop_heist_box"
  TaskPlayAnim(GetPlayerPed(-1), "anim@heists@box_carry@", "idle", 8.0, 1.0, -1, 50, 0, 0, 0, 0)
  local plyCoords = GetOffsetFromEntityInWorldCoords(GetPlayerPed(PlayerId()), 0.0, 0.0, -4.0)
  local propspawned = CreateObject(GetHashKey(prop), plyCoords.x, plyCoords.y, plyCoords.z, 1, 1, 1)
  Citizen.Wait(100)
  local netid = ObjToNet(propspawned)
  prop_net = netid
  AttachEntityToEntity(propspawned, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 60309), 0.025, 0.08, 0.255, -145.0, 290.0, 0.0, true, true, false, true, 1, true)
  closeGui()
  if lastBlip == nil then
    RemoveBlip(lastBlip)
  end
  local blip = AddBlipForCoord(Destination[1], Destination[2], Destination[3])
  SetBlipSprite(blip, 38)
  SetBlipScale(blip, 0.8)
  SetBlipAsShortRange(blip, true)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString("Destination")
  EndTextCommandSetBlipName(blip)
  SetBlipColour(blip, 2)
  lastBlip = blip
  notification(Config.Jobs[id].Description)
end

function stopjob()
  Destination = nil
  local ped = PlayerPedId()
  ClearPedTasks(ped)
  DetachEntity(NetToObj(prop_net), 1, 1)
  DeleteEntity(NetToObj(prop_net))
  DeleteObject(NetToObj(prop_net))
  StopScreenEffect(Rampage)
  ClearFacialIdleAnimOverride(ped)
  TriggerServerEvent("kasperr_jailjob:payReward")
  RemoveBlip(lastBlip)
end

function loadAnimDict(dict)
  while (not HasAnimDictLoaded(dict)) do
      RequestAnimDict(dict)
      Citizen.Wait(5)
  end
end

function notification(text)
  SetNotificationTextEntry("STRING")
  AddTextComponentString(text)
  DrawNotification(false, false)
end

AddEventHandler(
  "onResourceStop",
  function(resource)
    if resource == GetCurrentResourceName() then
      closeGui()
    end
  end
)
