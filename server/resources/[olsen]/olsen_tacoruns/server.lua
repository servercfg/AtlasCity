local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "olsen_tacoruns")

RegisterServerEvent('olsen_tacoruns:add')
AddEventHandler('olsen_tacoruns:add', function(type, amount, name)
	local source = source
	local user_id = vRP.getUserId({source})

	if type == 'money' then
		vRP.giveMoney({user_id,amount})
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Du modtog '..amount..'DKK', length = 2500 })
	elseif type == 'item' then
		vRP.giveInventoryItem({user_id,name,amount,true})
	end
end)

RegisterServerEvent('olsen_tacoruns:addtaco')
AddEventHandler('olsen_tacoruns:addtaco', function(type, amount, name)
	local source = source
	local user_id = vRP.getUserId({source})

	if type == 'item' then
		vRP.giveInventoryItem({user_id,"taco",1,true})
	end
end)

RegisterServerEvent('olsen_tacoruns:addcola')
AddEventHandler('olsen_tacoruns:addcola', function(type, amount, name)
	local source = source
	local user_id = vRP.getUserId({source})

	if type == 'item' then
		vRP.giveInventoryItem({user_id,"cola",1,true})
	end
end)

RegisterServerEvent('olsen_tacoruns:remove')
AddEventHandler('olsen_tacoruns:remove', function(type, amount, name)
	local source = source
    local user_id = vRP.getUserId({source})

	if type == 'money' then
		vRP.tryFullPayment({user_id,amount})
	elseif type == 'item' then
		vRP.tryGetInventoryItem({user_id,name,amount,true})
	else
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Du har ikke nogle tacos', length = 2500 })
	end
end)

RegisterServerEvent('olsen_tacoruns:server')
AddEventHandler('olsen_tacoruns:server', function()
	local source = source
	local user_id = vRP.getUserId({source})
	    if vRP.getBankMoney({user_id}) then
		vRP.tryFullPayment({user_id,Config.StartTaco})
		
	else
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Du har ikke nok penge til at starte en taco levering', length = 2500 })
	end
end)

RegisterServerEvent('olsen_tacoruns:buytaco')
AddEventHandler('olsen_tacoruns:buytaco', function()
	local source = source
	local user_id = vRP.getUserId({source})

	    if vRP.tryFullPayment({user_id,25}) then
		vRP.giveInventoryItem({user_id,"taco",1,true})
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = 'Du købte en taco til 25DKK', length = 2500 })	
	else
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Du har ikke nok penge.', length = 2500 })
	end
end)

RegisterServerEvent('olsen_tacoruns:selltaco')
AddEventHandler('olsen_tacoruns:selltaco', function()
	local source = source
	local user_id = vRP.getUserId({source})
	local antal = math.random(100,250)

	if vRP.getInventoryItemAmount({user_id,"tacopack"}) >= 1 then
		 vRP.tryGetInventoryItem({user_id,"tacopack",1,true})
		 vRP.giveMoney({user_id,antal})
		 TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = 'Du solgte en taco til '..antal..'DKK', length = 2500 })		
	else
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Du har ikke nok tacos.', length = 2500 })
	end
end)

RegisterServerEvent('olsen_tacoruns:delivery')
AddEventHandler('olsen_tacoruns:delivery', function()
	local source = source
	local user_id = vRP.getUserId({source})
	local reward = math.random(1500,3000)

	if vRP.getInventoryItemAmount({user_id,"tacopack"}) >= 1 then
		 vRP.tryGetInventoryItem({user_id,"tacopack",1,true})
		 vRP.giveMoney({user_id,reward})
		 TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = 'Du solgte en taco til '..reward..'DKK', length = 2500 })		
	else
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Du har ikke nok poser med tacos.', length = 2500 })
	end
end)