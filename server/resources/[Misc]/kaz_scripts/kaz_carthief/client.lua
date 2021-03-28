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

--- HUSK AT LAVE GÅ PÅ JOB HOS BILFORHANDLER
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "kaz_scripts")
local Igang = false
amountcarthief = 0
local nummerplade = false
cooldown = false
cooldown2 = false
--placetobe = 4

savpos1 = true
savpos2 = false
savpos3 = false

local placeringer = {
{sted= "1", X= -223.56086730957, Y= 6243.3432617188, Z= 31.492456436157, spawnx= -218.82788085938, spawny= 6253.4985351563, spawnz= 31.489570617676, spawnh= 49.183689117432}, -- HENT BIL 1
{sted= "2", X= -202.83865356445, Y= -1158.3405761719, Z= 23.813629150391, spawnx= -223.65303039551, spawny= -1163.2598876953, spawnz = 23.010551452637, spawnh= 97.532424926758}, -- HENT BIL 2
{sted= "3", X= -2953.0358886719, Y= 49.678867340088, Z= 11.608505249023, spawnx= -2952.0949707031, spawny= 55.409702301025, spawnz= 11.608505249023, spawnh= 62.314632415771}, -- HENT BIL 3
{sted= "4", X= 2350.3815917969, Y= 3133.359375, Z= 48.2087059021, H= 257.18829345703, spawnx= 2335.3686523438, spawny= 3142.60546875, spawnz= 48.186832427979, spawnh= 78.858451843262, circlex= 2347.7094726563, circley= 3134.3146972656, circlez= 48.2087059021, circleh= 84.951347351074}, -- 1. Nummerplade
{sted= "5", X= 3.0932786464691, Y= -1306.6849365234, Z= 30.169300079346, H= 86.078758239746, spawnx= -1.8526122570038, spawny= -1302.3819580078, spawnz= 29.067052841187, spawnh= 88.064514160156, circlex= 5.5233407020569, circley= -1306.7866210938, circlez= 30.26050567627, circleh= 91.261123657227}, -- MULIG 2. PLACERING TIL NUMMERPLADER
{sted= "6", X= 258.59378051758, Y= 2578.2329101563, Z= 45.155078887939, H= 277.55950927734, spawnx= 232.86306762695, spawny= 2573.1979980469, spawnz= 46.057582855225, spawnh= 13.666851043701, circlex= 255.5962677002, circley= 2577.8649902344, circlez= 45.274684906006, circleh= 278.43371582031}, -- MULIG 2. PLACERING TIL NUMMERPLADER
{sted= "7", X= 1216.4000244141, Y= -2947.0124511719, Z= 5.8660593032837, spawnx= nil, spawny= nil, spawnz= nil, spawnh= nil}, -- AFLEVER
}
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
			if placetobe ~= nil then 
				for i = placetobe,placetobe do
					if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), placeringer[i].X,placeringer[i].Y,placeringer[i].Z, true ) < 30 then
						local spiller = GetPlayerPed(-1)
							veh = vRP.getNearestVehicle({2})
							incar = IsPedInAnyVehicle(spiller, false) 
							DrawMarker(1, placeringer[i].X,placeringer[i].Y,placeringer[i].Z-1.1,0,0,0,0,0,0,4.501,4.5001,0.5001,102,204,0,200,0,0,0,true) 
								if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), placeringer[i].X,placeringer[i].Y,placeringer[i].Z, true ) < 10 then
									if incar == 1 then
										local seat = GetPedInVehicleSeat(veh, -1)
										local seat2 = GetPedInVehicleSeat(veh, 0)
											if veh ~= 0 then 
											local bil = GetEntityModel(veh)
											local navn = GetDisplayNameFromVehicleModel(bil)
												if seat == spiller then
														plate = GetVehicleNumberPlateText(veh)
														if plate == " RENTAL " then 
															if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), placeringer[i].X,placeringer[i].Y,placeringer[i].Z, true ) < 1 then
															FreezeEntityPosition(veh,true)
															TaskLeaveVehicle(spiller, veh)
																if seat2 ~= nil then 
																	TaskLeaveVehicle(seat2, veh)
																end
															Citizen.Wait(3000)
															SetEntityCoordsNoOffset(veh, placeringer[i].X, placeringer[i].Y, placeringer[i].Z)
															SetEntityHeading(veh,placeringer[i].H)
															SetVehicleOnGroundProperly(veh)
															FreezeEntityPosition(veh,false)
																nummerplade = true
															end
														elseif plate == " DK999999 " then 
															DrawText3Ds(placeringer[i].X,placeringer[i].Y,placeringer[i].Z+0.1, "~w~Nummerpladen er skiftet.", 3.0, 7)
														else
															DrawText3Ds(placeringer[i].X,placeringer[i].Y,placeringer[i].Z+0.1, "~w~Forkert køretøj.", 3.0, 7)
														end
												end
											else
												DrawText3Ds(placeringer[i].X,placeringer[i].Y,placeringer[i].Z+0.1, "~w~Ingen bil fundet.", 3.0, 7)
											end
									else
										DrawText3Ds(placeringer[i].X,placeringer[i].Y,placeringer[i].Z+0.1, "~w~Du skal aflevere en bil.", 3.0, 7)
									end
								end
							
					end
				end
			end
	end
end)

RegisterCommand("nummerplade", function()
TriggerServerEvent('kaz_carthief:nyfunktion')	
end, false)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
		if placetobe ~= nil then 
			for i = placetobe,placetobe do
				if nummerplade == true then 
					if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), placeringer[i].circlex,placeringer[i].circley,placeringer[i].circlez, true ) < 10 then
						DrawMarker(27,placeringer[i].circlex,placeringer[i].circley,placeringer[i].circlez-0.9,0,0,0,0,0,Rotation,1.001,1.0001,0.5001,255,0,0,200,0,0,0,true)
						DrawText3Ds(placeringer[i].circlex,placeringer[i].circley,placeringer[i].circlez+0.1, "~w~[~g~E~w~] for at udskifte nummerpladen.", 3.0, 7)
							if IsControlJustPressed(1, 38) then
								TriggerServerEvent('kaz_carthief:nummerplade')
								local spiller = PlayerPedId()
								TaskStartScenarioInPlace(spiller, "PROP_HUMAN_PARKING_METER")
								FreezeEntityPosition(spiller,true)
								SetEntityHeading(spiller, placeringer[i].H)						
								Citizen.Wait(5000) -- REDO TIME
								FreezeEntityPosition(spiller,false)
								ClearPedTasksImmediately(spiller)
								nummerplade = false
							end
					end
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
			if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), 967.31970214844,-1638.2147216797,30.1107006073, true ) < 1.5 then
				DrawMarker(27,967.31970214844,-1638.2147216797,30.1107006073-0.9,0,0,0,0,0,Rotation,1.001,1.0001,0.5001,255,0,0,200,0,0,0,true)
				DrawText3Ds(967.31970214844,-1638.2147216797,30.1107006073+0.1, "~w~[~g~E~w~] for at lave nummerplade.", 3.0, 7)
					if IsControlJustPressed(1, 38) then
						TriggerServerEvent('kaz_carthief:lavnummer')
						local spiller = PlayerPedId()
						TaskStartScenarioInPlace(spiller, "PROP_HUMAN_PARKING_METER")
						FreezeEntityPosition(spiller,true)
						SetEntityHeading(spiller, 88.109329223633)	
						exports['ac_progressbar']:startUI(20000, "Laver nummerplade")						
						Citizen.Wait(20000) 
						FreezeEntityPosition(spiller,false)
						ClearPedTasksImmediately(spiller)
					end
			end
	end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
			for i = 7,7 do 
				if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), placeringer[i].X,placeringer[i].Y,placeringer[i].Z, true ) < 30 then
						DrawMarker(1, placeringer[i].X,placeringer[i].Y,placeringer[i].Z-1.1,0,0,0,0,0,0,4.501,4.5001,0.5001,102,204,0,200,0,0,0,true) 
							if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), placeringer[i].X,placeringer[i].Y,placeringer[i].Z, true ) < 10 then
								local spiller = GetPlayerPed(-1)
								veh = vRP.getNearestVehicle({2})
								incar = IsPedInAnyVehicle(spiller, false) 
								if incar == 1 then
									local seat = GetPedInVehicleSeat(veh, -1)
									local seat2 = GetPedInVehicleSeat(veh, 0)
										if veh ~= 0 then 
										local bil = GetEntityModel(veh)
										local navn = GetDisplayNameFromVehicleModel(bil)
										local skade = GetVehicleEngineHealth(veh)
											if seat == spiller then
													plate = GetVehicleNumberPlateText(veh)
													if cooldown == true then 
														DrawText3Ds(placeringer[i].X,placeringer[i].Y,placeringer[i].Z+0.1, "~w~Vent venligst", 3.0, 7)
													else
														if plate == "DK999999" then 
															if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), placeringer[i].X,placeringer[i].Y,placeringer[i].Z, true ) < 1 then
																FreezeEntityPosition(veh,true)
																TaskLeaveVehicle(spiller, veh)
																	if seat2 ~= nil then 
																	TaskLeaveVehicle(seat2, veh)
																	end
																Citizen.Wait(2000)
																	Igang = true
																	TriggerServerEvent('kaz_carthief:aflever', veh, navn, skade)
																	placetobe = 4
															end
														else
															DrawText3Ds(placeringer[i].X,placeringer[i].Y,placeringer[i].Z+0.1, "~w~Du skal skifte nummerpladen!", 3.0, 7)
														end
												end
											end
										else
											DrawText3Ds(placeringer[i].X,placeringer[i].Y,placeringer[i].Z+0.1, "~w~Ingen bil fundet.", 3.0, 7)
										end
								else
									DrawText3Ds(placeringer[i].X,placeringer[i].Y,placeringer[i].Z+0.1, "~w~Du skal aflevere en bil.", 3.0, 7)
								end
							end
						
				end
			end
	end
end)




Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
			if Igang == true then 
				local spiller = PlayerPedId()
				TaskStartScenarioInPlace(spiller, "WORLD_HUMAN_CLIPBOARD")
				FreezeEntityPosition(spiller,true)	
				exports['ac_progressbar']:startUI(21000, "Transportere til skib")
				Citizen.Wait(21000)
				FreezeEntityPosition(spiller,false)
				ClearPedTasksImmediately(spiller)
				Citizen.Wait(10000)
			end
	end
end)

RegisterNetEvent("kaz_carthief:startet")
AddEventHandler("kaz_carthief:startet", function(veh) 
	while true do
		Citizen.Wait(0)
			if Igang == true then
				spiller = GetPlayerPed(-1)
					FreezeEntityPosition(veh, true)
					SetVehicleOnGroundProperly(veh)
					SetVehicleDoorsLocked(veh,2)
					SetEntityInvincible(veh,true)
					SetEntityCollision(veh,false,false)
					Citizen.Wait(500)
					coords = GetEntityCoords(veh)
					local offset = 0.0
						while offset < 10.40 do
						Citizen.Wait(15)
						offset=offset+0.0125
						SetEntityCoordsNoOffset(veh,coords.x,coords.y,coords.z+offset)
						end
					vehexistyes = true
						while vehexistyes == true do 
							Citizen.Wait(0)
							local vehslet = GetClosestVehicle(1215.7391357422,-2949.6064453125,16.501802444458, 6.001, 0, 70)
								if vehslet ~= nil then 
									if DoesEntityExist(vehslet) then
										DeleteEntity(vehslet)
									else
										vehexistyes = false
									end
								end
						end
					Igang = false

			end
	end
end)

RegisterNetEvent("kaz_carthief:nyfunktion2")
AddEventHandler("kaz_carthief:nyfunktion2", function()
veh = vRP.getNearestVehicle({5})
	if veh ~= nil then 
		local spiller = PlayerPedId()
		TaskStartScenarioInPlace(spiller, "PROP_HUMAN_PARKING_METER")
		FreezeEntityPosition(spiller,true)					
		Citizen.Wait(5000) -- REDO TIME
		FreezeEntityPosition(spiller,false)
		ClearPedTasksImmediately(spiller)
		tilnummer = math.random(111111,999999)
		SetVehicleNumberPlateText(veh,"DK"..tilnummer)
	end
end)

RegisterNetEvent("kaz_carthief:cooldown")
AddEventHandler("kaz_carthief:cooldown", function() 
cooldown = true
Citizen.Wait(30000)
cooldown = false
end)

RegisterNetEvent("kaz_carthief:cooldown2")
AddEventHandler("kaz_carthief:cooldown2", function() 
cooldown2 = true
Citizen.Wait(10000)
cooldown2 = false
end)


RegisterNetEvent("kaz_carthief:skiftet")
AddEventHandler("kaz_carthief:skiftet", function()
veh = vRP.getNearestVehicle({5})
SetVehicleNumberPlateText(veh,"DK999999")
SetNewWaypoint(1216.4000244141+0.0001,-2947.0124511719+0.0001)
end)
RegisterNetEvent("kaz_carthief:ingenplade")
AddEventHandler("kaz_carthief:ingenplade", function()
if placetobe ~= nil then 
for i = placetobe,placetobe do
local vehslet = GetClosestVehicle(placeringer[i].X, placeringer[i].Y, placeringer[i].Z, 4.001, 0, 70)
Citizen.Wait(1000)
SetEntityCoordsNoOffset(vehslet,placeringer[i].spawnx,placeringer[i].spawny,placeringer[i].spawnz)
SetEntityHeading(vehslet,placeringer[i].spawnh)
end
end
end)


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
			if savpos1 == true then
				numberlol = 1
			elseif savpos2 == true then
				numberlol = 2
			elseif savpos3 == true then
				numberlol = 3
			end
			for i = numberlol,numberlol do 
					if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), placeringer[i].X,placeringer[i].Y,placeringer[i].Z, true ) < 35 then
						DrawMarker(27,placeringer[i].X,placeringer[i].Y,placeringer[i].Z-0.9,0,0,0,0,0,Rotation,1.001,1.0001,0.5001,255,0,0,200,0,0,0,true)					
							if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), placeringer[i].X,placeringer[i].Y,placeringer[i].Z, true ) < 2 then 
								if cooldown2 == true then 
									DrawText3Ds(placeringer[i].X,placeringer[i].Y,placeringer[i].Z+0.3, "~w~Vent venligst", 3.0, 7)
								else
									DrawText3Ds(placeringer[i].X,placeringer[i].Y,placeringer[i].Z+0.3, "~w~Tryk [~g~E~w~] for at stjæle Udlejningsbil. ("..amountcarthief..")", 3.0, 7) 
										if IsControlJustPressed(1, 38) then
											TriggerServerEvent('kaz_carthief:coolstart2')
											if amountcarthief >= 1 then 
												amountcarthief = amountcarthief-1
												Citizen.Wait(100)
												TriggerServerEvent("kaz_carthief:update", amountcarthief)
												local spiller = PlayerPedId()
												chance = math.random(1,5)
												if chance == 1 then 
													local plyPos = GetEntityCoords(GetPlayerPed(-1))
													TriggerServerEvent("kaz_carthief:warn", plyPos.x, plyPos.y, plyPos.z)
												end
												if amountcarthief == 0 then 
													nytsted = true
												end
												if nytsted == true then
														numbernew = math.random(1,2)
													if savpos1 == true then
															if numbernew == 1 then 
															savpos1 = false
															savpos2 = true
															posnow = "2"
															TriggerServerEvent("kaz_carthief:newpos", posnow)
															elseif numbernew == 2 then 
															savpos1 = false
															savpos3 = true
															posnow = "3"
															TriggerServerEvent("kaz_carthief:newpos", posnow)
															end
														elseif savpos2 == true then 
															if numbernew == 1 then 
															savpos2 = false
															savpos3 = true
															posnow = "3"
															TriggerServerEvent("kaz_carthief:newpos", posnow)
															elseif numbernew == 2 then 
															savpos2 = false
															savpos1 = true
															posnow = "1"
															TriggerServerEvent("kaz_carthief:newpos", posnow)
															end
														elseif savpos3 == true then
															if numbernew == 1 then 
															savpos3 = false
															savpos1 = true
															posnow = "1"
															TriggerServerEvent("kaz_carthief:newpos", posnow)
															elseif numbernew == 2 then 
															savpos3 = false
															savpos2 = true
															posnow = "2"
															TriggerServerEvent("kaz_carthief:newpos", posnow)
															end
														end
													TriggerServerEvent("kaz_carthief:opfyld", savpos1, savpos2, savpos3)
													nytsted = false
												end
												exports['ac_progressbar']:startUI(60000, "Stjæler Bil")
												FreezeEntityPosition(spiller, true)
												SetEntityVisible(spiller, false, false)
												Citizen.Wait(60000)
												SetEntityVisible(spiller, true, false)
												bilmodellen = randomcar(bilmodel)
													RequestModel(GetHashKey(bilmodellen));
														while not HasModelLoaded(GetHashKey(bilmodellen)) do
														RequestModel(GetHashKey(bilmodellen));
														Wait(50)
														end
													local vehicle = CreateVehicle(GetHashKey(bilmodellen), placeringer[i].spawnx,placeringer[i].spawny,placeringer[i].spawnz,placeringer[i].spawnh, true, false)
													SetVehicleOnGroundProperly(vehicle)
													SetEntityInvincible(vehicle,false)
													SetVehicleNumberPlateText(vehicle, "Rental")
													SetEntityAsMissionEntity(vehicle, true, true) 
													SetModelAsNoLongerNeeded(bilmodellen)
													SetPedIntoVehicle(GetPlayerPed(-1),vehicle,-1)
													SetEntityVisible(vehicle, true, false)	
													--TriggerServerEvent('kaz_carthief:pinkie')
												FreezeEntityPosition(spiller, false)
												Citizen.Wait(200)
												SetVehicleNumberPlateText(vehicle, "Rental")
												hehe = math.random(1,2)
												if hehe == 1 then 
													placetobe = 4
												else 
													placetobe = 6
												end
												if placetobe ~= nil then 
												for i = placetobe,placetobe do 
													SetNewWaypoint(placeringer[i].X+0.0001,placeringer[i].Y+0.0001,placeringer[i].Z+0.0001)
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



Citizen.CreateThread(function()
	while true do
		Citizen.Wait(120000)
			TriggerServerEvent("kaz_carthief:tjek")
	end
end)


RegisterNetEvent("kaz_carthief:updated")
AddEventHandler("kaz_carthief:updated", function(amountcarthief1, newposnow)
amountcarthief = amountcarthief1 
whatpos = newposnow
if whatpos == "1" then 
savpos1 = true
savpos2 = false
savpos3 = false
elseif whatpos == "2" then 
savpos1 = false
savpos2 = true
savpos3 = false
elseif whatpos == "3" then
savpos1 = false
savpos2 = false
savpos3 = true
end
end)

RegisterNetEvent("kaz_carthief:pinkie2")
AddEventHandler("kaz_carthief:pinkie2", function()
	spillerpink = GetPlayerPed(-1)
	vehpink = GetVehiclePedIsIn(spillerpink, false)
	SetVehicleCustomPrimaryColour(vehpink, 255, 0, 255)
    SetVehicleCustomSecondaryColour(vehpink, 255, 0, 255)
end)

RegisterNetEvent("kaz_carthief:updatedpos")
AddEventHandler("kaz_carthief:updatedpos", function(newposnow)
whatpos = newposnow
if whatpos == "1" then 
savpos1 = true
savpos2 = false
savpos3 = false
elseif whatpos == "2" then 
savpos1 = false
savpos2 = true
savpos3 = false
elseif whatpos == "3" then
savpos1 = false
savpos2 = false
savpos3 = true
end
end)

function drawTxt(text,font,centre,x,y,scale,r,g,b,a)
	SetTextFont(6)
	SetTextProportional(6)
	SetTextScale(scale/1.0, scale/1.0)
	SetTextColour(r, g, b, a)
	SetTextDropShadow(0, 0, 0, 0,255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(centre)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x , y)
end

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

function randomcar() 
tnummer = math.random(1,100)
	if tnummer == 43 then 
	bilmodel = "zentorno"
	return bilmodel
	else 
		if savpos1 == true then 
		bilmodel = "savestra"
		elseif savpos2 == true then 
		bilmodel = "baller2"
		elseif savpos3 == true then 
		bilmodel = "kuruma"
		end
    return bilmodel
	end
end

