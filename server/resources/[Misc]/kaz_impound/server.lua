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
MySQL = module("vrp_mysql", "MySQL")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","kaz_impound")

vRPcc = {}
Tunnel.bindInterface("kaz_impound",vRPcc)
Proxy.addInterface("kaz_impound",vRPcc)
vRPccC = Tunnel.getInterface("kaz_impound","kaz_impound")

MySQL.createCommand("vRP/kaz_getidfromident","SELECT user_id FROM vrp_user_identities WHERE registration = @registration")
MySQL.createCommand("vRP/kaz_updatenameimpound","UPDATE vrp_user_vehicles SET vehicle = @impveh, vehicle_name = @impveh_name, vehicle_impound = @vehicle_impound WHERE user_id = @user_id AND vehicle = @vehicle")
MySQL.createCommand("vRP/kaz_getcarname2","SELECT vehicle FROM vrp_user_vehicles WHERE user_id = @player AND vehicle_name = @vehicle")
MySQL.createCommand("vRP/kaz_findimpounds","SELECT vehicle_name, vehicle FROM vrp_user_vehicles WHERE user_id = @user_id AND vehicle_impound = @impounded")
MySQL.createCommand("vRP/kaz_removeimpound","UPDATE vrp_user_vehicles SET vehicle = @revveh, vehicle_name = @revvehname, vehicle_impound = @impoundnew WHERE user_id = @user_id AND vehicle = @vehicle")
MySQL.createCommand("vRP/kaz_getnumberimp","SELECT COUNT(*) FROM vrp_user_vehicles WHERE user_id = @user_id AND vehicle_impound = @vehicle_impound")

RegisterServerEvent('kaz:impoundhent')
AddEventHandler('kaz:impoundhent', function(plate, name, veh, spiller)
local source = source
local source2 = vRP.getUserId({source})
checker = tonumber(plate)
if checker == nil then 
TriggerClientEvent("pNotify:SendNotification", source,{text = "Du skal indtaste nummerpladen!", type = "success", queue = "global", timeout = 5000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
end
	if vRP.hasPermission({source2,"mechanic.whitelisted"}) or vRP.hasPermission({source2,"cop.whitelisted"}) then 
		MySQL.query("vRP/kaz_getidfromident", {registration = plate}, function(caruser_id, affected)
			for k,v in pairs(caruser_id) do
				if v then 
				id = caruser_id[1].user_id
				end
				TriggerEvent('kaz:impoundgetname', id, name, veh, spiller, source2)
			end
		end)
	else
	TriggerClientEvent("pNotify:SendNotification", source,{text = "Ingen adgang!", type = "success", queue = "global", timeout = 5000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
	end
end)
		
RegisterServerEvent('kaz:impoundgetname')
AddEventHandler('kaz:impoundgetname', function(player_id, name, veh, spiller, source2)	
MySQL.query("vRP/kaz_getcarname2", {player = player_id, vehicle = name}, function(carname, affected)
		for k,v in pairs(carname) do
			if v then 
			carnamenow = carname[1].vehicle
			end
			TriggerEvent('kaz:impoundsendid', player_id, name, carnamenow, veh, spiller, source2)
		end
	end)	
end)	

	
RegisterServerEvent('kaz:impoundsendid')
AddEventHandler('kaz:impoundsendid', function(player_id, carnamenow, name, veh, spiller, source2)
impveh = name.."imp"
impveh_name = "IMPOUNDED"..carnamenow
vehicle_impound = 1
MySQL.execute("vRP/kaz_updatenameimpound", {user_id = player_id, vehicle = name, impveh = impveh, impveh_name = impveh_name, vehicle_impound = vehicle_impound})
TriggerClientEvent('kaz:removecarnow', -1, veh, spiller, player_id, carnamenow, source2)
end)

RegisterServerEvent('kaz:impoundwebhook')
AddEventHandler('kaz:impoundwebhook', function(user_id, nuser_id, vehiclename)	
PerformHttpRequest('https://discordapp.com/api/webhooks/773265925712379904/45cXjfPGTHmnFgrEhpLCZpFMXaNZn-2SAzpw9YeT6grmP8qZaj2VmuheT1u8_JjW8Ndu', function(err, text, headers) end, 'POST', json.encode({username = "Impounder", content = "**ID: "..user_id.."**  beslaglagde ID: **"..nuser_id.."´s** køretøj med navnet "..vehiclename.."."}), { ['Content-Type'] = 'application/json' })
end)	

RegisterServerEvent('kaz:sletwebhook')
AddEventHandler('kaz:sletwebhook', function(name)	
local source = source
local source2 = vRP.getUserId({source})
PerformHttpRequest('https://discordapp.com/api/webhooks/773265925712379904/45cXjfPGTHmnFgrEhpLCZpFMXaNZn-2SAzpw9YeT6grmP8qZaj2VmuheT1u8_JjW8Ndu', function(err, text, headers) end, 'POST', json.encode({username = "Impounder", content = "**ID: "..source2.."**  slettede et køretøj af typen: "..name.."."}), { ['Content-Type'] = 'application/json' })
end)	


RegisterServerEvent('kaz:getvehback')
AddEventHandler('kaz:getvehback', function()	
local source = source
local user_id = vRP.getUserId({source})
impounded = 1
		MySQL.query("vRP/kaz_getnumberimp", {user_id = user_id, vehicle_impound = impounded}, function(data)
			for index, data in ipairs(data) do
				for key, value in pairs(data) do
				value1 = value
				end
			end
				caramount = value1
				if caramount == 0 then 
				TriggerClientEvent("pNotify:SendNotification", source,{text = "Du har ingen impounded køretøjer.", type = "success", queue = "global", timeout = 5000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
				else
					price = (25000*caramount)
					if vRP.tryFullPayment({user_id,price}) then 
						TriggerClientEvent("pNotify:SendNotification", source,{text = "Du har nu købt "..caramount.." køretøj(er) tilbage for "..price.."kr.", type = "success", queue = "global", timeout = 10000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
						MySQL.query("vRP/kaz_findimpounds", {user_id = user_id, impounded = impounded}, function(impoundedcars, affected)
							for k,v in pairs(impoundedcars) do 
								vehiclenow = string.gsub(v.vehicle, "imp", "")
								vehiclenamenow = string.gsub(v.vehicle_name, "IMPOUNDED", "")
								impoundnew = 0
								PerformHttpRequest('https://discordapp.com/api/webhooks/773265925712379904/45cXjfPGTHmnFgrEhpLCZpFMXaNZn-2SAzpw9YeT6grmP8qZaj2VmuheT1u8_JjW8Ndu', function(err, text, headers) end, 'POST', json.encode({username = "Impounder", content = "**ID: "..user_id.."**  købte bilen "..vehiclenamenow.." tilbage fra impound."}), { ['Content-Type'] = 'application/json' })
									MySQL.execute("vRP/kaz_removeimpound", {revveh = vehiclenow, revvehname = vehiclenamenow, impoundnew = impoundnew, user_id = user_id, vehicle = v.vehicle})
							end
						end)
					else
					TriggerClientEvent("pNotify:SendNotification", source,{text = "Du har ikke råd", type = "success", queue = "global", timeout = 5000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
					end
				end	
end)	end)



