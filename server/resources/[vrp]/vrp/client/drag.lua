other = nil
drag = false
playerStillDragged = false
drag1 = false
drag2 = false
dragversion = 1

RegisterNetEvent("dr:drag")
AddEventHandler('dr:drag', function(pl)
	other = pl
	drag = not drag
	dragversion = 1
end)

RegisterNetEvent("dr:drag2")
AddEventHandler('dr:drag2', function(pl)
	other = pl
	drag = not drag
	dragversion = 2
end)

RegisterNetEvent("dr:undrag")
AddEventHandler('dr:undrag', function(pl)
	drag2 = false
	drag1 = false
	drag = false
end)

RegisterNetEvent("dr:undrag2")
AddEventHandler('dr:undrag2', function(pl)
	drag2 = false
	drag1 = false
	drag = false
	ClearPedTasksImmediately(GetPlayerPed(-1))
end)


Citizen.CreateThread(function()
	while true do
		if drag and other ~= nil then
			local ped = GetPlayerPed(GetPlayerFromServerId(other))
			local myped = GetPlayerPed(-1)
			if dragversion == 1 then 
			AttachEntityToEntity(myped, ped, 9816, 0.015, 0.38, 0.11, 0.9, 0.30, 90.0, false, false, false, false, 2, false)
			else
			AttachEntityToEntity(myped, ped, 0, 0.27, 0.15, 0.63, 0.5, 0.5, 0.0, false, false, false, false, 2, false)
			end
			playerStillDragged = true
		else
			if(playerStillDragged) then
				DetachEntity(GetPlayerPed(-1), true, false)
				playerStillDragged = false
			end
		end
		Citizen.Wait(0)
	end
end)

RegisterNetEvent("dr:dragkaz")
AddEventHandler('dr:dragkaz', function()
			if drag1 == false then 
				local dict = "anim@heists@box_carry@"
				RequestAnimDict(dict)
				while not HasAnimDictLoaded(dict) do
					Citizen.Wait(100)
				end
				TaskPlayAnim(GetPlayerPed(-1), dict, "idle", 8.0, 8.0, -1, 50, 0, false, false, false)
				drag1 = true
			else
				ClearPedTasksImmediately(GetPlayerPed(-1))
				drag1 = false
			end	
end)

RegisterNetEvent("dr:dragkaz2")
AddEventHandler('dr:dragkaz2', function()
			if drag2 == false then 
				local dict = "amb@code_human_in_car_idles@generic@ps@base"
				RequestAnimDict(dict)
				while not HasAnimDictLoaded(dict) do
					Citizen.Wait(100)
				end
				TaskPlayAnim(GetPlayerPed(-1), dict, "base", 5.0, -1, -1, 1, 0, false, false, false)
				drag2 = true
			else
				ClearPedTasksImmediately(GetPlayerPed(-1))
				drag2 = false
			end	
end)

RegisterNetEvent("dr:dragkaz3")
AddEventHandler('dr:dragkaz3', function()
			if drag1 == false then 
				local dict = "missfinale_c2mcs_1"
				RequestAnimDict(dict)
				while not HasAnimDictLoaded(dict) do
					Citizen.Wait(100)
				end
				TaskPlayAnim(GetPlayerPed(-1), dict, "fin_c2_mcs_1_camman", 8.0, 8.0, -1, 50, 0, false, false, false)
				drag1 = true
			else
				ClearPedTasksImmediately(GetPlayerPed(-1))
				drag1 = false
			end	
end)

RegisterNetEvent("dr:dragkaz4")
AddEventHandler('dr:dragkaz4', function()
			if drag2 == false then 
				ClearPedTasksImmediately(GetPlayerPed(-1))
				drag2 = false
				local dict = "nm"
				RequestAnimDict(dict)
				while not HasAnimDictLoaded(dict) do
					Citizen.Wait(100)
				end
				TaskPlayAnim(GetPlayerPed(-1), dict, "firemans_carry", 5.0, -1, -1, 1, 0, false, false, false)
				drag2 = true
				TriggerEvent('kaz:stopcuffs', drag2)
			else
				ClearPedTasksImmediately(GetPlayerPed(-1))
				drag2 = false
				TriggerEvent('kaz:stopcuffs', drag2)
			end	
end)


