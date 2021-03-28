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

local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "kasperr_panic_button")

RegisterServerEvent("kasperr_panic_button")
AddEventHandler("kasperr_panic_button", function(coords)
  local user_id = vRP.getUserId({source})
  local _source = source

  if vRP.hasPermission({user_id, Config.RequiredPermission}) then
    vRP.getUserIdentity({user_id, function(identity)
      if identity then
          local name = identity.firstname .. " " .. identity.name
          call(name, coords)
		  TriggerClientEvent('3dme:triggerDisplay', -1, "Udløst Panik-knap", _source)
      end
    end})
  end
end)

function call(name, coords)
  local players = {}
  local users = vRP.getUsers()

  for k, v in pairs(users) do
    local player = vRP.getUserSource({tonumber(k)})
    if vRP.hasPermission({k, Config.RequiredPermission}) and player then
      table.insert(players, player)
    end
  end

  for k, v in pairs(players) do
    TriggerClientEvent("pNotify:SendNotification", v, {
      text = "<b>Panikknap udløst</b><br /><br />" .. name .. "<br />Der er blevet udløst en paniknap!",
      type = "warning",
      queue = "warning",
      timeout = 30000,
      layout = "bottomRight",
      sounds = {
        sources = {"panic_button.mp3"},
        volume = 0.2,
        conditions = {"docVisible"}
      }
    })
    TriggerClientEvent("kasperr_panic_button:showBlip", v, coords)
  end
end