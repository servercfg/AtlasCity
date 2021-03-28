local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vrp_headbag")

RegisterServerEvent('closest')
AddEventHandler('closest', function()

	local user_id = vRP.getUserId({source})
  local player = vRP.getUserSource({user_id})
  	vRPclient.getNearestPlayer(player,{10},function(nplayer)
	if nplayer ~= nil then  
		vRPclient.isHandcuffed(nplayer,{}, function(handcuffed)
			if handcuffed then
				if vRP.tryGetInventoryItem({user_id,"pose",1,false}) then
						TriggerClientEvent('pune_headbag', nplayer)
				else
					TriggerClientEvent('pune_headbag2', nplayer)
					--TriggerClientEvent("pNotify:SendNotification", source,{text = "Du har ikke nogen pose!", type = "error", queue = "global", timeout = 5000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
				end
			else
					TriggerClientEvent("pNotify:SendNotification", source,{text = "Personen er ikke i håndjern!", type = "error", queue = "global", timeout = 5000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
			end
		end)
	else
		TriggerClientEvent("pNotify:SendNotification", source,{text = "Ingen spillere i nærheden.", type = "error", queue = "global", timeout = 5000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
	end
    end)
end)



