--bind client tunnel interface
vRPbm = {}
Tunnel.bindInterface("vRP_basic_menu",vRPbm)
vRP = Proxy.getInterface("vRP")

local frozen = false
local unfrozen = false
function vRPbm.loadFreeze(freeze)
	if freeze then
	  frozen = true
	  unfrozen = false
	else
	  unfrozen = true
	end
end

kortslutter = false
police1 = 0
locked = true 

RegisterNetEvent('kaz:sendpolice')
AddEventHandler('kaz:sendpolice', function(police)
police1 = police
end)

RegisterNetEvent('kaz_jail:lockstatus2')
AddEventHandler('kaz_jail:lockstatus2', function(locked2)
locked = locked2
end)

local state_ready = false

AddEventHandler("playerSpawned",function() -- delay state recording
  state_ready = false
  
  Citizen.CreateThread(function()
    Citizen.Wait(30000)
    state_ready = true
  end)
end)

Citizen.CreateThread(function()
	while true do
		if frozen then
			if unfrozen then
				SetEntityInvincible(GetPlayerPed(-1),false)
				SetEntityVisible(GetPlayerPed(-1),true)
				FreezeEntityPosition(GetPlayerPed(-1),false)
				frozen = false
			else
				SetEntityInvincible(GetPlayerPed(-1),true)
				SetEntityVisible(GetPlayerPed(-1),false)
				FreezeEntityPosition(GetPlayerPed(-1),true)
			end
		end
		Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(300000)
		if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), 1670.8273925781,2618.3583984375,53.190883636475, true ) > 250 then
		TriggerServerEvent('kaz_gobacktojail:1')
		end
	end
end)	

Citizen.CreateThread(function()
	while true do
		if not vRP.isHandcuffed() then 
			TriggerServerEvent('jail:removeJailedGroup')
		end
		Citizen.Wait(10000)
	end
end)

function fodting(success, timeremaining)
	if success then
		TriggerEvent('mhacking:hide')
		TriggerServerEvent('kaz_jail:hacked')
	else
		TriggerEvent("pNotify:SendNotification",{text = "Du fejlede, systemet har sendt politiet en besked.",type = "success",timeout = (8500),layout = "centerRight",queue = "global",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
		local plyPos = GetEntityCoords(GetPlayerPed(-1))
		message = "En person forsøgte forgæves at hacke fodlænken."
		TriggerServerEvent('kaz_jail:dispatch', plyPos.x, plyPos.y, plyPos.z, message)
		TriggerEvent('mhacking:hide')
	end
end	
				
				
function DrawText3Ds(x,y,z, text)
  local onScreen,_x,_y=World3dToScreen2d(x,y,z)
  local px,py,pz=table.unpack(GetGameplayCamCoords())
  
  SetTextScale(0.35, 0.35)
  SetTextFont(4)
  SetTextProportional(1)
  SetTextColour(255, 255, 255, 215)
  SetTextEntry("STRING")
  SetTextCentre(1)
  AddTextComponentString(text)
  DrawText(_x,_y)
  local factor = (string.len(text)) / 370
  DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end