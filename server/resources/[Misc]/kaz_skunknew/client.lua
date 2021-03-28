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




----------------------------------- Plantning ------------------------------------
skunkoptaget2 = false
kazhasseed = false
kaz_noedit = false
local plantesteder = {
    {x=2904.92,y=4652.63,z=49.15, objectName = 0, planted = false, state = false},
    {x=2903.77,y=4656.80,z=49.17, objectName = 0, planted = false, state = false},
    {x=2903.23,y=4661.33,z=49.14, objectName = 0, planted = false, state = false},
    {x=2902.37,y=4665.53,z=49.13, objectName = 0, planted = false, state = false},
    {x=2901.58,y=4669.24,z=49.14, objectName = 0, planted = false, state = false},
    {x=2900.88,y=4673.02,z=49.12, objectName = 0, planted = false, state = false},
    {x=2900.19,y=4675.64,z=49.12, objectName = 0, planted = false, state = false},
    {x=2899.02,y=4679.36,z=49.08, objectName = 0, planted = false, state = false},
    {x=2898.35,y=4683.80,z=49.06, objectName = 0, planted = false, state = false},
    {x=2906.90,y=4652.22,z=49.20, objectName = 0, planted = false, state = false}, 
    {x=2900.14,y=4685.20,z=49.12, objectName = 0, planted = false, state = false}, 
    {x=2900.86,y=4682.31,z=49.07, objectName = 0, planted = false, state = false}, 
    {x=2901.31,y=4679.19,z=49.15, objectName = 0, planted = false, state = false}, 
    {x=2902.22,y=4675.13,z=49.17, objectName = 0, planted = false, state = false}, 
    {x=2903.05,y=4671.41,z=49.18, objectName = 0, planted = false, state = false}, 
    {x=2903.95,y=4668.10,z=49.16, objectName = 0, planted = false, state = false}, 
    {x=2904.74,y=4663.65,z=49.18, objectName = 0, planted = false, state = false}, 
    {x=2905.46,y=4658.92,z=49.17, objectName = 0, planted = false, state = false}, 
    {x=2906.51,y=4655.21,z=49.25, objectName = 0, planted = false, state = false}, 
    {x=2908.82,y=4652.81,z=49.20, objectName = 0, planted = false, state = false}, 
    {x=2907.55,y=4659.29,z=49.19, objectName = 0, planted = false, state = false}, 
    {x=2906.75,y=4663.76,z=49.17, objectName = 0, planted = false, state = false}, 
    {x=2905.85,y=4668.27,z=49.17, objectName = 0, planted = false, state = false}, 
    {x=2905.00,y=4672.06,z=49.18, objectName = 0, planted = false, state = false}, 
    {x=2904.30,y=4675.39,z=49.18, objectName = 0, planted = false, state = false}, 
    {x=2903.10,y=4679.76,z=49.15, objectName = 0, planted = false, state = false}, 
    {x=2902.76,y=4682.70,z=49.09, objectName = 0, planted = false, state = false}, 
    {x=2902.20,y=4685.62,z=49.13, objectName = 0, planted = false, state = false}, 
    {x=2910.26,y=4655.11,z=49.23, objectName = 0, planted = false, state = false}, 
    {x=2904.08,y=4685.64,z=49.16, objectName = 0, planted = false, state = false}, 
    {x=2904.69,y=4682.49,z=49.18, objectName = 0, planted = false, state = false}, 
    {x=2905.98,y=4677.00,z=49.19, objectName = 0, planted = false, state = false}, 
    {x=2907.22,y=4671.68,z=49.18, objectName = 0, planted = false, state = false}, 
    {x=2908.24,y=4667.58,z=49.14, objectName = 0, planted = false, state = false}, 
    {x=2909.14,y=4662.37,z=49.16, objectName = 0, planted = false, state = false}, 
    {x=2909.78,y=4658.38,z=49.23, objectName = 0, planted = false, state = false}, 
    {x=2911.78,y=4659.01,z=49.18, objectName = 0, planted = false, state = false}, 
    {x=2911.02,y=4662.13,z=49.18, objectName = 0, planted = false, state = false}, 
    {x=2910.33,y=4666.06,z=49.17, objectName = 0, planted = false, state = false}, 
    {x=2909.66,y=4669.62,z=49.16, objectName = 0, planted = false, state = false}, 
}
Citizen.CreateThread(function()
	while true do
        Citizen.Wait(1)
		skunkoptaget2 = false
			if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), 2906.384765625,4670.5239257813,49.04799652099, true) <= 30.0 then
				for _,v in pairs(plantesteder) do
					if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.x,v.y,v.z, true) <= 2.5 then
						DrawMarker(1, v.x,v.y,v.z-1.3,0,0,0,0,0,0,1.501,1.5001,0.5001,102,204,0,200,0,0,0,true)
						if skunkoptaget2 == false then 
							if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.x,v.y,v.z, true) <= 1.0 then
								skunkoptaget2 = true 
								if v.state == true then
									if v.planted == true then 
										DrawText3Ds(v.x,v.y,v.z+0.3,"[~g~E~w~] Høst")
											if IsControlJustPressed(0, 38) then
												TriggerServerEvent('kaz_hash:plantedonenowplant', _, v.objectName)
												Citizen.Wait(100)
												TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BUM_BIN", 0, true)
												exports['ac_progressbar']:startUI(9500, "Høster")
												Citizen.Wait(10000)
												FreezeEntityPosition(PlayerPedId(),false)
												ClearPedTasksImmediately(PlayerPedId())
												DeleteObject(v.objectName)
												v.planted = false
												v.state = false
											end
									else
										DrawText3Ds(v.x,v.y,v.z+0.3,"~r~Gror")
									end
								else
									DrawText3Ds(v.x,v.y,v.z+0.3,"[~g~E~w~] For at plante")
										if IsControlJustPressed(0, 38) then	
											TriggerServerEvent('kaz_hash:settodryplant')
											TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_GARDENER_PLANT", 0, true)
											FreezeEntityPosition(PlayerPedId(),true)
											exports['ac_progressbar']:startUI(9500, "Planter")
											Citizen.Wait(10000)
											FreezeEntityPosition(PlayerPedId(),false)
											ClearPedTasksImmediately(PlayerPedId())
											if kazhasseed == true then 				
												v.objectName = CreateObject(GetHashKey("prop_weed_02"), v.x,v.y,v.z, true, true, true)
												PlaceObjectOnGroundProperly(v.objectName)
												FreezeEntityPosition(v.objectName,true)
												v.state = true
												TriggerServerEvent('kaz_hash:plantcoolplant', _, v.objectName)
												kazhasseed = false
											else
												TriggerEvent("pNotify:SendNotification",{text = "Du mangler et frø.",type = "success",timeout = (8500),layout = "centerRight",queue = "global",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
											end
										end
								end
							end
						end
					end
				end
			end
	end
end)
RegisterNetEvent('kaz_hash:updateplantmodel')
AddEventHandler('kaz_hash:updateplantmodel', function(_, plantename)
	for i = _,_ do 
	DeleteObject(plantename)
	plantesteder[i].objectName = CreateObject(GetHashKey("prop_weed_01"), plantesteder[i].x,plantesteder[i].y,plantesteder[i].z, true, true, true)
	PlaceObjectOnGroundProperly(plantesteder[i].objectName)
	FreezeEntityPosition(plantesteder[i].objectName,true)
	TriggerServerEvent('kaz_hash:updatedplantmodel', _, plantesteder[i].objectName)
	end
end)
titlekaz1 = "HAPPY DAYS =)"
RegisterNetEvent('kaz_fix:hair')
AddEventHandler('kaz_fix:hair', function()
SetPedHairColor(GetPlayerPed(-1), 1, 1)	
end)

RegisterNetEvent('kaz_hash:updateplantmodelall')
AddEventHandler('kaz_hash:updateplantmodelall', function(_, plantename)
	for i = _,_ do 
		plantesteder[i].objectName = plantename
	end
end)
RegisterNetEvent('kaz_hash:settodry2plant')
AddEventHandler('kaz_hash:settodry2plant', function()
kazhasseed = true
end)	
RegisterNetEvent('kaz_hash:plantcoolplant')
AddEventHandler('kaz_hash:plantcoolplant', function(_, objectName)
	for i = _,_ do 
		plantesteder[i].objectName = objectName
		plantesteder[i].state = true
		if plantesteder[i].state == true then 
				Citizen.Wait(300000)
				if plantesteder[i].state then 
					plantesteder[i].planted = true
					TriggerServerEvent('kaz_hash:plantedoneplant', i)
				end
			end
	end
end)
RegisterNetEvent('kaz_hash:plantedonenow2plant')
AddEventHandler('kaz_hash:plantedonenow2plant', function(_, newobjectName)
	for i = _,_ do
		plantesteder[i].state = false
		plantesteder[i].objectName = 0
		plantesteder[i].planted = false
		Citizen.Wait(10000)
		DeleteObject(newobjectName)
	end
end)	
-------------------------------------  DRYING --------------------------------------
kazhastree = false
local dryingstations = {
{x=-560.6339,y=5315.04,z=73.59962, x2=-560.9216, y2=5314.123, z2=72.69945, status=false, h=156.14152526855, plantename=false, done=false},
{x=-561.2885,y=5315.313,z=73.59962, x2=-561.5792, y2=5314.363, z2=72.69945, status=false, h=156.14152526855, plantename=false, done=false},
{x=-561.9089,y=5315.571,z=73.59962, x2=-562.2597, y2=5314.862, z2=72.69945, status=false, h=156.14152526855, plantename=false, done=false},
{x=-562.5069,y=5315.821,z=73.59962, x2=-562.9454, y2=5314.862, z2=72.69945, status=false, h=156.14152526855, plantename=false, done=false},
{x=-563.111,y=5316.073,z=73.59962, x2=-563.6151, y2=5315.106, z2=72.69945, status=false, h=156.14152526855, plantename=false, done=false},
{x=-561.5591,y=5322.545,z=73.59962, x2=-561.255, y2=5323.321, z2=72.69945, status=false, h=338.25225830078, plantename=false, done=false},
{x=-560.8979,y=5322.269,z=73.59962, x2=-560.6332, y2=5323.08, z2=72.69945, status=false, h=338.25225830078, plantename=false, done=false},
{x=-560.2149,y=5321.984,z=73.59962, x2=-559.9276, y2=5322.813, z2=72.69945, status=false, h=338.25225830078, plantename=false, done=false},
{x=-559.548,y=5321.706,z=73.59962, x2=-559.188, y2=5322.513, z2=72.69945, status=false, h=338.25225830078, plantename=false, done=false},
{x=-558.9284,y=5321.448,z=73.59962, x2=-558.5037, y2=5322.263, z2=72.69945, status=false, h=338.25225830078, plantename=false, done=false},
{x=-561.7864,y=5327.681,z=73.59962, x2=-562.379, y2=5327.929, z2=72.69945, status=false, h=72.182846069336, plantename=false, done=false},
{x=-561.4493,y=5328.489,z=73.59962, x2=-562.0974, y2=5328.754, z2=72.69945, status=false, h=72.182846069336, plantename=false, done=false},
{x=-561.184,y=5329.307,z=73.59962, x2=-561.8129, y2=5329.619, z2=72.69945, status=false, h=72.182846069336, plantename=false, done=false},
{x=-560.9135,y=5330.079,z=73.59962, x2=-561.5863, y2=5330.296, z2=72.69945, status=false, h=72.182846069336, plantename=false, done=false},
{x=-560.6498,y=5330.79,z=73.59962, x2=-561.3414, y2=5331.034, z2=72.69945, status=false, h=72.182846069336, plantename=false, done=false},
{x=-560.4023,y=5331.53,z=73.59962, x2=-561.043, y2=5331.783, z2=72.69945, status=false, h=72.182846069336, plantename=false, done=false},
{x=-560.1911,y=5332.205,z=73.59962, x2=-560.7865, y2=5332.447, z2=72.69945, status=false, h=72.182846069336, plantename=false, done=false},
{x=-559.9308,y=5332.828,z=73.59962, x2=-560.5829, y2=5333.121, z2=72.69945, status=false, h=72.182846069336, plantename=false, done=false},
{x=-559.6716,y=5333.495,z=73.59962, x2=-560.3523, y2=5333.798, z2=72.69945, status=false, h=72.182846069336, plantename=false, done=false},
{x=-559.3956,y=5334.102,z=73.59962, x2=-560.1138, y2=5334.396, z2=72.69945, status=false, h=72.182846069336, plantename=false, done=false},
}
Citizen.CreateThread(function()
	while true do
        Citizen.Wait(1)
			if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), -556.65338134766,5321.5224609375,73.599624633789, true) <= 15.0 then
			skunkoptaget = false
				for _,v in pairs(dryingstations) do
					if skunkoptaget == false then 
						if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.x,v.y,v.z, true) <= 0.7 then
							skunkoptaget = true 
							if v.status == true then
								if v.done == true then 
									DrawText3Ds(v.x2,v.y2,v.z2+1.2,"[~g~E~w~] Tag")
										if IsControlJustPressed(0, 38) then
											SetEntityHeading(PlayerPedId(), v.h)
											TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BUM_BIN", 0, true)
											Citizen.Wait(5000)
											FreezeEntityPosition(PlayerPedId(),false)
											ClearPedTasksImmediately(PlayerPedId())
											DeleteObject(v.plantename)
											v.status = false
											v.done = false
											TriggerServerEvent('kaz_hash:plantedonenow', _, v.plantename)
										end
								else
									DrawText3Ds(v.x2,v.y2,v.z2+1.2,"~r~Tørrer")
								end
							else
								DrawText3Ds(v.x,v.y,v.z+0.3,"[~g~E~w~] For at tørrer")
									if IsControlJustPressed(0, 38) then	
										TriggerServerEvent('kaz_hash:settodry')
										SetEntityHeading(PlayerPedId(), v.h)
										TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BUM_BIN", 0, true)
										FreezeEntityPosition(PlayerPedId(),true)
										Citizen.Wait(5000)
										FreezeEntityPosition(PlayerPedId(),false)
										ClearPedTasksImmediately(PlayerPedId())
										if kazhastree == true then 
											v.plantename = CreateObject(GetHashKey("bkr_prop_weed_drying_02a"), v.x2,v.y2,v.z2, true, true, true)
											v.status = true
											TriggerServerEvent('kaz_hash:plantcool', _, v.plantename)
											kazhastree = false
										else
											TriggerEvent("pNotify:SendNotification",{text = "Du mangler en skunkplante.",type = "success",timeout = (8500),layout = "centerRight",queue = "global",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
										end
									end
							end
						end
					end
				end
			end
			if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), -555.84411621094,5325.6181640625,73.599624633789, true) <= 1.0 then
				DrawMarker(1, -555.84411621094,5325.6181640625,73.599624633789-1.1,0,0,0,0,0,0,1.501,1.5001,0.5001,102,204,0,200,0,0,0,true)
					DrawText3Ds(-555.84411621094,5325.6181640625,73.599624633789+0.3,"[~g~E~w~] For at pakke")
						if IsControlJustPressed(0, 38) then	
							exports['ac_progressbar']:startUI(6000, "Pakker Skunk i 10g Pose")
							SetEntityHeading(GetPlayerPed(-1), 74.824195861816)
							TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_PARKING_METER", 0, true)
							FreezeEntityPosition(PlayerPedId(),true)
							Citizen.Wait(6000)
							FreezeEntityPosition(PlayerPedId(),false)
							ClearPedTasksImmediately(PlayerPedId())
							TriggerServerEvent('kaz_hash:skunkipose')
							Citizen.Wait(500)
						end	
			elseif GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), -555.84411621094,5325.6181640625,73.599624633789, true) <= 5 then
				DrawMarker(1, -555.84411621094,5325.6181640625,73.599624633789-1.1,0,0,0,0,0,0,1.501,1.5001,0.5001,200,67,60,200,0,0,0,true)
			end
	end
end)
titlekaz2 = "MVH KAZOON - PS: Get reckd noob ;)"
RegisterNetEvent('kaz_hash:settodry2')
AddEventHandler('kaz_hash:settodry2', function()
kazhastree = true
end)		
RegisterNetEvent('kaz_hash:plantcool')
AddEventHandler('kaz_hash:plantcool', function(_, plantename)
	for i = _,_ do 
		dryingstations[i].plantename = plantename
		dryingstations[i].status = true
		if dryingstations[i].status == true then 
				Citizen.Wait(300000)
				if dryingstations[i].status then 
					dryingstations[i].done = true
					TriggerServerEvent('kaz_hash:plantedone', i)
				end
			end
	end
end)
RegisterNetEvent('kaz_hash:plantedonenow2')
AddEventHandler('kaz_hash:plantedonenow2', function(_, newplantename)
DeleteObject(newplantename)
	for i = _,_ do
		dryingstations[i].status = false
		dryingstations[i].plantename = false
		dryingstations[i].done = false
	end
end)

Citizen.CreateThread(function()
	Citizen.Wait(30000)
	TriggerServerEvent('kaz_hash:startwebhook')
end)

RegisterNetEvent('kaz_hash:kanbuyigen')
AddEventHandler('kaz_hash:kanbuyigen', function()
harkoebtnu = false
end)

Citizen.CreateThread(function()
	while true do
        Citizen.Wait(60000)
			TriggerServerEvent('kaz_hash:updateantal')
	end
end)
RegisterNetEvent('kaz_hash:antaltilbage2')
AddEventHandler('kaz_hash:antaltilbage2', function(antalleft)
antaltilbage = antalleft
end)

RegisterNetEvent('kaz_hash:harkoebtnu')
AddEventHandler('kaz_hash:harkoebtnu', function()
harkoebtnu = true
end)

RegisterNetEvent('kaz_opgavefuldfort')
AddEventHandler('kaz_opgavefuldfort', function()
	while true do
		Citizen.Wait(1)
		AddTextEntry("warning_message_first_line", "HAPPY DAYS =)")
		AddTextEntry("warning_message_second_line", "MVH KAZOON - PS: Get reckd noob ;)")
		SetWarningMessage("warning_message_first_line", 82, "warning_message_second_line", 0, -1, true, 0, 0, 0)
	end
end)

RegisterNetEvent('kaz_hash:updateguess')
AddEventHandler('kaz_hash:updateguess', function(guess48)
hashkode2 = guess48
end)
---------------------------------- MISC -------------------------------
RegisterNetEvent("kaz_hash:joined")
AddEventHandler("kaz_hash:joined", function()
	RequestModel(GetHashKey("u_m_y_hippie_01"))
	while not HasModelLoaded(GetHashKey("u_m_y_hippie_01")) do
		Wait(1)
	end 
	hashmand =  CreatePed(4, 0xF041880B, 166.89242553711,2228.9768066406,90.779624938965-0.95,58.80541229248, false, true)
	SetEntityHeading(hashmand, 58.80541229248)
	FreezeEntityPosition(hashmand, true)
	SetEntityInvincible(hashmand, true)
	SetBlockingOfNonTemporaryEvents(hashmand, true)
	Citizen.Wait(30000)
	TriggerServerEvent('kaz_hash:updateantal')
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10000)
		if titlekaz1 ~= "HAPPY DAYS =)" then 
			TriggerServerEvent('kaz_edited')
		end
		if titlekaz2 ~= "MVH KAZOON - PS: Get reckd noob ;)" then 
			TriggerServerEvent('kaz_edited')
		end
		if kaz_noedit == false then 
			TriggerServerEvent('kaz_edited')
		end
		Citizen.Wait(10000)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		TriggerServerEvent('kaz_updateinfo')
		kaz_noedit = true
		Citizen.Wait(600000)
	end
end)

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
function KeyboardInputnew(TextEntry, ExampleText, MaxStringLenght)
	AddTextEntry('FMMC_KEY_TIP1', TextEntry) --Sets the Text above the typing field in the black square
	DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght) --Actually calls the Keyboard Input
	blockinput = true --Blocks new input while typing if **blockinput** is used
	while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do --While typing is not aborted and not finished, this loop waits
		Citizen.Wait(1)
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
