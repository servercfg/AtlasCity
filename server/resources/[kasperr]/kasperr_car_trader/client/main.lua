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
vRPclient = Tunnel.getInterface("vRP", "kasperr_car_trader")

kasperr = nil

Citizen.CreateThread(function()
	while kasperr == nil do
		TriggerEvent('kasperr_base:getBaseObjects', function(obj) kasperr = obj end)
		Citizen.Wait(0)
	end
end)

local show = false

function openGui()
  if show == false then
    SetNuiFocus(true, true)
    SendNUIMessage({
      show = true
    })
  end
end

function closeGui()
  show = false
  SetNuiFocus(false)
  SendNUIMessage({show = false})
end

RegisterNUICallback(
  "close",
  function(data)
    closeGui()
  end
)

RegisterCommand(
  Config.Command,
  function(source, args)
   TriggerEvent("kasperr_car_trader:open")
     end
 )

RegisterNetEvent("kasperr_car_trader:open")
AddEventHandler("kasperr_car_trader:open", function()
    openGui()
end)

RegisterNUICallback("get-vehicles", function(data, cb)
  kasperr.TriggerServerCallback('kasperr_car_trader:getVehicles', function(result)
    cb(result)
  end)
end)

RegisterNUICallback("add-vehicle", function(data, cb)
  Citizen.Wait(2000)
  kasperr.TriggerServerCallback('kasperr_car_trader:addVehicle', function(result)
    cb(result)
  end, data.values)
end)

RegisterNUICallback("delete-vehicle", function(data, cb)
  Citizen.Wait(2000)
  kasperr.TriggerServerCallback('kasperr_car_trader:deleteVehicle', function(result)
    cb(result)
  end, data.vehicleid)
end)

RegisterNUICallback("get-language", function(data, cb)
  cb(Config)
end)

AddEventHandler(
  "onResourceStop",
  function(resource)
    if resource == GetCurrentResourceName() then
      closeGui()
    end
  end
)