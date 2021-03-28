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
cfg = module("kaz_tuning", "cfg/tuning")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","kaz_tuning")

vRPcc = {}
Tunnel.bindInterface("kaz_tuning",vRPcc)
Proxy.addInterface("kaz_tuning",vRPcc)
vRPccC = Tunnel.getInterface("kaz_tuning","kaz_tuning")

MySQL.createCommand("vRP/kaz_tuning:hent1","SELECT vehicle_mods11, vehicle_mods12, vehicle_mods13, vehicle_turbo FROM vrp_user_vehicles WHERE user_id = @kundeid AND vehicle = @model")
MySQL.createCommand("vRP/kaz_tuning:motor1","UPDATE vrp_user_vehicles SET vehicle_mods11 = @motorupgrade WHERE user_id = @idkunde AND vehicle = @modellen")
MySQL.createCommand("vRP/kaz_tuning:gear1","UPDATE vrp_user_vehicles SET vehicle_mods13 = @gearupgrade WHERE user_id = @idkunde AND vehicle = @modellen")
MySQL.createCommand("vRP/kaz_tuning:brems1","UPDATE vrp_user_vehicles SET vehicle_mods12 = @bremsupgrade WHERE user_id = @idkunde AND vehicle = @modellen")
MySQL.createCommand("vRP/kaz_tuning:turbo1","UPDATE vrp_user_vehicles SET vehicle_turbo = @turboupgrade WHERE user_id = @idkunde AND vehicle = @modellen")

RegisterServerEvent('kaz:infohentet')
AddEventHandler('kaz:infohentet', function(name)
local lsource = source
user_id = vRP.getUserId({source})
MySQL.query('vRP/kaz_tuning:hent1', {kundeid = user_id, model = name}, function(data)
				for k,v in pairs(data) do
							if v then
		motor = tonumber(data[1].vehicle_mods11)
		bremser = tonumber(data[1].vehicle_mods12)
		gearing = tonumber(data[1].vehicle_mods13)
		turbo = data[1].vehicle_turbo
		if turbo == "off" then
			turbony = 1
		elseif turbo == "on" then 
			turbony = 2
		end
		local user_id = vRP.getUserId({lsource})
		if vRP.hasPermission({user_id,"repair.service"}) then
			TriggerClientEvent('kaz_tuning:sendinfo', -1, motor, bremser, gearing, turbony)
			TriggerClientEvent('kaz_tuning:sendid', -1, user_id, name)
		else
			TriggerClientEvent("pNotify:SendNotification", lsource,{text = "Du er ikke mekaniker.", type = "error", queue = "global", timeout = 10000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
		end
			end
			end
		end)
end)

RegisterServerEvent('kaz:updatemotor')
AddEventHandler('kaz:updatemotor', function(motoren, idkunde, modellen, pris)
local user_id = vRP.getUserId({source})
idkunde = idkunde
modellen = modellen
motorupgrade = motoren
pris = pris
		if vRP.tryFullPayment({user_id,pris}) then
		TriggerClientEvent("pNotify:SendNotification", source,{text = "Du monterede ny motor.", type = "error", queue = "global", timeout = 10000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
		MySQL.execute('vRP/kaz_tuning:motor1', {motorupgrade = motorupgrade, idkunde = idkunde, modellen = modellen})
		else
		TriggerClientEvent("pNotify:SendNotification", source,{text = "Du har ikke råd.", type = "error", queue = "global", timeout = 10000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
		end
end)

RegisterServerEvent('kaz:updatebrems')
AddEventHandler('kaz:updatebrems', function(bremserne, idkunde, modellen, pris)
local user_id = vRP.getUserId({source})
idkunde = idkunde
modellen = modellen
bremsupgrade = bremserne
pris = pris
		if vRP.tryFullPayment({user_id,pris}) then
		TriggerClientEvent("pNotify:SendNotification", source,{text = "Du monterede nye bremser.", type = "error", queue = "global", timeout = 10000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
		MySQL.execute('vRP/kaz_tuning:brems1', {bremsupgrade = bremsupgrade, idkunde = idkunde, modellen = modellen})
		else
		TriggerClientEvent("pNotify:SendNotification", source,{text = "Du har ikke råd.", type = "error", queue = "global", timeout = 10000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
		end
end)

RegisterServerEvent('kaz:updategear')
AddEventHandler('kaz:updategear', function(gearingen, idkunde, modellen, pris)
local user_id = vRP.getUserId({source})
idkunde = idkunde
modellen = modellen
gearupgrade = gearingen
pris = pris
		if vRP.tryFullPayment({user_id,pris}) then
		TriggerClientEvent("pNotify:SendNotification", source,{text = "Du monterede nyt gear.", type = "error", queue = "global", timeout = 10000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
		MySQL.execute('vRP/kaz_tuning:gear1', {gearupgrade = gearupgrade, idkunde = idkunde, modellen = modellen})
		else
		TriggerClientEvent("pNotify:SendNotification", source,{text = "Du har ikke råd.", type = "error", queue = "global", timeout = 10000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
		end
end)

RegisterServerEvent('kaz:updateturbo')
AddEventHandler('kaz:updateturbo', function(turboen, idkunde, modellen, pris)
local user_id = vRP.getUserId({source})
idkunde = idkunde
modellen = modellen
turboupgrade = turboen
pris = pris
		if vRP.tryFullPayment({user_id,pris}) then
		TriggerClientEvent("pNotify:SendNotification", source,{text = "Du monterede/demonterede turbo.", type = "error", queue = "global", timeout = 10000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
		MySQL.execute('vRP/kaz_tuning:turbo1', {turboupgrade = turboupgrade, idkunde = idkunde, modellen = modellen})
		else
		TriggerClientEvent("pNotify:SendNotification", source,{text = "Du har ikke råd.", type = "error", queue = "global", timeout = 10000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
		end
end)

