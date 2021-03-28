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
vRPclient = Tunnel.getInterface("vRP", "kasperr_panic_button")

local cooldown = 0

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    if IsControlPressed(1, 19) and IsControlJustPressed(1, 74) then
      if cooldown == 0 then
        cooldown = Config.AntiSpamCooldown
        local coords = GetEntityCoords(GetPlayerPed(-1), 0)
        TriggerServerEvent("kasperr_panic_button", coords)
      end
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

RegisterNetEvent("kasperr_panic_button:showBlip")
AddEventHandler("kasperr_panic_button:showBlip", function(coords)
	local ped = GetPlayerPed(-1)
  local blip = AddBlipForCoord(coords.x+0.001, coords.y+0.001, coords.z+0.001)
  SetBlipSprite(blip, 304)
  SetBlipColour(blip, 1)
  SetBlipAlpha(blip, 250)
  SetBlipAsShortRange(blip, true)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString("Panikknap")
  SetBlipScale(blip, 0.8)
  EndTextCommandSetBlipName(blip)

  Citizen.SetTimeout(Config.BlipDeleteCooldown, function()
    RemoveBlip(blip)
  end)
end)