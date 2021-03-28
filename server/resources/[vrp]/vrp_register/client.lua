--[[              
  /     \  _____     __| _/  ____   \______   \ ___.__.   ____    /     \  _____   _______ |  | __  ____  ________
 /  \ /  \ \__  \   / __ | _/ __ \   |    |  _/<   |  |  /  _ \  /  \ /  \ \__  \  \_  __ \|  |/ /_/ __ \ \___   /
/    Y    \ / __ \_/ /_/ | \  ___/   |    |   \ \___  | (  <_> )/    Y    \ / __ \_ |  | \/|    < \  ___/  /    / 
\____|__  /(____  /\____ |  \___  >  |______  / / ____|  \____/ \____|__  /(____  / |__|   |__|_ \ \___  >/_____ \
        \/      \/      \/      \/          \/  \/                      \/      \/              \/     \/       \/
]]
local open = false
local cam  = nil
local frozen = true
local unfrozen = false

RegisterNetEvent('vRPlf:Unfreeze')
AddEventHandler('vRPlf:Unfreeze', function()
	unfrozen = true
end)

Citizen.CreateThread(function()
	while true do
		if frozen then
			if unfrozen then
				SetEntityInvincible(GetPlayerPed(-1),false)
				SetEntityVisible(GetPlayerPed(-1),true)
				FreezeEntityPosition(GetPlayerPed(-1),false)
				DisableControlAction(0,56,false) -- disable F9
				DisableControlAction(0,51,false) -- disable E
				DisableControlAction(0,200,false) -- disable ESC
				frozen = false
			else
				SetEntityInvincible(GetPlayerPed(-1),true)
				SetEntityVisible(GetPlayerPed(-1),false)
				FreezeEntityPosition(GetPlayerPed(-1),true)
				DisableControlAction(0,56,true) -- disable F9
				DisableControlAction(0,51,true) -- disable E
				DisableControlAction(0,200,true) -- disable ESC
			end
		end
		Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(3000)
    	TriggerServerEvent('eye:color')	  
	end
end)

RegisterNetEvent('eyes')
AddEventHandler('eyes', function(eyes)
  Wait(1000)
  SetPedEyeColor(GetPlayerPed(-1), eyes)
end)

-- Open the register form, (call from server)
RegisterNetEvent('jsfour-register:open')
AddEventHandler('jsfour-register:open', function()
	SetNuiFocus(true, true)
	open = true
	SendNUIMessage({
		action = "open"
	})
end)
-- Register the player (call from javascript > send to server < callback from server)
RegisterNUICallback('opretborger', function(data, cb)
	cb('ok')
	TriggerServerEvent('vRP_register:register', data)
end)

RegisterNetEvent("register:closeMenu")
AddEventHandler("register:closeMenu", function()
	SetNuiFocus(false, false)
	open = false

	SendNUIMessage({
		action = "close"
	})
end)

-- Freeze player movements
Citizen.CreateThread(function()
    while true do
	Citizen.Wait(0)
      if open then
	      DisableControlAction(0, 1, true) -- LookLeftRight
	      DisableControlAction(0, 2, true) -- LookUpDown
	      DisableControlAction(0, 24, true) -- Attack
	      DisablePlayerFiring(GetPlayerPed(-1), true) -- Disable weapon firing
	      DisableControlAction(0, 142, true) -- MeleeAttackAlternate
	      DisableControlAction(0, 106, true) -- VehicleMouseControlOverride
      end
    end
end)

-- Close the NUI/HTML window
RegisterNUICallback('escape', function(data, cb)
	SetNuiFocus(false, false)
	open = false
	cb('ok')
end)

RegisterNUICallback('agelimit', function(data, cb)
	TriggerEvent("pNotify:SendNotification", {
		text = "Din alder skal være mellem 10 og 99!",
		type = "error",
		timeout = 2000,
		layout = "bottomCenter",
		queue = "global"
	})
	cb('ok')
end)