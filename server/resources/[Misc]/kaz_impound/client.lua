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

vRP = Proxy.getInterface("vRP")

RegisterCommand('impound', function(source)
			local spiller = (GetPlayerPed(-1))			
			local veh = vRP.getNearestVehicle({10})
			local model = GetEntityModel(veh)
			local displaytext = GetDisplayNameFromVehicleModel(model)
			local name = GetLabelText(displaytext)	
			local spiller = PlayerPedId()
			local plate2 = GetVehicleNumberPlateText(veh)
			if plate2 ~= nil then 
				local plate = plate2:gsub('DK', '')
				if plate ~= nil then
					FreezeEntityPosition(spiller, true)
					TaskStartScenarioInPlace(spiller, "WORLD_HUMAN_CLIPBOARD")
					exports['ac_progressbar']:startUI(15000, "Impounder Køretøj")
					Citizen.Wait(15000)
					FreezeEntityPosition(spiller, false)
					ClearPedTasksImmediately(spiller)
					TriggerServerEvent('kaz:impoundhent', plate, name, veh, spiller)
				else
					TriggerEvent("pNotify:SendNotification",{text = "Ingen bil fundet.",type = "error",timeout = (5000),layout = "centerRight",queue = "global",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
				end
			else
				TriggerEvent("pNotify:SendNotification",{text = "Ingen bil fundet.",type = "error",timeout = (5000),layout = "centerRight",queue = "global",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
			end
end)

RegisterNetEvent('kaz:removecarnow')
AddEventHandler('kaz:removecarnow', function(veh, user_id, nuser_id, vehiclename, source2)
local spiller = GetPlayerPed(-1)
	if user_id == spiller then
		oldpos = GetEntityCoords(GetPlayerPed(-1))
		oldheading = GetEntityHeading(GetPlayerPed(-1))
		TriggerEvent("pNotify:SendNotification",{text = "Køretøj impounded!",type = "error",timeout = (5000),layout = "centerRight",queue = "global",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
		TriggerServerEvent('kaz:impoundwebhook', source2, nuser_id, vehiclename)
	    SetPedIntoVehicle(spiller, veh, -1)
		Citizen.Wait(1000)
		Citizen.InvokeNative(0xEA386986E786A54F,Citizen.PointerValueIntInitialized(veh))
		SetEntityCoords(GetPlayerPed(-1), oldpos.x,oldpos.y,oldpos.z)
		SetEntityHeading(GetPlayerPed(-1),oldheading)
	end
end)

RegisterNetEvent('kaz_impound:vent')
AddEventHandler('kaz_impound:vent', function()
Citizen.Wait(15000)
local spiller = PlayerPedId()
ClearPedTasksImmediately(spiller)
end)

Citizen.CreateThread(function()
	while true do
	Citizen.Wait(0)
			if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), 409.51037597656,-1623.1654052734,29.291942596436, true ) < 2.5 then
				DrawText3Ds(409.51037597656,-1623.1654052734,29.291942596436+0.2, "~w~Tryk [~g~E~w~] for at købe biler tilbage.", 3.0, 7)
				DrawText3Ds(409.51037597656,-1623.1654052734,29.291942596436, "~r~25.000 pr styk!", 3.0, 7)
				DrawMarker(27,409.51037597656,-1623.1654052734,29.291942596436-0.99,0,0,0,0,0,Rotation,1.501,1.5001,0.5001,255,0,0,200,0,0,0,true)
				if IsControlJustPressed(1, 38) then
				TriggerServerEvent('kaz:getvehback')
				end
			elseif GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), 409.51037597656,-1623.1654052734,29.291942596436, true ) < 15 then
				DrawMarker(27,409.51037597656,-1623.1654052734,29.291942596436-0.99,0,0,0,0,0,Rotation,1.501,1.5001,0.5001,255,0,0,200,0,0,0,true)
			end
	end		
end)

function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())

    SetTextScale(0.32, 0.32)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 255)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 0, 0, 0, 80)
end

function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)

	AddTextEntry('FMMC_KEY_TIP1', TextEntry) --Sets the Text above the typing field in the black square
	DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght) --Actually calls the Keyboard Input
	blockinput = true --Blocks new input while typing if **blockinput** is used

	while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do --While typing is not aborted and not finished, this loop waits
		Citizen.Wait(0)
	end
		
	if UpdateOnscreenKeyboard() ~= 2 then
		local result = GetOnscreenKeyboardResult() --Gets the result of the typing
		Citizen.Wait(500) --Little Time Delay, so the Keyboard won't open again if you press enter to finish the typing
		blockinput = false --This unblocks new Input when typing is done
		return result --Returns the result
	else
		Citizen.Wait(500) --Little Time Delay, so the Keyboard won't open again if you press enter to finish the typing
		blockinput = false --This unblocks new Input when typing is done
		return nil --Returns nil if the typing got aborted
	end
end
