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
MySQL = module("vrp_mysql", "MySQL")
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "kasperr_job_vehicles")

kasperr = nil

TriggerEvent('kasperr_base:getBaseObjects', function(obj) kasperr = obj end)

--SQL--
MySQL.createCommand("vRP/kasperr_job_vehicles_get_vehicles","SELECT * FROM vrp_user_vehicles WHERE user_id = @user_id")

kasperr.RegisterServerCallback('kasperr_job_vehicles:checkBeforeSpawn', function (source, cb, params)
  local user_id = vRP.getUserId({source})
  local _source = source
  if vRP.hasPermission({user_id, Config.Garages[params.garageID].vehicles[params.vehicleID].permissions }) then
    vRP.getUserIdentity({user_id, function(identity)
      cb({
        status = true,
        notification = "",
        data = {
          vehicleID = params.vehicleID,
          garageID = params.garageID,
          registration = identity.registration
        }
      })
    end})
  else
    cb({
      status = false,
      notification = "Du har ikke adgang til dette køretøj",
      data = {}
    })
  end
end)

kasperr.RegisterServerCallback('kasperr_job_vehicles:getAccess', function (source, cb, garageID)
  local user_id = vRP.getUserId({source})
  local _source = source
  if garageID ~= nil then
    if vRP.hasPermission({user_id, Config.Garages[garageID].permissions }) then
      cb(true)
    else
      cb(false)
    end
  else
    cb(false)
  end
end)