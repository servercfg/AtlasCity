--------------------------------------------------------------------------------------------
------- Created by OGKUSH#2625  - Made for AltasCity FiveM - Owned by Olsen1157#5852 -------
--------------------------------------------------------------------------------------------

local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","ac-repair")

RegisterNetEvent('ac-repairadvanced:removeKit')
AddEventHandler('ac-repairadvanced:removeKit', function()
	local _source = source
	local user_id = vRP.getUserId({_source})
	
	vRP.tryGetInventoryItem({user_id,"repairkitadv",1})
	vRP.giveInventoryItem({user_id,"Metalskrot",5,true})
	vRP.giveInventoryItem({user_id,"stål stykke",2,true})
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Repairkittet blev ødelagt under repairtionen', length = 2500, style = { ['background-color'] = '#dc1313', ['color'] = '#ffffff' } })
end)

RegisterNetEvent('ac-repair:removeKit')
AddEventHandler('ac-repair:removeKit', function()
	local _source = source
	local user_id = vRP.getUserId({_source})
	
	vRP.tryGetInventoryItem({user_id,"bread",1})
	vRP.giveInventoryItem({user_id,"Metalskrot",3,true})
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Repairkittet blev ødelagt under repairtionen', length = 2500, style = { ['background-color'] = '#dc1313', ['color'] = '#ffffff' } })
end)


RegisterNetEvent('ac-repair:buykit')
AddEventHandler('ac-repair:buykit', function()
	local _source = source
	local user_id = vRP.getUserId({_source}) 

	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Repairkittet blev ødelagt under repairtionen', length = 2500, style = { ['background-color'] = '#dc1313', ['color'] = '#ffffff' } })
end)

RegisterCommand('repair', function(_source, args, rawCommand)
	--TriggerClientEvent('vrp_repairadvanced:onUse', source)
	TriggerClientEvent('ac-repair:onUse', _source)
    end)