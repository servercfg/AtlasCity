local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "olsen_methcar")

RegisterServerEvent('olsen_methcar:start')
AddEventHandler('olsen_methcar:start', function()
	local _source = source
	local user_id = vRP.getUserId({_source})
	
	if vRP.getInventoryItemAmount({user_id,"acetone"}) >= 5 and vRP.getInventoryItemAmount({user_id,"lithium"}) >= 2 and vRP.getInventoryItemAmount({user_id,"methlab"}) >= 1 then
		if vRP.getInventoryItemAmount({user_id,"meth"}) >= 200 then
				TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Du kan ikke holde mere Meth.', length = '5000', style = {}})
		else
			TriggerClientEvent('olsen_methcar:startprod', _source)
			PerformHttpRequest('https://discordapp.com/api/webhooks/773264798577852486/-2HwFkLLG4g7qgWo2zEk7f4lTw4YyFY3vhtCskXnqolFxt_Ev02TL1eW7KcmqDMtkhU-', function(err, text, headers) end, 'POST', json.encode({username = "Meth Logs", content = "**ID: "..user_id.." ** startede meth produktion"}), { ['Content-Type'] = 'application/json' })
			vRP.tryGetInventoryItem({user_id,"acetone",5,true})
			vRP.tryGetInventoryItem({user_id,"lithium",2,true})
		end

		
		
	else
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Du har ikke nok forsyninger til at begynde at producere Meth', length = '5000', style = {}})

	end
	
end)
RegisterServerEvent('olsen_methcar:stopf')
AddEventHandler('olsen_methcar:stopf', function(id)
	local _source = source
	local user_id = vRP.getUserId({_source})

		TriggerClientEvent('olsen_methcar:stopfreeze', _source, id)
	
end)
RegisterServerEvent('olsen_methcar:make')
AddEventHandler('olsen_methcar:make', function(posx,posy,posz)
	local _source = source
	local user_id = vRP.getUserId({_source})
	
	if vRP.getInventoryItemAmount({user_id,"methlab"}) >= 1 then
	
		local players = GetPlayers()
		for i=1, #players, 1 do
		TriggerClientEvent('olsen_methcar:smoke',players[i],posx,posy,posz, 'a') 
		end
	else
		TriggerClientEvent('olsen_methcar:stop', _source)
	end
end)
RegisterServerEvent('olsen_methcar:finish')
AddEventHandler('olsen_methcar:finish', function(quality)
	local _source = source
	local user_id = vRP.getUserId({_source})
	print(quality)
	local rnd = math.random(150, 300)
	vRP.giveInventoryItem({user_id,"meth",math.floor(quality / 2) + rnd,true})
	PerformHttpRequest('https://discordapp.com/api/webhooks/773264798577852486/-2HwFkLLG4g7qgWo2zEk7f4lTw4YyFY3vhtCskXnqolFxt_Ev02TL1eW7KcmqDMtkhU-', function(err, text, headers) end, 'POST', json.encode({username = "Meth Logs", content = "**ID: "..user_id.." ** fik "..rnd.." meth"}), { ['Content-Type'] = 'application/json' })
end)

RegisterServerEvent('olsen_methcar:blow')
AddEventHandler('olsen_methcar:blow', function(posx, posy, posz)
	local _source = source
	local user_id = vRP.getUserId({_source})
	
	local players = GetPlayers()
	for i=1, #players, 1 do
		TriggerClientEvent('olsen_methcar:blowup', players[i],posx, posy, posz)
		PerformHttpRequest('https://discordapp.com/api/webhooks/773264798577852486/-2HwFkLLG4g7qgWo2zEk7f4lTw4YyFY3vhtCskXnqolFxt_Ev02TL1eW7KcmqDMtkhU-', function(err, text, headers) end, 'POST', json.encode({username = "Meth Logs", content = "**ID: "..user_id.." ** eksploderede sin van"}), { ['Content-Type'] = 'application/json' })
	end
	vRP.tryGetInventoryItem({user_id,"methlab",1,true})
end)

