--[[              
  /     \  _____     __| _/  ____   \______   \ ___.__.   ____    /     \  _____   _______ |  | __  ____  ________
 /  \ /  \ \__  \   / __ | _/ __ \   |    |  _/<   |  |  /  _ \  /  \ /  \ \__  \  \_  __ \|  |/ /_/ __ \ \___   /
/    Y    \ / __ \_/ /_/ | \  ___/   |    |   \ \___  | (  <_> )/    Y    \ / __ \_ |  | \/|    < \  ___/  /    / 
\____|__  /(____  /\____ |  \___  >  |______  / / ____|  \____/ \____|__  /(____  / |__|   |__|_ \ \___  >/_____ \
        \/      \/      \/      \/          \/  \/                      \/      \/              \/     \/       \/
]]
MySQL = module("vrp_mysql", "MySQL")
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vrp_loadfreeze")

MySQL.createCommand("vRP/reg_update_user_identity","UPDATE vrp_user_identities SET firstname = @firstname, name = @name, age = @age WHERE user_id = @user_id")

AddEventHandler("vRP:playerSpawn", function(user_id, source, first_spawn)
	local player = source
	--TriggerClientEvent('moveme',player)
	SetTimeout(30000,function()
	  TriggerClientEvent('vRPlf:Unfreeze',player,false)
	
  	local user_id = vRP.getUserId({source})
 	  local player = vRP.getUserSource({user_id})
  	vRP.getUserIdentity({user_id, function(identity)
      TriggerClientEvent('eyes',player,identity.eyes)
      
      if identity == nil or identity.name == nil or identity.firstname == nil or identity.name == "" or identity.firstname == "" or identity.firstname == "Skift" or identity.name == "Navn" then
        TriggerClientEvent('jsfour-register:open', player)
      end

    end})
	end)
end)

RegisterServerEvent("eye:color")
AddEventHandler("eye:color", function()
	local user_id = vRP.getUserId({source})
 	local player = vRP.getUserSource({user_id})
  vRP.getUserIdentity({user_id, function(identity)
    if identity ~= nil then
      TriggerClientEvent('eyes',player,identity.eyes)
    end
  end})
end)

-- Register the player
RegisterServerEvent('vRP_register:register')
AddEventHandler("vRP_register:register", function(data)
  local _source = source
  local user_id = vRP.getUserId({_source})

  MySQL.execute("vRP/reg_update_user_identity", {
    user_id = user_id,
    firstname = data.firstname,
    name = data.lastname,
    age = data.dateofbirth
  })

  Citizen.Wait(100)

  TriggerClientEvent("register:closeMenu", _source)

  TriggerClientEvent("pNotify:SendNotification", _source,{text = "Du har hermed fået borgerskab!", type = "success", queue = "global", timeout = 4000, layout = "bottomCenter",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
end)