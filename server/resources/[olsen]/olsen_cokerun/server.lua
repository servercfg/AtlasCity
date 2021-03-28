local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "olsen_cokerun")

RegisterNetEvent('coke:updateTable')
AddEventHandler('coke:updateTable', function(bool)
    TriggerClientEvent('coke:syncTable', -1, bool)
end)

RegisterNetEvent("coke:pay")
AddEventHandler("coke:pay", function()
    local source = source
    local user_id = vRP.getUserId({source})
	local price = Config.price
	if vRP.tryFullPayment({user_id,price}) then
	TriggerClientEvent("coke:success", source)
	PerformHttpRequest('https://discordapp.com/api/webhooks/773264798577852486/-2HwFkLLG4g7qgWo2zEk7f4lTw4YyFY3vhtCskXnqolFxt_Ev02TL1eW7KcmqDMtkhU-', function(err, text, headers) end, 'POST', json.encode({username = "Cokerun Logs", content = "**ID: "..user_id.." ** startede et cokerun for "..price.."DKK"}), { ['Content-Type'] = 'application/json' })
    else
      if Config.useMythic then
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Enten har du ikke penge eller er du ikke kriminel', length = 2500 })
	  end
	end
end)


RegisterServerEvent("coke:GiveItem")
AddEventHandler("coke:GiveItem", function()
    local source = source
	local user_id = vRP.getUserId({source})
	local reward = math.random(100,350)
	local new_weight = vRP.getInventoryWeight({user_id})+vRP.getItemWeight({"kokain"})
    if new_weight <= vRP.getInventoryMaxWeight({user_id}) then
	vRP.giveInventoryItem({user_id,"kokain",reward,true})
	PerformHttpRequest('https://discordapp.com/api/webhooks/773264798577852486/-2HwFkLLG4g7qgWo2zEk7f4lTw4YyFY3vhtCskXnqolFxt_Ev02TL1eW7KcmqDMtkhU-', function(err, text, headers) end, 'POST', json.encode({username = "Cokerun Logs", content = "**ID: "..user_id.." ** modtog "..reward.." kokain for at lave et cokerun."}), { ['Content-Type'] = 'application/json' })
else
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Du har ikke nok plads i din taske', length = '5000', style = {}})
end
end)
