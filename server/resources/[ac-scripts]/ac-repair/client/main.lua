--------------------------------------------------------------------------------------------
------- Created by OGKUSH#2625  - Made for AltasCity FiveM - Owned by Olsen1157#5852 -------
--------------------------------------------------------------------------------------------

vRP = Proxy.getInterface("vRP")

local Keys = {
  ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
  ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
  ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
  ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
  ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
  ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
  ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
  ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
  ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

local PlayerData		= {}
local fixingvehicle     = false

function Progressbar(time, msg)
	exports['ac_progressbar']:startUI(time, msg)
	--exports["taskbar"]:taskBar(time, msg)
end

function notification(type ,msg)
	exports['mythic_notify']:SendAlert(type, msg)
end

RegisterNetEvent('ac-repair:onUse')
AddEventHandler('ac-repair:onUse', function()
	local playerPed		= GetPlayerPed(-1)
	local coords		= GetEntityCoords(playerPed)

	if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
		local vehicle = nil

		if IsPedInAnyVehicle(playerPed, false) then
			notification("inform", "Du skal være ude af køretøjet for at kunne reparer det")
		else
			vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
		end

		if DoesEntityExist(vehicle) then
			notification('inform', 'luk inventoryet')
			Citizen.Wait(3000)
            local finished = exports["ac-skillbar"]:taskBar(4000,math.random(8,12))
            if finished ~= 100 then
                ClearPedTasks(PlayerPedId())
            end
            if finished == 100 then
            local finished2 = exports["ac-skillbar"]:taskBar(2000,math.random(6,8))
            if finished2 ~= 100 then
                ClearPedTasks(PlayerPedId())
            end
            if finished2 == 100 then
            local finished3 = exports["ac-skillbar"]:taskBar(2000,math.random(4,6))
            if finished3 ~= 100 then
                ClearPedTasks(PlayerPedId())
            end
            if finished3 == 100 then

			SetVehicleDoorOpen(vehicle, 4, 0, 0)
			Citizen.Wait(100)
			RepairVehicleAnimation()

			Citizen.CreateThread(function()
				
				ThreadID = GetIdOfThisThread()
				fixingvehicle = true

				local vehbody = GetVehicleBodyHealth(vehicle)
				local vehengine = GetVehicleEngineHealth(vehicle)

					if vehbody < 999.0 then
						SetVehicleBodyHealth(vehicle, 1000.0)
						SetVehicleDeformationFixed(vehicle)
						--SetVehicleFixed(vehicle)
					end
					if vehengine < 400.0 then
						SetVehicleEngineHealth(vehicle, 400.0)
					end
					if vehengine < 500.0 then
						SetVehicleEngineHealth(vehicle, 500.0)
					end
					if vehengine < 600.0 then
						SetVehicleEngineHealth(vehicle, 600.0)
					end
					if GetEntityModel(vehicle) == GetHashKey("BLAZER") then
						SetVehicleEngineHealth(vehicle, 600.0)
						SetVehicleBodyHealth(vehicle, 800.0)
					end
					for i = 0, 5 do
					if IsVehicleTyreBurst(vehicle, i) then
                        SetVehicleTyreFixed(vehicle, i) 
					end
				end
			
					SetVehicleUndriveable(vehicle, false)
					SetVehicleDeformationFixed(vehicle)
					SetVehicleEngineOn(vehicle, true, true)
					ClearPedTasksImmediately(playerPed)
					SetVehicleDoorShut(vehicle, 4, 1, 1)

					local randomchance = math.random(1,100)

					if randomchance < 5 then
						fixingvehicle = false
						TriggerServerEvent('ac-repair:removeKit')
					else
						fixingvehicle = false
						notification("success", "Du repareret køretøjet")
					end
				end)
			end
		end
		end
		end
		end
		
	end)

RegisterNetEvent('ac-repairadv:onUse')
AddEventHandler('ac-repairadv:onUse', function()
	local playerPed		= GetPlayerPed(-1)
	local coords		= GetEntityCoords(playerPed)

	if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
		local vehicle = nil

		if IsPedInAnyVehicle(playerPed, false) then
			notification("inform", "Du skal være ude af køretøjet for at kunne reparer det")
		else
			vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
		end

		if DoesEntityExist(vehicle) then
			notification('inform', 'luk inventoryet')
			Citizen.Wait(3000)
            local finished = exports["ac-skillbar"]:taskBar(4000,math.random(8,12))
            if finished ~= 100 then
                ClearPedTasks(PlayerPedId())
            end
            if finished == 100 then
            local finished2 = exports["ac-skillbar"]:taskBar(2000,math.random(6,8))
            if finished2 ~= 100 then
                ClearPedTasks(PlayerPedId())
            end
            if finished2 == 100 then
            local finished3 = exports["ac-skillbar"]:taskBar(2000,math.random(4,6))
            if finished3 ~= 100 then
                ClearPedTasks(PlayerPedId())
            end
            if finished3 == 100 then
			SetVehicleDoorOpen(vehicle, 4, 0, 0)
			Citizen.Wait(100)
			RepairVehicleAdvancedAnimation()

			Citizen.CreateThread(function()
				
				ThreadID = GetIdOfThisThread()
				fixingvehicle = true

				local vehbody = GetVehicleBodyHealth(vehicle)
				local vehengine = GetVehicleEngineHealth(vehicle)

					if vehbody < 999.0 then
						SetVehicleBodyHealth(vehicle, 1000.0)
						SetVehicleDeformationFixed(vehicle)
						SetVehicleFixed(vehicle)
					end
					if vehengine < 400.0 then
						SetVehicleEngineHealth(vehicle, 600.0)
					end
					if vehengine < 600.0 then
						SetVehicleEngineHealth(vehicle, 700.0)
					end
					if vehengine < 700.0 then
						SetVehicleEngineHealth(vehicle, 900.0)
						SetVehicleFixed(vehicle)
					end
					if GetEntityModel(vehicle) == GetHashKey("BLAZER") then
						SetVehicleEngineHealth(vehicle, 600.0)
						SetVehicleBodyHealth(vehicle, 800.0)
					end
					for ii = 0, 5 do
					if IsVehicleTyreBurst(vehicle, ii) then
                        SetVehicleTyreFixed(vehicle, ii) 
					end
				end
			
					SetVehicleUndriveable(vehicle, false)
					SetVehicleDeformationFixed(vehicle)
					SetVehicleEngineOn(vehicle, true, true)
					ClearPedTasksImmediately(playerPed)
					SetVehicleDoorShut(vehicle, 4, 1, 1)

					local randomchanceadv = math.random(1,100)

					if randomchanceadv < 2 then
						TriggerServerEvent('ac-repairadv:removeKit')
					else
						fixingvehicle = false
						notification("success", "Du repareret køretøjet")
					end
				end)
			end
		end
		end
		end
		end
	end)

-- Animations
function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end 

function RepairVehicleAnimation()
	local playerPed	= GetPlayerPed(-1)
	local vehicle = nil
	local coords		= GetEntityCoords(playerPed)

	vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
	TaskTurnPedToFaceEntity(playerPed, vehicle, Config.RepairTime * 1000)
    loadAnimDict( "mini@repair" )    	
	TaskPlayAnim( playerPed, "mini@repair", "fixing_a_player", 8.0, -8, -1, 16, 0, 0, 0, 0)
	Progressbar(Config.RepairTime * 1000, "Reparere køretøj")
	Citizen.Wait(Config.RepairTime * 1000)
	ClearPedSecondaryTask(playerPed)
end

function RepairVehicleAdvancedAnimation()
	local playerPed	= GetPlayerPed(-1)
	local vehicle = nil
	local coords = GetEntityCoords(playerPed)

	vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
	TaskTurnPedToFaceEntity(playerPed, vehicle, Config.RepairTimeAdvanced * 1000)
    loadAnimDict( "mini@repair" )    	
	TaskPlayAnim( playerPed, "mini@repair", "fixing_a_player", 8.0, -8, -1, 16, 0, 0, 0, 0)
	Progressbar(Config.RepairTime * 1000, "Reparere køretøj")
	Citizen.Wait(Config.RepairTimeAdvanced * 1000)
	ClearPedSecondaryTask(playerPed)
end

-- Stops player from doing anything except stuff needed
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        if fixingvehicle then
			DisableAllControlActions(0)
			EnableControlAction(0, Keys['G'], true)
			EnableControlAction(0, Keys['T'], true)
			EnableControlAction(0, Keys['N'], true)
			EnableControlAction(0, Keys['DEL'], true)
			EnableControlAction(0, Keys['F10'], true)
			EnableControlAction(0, Keys['CAPS'], true)
			EnableControlAction(0, 1, true) -- Disable pan
			EnableControlAction(0, 2, true) -- Disable tilt
        end
    end
end)