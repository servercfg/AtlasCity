can_putbag = true
bag = nil
pose = false

local a = 0

function openGui()
	SetNuiFocus(false)
	SendNUIMessage({openNUI = true})
end

function closeGui()
	SetNuiFocus(false)
	SendNUIMessage({openNUI = false})
end

RegisterNetEvent('pune_headbag')
AddEventHandler('pune_headbag', function()
if pose == false then 
    local playerPed = GetPlayerPed(-1)
    bag = CreateObject(GetHashKey("prop_money_bag_01"), 0, 0, 0, true, true, true)
    AttachEntityToEntity(bag, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 12844), 0.2, 0.04, 0, 0, 270.0, 60.0, true, true, false, true, 1, true)
    openGui()
    can_putbag = false
	bag = bag
	pose = true
else
		DeleteEntity(bag)
		closeGui()
		can_putbat = true
		pose = false
end
end)

RegisterNetEvent('pune_headbag2')
AddEventHandler('pune_headbag2', function()
	DeleteEntity(bag)
	closeGui()
	can_putbag = true
	pose = false
end)

RegisterNetEvent("blindfoldnow")
AddEventHandler('blindfoldnow', function()
	Wait(0)
    	if not IsPedInAnyVehicle(GetPlayerPed(-1),false) then
			TaskStartScenarioInPlace(GetPlayerPed(-1), "PROP_HUMAN_PARKING_METER")
			Citizen.Wait(2500)
        	TriggerServerEvent('closest')
		  	ClearPedTasksImmediately(GetPlayerPed(-1))
		end
end)

RegisterCommand("blindfold", function(source, args, raw)
    TriggerEvent("blindfoldnow")
end, false)
