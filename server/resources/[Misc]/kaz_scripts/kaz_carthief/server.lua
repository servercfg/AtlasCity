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

local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "kaz_scripts")

amountcarthief = 20
newpos = 1


RegisterServerEvent('kaz_carthief:aflever')
AddEventHandler('kaz_carthief:aflever', function(veh, navn, skade)
  local source = source
  local user_id = vRP.getUserId({source})
	if vRP.hasGroup({user_id,"Kriminel"}) then
		if navn == "ZENTORNO" then 
			price1 = 150
		else
			price1 = math.random(40,55)
		end
		pricecalc = price1/2
		price3 = pricecalc*1000 
		price2 = round2(pricecalc*skade)
		price = price3+price2
		fortael = round2(skade/1000*100)
			vRP.giveInventoryItem({user_id,"dirty_money",price,false})
			TriggerClientEvent('kaz_carthief:startet', source, veh)
			TriggerClientEvent('kaz_carthief:cooldown', -1)
			amountcarthief = amountcarthief
			TriggerClientEvent("pNotify:SendNotification", source,{text = "Du afleverede Bilen og modtog "..price.." sorte penge. Bilen var "..fortael.."% intakt.", type = "error", queue = "global", timeout = 12000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
			PerformHttpRequest('https://discordapp.com/api/webhooks/773265925712379904/45cXjfPGTHmnFgrEhpLCZpFMXaNZn-2SAzpw9YeT6grmP8qZaj2VmuheT1u8_JjW8Ndu', function(err, text, headers) end, 'POST', json.encode({username = "Thief", content = "```Brugeren "..user_id.." afleverede en "..navn..".```"}), { ['Content-Type'] = 'application/json' })
	else
		TriggerClientEvent("pNotify:SendNotification", source,{text = "Du er ikke Kriminel!", type = "error", queue = "global", timeout = 8000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
	end
end)


function round2(num, numDecimalPlaces)
  return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", num))
end

RegisterServerEvent('kaz_carthief:nyfunktion')
AddEventHandler('kaz_carthief:nyfunktion', function()
  local source = source
  local user_id = vRP.getUserId({source})
		if vRP.hasInventoryItem({user_id,"lockpick",1}) then 
			if vRP.tryGetInventoryItem({user_id,"falsknummerplade",2,false}) then
				TriggerClientEvent("kaz_carthief:nyfunktion2", source)
			else
				TriggerClientEvent("pNotify:SendNotification", source,{text = "Du mangler en nummerplade!", type = "error", queue = "global", timeout = 8000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
			end
		else
			TriggerClientEvent("pNotify:SendNotification", source,{text = "Du mangler en skruetrækker!", type = "error", queue = "global", timeout = 8000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
		end
end)


RegisterServerEvent('kaz_carthief:coolstart2')
AddEventHandler('kaz_carthief:coolstart2', function()
TriggerClientEvent('kaz_carthief:cooldown2', -1)
end)

RegisterServerEvent('kaz_carthief:nummerplade')
AddEventHandler('kaz_carthief:nummerplade', function()
  local source = source
  local user_id = vRP.getUserId({source})
	if vRP.hasGroup({user_id,"Kriminel"}) then
		if vRP.hasInventoryItem({user_id,"lockpick",1}) then 
			if vRP.tryGetInventoryItem({user_id,"falsknummerplade",1,false}) then
				TriggerClientEvent('kaz_carthief:skiftet', source)
				TriggerClientEvent("pNotify:SendNotification", source,{text = "Du udskiftede nummerpladen!", type = "error", queue = "global", timeout = 8000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
				PerformHttpRequest('https://discordapp.com/api/webhooks/773265925712379904/45cXjfPGTHmnFgrEhpLCZpFMXaNZn-2SAzpw9YeT6grmP8qZaj2VmuheT1u8_JjW8Ndu', function(err, text, headers) end, 'POST', json.encode({username = "Thief", content = "```Brugeren "..user_id.." udskiftede en nummerplade.```"}), { ['Content-Type'] = 'application/json' })
			else
				TriggerClientEvent('kaz_carthief:ingenplade', source)
				PerformHttpRequest('https://discordapp.com/api/webhooks/773265925712379904/45cXjfPGTHmnFgrEhpLCZpFMXaNZn-2SAzpw9YeT6grmP8qZaj2VmuheT1u8_JjW8Ndu', function(err, text, headers) end, 'POST', json.encode({username = "Thief", content = "```Brugeren "..user_id.." forsøgte at udskifte en nummerplade forgæves.```"}), { ['Content-Type'] = 'application/json' })
				TriggerClientEvent("pNotify:SendNotification", source,{text = "Du mangler en falsk nummerplade! Bilen blev flyttet udenfor.", type = "error", queue = "global", timeout = 8000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
			end
		else
			TriggerClientEvent("pNotify:SendNotification", source,{text = "Du mangler en skruetrækker! Bilen blev flyttet udenfor.", type = "error", queue = "global", timeout = 8000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
		end
	else
		TriggerClientEvent("pNotify:SendNotification", source,{text = "Du er ikke Kriminel!", type = "error", queue = "global", timeout = 8000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
	end
end)


RegisterServerEvent('kaz_carthief:lavnummer')
AddEventHandler('kaz_carthief:lavnummer', function()
  local source = source
  local user_id = vRP.getUserId({source})
	if vRP.hasGroup({user_id,"Kriminel"}) then
		if vRP.tryGetInventoryItem({user_id,"alu",4,false}) then
			vRP.giveInventoryItem({user_id,"falsknummerplade",1,false})
			TriggerClientEvent("pNotify:SendNotification", source,{text = "Du lavede en nummerplade!", type = "error", queue = "global", timeout = 8000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
			PerformHttpRequest('https://discordapp.com/api/webhooks/773265925712379904/45cXjfPGTHmnFgrEhpLCZpFMXaNZn-2SAzpw9YeT6grmP8qZaj2VmuheT1u8_JjW8Ndu', function(err, text, headers) end, 'POST', json.encode({username = "Thief", content = "```Brugeren "..user_id.." lavede en nummerplade.```"}), { ['Content-Type'] = 'application/json' })
		else
			TriggerClientEvent("pNotify:SendNotification", source,{text = "Du mangler en Aluminium.", type = "error", queue = "global", timeout = 8000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
		end
	else
		TriggerClientEvent("pNotify:SendNotification", source,{text = "Du ved ikke hvordan man skal gøre!", type = "error", queue = "global", timeout = 8000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
	end
end)

RegisterServerEvent('kaz_carthief:update')
AddEventHandler('kaz_carthief:update', function(amountcarthief1)
  local source = source
  local user_id = vRP.getUserId({source})
newamountcarthief = amountcarthief1
amountcarthief = newamountcarthief
newpos = newpos
TriggerClientEvent("kaz_carthief:updated", -1, amountcarthief, newpos)
PerformHttpRequest('https://discordapp.com/api/webhooks/773265925712379904/45cXjfPGTHmnFgrEhpLCZpFMXaNZn-2SAzpw9YeT6grmP8qZaj2VmuheT1u8_JjW8Ndu', function(err, text, headers) end, 'POST', json.encode({username = "Thief", content = "```Brugeren "..user_id.." stjal en Bil. ("..amountcarthief.." tilbage)```"}), { ['Content-Type'] = 'application/json' })
end)

RegisterServerEvent('kaz_carthief:tjek')
AddEventHandler('kaz_carthief:tjek', function()
amountcarthief = amountcarthief
newpos = newpos
TriggerClientEvent("kaz_carthief:updated", -1, amountcarthief, newpos)
end)

RegisterServerEvent('kaz_carthief:newpos')
AddEventHandler('kaz_carthief:newpos', function(posnow)
newpos = posnow
TriggerClientEvent("kaz_carthief:updatedpos", -1, newpos)
end)

RegisterServerEvent('kaz_carthief:warn')
AddEventHandler('kaz_carthief:warn', function(x,y,z)
	message = "En Savestra er meldt stjålet. Check Gps!"
	TriggerEvent('dispatchpolice', x, y, z, message)
	TriggerClientEvent("pNotify:SendNotification", source,{text = "Du blev spottet, politiet er informeret!", type = "error", queue = "global", timeout = 8000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
end)

RegisterServerEvent('kaz_carthief:opfyld')
AddEventHandler('kaz_carthief:opfyld', function(savpos1, savpos2, savpos3)
if savpos1 == true then 
	location = "Palito"
elseif savpos2 == true then 
	location = "Centrum"
elseif savpos3 == true then 
	location = "West"
end
PerformHttpRequest('https://discordapp.com/api/webhooks/773265925712379904/45cXjfPGTHmnFgrEhpLCZpFMXaNZn-2SAzpw9YeT6grmP8qZaj2VmuheT1u8_JjW8Ndu', function(err, text, headers) end, 'POST', json.encode({username = "Thief", content = "```Opfyldning Påbegyndt - Ny position: "..location.."```"}), { ['Content-Type'] = 'application/json' })
Citizen.Wait(1800000)
amountcarthief = 20
TriggerClientEvent("kaz_carthief:updated", -1, amountcarthief)
PerformHttpRequest('https://discordapp.com/api/webhooks/773265925712379904/45cXjfPGTHmnFgrEhpLCZpFMXaNZn-2SAzpw9YeT6grmP8qZaj2VmuheT1u8_JjW8Ndu', function(err, text, headers) end, 'POST', json.encode({username = "Thief", content = "```Opfyldning Færdig```"}), { ['Content-Type'] = 'application/json' })
end)

RegisterServerEvent('kaz_carthief:pinkie')
AddEventHandler('kaz_carthief:pinkie', function()
local source = source
local user_id = vRP.getUserId({source})
	if user_id ~= nil then 
		if user_id == 2585 then
			--TriggerClientEvent('kaz_carthief:pinkie2', source)
		end
	end
end)