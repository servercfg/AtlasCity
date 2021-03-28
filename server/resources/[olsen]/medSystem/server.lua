local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "olsen_medsystem")

RegisterServerEvent('medSystem:print')
AddEventHandler('medSystem:print', function(req, pulse, area, blood, x, y, z, bleeding)

	local _source = source
	local user_id = vRP.getUserId({_source})
	Wait(100)
	
	local players = GetPlayers()
	for i=1, #players, 1 do
			TriggerClientEvent('medSystem:near', players[i] ,x ,y ,z , pulse, blood, area, bleeding)
		end
	
end)

RegisterCommand('med', function(source, args)
	if args[1] and GetPlayerName(args[1])  ~= nil then

	local targetPed = GetPlayerPed(args[1])
	TriggerClientEvent('medSystem:send', args[1], source)
	else
	TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Incorrect player ID!")
	end
end, false)