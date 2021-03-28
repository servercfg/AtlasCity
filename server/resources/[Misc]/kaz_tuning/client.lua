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

local tuning = cfg.tuning
local tuning2 = cfg.tuning2
local tuning3 = cfg.tuning3
local tuning4 = cfg.tuning4
local tuning5 = cfg.tuning5
local openup = false

Citizen.CreateThread(function ()
	while true do
		Citizen.Wait(0)		
		if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), tuning2.x,tuning2.y,tuning2.z, true ) < 10 then
			DrawMarker(27, tuning2.x,tuning2.y,tuning2.z-0.4, 0, 0, 0, 0, 0, 0, 3.0001,3.0001,1.0001, 0, 232, 255, 155, 0, 0, 0, 0, 0, 0, 0)
			if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), tuning2.x,tuning2.y,tuning2.z, true ) < 1.5 then
				DrawText3Ds( tuning2.x,tuning2.y,tuning2.z+0.5, "~w~Tryk [~g~E~w~] for at åbne menu.", 3.0, 7)
			 if (IsControlJustReleased(1, 51)) then
					 veh = GetVehiclePedIsIn(GetPlayerPed(-1), false)
					if(GetPedInVehicleSeat(veh, -1) == GetPlayerPed(-1))then
						local ok, vtype, name = vRP.getNearestOwnedVehicle({7})
						if ok then
							if vtype ~= nil and name ~= nil then 
								TriggerServerEvent('kaz:infohentet', name)
								openup = true
							else
								TriggerEvent("pNotify:SendNotification",{text = "Du skal komme med dit eget køretøj!",type = "success",timeout = (8500),layout = "centerRight",queue = "global",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}}) 
							end
						else
							TriggerEvent("pNotify:SendNotification",{text = "Du skal komme med dit eget køretøj!",type = "success",timeout = (8500),layout = "centerRight",queue = "global",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}}) 
						end
					else
						TriggerEvent("pNotify:SendNotification",{text = "Du er ikke i et køretøj.",type = "success",timeout = (8500),layout = "centerRight",queue = "global",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}}) 
					end	 
			 end
			end
		end
		if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), tuning3.x,tuning3.y,tuning3.z, true ) < 10 then
			DrawMarker(27, tuning3.x,tuning3.y,tuning3.z-0.95, 0, 0, 0, 0, 0, 0, 3.0001,3.0001,1.0001, 0, 232, 255, 155, 0, 0, 0, 0, 0, 0, 0)
			if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), tuning3.x,tuning3.y,tuning3.z, true ) < 1.5 then
				DrawText3Ds( tuning3.x,tuning3.y,tuning3.z+0.5, "~w~Tryk [~g~E~w~] for at åbne menu.", 3.0, 7)
			 if (IsControlJustReleased(1, 51)) then
					 veh = GetVehiclePedIsIn(GetPlayerPed(-1), false)
					if(GetPedInVehicleSeat(veh, -1) == GetPlayerPed(-1))then
						local ok, vtype, name = vRP.getNearestOwnedVehicle({7})
						if ok then
							if vtype ~= nil and name ~= nil then 
								TriggerServerEvent('kaz:infohentet', name)
								openup = true
							else
								TriggerEvent("pNotify:SendNotification",{text = "Du skal komme med dit eget køretøj!",type = "success",timeout = (8500),layout = "centerRight",queue = "global",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}}) 
							end
						else
							TriggerEvent("pNotify:SendNotification",{text = "Du skal komme med dit eget køretøj!",type = "success",timeout = (8500),layout = "centerRight",queue = "global",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}}) 
						end
					else
						TriggerEvent("pNotify:SendNotification",{text = "Du er ikke i et køretøj.",type = "success",timeout = (8500),layout = "centerRight",queue = "global",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}}) 
					end	 
			 end
			end
		end
		if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), tuning4.x,tuning4.y,tuning4.z, true ) < 10 then
			DrawMarker(27, tuning4.x,tuning4.y,tuning4.z-0.95, 0, 0, 0, 0, 0, 0, 3.0001,3.0001,1.0001, 0, 232, 255, 155, 0, 0, 0, 0, 0, 0, 0)
			if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), tuning4.x,tuning4.y,tuning4.z, true ) < 1.5 then
				DrawText3Ds( tuning4.x,tuning4.y,tuning4.z+0.5, "~w~Tryk [~g~E~w~] for at åbne menu.", 3.0, 7)
			 if (IsControlJustReleased(1, 51)) then
					 veh = GetVehiclePedIsIn(GetPlayerPed(-1), false)
					if(GetPedInVehicleSeat(veh, -1) == GetPlayerPed(-1))then
						local ok, vtype, name = vRP.getNearestOwnedVehicle({7})
						if ok then
							if vtype ~= nil and name ~= nil then 
								TriggerServerEvent('kaz:infohentet', name)
								openup = true
							else
								TriggerEvent("pNotify:SendNotification",{text = "Du skal komme med dit eget køretøj!",type = "success",timeout = (8500),layout = "centerRight",queue = "global",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}}) 
							end
						else
							TriggerEvent("pNotify:SendNotification",{text = "Du skal komme med dit eget køretøj!",type = "success",timeout = (8500),layout = "centerRight",queue = "global",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}}) 
						end
					else
						TriggerEvent("pNotify:SendNotification",{text = "Du er ikke i et køretøj.",type = "success",timeout = (8500),layout = "centerRight",queue = "global",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}}) 
					end	 
			 end
			end
		end
		if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), tuning5.x,tuning5.y,tuning5.z, true ) < 10 then
			DrawMarker(27, tuning5.x,tuning5.y,tuning5.z-0.95, 0, 0, 0, 0, 0, 0, 3.0001,3.0001,1.0001, 0, 232, 255, 155, 0, 0, 0, 0, 0, 0, 0)
			if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), tuning5.x,tuning5.y,tuning5.z, true ) < 1.5 then
				DrawText3Ds( tuning5.x,tuning5.y,tuning5.z+0.5, "~w~Tryk [~g~E~w~] for at åbne menu.", 3.0, 7)
			 if (IsControlJustReleased(1, 51)) then
					 veh = GetVehiclePedIsIn(GetPlayerPed(-1), false)
					if(GetPedInVehicleSeat(veh, -1) == GetPlayerPed(-1))then
						local ok, vtype, name = vRP.getNearestOwnedVehicle({7})
						if ok then
							if vtype ~= nil and name ~= nil then 
								TriggerServerEvent('kaz:infohentet', name)
								openup = true
							else
								TriggerEvent("pNotify:SendNotification",{text = "Du skal komme med dit eget køretøj!",type = "success",timeout = (8500),layout = "centerRight",queue = "global",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}}) 
							end
						else
							TriggerEvent("pNotify:SendNotification",{text = "Du skal komme med dit eget køretøj!",type = "success",timeout = (8500),layout = "centerRight",queue = "global",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}}) 
						end
					else
						TriggerEvent("pNotify:SendNotification",{text = "Du er ikke i et køretøj.",type = "success",timeout = (8500),layout = "centerRight",queue = "global",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}}) 
					end	 
			 end
			end
		end
		
	end
end)





RegisterNetEvent('kaz_tuning:sendid')
AddEventHandler('kaz_tuning:sendid', function(kundeid, model)
idkunde = kundeid
modellen = model
end)

RegisterNetEvent('kaz_tuning:sendinfo')
AddEventHandler('kaz_tuning:sendinfo', function(motorny, bremserny, gearingny, turbony)
motor = motorny
bremser = bremserny
gearing = gearingny
turbo = turbony
	if openup == true then 
		if motor == -1 then
				motor1 = "Standard"
			elseif motor == 1 then 
				motor1 = "Street"
			elseif motor == 2 then
				motor1 = "Racer"
			elseif motor == 0 then
				motor1 = "Økonomisk"
			else 
				motor1 = "Økonomisk"
			end
			if bremser == -1 then
				bremser1 = "Standard"
			elseif bremser == 1 then 
				bremser1 = "Street"
			elseif bremser == 2 then
				bremser1 = "Racer"
			elseif bremser == 0 then 
				bremser1 = "Økonomisk"
			else 
				bremser1 = "Økonomisk"
			end
			if gearing == -1 then
				gearing1 = "Standard"
			elseif gearing == 1 then 
				gearing1 = "Street"
			elseif gearing == 2 then
				gearing1 = "Racer"
			elseif gearing == 0 then 
				gearing1 = "Økonomisk"
			else 
				gearing1 = "Økonomisk"
			end
			if turbo == 1 then
				turbo1 = "Off"
			elseif turbo == 2 then
				turbo1 = "On"
			end
		SetNuiFocus( true, true )
		SendNUIMessage({
		showPlayerMenu = true,
		motor2 = motor1,
		bremser2 = bremser1,
		gearing2 = gearing1,
		turbo2 = turbo1
		})	
		openup = false
	end
end)

RegisterNUICallback('motorstd', function(data, cb)
motoren = -1
pris = 10000
TriggerServerEvent('kaz:updatemotor', motoren, idkunde, modellen, pris)
end)

RegisterNUICallback('motoroko', function(data, cb)
motoren = 0
pris = 20000
TriggerServerEvent('kaz:updatemotor', motoren, idkunde, modellen, pris)
end)

RegisterNUICallback('motorstreet', function(data, cb)
motoren = 1
pris = 32500
TriggerServerEvent('kaz:updatemotor', motoren, idkunde, modellen, pris)
end)

RegisterNUICallback('motorracer', function(data, cb)
motoren = 2
pris = 42500
TriggerServerEvent('kaz:updatemotor', motoren, idkunde, modellen, pris)
end)

RegisterNUICallback('bremsstd', function(data, cb)
bremserne = -1
pris = 5000
TriggerServerEvent('kaz:updatebrems', bremserne, idkunde, modellen, pris)
end)

RegisterNUICallback('bremsoko', function(data, cb)
bremserne = 0
pris = 12500
TriggerServerEvent('kaz:updatebrems', bremserne, idkunde, modellen, pris)
end)

RegisterNUICallback('bremsstreet', function(data, cb)
bremserne = 1
pris = 17500
TriggerServerEvent('kaz:updatebrems', bremserne, idkunde, modellen, pris)
end)

RegisterNUICallback('bremsracer', function(data, cb)
bremserne = 2
pris = 20000
TriggerServerEvent('kaz:updatebrems', bremserne, idkunde, modellen, pris)
end)

RegisterNUICallback('gearstd', function(data, cb)
gearingen = -1
pris = 7500
TriggerServerEvent('kaz:updategear', gearingen, idkunde, modellen, pris)
end)

RegisterNUICallback('gearoko', function(data, cb)
gearingen = 0
pris = 15000
TriggerServerEvent('kaz:updategear', gearingen, idkunde, modellen, pris)
end)

RegisterNUICallback('gearstreet', function(data, cb)
gearingen = 1
pris = 20000
TriggerServerEvent('kaz:updategear', gearingen, idkunde, modellen, pris)
end)

RegisterNUICallback('gearracer', function(data, cb)
gearingen = 2
pris = 27500
TriggerServerEvent('kaz:updategear', gearingen, idkunde, modellen, pris)
end)

RegisterNUICallback('turstd', function(data, cb)
turboen = "off"
pris = 10000
TriggerServerEvent('kaz:updateturbo', turboen, idkunde, modellen, pris)
end)

RegisterNUICallback('turoko', function(data, cb)
turboen = "on"
pris = 25000
TriggerServerEvent('kaz:updateturbo', turboen, idkunde, modellen, pris)
end)

RegisterNetEvent("ToggleActionmenu")
AddEventHandler("ToggleActionmenu", function()
	ToggleActionMenu()
end)

function ToggleActionMenu()
	Citizen.Trace("tutorial launch")
	menuEnabled = not menuEnabled
	if ( menuEnabled ) then
		SetNuiFocus( true, true )
		SendNUIMessage({
			showPlayerMenu = true
		})
	else
		SetNuiFocus( false )
		SendNUIMessage({
			showPlayerMenu = false
		})
	end
end

function killTutorialMenu()
SetNuiFocus( false )
		SendNUIMessage({
			showPlayerMenu = false
		})
		menuEnabled = false

end
		
RegisterNUICallback('closeButton', function(data, cb)
	killTutorialMenu()
  	cb('ok')
end)
		
RegisterNUICallback('close', function(data, cb)
  ToggleActionMenu()
  cb('ok')
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

function KeyboardInput2(TextEntry, ExampleText, MaxStringLenght)
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