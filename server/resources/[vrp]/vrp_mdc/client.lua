--[[              
  /     \  _____     __| _/  ____   \______   \ ___.__.   ____    /     \  _____   _______ |  | __  ____  ________
 /  \ /  \ \__  \   / __ | _/ __ \   |    |  _/<   |  |  /  _ \  /  \ /  \ \__  \  \_  __ \|  |/ /_/ __ \ \___   /
/    Y    \ / __ \_/ /_/ | \  ___/   |    |   \ \___  | (  <_> )/    Y    \ / __ \_ |  | \/|    < \  ___/  /    / 
\____|__  /(____  /\____ |  \___  >  |______  / / ____|  \____/ \____|__  /(____  / |__|   |__|_ \ \___  >/_____ \
        \/      \/      \/      \/          \/  \/                      \/      \/              \/     \/       \/
------------------------CREDITS------------------------
--   Copyright 2019 ©oMarkez. All rights reserved    --
-------------------------------------------------------
]]
local open = false

vRPCmdc = {}
Tunnel.bindInterface("vrp_mdc",vRPCmdc)
Proxy.addInterface("vrp_mdc",vRPCmdc)
vRPSerMDC = Tunnel.getInterface("vrp_mdc","vrp_mdc")
vRP = Proxy.getInterface("vRP")

Citizen.CreateThread(function() TriggerEvent('jabimochat:addSuggestion', '/tablet', 'Åbner Politi Ipaden.') end)
Citizen.CreateThread(function() TriggerEvent('jabimochat:addSuggestion', '/ipad', 'Åbner Politi Ipaden.') end)
-- Checks if the car is in the list
function vehicleType(using)
  local cars = Config.Cars
  for i=1, #cars, 1 do
    if IsVehicleModel(using, GetHashKey(cars[i])) then
      return true
    end
  end
end

-- Key events
Citizen.CreateThread(function()
  SetNuiFocus(false, false)
  while true do
    Citizen.Wait(10)
    if IsControlJustReleased(0, 58) and GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1))) < 1 then
			if IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then
        if vehicleType(GetVehiclePedIsUsing(GetPlayerPed(-1))) then
          open = true
          SetNuiFocus(true, true)
          SendNUIMessage({
            action = "open"
          })
				end
			end
		end
  end
end)

-- NUI Callback - alarm
RegisterNUICallback('alarm', function(data, cb)
  SetVehicleAlarm(GetPlayersLastVehicle(), true)
  StartVehicleAlarm(GetPlayersLastVehicle())
  SetTimeout(10000, function()
    cb('done')
  end)
end)

-- NUI Callback - save
RegisterNUICallback('save', function(data, cb)
  oMarkez.TriggerServerCallback('vrp_mdc:save', function( d )
    cb(d)
  end, data)
end)

-- NUI Callback - fetch
RegisterNUICallback('fetch', function(data, cb)
  oMarkez.TriggerServerCallback('vrp_mdc:fetch', function( d )
    cb(d)
  end, data)
end)

RegisterNUICallback("login", function(data, cb)
  TriggerServerEvent("mdc_login", data)
  cb("ok")
end)

-- NUI Callback - remove
RegisterNUICallback('remove', function(data, cb)
  oMarkez.TriggerServerCallback('mdc_remove', function( d )
    cb(d)
  end, data)
end)

-- NUI Callback - close
RegisterNUICallback('escape', function(data, cb)
	SetNuiFocus(false, false)
  open = false
  TriggerEvent("jabimo:cancelemote")
end)

RegisterNetEvent("jabimo:polititablet")
AddEventHandler("jabimo:polititablet", function()
  if not IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then 
    if open == false then
      open = true
      SetNuiFocus(true, true)
      SendNUIMessage({
        action = "open"
      })
      ExecuteCommand("emote tablet2")
    end
  else
    TriggerEvent("pNotify:SendNotification", {text = "Du sidder i en bil! Brug knappen G i stedet!",type = "error",timeout = (3000),layout = "centerRight",queue = "global",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})  
  end
end)