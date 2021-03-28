local frozen = true
local unfrozen = false
local waittime = 0

RegisterNetEvent('vRPlf:Unfreeze')
AddEventHandler('vRPlf:Unfreeze', function()
	unfrozen = true
	waittime = 10000
end)

Citizen.CreateThread(function()
	while true do
		if frozen then
			if unfrozen then
				FreezeEntityPosition(GetPlayerPed(-1),false)
				SetEntityInvincible(GetPlayerPed(-1),false)
				SetEntityVisible(GetPlayerPed(-1), true, true)
				frozen = false
			else
				FreezeEntityPosition(GetPlayerPed(-1),true)
				SetEntityInvincible(GetPlayerPed(-1),true)
				SetEntityVisible(GetPlayerPed(-1), false, false)
			end
		end
		Citizen.Wait(waittime)
	end
end)
