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
vRPclient = Tunnel.getInterface("vRP", "kasperr_jailjob")

RegisterServerEvent("kasperr_jailjob:payReward")
AddEventHandler("kasperr_jailjob:payReward", function()
  local user_id = vRP.getUserId({source})
  local _source = source

  local reward = math.random(Config.MinReward,Config.MaxReward)
  vRP.giveMoney({user_id,reward})
  TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'inform', text = 'Du modtog ' .. reward .. ' som tak for din indsats', length = 2500, style = {}})
end)

RegisterServerEvent("kasperr_jailjob:isJailed")
AddEventHandler("kasperr_jailjob:isJailed", function()
  local user_id = vRP.getUserId({source})
  local _source = source
  if tonumber(user_id) ~= nil then
    vRP.getUData({tonumber(user_id),"vRP:jail:time",function(value)
      if value ~= nil then
        custom = json.decode(value)
        if custom ~= nil and custom ~= -1 then
          TriggerClientEvent("kasperr_jailjob:setJailed", _source, true)
        else 
          TriggerClientEvent("kasperr_jailjob:setJailed", _source, false)
        end
      else
        TriggerClientEvent("kasperr_jailjob:setJailed", _source, false)
      end
    end})
  end
end)