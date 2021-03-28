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

MySQL = module("vrp_mysql", "MySQL")
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
KazAreaInUse = {}

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "kaz_garage")

MySQL.createCommand("vRP/KazGetVehicles","SELECT * FROM vrp_user_vehicles WHERE user_id = @user_id")
MySQL.createCommand("vRP/KazLoadVehicles", "SELECT * FROM vrp_user_vehicles WHERE user_id = @user_id AND vehicle = @vehicle") -- added for lscustoms
MySQL.createCommand("vRP/skiftnavn","UPDATE vrp_user_vehicles SET vehicle_name = @name WHERE user_id = @user_id AND vehicle = @vehicle")

RegisterServerEvent('KazGarage:CheckForVeh')
RegisterServerEvent('KazGarage:LoadLocal')
RegisterServerEvent('KazGarage:LoadServer')
RegisterServerEvent('KazGarage:InUse')
RegisterServerEvent('KazGarage:NotInUse')
RegisterServerEvent('KazGarage:LoadInUse')

Citizen.CreateThread(function()
	for i = 1,cfg.KazGarageAmount do
		KazAreaInUse[i] = false
	end
end)

AddEventHandler("KazGarage:LoadInUse", function()
local source = source
TriggerClientEvent('KazGarage:LoadInUse2', source, KazAreaInUse)
end)

AddEventHandler("KazGarage:InUse", function(sted)
KazAreaInUse[sted] = true
TriggerClientEvent('KazGarage:AreaUpdate', -1, KazAreaInUse)
end) 

AddEventHandler("KazGarage:NotInUse", function(sted)
KazAreaInUse[sted] = false
TriggerClientEvent('KazGarage:AreaUpdate', -1, KazAreaInUse)
end)


AddEventHandler("KazGarage:CheckForVeh", function()
	local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})
    MySQL.query("vRP/KazGetVehicles", {user_id = user_id}, function(pvehicles, affected)
      local vehicles = {}
      for k,v in ipairs(pvehicles) do
		if v.veh_type == "car" or v.veh_type == "bike" or v.veh_type == "citybike" then
		  table.insert(vehicles, {["vehicle_model"] = v.vehicle, ["vehicle_name"] = v.vehicle_name})
		end
      end
	  TriggerClientEvent('KazGarage:GetVehicles', player, vehicles)
	end)
end)

AddEventHandler('KazGarage:LoadLocal', function(vehicle)
	local source = source
	local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})
	if user_id ~= nil then 
		if player ~= nil then 
			if vehicle ~= nil then 
				MySQL.query("vRP/KazLoadVehicles", {user_id = user_id, vehicle = vehicle}, function(result, affected)
				  if result ~= nil then 
				  TriggerClientEvent('KazGarage:LoadLocal2', player, result[1].veh_type,vehicle,result[1].vehicle_plate, result[1].vehicle_colorprimary, result[1].vehicle_colorsecondary, result[1].vehicle_pearlescentcolor, result[1].vehicle_wheelcolor, result[1].vehicle_plateindex, result[1].vehicle_neoncolor1, result[1].vehicle_neoncolor2, result[1].vehicle_neoncolor3, result[1].vehicle_windowtint, result[1].vehicle_wheeltype, result[1].vehicle_mods0, result[1].vehicle_mods1, result[1].vehicle_mods2, result[1].vehicle_mods3, result[1].vehicle_mods4, result[1].vehicle_mods5, result[1].vehicle_mods6, result[1].vehicle_mods7, result[1].vehicle_mods8, result[1].vehicle_mods9, result[1].vehicle_mods10, result[1].vehicle_mods11, result[1].vehicle_mods12, result[1].vehicle_mods13, result[1].vehicle_mods14, result[1].vehicle_mods15, result[1].vehicle_mods16, result[1].vehicle_turbo, result[1].vehicle_tiresmoke, result[1].vehicle_xenon, result[1].vehicle_mods23, result[1].vehicle_mods24, result[1].vehicle_neon0, result[1].vehicle_neon1, result[1].vehicle_neon2, result[1].vehicle_neon3, result[1].vehicle_bulletproof, result[1].vehicle_smokecolor1, result[1].vehicle_smokecolor2, result[1].vehicle_smokecolor3, result[1].vehicle_modvariation)
				  livery =  result[1].vehicle_livery
				  TriggerClientEvent('kaz_liveries:hentlivery', player, livery)
				  end
				end)
			end
		end
	end
end)

AddEventHandler('KazGarage:LoadServer', function(vehicle)
	local source = source
	local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})
	if user_id ~= nil then 
		if player ~= nil then 
			if vehicle ~= nil then 
				MySQL.query("vRP/KazLoadVehicles", {user_id = user_id, vehicle = vehicle}, function(result, affected)
				  if result ~= nil then 
				  TriggerClientEvent('KazGarage:LoadServer2', player, result[1].veh_type,vehicle,result[1].vehicle_plate, result[1].vehicle_colorprimary, result[1].vehicle_colorsecondary, result[1].vehicle_pearlescentcolor, result[1].vehicle_wheelcolor, result[1].vehicle_plateindex, result[1].vehicle_neoncolor1, result[1].vehicle_neoncolor2, result[1].vehicle_neoncolor3, result[1].vehicle_windowtint, result[1].vehicle_wheeltype, result[1].vehicle_mods0, result[1].vehicle_mods1, result[1].vehicle_mods2, result[1].vehicle_mods3, result[1].vehicle_mods4, result[1].vehicle_mods5, result[1].vehicle_mods6, result[1].vehicle_mods7, result[1].vehicle_mods8, result[1].vehicle_mods9, result[1].vehicle_mods10, result[1].vehicle_mods11, result[1].vehicle_mods12, result[1].vehicle_mods13, result[1].vehicle_mods14, result[1].vehicle_mods15, result[1].vehicle_mods16, result[1].vehicle_turbo, result[1].vehicle_tiresmoke, result[1].vehicle_xenon, result[1].vehicle_mods23, result[1].vehicle_mods24, result[1].vehicle_neon0, result[1].vehicle_neon1, result[1].vehicle_neon2, result[1].vehicle_neon3, result[1].vehicle_bulletproof, result[1].vehicle_smokecolor1, result[1].vehicle_smokecolor2, result[1].vehicle_smokecolor3, result[1].vehicle_modvariation)
				  livery =  result[1].vehicle_livery
				  TriggerClientEvent('kaz_liveries:hentlivery', player, livery)
				  end
				end)
			end
		end
	end
end)

RegisterServerEvent('ply_garages:SkiftNavn')
AddEventHandler("ply_garages:SkiftNavn", function(vehicle)
	local source = source
	local user_id = vRP.getUserId({source})
	vRP.prompt({source,"Nye navn:","",function(source,navn)
		if navn == "" then
			print("fejl")
		else
			MySQL.execute("vRP/skiftnavn", {name = navn, user_id = user_id, vehicle = vehicle})
		end
	end})
end)
