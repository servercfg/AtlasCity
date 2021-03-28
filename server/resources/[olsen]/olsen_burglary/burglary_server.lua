local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "olsen_burglary")

RegisterServerEvent('99kr-burglary:Add')
AddEventHandler('99kr-burglary:Add', function(item, qtty)
    local source = source
	local user_id = vRP.getUserId({source})
	vRP.giveInventoryItem({user_id,item,qtty,true})
end)

RegisterServerEvent('99kr-burglary:Remove')
AddEventHandler('99kr-burglary:Remove', function(item, qtty)
    local source = source
	local user_id = vRP.getUserId({source})
	vRP.tryGetInventoryItem({user_id,item,qtty,true})
end)

RegisterServerEvent('olsen_burglary:warn')
AddEventHandler('olsen_burglary:warn', function(x,y,z)
	message = "En nabo har anmeldt et husrøveri. Tjek GPS!"
	TriggerEvent('dispatchpolice', x, y, z, message)
	TriggerClientEvent("pNotify:SendNotification", source,{text = "Du blev spottet, politiet er informeret!", type = "error", queue = "global", timeout = 8000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
end)

