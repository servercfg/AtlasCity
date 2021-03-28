local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRPclient = Tunnel.getInterface("vRP","kaos-tackle")
vRP = Proxy.getInterface("vRP")

RegisterServerEvent('kaos:tryTackle')
AddEventHandler('kaos:tryTackle', function()
	local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})

    local _source = source

	if vRP.hasPermission({user_id, "tackle.pc"}) then
		vRPclient.getNearestPlayer(player,{5},function(nplayer)
			local nuser_id = vRP.getUserId({nplayer})
			if nuser_id ~= nil then
				TriggerClientEvent('kaos:getTackled', nplayer, player)
				TriggerClientEvent('kaos:playTackle', player)
			else
				vRPclient.notify(player,{"Ingen spiller i nærheden"})
			end
		end)
	end
end)