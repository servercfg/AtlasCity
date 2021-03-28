
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "CodeZ_Licenseplate")

RegisterNetEvent("CodeZ_Licenseplate:RemovePlate")
AddEventHandler("CodeZ_Licenseplate:RemovePlate", function()
	exports['ac_progressbar']:startUI(10000, "Fjerner nummerplade")
  	RequestAnimDict('anim@amb@clubhouse@tutorial@bkr_tut_ig3@')
    while not HasAnimDictLoaded('anim@amb@clubhouse@tutorial@bkr_tut_ig3@') do
    Citizen.Wait(0)
  	end
	  TaskPlayAnim(GetPlayerPed(-1), 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@' , 'machinic_loop_mechandplayer' ,8.0, -8.0, -1, 1, 0, false, false, false )
	Wait(10000)	
	local ped = PlayerPedId()
	local pos = GetEntityCoords(PlayerPedId())
	local vehicle = GetClosestVehicle(pos.x, pos.y, pos.z, 3.000, 0, 70)
	SetVehicleNumberPlateText(vehicle, "")
	ClearPedTasks(ped)
end)


RegisterNetEvent("CodeZ_Licenseplate:AddPlate")
AddEventHandler("CodeZ_Licenseplate:AddPlate", function()
	exports['ac_progressbar']:startUI(10000, "Tilføjer nummerplade")
  	RequestAnimDict('anim@amb@clubhouse@tutorial@bkr_tut_ig3@')
    while not HasAnimDictLoaded('anim@amb@clubhouse@tutorial@bkr_tut_ig3@') do
    Citizen.Wait(0)
  	end
	  TaskPlayAnim(GetPlayerPed(-1), 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@' , 'machinic_loop_mechandplayer' ,8.0, -8.0, -1, 1, 0, false, false, false )
	Wait(10000)	
	local ped = PlayerPedId()
	local pos = GetEntityCoords(PlayerPedId())
	local vehicle = GetClosestVehicle(pos.x, pos.y, pos.z, 3.000, 0, 70)
	SetVehicleNumberPlateText(vehicle, "DK" .. vRP.getRegistrationNumber({}))
	ClearPedTasks(ped)
end)

RegisterCommand("fjernplade", function()
	TriggerServerEvent("RemovePlate")
end)

RegisterCommand("addplade", function()
	TriggerServerEvent("AddPlate")
end)