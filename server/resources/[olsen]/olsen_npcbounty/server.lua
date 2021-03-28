local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "olsen_npcbounty")

RegisterServerEvent("bounty:GiveItem")
AddEventHandler("bounty:GiveItem", function(x,y,z)
  local source = source
  local user_id = vRP.getUserId({source})
  local reward = math.random(100000,200000)
  local reward2 = math.random(10,30)
      vRP.giveInventoryItem({user_id,"dirty_money",reward,true})
      vRP.giveInventoryItem({user_id,"PISTOL_AMMO",reward2,true})
      PerformHttpRequest('https://discordapp.com/api/webhooks/773265600063602691/CBmu6SZxREJUaYd9_VOY3qPW3dmWmYLk1YOdsRFAJcqDm5S1lxMSWt6tW8ewOUhU_Hy8', function(err, text, headers) end, 'POST', json.encode({username = "Cokerun Logs", content = "**ID: "..user_id.." ** modtog "..reward.." sorte penge og "..reward2.." pistol skud."}), { ['Content-Type'] = 'application/json' })
end)

RegisterNetEvent('bounty:updatetable')
AddEventHandler('bounty:updatetable', function(bool)
    TriggerClientEvent('bounty:synctable', -1, bool)
end)

RegisterServerEvent("bounty:syncMission")
AddEventHandler("bounty:syncMission", function(missionData)
	local missionData = missionData
	TriggerClientEvent('bounty:syncMissionClient', -1, missionData)
end)
  
-- call this function if you want to print the table in server console - (debugging)
function tprint (tbl, indent)
  if not indent then indent = 0 end
  for k, v in pairs(tbl) do
    formatting = string.rep("  ", indent) .. k .. ": "
    if type(v) == "table" then
      print(formatting)
      tprint(v, indent+1)
    elseif type(v) == 'boolean' then
      print(formatting .. tostring(v))
    else
      print(formatting .. v)
    end
  end
end

