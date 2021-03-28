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
vRPclient = Tunnel.getInterface("vRP", "kaz_boombox")

RegisterServerEvent('kaz_boombox:remove_hifi')
AddEventHandler('kaz_boombox:remove_hifi', function(coords)
	TriggerClientEvent('kaz_boombox:stop_music', -1, coords)
end)


RegisterServerEvent('kaz_boombox:play_music')
AddEventHandler('kaz_boombox:play_music', function(id, coords)
	TriggerClientEvent('kaz_boombox:play_music', -1, id, coords)
end)

RegisterServerEvent('kaz_boombox:stop_music')
AddEventHandler('kaz_boombox:stop_music', function(coords)
	TriggerClientEvent('kaz_boombox:stop_music', -1, coords)
end)

RegisterServerEvent('kaz_boombox:setVolume')
AddEventHandler('kaz_boombox:setVolume', function(volume, coords)
	TriggerClientEvent('kaz_boombox:setVolume', -1, volume, coords)
end)

RegisterServerEvent('kaz_boombox:playnow')
AddEventHandler('kaz_boombox:playnow', function(lCoords)
local source = source
local user_id = vRP.getUserId({source})
local player = vRP.getUserSource({user_id})
	vRP.prompt({player,"Link til video","",function(player,answer)
	datavalue = answer
	coords = lCoords
		TriggerEvent('kaz_boombox:play_music', datavalue, coords)
		TriggerClientEvent('kaz_boombox:animation', player)	
	end})
end)

RegisterServerEvent('kaz_boombox:volumenow')
AddEventHandler('kaz_boombox:volumenow', function(lCoords)
local source = source
local user_id = vRP.getUserId({source})
local player = vRP.getUserSource({user_id})
	if vRP.hasGroup({user_id,"DJ"}) then 
		vRP.prompt({player,"volume 1-100","",function(player,answer)
				answer1 = tonumber(answer)
			if answer1 ~= nil then
				if answer1 > 0 and answer1 < 101 then 
					if answer1 > 100 then 
						answer1 = 100
					end
					value = round2(answer1)
					if value < 1 then 
						value = 1
					end
					coords = lCoords
					TriggerEvent('kaz_boombox:setVolume', value, coords)  
					TriggerClientEvent('kaz_boombox:animation', player)
				else
					TriggerClientEvent("pNotify:SendNotification", source,{text = "Du kan kun indtaste tal mellem 1-100", type = "error", queue = "global", timeout = 8000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
				end
			else
				TriggerClientEvent("pNotify:SendNotification", source,{text = "Du kan kun indtaste tal mellem 1-100", type = "error", queue = "global", timeout = 8000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
			end
		end})
	else
		vRP.prompt({player,"volume 1-100","",function(player,answer)
				answer1 = tonumber(answer)
			if answer1 ~= nil then
				if answer1 > 0 and answer1 < 101 then 
					if answer1 > 100 then 
						answer1 = 100
					end
					value = round2(answer1/8)
					if value < 1 then 
						value = 1
					end
					coords = lCoords
					TriggerEvent('kaz_boombox:setVolume', value, coords) 
					TriggerClientEvent('kaz_boombox:animation', player)
				else
					TriggerClientEvent("pNotify:SendNotification", source,{text = "Du kan kun indtaste tal mellem 1-100", type = "error", queue = "global", timeout = 8000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
				end
			else
				TriggerClientEvent("pNotify:SendNotification", source,{text = "Du kan kun indtaste tal mellem 1-100", type = "error", queue = "global", timeout = 8000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
			end
		end})
	end
end)

function round2(num, numDecimalPlaces)
  return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", num))
end