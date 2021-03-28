--[[
─────────────────────────────────────────────────────────────────────────────────────────────────────────
─██████──████████─██████████████─██████████████████─██████████████─██████████████─██████──────────██████─
─██░░██──██░░░░██─██░░░░░░░░░░██─██░░░░░░░░░░░░░░██─██░░░░░░░░░░██─██░░░░░░░░░░██─██░░██████████──██░░██─
─██░░██──██░░████─██░░██████░░██─████████████░░░░██─██░░██████░░██─██░░██████░░██─██░░░░░░░░░░██──██░░██─
─██░░██──██░░██───██░░██──██░░██─────────████░░████─██░░██──██░░██─██░░██──██░░██─██░░██████░░██──██░░██─
─██░░██████░░██───██░░██████░░██───────████░░████───██░░██──██░░██─██░░██──██░░██─██░░██──██░░██──██░░██─
─██░░░░░░░░░░██───██░░░░░░░░░░██─────████░░████─────██░░██──██░░██─██░░██──██░░██─██░░██──██░░██──██░░██─
─██░░██████░░██───██░░██████░░██───████░░████───────██░░██──██░░██─██░░██──██░░██─██░░██──██░░██──██░░██─
─██░░██──██░░██───██░░██──██░░██─████░░████─────────██░░██──██░░██─██░░██──██░░██─██░░██──██░░██████░░██─
─██░░██──██░░████─██░░██──██░░██─██░░░░████████████─██░░██████░░██─██░░██████░░██─██░░██──██░░░░░░░░░░██─
─██░░██──██░░░░██─██░░██──██░░██─██░░░░░░░░░░░░░░██─██░░░░░░░░░░██─██░░░░░░░░░░██─██░░██──██████████░░██─
─██████──████████─██████──██████─██████████████████─██████████████─██████████████─██████──────────██████─
─────────────────────────────────────────────────────────────────────────────────────────────────────────
]]--

local Proxy = module("vrp", "lib/Proxy")
local Tunnel = module("vrp", "lib/Tunnel")
local narkopris = 45

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vrp_kekmememememes")

RegisterServerEvent('drugs:item')
AddEventHandler('drugs:item', function(antal)
	local antal = antal
	local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})
	if vRP.tryGetInventoryItem({user_id,"amf",antal,false}) then -- ITEM
		TriggerClientEvent('cancel', player)
		narkopris = math.random(450, 550)
		local reward = narkopris -- PRIS 
		local udbetaling = reward*antal
		--vRP.giveMoney({user_id,udbetaling})
		Wait(6000)
		vRP.giveInventoryItem({user_id,"dirty_money",udbetaling,true})
		PerformHttpRequest('https://discordapp.com/api/webhooks/714055270505906298/FfXe6i8ZyGx8mvaybdInhuumcHSZv2X0B_NcW94w5DJeCI1RENwYhOOIEsrLiLmV_PI5', function(err, text, headers) end, 'POST', json.encode({username = "blackmarket", content = "**ID: "..user_id.."** solgte "..antal.." meth til npcér for "..udbetaling.."."}), { ['Content-Type'] = 'application/json' })

	elseif	vRP.tryGetInventoryItem({user_id,"kokain",antal,false}) then
		TriggerClientEvent('cancel', player)
		narkopris = math.random(475, 575)
		local reward = narkopris -- PRIS 
		local udbetaling = reward*antal
		--vRP.giveMoney({user_id,udbetaling})
		Wait(6000)
		vRP.giveInventoryItem({user_id,"dirty_money",udbetaling,true})
		PerformHttpRequest('https://discordapp.com/api/webhooks/773264798577852486/-2HwFkLLG4g7qgWo2zEk7f4lTw4YyFY3vhtCskXnqolFxt_Ev02TL1eW7KcmqDMtkhU-', function(err, text, headers) end, 'POST', json.encode({username = "blackmarket", content = "**ID: "..user_id.."** solgte "..antal.." lsd til npcér for "..udbetaling.."."}), { ['Content-Type'] = 'application/json' })
		
	elseif	vRP.tryGetInventoryItem({user_id,"lsd",antal,false}) then
		TriggerClientEvent('cancel', player)
		narkopris = math.random(350, 450)
		local reward = narkopris -- PRIS 
		local udbetaling = reward*antal
		--vRP.giveMoney({user_id,udbetaling})
		Wait(6000)
		vRP.giveInventoryItem({user_id,"dirty_money",udbetaling,true})
		PerformHttpRequest('https://discordapp.com/api/webhooks/773264798577852486/-2HwFkLLG4g7qgWo2zEk7f4lTw4YyFY3vhtCskXnqolFxt_Ev02TL1eW7KcmqDMtkhU-', function(err, text, headers) end, 'POST', json.encode({username = "blackmarket", content = "**ID: "..user_id.."** solgte "..antal.." kokain til npcér for "..udbetaling.."."}), { ['Content-Type'] = 'application/json' })

	elseif	vRP.tryGetInventoryItem({user_id,"meth",antal,false}) then
		TriggerClientEvent('cancel', player)
		narkopris = math.random(500, 600)
		local reward = narkopris -- PRIS 
		local udbetaling = reward*antal
		--vRP.giveMoney({user_id,udbetaling})
		Wait(6000)
		vRP.giveInventoryItem({user_id,"dirty_money",udbetaling,true})
		PerformHttpRequest('https://discordapp.com/api/webhooks/773264798577852486/-2HwFkLLG4g7qgWo2zEk7f4lTw4YyFY3vhtCskXnqolFxt_Ev02TL1eW7KcmqDMtkhU-', function(err, text, headers) end, 'POST', json.encode({username = "blackmarket", content = "**ID: "..user_id.."** solgte "..antal.." kokain til npcér for "..udbetaling.."."}), { ['Content-Type'] = 'application/json' })
	elseif	vRP.tryGetInventoryItem({user_id,"klump10",antal,false}) then
		TriggerClientEvent('cancel', player)
		narkopris = math.random(300, 400)
		local reward = narkopris -- PRIS 
		local udbetaling = reward*antal
		--vRP.giveMoney({user_id,udbetaling})
		Wait(6000)
		vRP.giveInventoryItem({user_id,"dirty_money",udbetaling,true})
		PerformHttpRequest('https://discordapp.com/api/webhooks/773264798577852486/-2HwFkLLG4g7qgWo2zEk7f4lTw4YyFY3vhtCskXnqolFxt_Ev02TL1eW7KcmqDMtkhU-', function(err, text, headers) end, 'POST', json.encode({username = "blackmarket", content = "**ID: "..user_id.."** solgte "..antal.." skunk(10g) til npcér for "..udbetaling.."."}), { ['Content-Type'] = 'application/json' })
	else
		TriggerClientEvent("pNotify:SendNotification", source,{text = "Du har ikke flere stoffer!", type = "error", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
		TriggerClientEvent('done', player)
		TriggerClientEvent('cancel', player)
	end
end)

RegisterServerEvent('drugs:money')
AddEventHandler('drugs:money', function(antal)
	local antal = antal
	local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})
	local reward = narkopris -- PRIS 
	local udbetaling = reward*antal
	TriggerClientEvent("pNotify:SendNotification", source,{text = "Du solgte "..antal.." stk.", type = "error", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
end)

RegisterServerEvent('drugs:checkitem')
AddEventHandler('drugs:checkitem', function()
	local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})
	local new_weight = vRP.getInventoryWeight({user_id})+vRP.getItemWeight({"dirty_money"})
    if new_weight <= vRP.getInventoryMaxWeight({user_id}) then
			if vRP.hasInventoryItem({user_id,"meth",1}) or vRP.hasInventoryItem({user_id,"lsd",1}) or vRP.hasInventoryItem({user_id,"kokain",1}) or vRP.hasInventoryItem({user_id,"amf",1}) or vRP.hasInventoryItem({user_id,"klump10",1}) then
				TriggerClientEvent('playerhasdrugs', player)
			else
				TriggerClientEvent('playerhasnodrugs', player)
			end
		else
			TriggerClientEvent('playerhasnodrugs', player)
		end
end)

RegisterServerEvent('vRP_drugNPC:policia')
AddEventHandler('vRP_drugNPC:policia', function(x,y,z)
message = "En person forsøger at sælge mig stoffer. Check GPS!"
		TriggerEvent('dispatchpolice', x, y, z, message)
end)