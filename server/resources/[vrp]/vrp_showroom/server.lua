local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

MySQL = module("vrp_mysql", "MySQL")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP_showroom")
Gclient = Tunnel.getInterface("vRP_garages","vRP_showroom")

local cfg = module("vrp_showroom","cfg/config")
local vehgarage = cfg.showgarage


-- vehicle db / garage and lscustoms compatibility
MySQL.createCommand("vRP/showroom_columns", [[
ALTER TABLE vrp_user_vehicles ADD IF NOT EXISTS veh_type varchar(255) NOT NULL DEFAULT 'default';
ALTER TABLE vrp_user_vehicles ADD IF NOT EXISTS vehicle_name varchar(255) NOT NULL DEFAULT '';
ALTER TABLE vrp_user_vehicles ADD IF NOT EXISTS vehicle_plate varchar(255) NOT NULL;
ALTER TABLE vrp_user_vehicles ADD IF NOT EXISTS vehicle_price int(60) NOT NULL DEFAULT 0;
]])
MySQL.query("vRP/showroom_columns")

MySQL.createCommand("vRP/add_custom_vehicle","INSERT IGNORE INTO vrp_user_vehicles(user_id,vehicle,vehicle_name,vehicle_plate,veh_type,vehicle_price) VALUES(@user_id,@vehicle,@vehicle_name,@vehicle_plate,@veh_type,@vehicle_price)")

-- SHOWROOM
RegisterServerEvent('veh_SR:CheckMoneyForVeh')
AddEventHandler('veh_SR:CheckMoneyForVeh', function(vehicle, vehicle_name, price, veh_type)
  local user_id = vRP.getUserId({source})
  local player = vRP.getUserSource({user_id})
  MySQL.query("vRP/get_vehicle", {user_id = user_id, vehicle = vehicle}, function(pvehicle, affected)
		vRP.prompt({player,"Er du sikker på, at du vil købe køretøjet? (ja/nej)","",function(player,answer)
			if string.lower(answer) == "ja" then
			if #pvehicle > 0 then
				TriggerClientEvent("pNotify:SendNotification", player,{text = "Du ejer allerede dette køretøj.", type = "error", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
			else
			   for i=1, #vehgarage.vehicles do
				 if vehgarage.vehicles[i].model == vehicle and vehgarage.vehicles[i].costs == price then
					if vRP.tryFullPayment({user_id,price}) then
					  vRP.getUserIdentity({user_id, function(identity)
							MySQL.query("vRP/add_custom_vehicle", {user_id = user_id, vehicle = vehicle, vehicle_name = vehicle_name, vehicle_plate = "DK"..identity.registration, veh_type = veh_type, vehicle_price = price})
						   end})

						TriggerClientEvent('veh_SR:CloseMenu', player, vehicle, veh_type)
						TriggerClientEvent("pNotify:SendNotification", player,{text = "Du betalte <b style='color: #DB4646'>"..price.." DKK</b> for en " ..vehicle_name, type = "error", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
						PerformHttpRequest('https://discordapp.com/api/webhooks/773270625048461352/Ns82zLFFI5NyNyN1ZPlnes430sMtuIcyC5hd8cLkYXW3OWsuBxofYq4ry7f76sUMA24h', function(err, text, headers) end, 'POST', json.encode({username = "Bilforhandleren", content = "Borger ID: "..user_id.."\nKøbte: "..vehicle.."\nPris: "..price..",-"}), { ['Content-Type'] = 'application/json' })
					else
						TriggerClientEvent("pNotify:SendNotification", player,{text = "Du har ikke råd til at købe dette køretøj.", type = "error", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
					  end
					end
				  end
				end
			else
				TriggerClientEvent("pNotify:SendNotification", player,{text = "Købet blev afbrudt, da du ikke bekræftede købet.", type = "error", queue = "global", timeout = 5000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
			end
		end})
      end)
  end)