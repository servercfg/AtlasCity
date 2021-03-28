function LocalPed()
    return GetPlayerPed(-1)
end

armory = true

Citizen.CreateThread(function()
    while true do
		Citizen.Wait(1)
			if armory then	
				local playerCoords = GetEntityCoords(LocalPed())
				local ped = GetPlayerPed(-1)
				local pos = GetEntityCoords(PlayerPedId())
				for k,v in pairs(config.armoryplace) do
				if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, v.x, v.y, v.z, true ) < 10 then
					DrawMarker(20, v.x,v.y,v.z-0.25, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 101, 153, 186, 100, false, true, 2, true, false, false, false)
				--	DrawMarker(20, v.x,v.y,v.z-0.35, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.6, 0.6, 0.6, 50, 50, 204, 100, false, true, 2, nil, nil, false)
					if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, v.x, v.y, v.z, true ) < 0.5 then
						DrawText3Ds(v.x,v.y,v.z, "Tryk ~c~[~b~E~c~] ~w~for at åbne våbenlageret", 3.0, 7)
						if IsControlJustPressed(1, 38) then
						TriggerServerEvent("nicki_armoryv2:checkPerms")
						end
					end
				end
			end
		end
	end
end)

RegisterNetEvent('nicki_armoryv2:OpenArmory')
AddEventHandler('nicki_armoryv2:OpenArmory', function()
	local dict, anim = 'mini@repair', 'fixing_a_player'
	
	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Citizen.Wait(0)
	end

	TaskPlayAnim(GetPlayerPed(-1), 'mini@repair', 'fixing_a_player', 8.0, -8, -1, 49, 0, 0, 0, 0)
	armory = false
	SetNuiFocus(true, true)
	SendNUIMessage({
	  show = true,
	})
end)

RegisterNetEvent('nicki_armoryv2:StartAnim')
AddEventHandler('nicki_armoryv2:StartAnim', function()
	local dict2, anim2 = 'mp_take_money_mg', 'stand_cash_in_bag_loop'
	RequestAnimDict(dict2)
	while not HasAnimDictLoaded(dict2) do
		Citizen.Wait(0)
	end
	
	TaskPlayAnim(PlayerPedId(), dict2, anim2, 8.0, 1.0, 1000, 16, 0.0, false, false, false)
end)

function openGui()
	if show == false then
	  SetNuiFocus(true, true)
	  SendNUIMessage({
	  })
	end
  end

  function closeGui()
	ClearPedSecondaryTask(GetPlayerPed(-1))
	SetNuiFocus(false)
	SendNUIMessage({show = false})
  end
  
  AddEventHandler(
	"onResourceStop",
	function(resource)
	  if resource == GetCurrentResourceName() then
		closeGui()
	  end
	end
  )

  RegisterNUICallback("close", function(data)
	ClearPedSecondaryTask(GetPlayerPed(-1))
	closeGui()
	DisableControlAction(0, 20, false)
	Wait(250)
	armory = true
end)

  RegisterNUICallback("pistol", function(data)
	ClearPedSecondaryTask(GetPlayerPed(-1))	
	DisableControlAction(0, 20, true)
	closeGui()
	TriggerEvent("nicki_armoryv2:StartAnim")
	Wait(1750)
	armory = true
	GiveWeaponToPed(PlayerPedId(), GetHashKey("WEAPON_FLASHLIGHT"), 250, false, true)
	GiveWeaponToPed(PlayerPedId(), GetHashKey("WEAPON_NIGHTSTICK"), 250, false, true)
	GiveWeaponToPed(PlayerPedId(), GetHashKey("WEAPON_COMBATPISTOL"), 250, false, true)
	GiveWeaponToPed(PlayerPedId(), GetHashKey("WEAPON_STUNGUN"), 250, false, true)
end)
	
RegisterNUICallback("smg", function(data)
	ClearPedSecondaryTask(GetPlayerPed(-1))
	DisableControlAction(0, 20, true)
	closeGui()
	TriggerEvent("nicki_armoryv2:StartAnim")
	Wait(1750)
	armory = true
	GiveWeaponToPed(PlayerPedId(), GetHashKey("WEAPON_FLASHLIGHT"), 250, false, true)
	GiveWeaponToPed(PlayerPedId(), GetHashKey("WEAPON_NIGHTSTICK"), 250, false, true)
	GiveWeaponToPed(PlayerPedId(), GetHashKey("WEAPON_COMBATPISTOL"), 250, false, true)
	GiveWeaponToPed(PlayerPedId(), GetHashKey("WEAPON_STUNGUN"), 250, false, true)
	GiveWeaponToPed(PlayerPedId(), GetHashKey("WEAPON_SMG"), 250, false, true)
end)

RegisterNUICallback("carbine", function(data)
	ClearPedSecondaryTask(GetPlayerPed(-1))	
	DisableControlAction(0, 20, true)
	closeGui()
	TriggerEvent("nicki_armoryv2:StartAnim")
	Wait(1750)
	armory = true
	GiveWeaponToPed(PlayerPedId(), GetHashKey("WEAPON_FLASHLIGHT"), 250, false, true)
	GiveWeaponToPed(PlayerPedId(), GetHashKey("WEAPON_NIGHTSTICK"), 250, false, true)
	GiveWeaponToPed(PlayerPedId(), GetHashKey("WEAPON_COMBATPISTOL"), 250, false, true)
	GiveWeaponToPed(PlayerPedId(), GetHashKey("WEAPON_STUNGUN"), 250, false, true)
	GiveWeaponToPed(PlayerPedId(), GetHashKey("WEAPON_SMG"), 250, false, true)
	GiveWeaponToPed(PlayerPedId(), GetHashKey("WEAPON_CARBINERIFLE"), 250, false, true)
	GiveWeaponToPed(PlayerPedId(), GetHashKey("WEAPON_SNIPERRIFLE"), 250, false, true)
end)

function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 255)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
  end