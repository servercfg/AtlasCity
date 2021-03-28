-------------------------------------------------------
-----------    Script converted by Nicki    -----------
                ---   21/05/2020	---
   ---  Copyright 2019 Nicki. All rights reserved	---
-------------------Discord:Nicki#3629--------------------

local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vrp_jewerly")

local stores = cfg.holdups

local robbers = {}

function get3DDistance(x1, y1, z1, x2, y2, z2)
	return math.sqrt(math.pow(x1 - x2, 2) + math.pow(y1 - y2, 2) + math.pow(z1 - z2, 2))
end



RegisterServerEvent('vrp_jewerly:toofar')
AddEventHandler('vrp_jewerly:toofar', function(robb)
	if(robbers[source])then
		TriggerClientEvent('vrp_jewerly:toofarlocal', source)
		robbers[source] = nil
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Røveri afbrudt ved: Vangelico Juvelbutik!'}, 15000)
	--	TriggerClientEvent("pNotify:SendNotification", -1,{text = "Røveri afbrudt ved: " .. stores[robb].nameofstore.."!", type = "warning", queue = "global", timeout = 5000, layout = "bottomCenter",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
	end
end)

RegisterServerEvent('vrp_jewerly:playerdied')
AddEventHandler('vrp_jewerly:playerdied', function(robb)
	if(robbers[source])then
		TriggerClientEvent('vrp_jewerly:playerdiedlocal', source)
		robbers[source] = nil
		TriggerClientEvent("pNotify:SendNotification", -1,{text = "Røveri afbrudt ved: " .. stores[robb].nameofstore, type = "info", queue = "global", timeout = 5000, layout = "bottomCenter",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
	end
end)

RegisterServerEvent('vrp_jewerly:rob')
AddEventHandler('vrp_jewerly:rob', function(robb,x,y,z)
  local user_id = vRP.getUserId({source})
  local player = vRP.getUserSource({user_id})
  local cops = vRP.getUsersByPermission({cfg.permission})
  if vRP.hasPermission({user_id,cfg.permission}) then
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Du kan ikke røve butikken som betjent!'}, 15000)
--	TriggerClientEvent("pNotify:SendNotification", player,{text = "Du kan ikke røve butikken som betjent.", type = "error", queue = "global", timeout = 5000, layout = "centerLeft",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
  else
    if #cops >= cfg.cops then
	  if stores[robb] then
		  local store = stores[robb]

		  if (os.time() - store.lastrobbed) <  cfg.seconds+cfg.cooldown and store.lastrobbed ~= 0 then
			TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Vent venligt: '..(cfg.seconds+cfg.cooldown - (os.time() - store.lastrobbed))..' sekunder!'}, 15000)  
		--	TriggerClientEvent("pNotify:SendNotification", player,{text = "Vent venligt: "..(cfg.seconds+cfg.cooldown - (os.time() - store.lastrobbed)).." sekunder.", type = "error", queue = "global", timeout = 5000, layout = "bottomCenter",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
			  return
		  end

		  local message = "^7^*Røveri ved " .. store.nameofstore .. " !"
		  TriggerEvent('dispatchpolice', x, y, z, message)

		  TriggerClientEvent('mythic_notify:client:SendAlert', -1, { type = 'inform', text = 'Juvelrøveri ved '..store.nameofstore..'!'}, 15000)  
		--  TriggerClientEvent("pNotify:SendNotification", -1,{text = "Butiksrøveri ved "..store.nameofstore.."!", type = "warning", queue = "global", timeout = 5000, layout = "bottomCenter",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
		  TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Du startede et røveri, forlad ikke Juvelbutikken!'}, 15000)
		--  TriggerClientEvent("pNotify:SendNotification", source,{text = "Du startede et røveri, forlad ikke butikken!", type = "warning", queue = "global", timeout = 5000, layout = "centerLeft",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
		--  TriggerClientEvent("pNotify:SendNotification", source,{text = "Hold butikken i 5 minutter og pengene er dine!", type = "info", queue = "global", timeout = 5000, layout = "centerLeft",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
		  TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Hold Juvelbutikken i 5 minutter og pengene er dine!'}, 15000)  
		  TriggerClientEvent('vrp_jewerly:currentlyrobbing', player, robb)
		  stores[robb].lastrobbed = os.time()
		  robbers[player] = robb
		  local savedSource = player
		  SetTimeout(cfg.seconds*1000, function()
			  if(robbers[savedSource])then
				  if(user_id)then
					  vRP.giveInventoryItem({user_id,"dirty_money",store.reward,true})
					  TriggerClientEvent('mythic_notify:client:SendAlert', -1, { type = 'inform', text = 'Røveri ved '..store.nameofstore..' blev afsluttet!'}, 15000)
					--  TriggerClientEvent("pNotify:SendNotification", -1,{text = "Røveri ved "..store.nameofstore.." blev afsluttet, røverne slap væk med ca. "..store.reward.." i kontanter</br>", type = "warning", queue = "global", timeout = 5000, layout = "bottomCenter",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
					  TriggerClientEvent('vrp_jewerly:robberycomplete', savedSource, store.reward)
				  end
			  end
		  end)		
	  end
    else
	TriggerClientEvent('mythic_notify:client:SendAlert', player, { type = 'inform', text = 'Der skal være min. ' ..cfg.cops..' betjente på, før du kan røve denne butik'}, 15000)
--	TriggerClientEvent("pNotify:SendNotification", player,{text = "Der skal være min. <b>" ..cfg.cops.."</b> betjente på, før du kan røve denne butik", type = "error", queue = "global", timeout = 5000, layout = "centerLeft",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
    end
  end
end)

RegisterServerEvent('vrp_jewerly:random')
AddEventHandler('vrp_jewerly:random', function()

	local user_id = vRP.getUserId({source})
	
	vRP.giveInventoryItem({user_id,"nicki_juvel", math.random(1, 7)})
end)
