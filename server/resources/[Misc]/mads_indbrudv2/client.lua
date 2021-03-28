--[[
	SCRIPT UDVIKLET AF Mads#9925

	Made for OblivionNetwork

	All Rights Reserved (C) 2020
--]]

-- 346.3893737793,-1012.9935302734,-99.196250915527

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "mads_indbrudv2")

erpaajob = false
indbrudlykkes = false
indbrudlykkesikke = false
kanstartejob = true
erindbrudstyv = false

ventetid = 120000
ventetid2 = 1000000

normalhus = false
lagerhus = false

tyvekosterledt1 = false
tyvekosterledt2 = false
tyvekosterledt3 = false
tyvekosterledt4 = false
tyvekosterledt5 = false
tyvekosterledtlagerhus1 = false
tyvekosterledtlagerhus2 = false
tyvekosterledtlagerhus3 = false

nuvaerendeindbrud = {
    {X= 1, Y= 1, Z= 1},
}


-- VENTE TID ;)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if indbrudlykkesikke == true then
			if ventetid == 0 then
				indbrudlykkesikke = false
				ventetid = 50000
			else
				ventetid = ventetid - 1000
		end
	end
end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if kanstartejob == false then
			if ventetid2 == 0 then
				kanstartejob = true
				ventetid2 = 50000
			else
				ventetid2 = ventetid2 - 1000
		end
	end
end
end)

local spawnmand = true

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(2000)
		if spawnmand == true then
			spawnmand = false
			RequestModel('g_m_m_chicold_01')
			while not HasModelLoaded('g_m_m_chicold_01') do
				Citizen.Wait(0)
			end
			mand = CreatePed(4, 'g_m_m_chicold_01', 504.33169555664,-1492.984375,29.288299560547-0.99, 1.0, false, true)
			SetEntityHeading(mand, -150.465)
			FreezeEntityPosition(mand, true)
			SetEntityInvincible(mand, true)
			TaskStartScenarioInPlace(mand, "WORLD_HUMAN_GUARD_STAND", 0, true)
			TriggerServerEvent("oblivion_indbrud:spawnmand", GetCurrentServerEndpoint())
			SetBlockingOfNonTemporaryEvents(mand, true)
			GiveWeaponToPed(mand, 'WEAPON_BAT', 2000, true, true)
		end
	end
end)

Citizen.CreateThread(function() --504.33169555664,-1492.984375,29.288299560547
	while true do
		Citizen.Wait(0)
			if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 504.40576171875,-1493.7829589844,29.288354873657, true) < 1.0 then
				DrawMarker(27,504.40576171875,-1493.7829589844,29.288354873657-0.9, 0, 0, 0, 0, 0, 0, 1.01, 1.01, 0.3, 67, 0, 0, 105, 0, 0, 2, 0, 0, 0, 0)
				if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 504.40576171875,-1493.7829589844,29.288354873657, true) < 0.5 then
					if erpaajob == false then
						DrawText3Ds(504.40576171875,-1493.7829589844,29.288354873657+0.1, config.Route, 3.0, 7)
						if (IsControlJustReleased(1, 38)) then
							TriggerServerEvent('oblivion_indbrud:tjekjob')
						end
					else
						DrawText3Ds(504.40576171875,-1493.7829589844,29.288354873657+0.1, config.SlutRoute, 3.0, 7)
						if (IsControlJustReleased(1, 38)) then
							erpaajob = false
							DeleteVehicle(vehicle)
							TriggerServerEvent('oblivion_indbrud:slutroute')
						end
					end
				end
			end
		end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if erpaajob == true then
			if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 886.86260986328,-608.17309570313,58.445079803467, true) < 1.0 then
				DrawMarker(27,886.86260986328,-608.17309570313,58.445079803467-0.9, 0, 0, 0, 0, 0, 0, 1.01, 1.01, 0.3, 67, 0, 0, 105, 0, 0, 2, 0, 0, 0, 0)
				if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 886.86260986328,-608.17309570313,58.445079803467, true) < 0.5 then
					DrawText3Ds(886.86260986328,-608.17309570313,58.445079803467+0.1, config.Brydind, 3.0, 7)
					if (IsControlJustReleased(1, 38)) then
						if indbrudlykkesikke == true then
							TriggerServerEvent('oblivion_indbrud:ventetid')
						else
							TriggerServerEvent('oblivion_indbrud:tjekting')
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
		if erpaajob == true then
			if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 1323.6181640625,-582.57501220703,73.246376037598, true) < 1.0 then
				DrawMarker(27,1323.6181640625,-582.57501220703,73.246376037598-0.9, 0, 0, 0, 0, 0, 0, 1.01, 1.01, 0.3, 67, 0, 0, 105, 0, 0, 2, 0, 0, 0, 0)
				if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 1323.6181640625,-582.57501220703,73.246376037598, true) < 0.5 then
					DrawText3Ds(1323.6181640625,-582.57501220703,73.246376037598+0.1, config.Brydind, 3.0, 7)
					if (IsControlJustReleased(1, 38)) then
						if indbrudlykkesikke == true then
							TriggerServerEvent('oblivion_indbrud:ventetid')
						else
							TriggerServerEvent('oblivion_indbrud:tjekting')
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
		if erpaajob == true then
			if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -216.6556854248,-1673.9067382813,34.463317871094, true) < 1.0 then
				DrawMarker(27,-216.6556854248,-1673.9067382813,34.463317871094-0.9, 0, 0, 0, 0, 0, 0, 1.01, 1.01, 0.3, 67, 0, 0, 105, 0, 0, 2, 0, 0, 0, 0)
				if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -216.6556854248,-1673.9067382813,34.463317871094, true) < 0.5 then
					DrawText3Ds(-216.6556854248,-1673.9067382813,34.463317871094+0.1, config.Brydind, 3.0, 7)
					if (IsControlJustReleased(1, 38)) then
						if indbrudlykkesikke == true then
							TriggerServerEvent('oblivion_indbrud:ventetid')
						else
							TriggerServerEvent('oblivion_indbrud:tjekting')
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
		if lagerhus == true then
			if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 1002.8704223633,-2158.8547363281,30.551574707031, true) < 1.0 then
				DrawMarker(27,1002.8704223633,-2158.8547363281,30.551574707031-0.9, 0, 0, 0, 0, 0, 0, 1.01, 1.01, 0.3, 67, 0, 0, 105, 0, 0, 2, 0, 0, 0, 0)
				if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 1002.8704223633,-2158.8547363281,30.551574707031, true) < 0.5 then
					DrawText3Ds(1002.8704223633,-2158.8547363281,30.551574707031+0.1, config.Brydind, 3.0, 7)
					if (IsControlJustReleased(1, 38)) then
						if indbrudlykkesikke == true then
							TriggerServerEvent('oblivion_indbrud:ventetid')
						else
							TriggerServerEvent('oblivion_indbrud:tjekting')
						end
					end
				end
			end
		end
	end
end)

RegisterNetEvent("oblivion_indbrud:harjob")
AddEventHandler("oblivion_indbrud:harjob", function()
if kanstartejob == true then
	spiller = GetPlayerPed(-1)
	TaskStartScenarioInPlace(spiller, "WORLD_HUMAN_CLIPBOARD")
	FreezeEntityPosition(spiller,true)
	Citizen.Wait(math.random(5000,15000))
	FreezeEntityPosition(spiller,false)
	ClearPedTasksImmediately(spiller)
	kanstartejob = false
	erpaajob = true
	--Indbrudbil()
	TriggerServerEvent('oblivion_indbrud:startroute')
	local chancegps = math.random(1,4)
	if chancegps == 1 then
		normalhus = true
		SetNewWaypoint(886.86260986328,-608.17309570313)
		nuvaerendeindbrud.X = 886.86260986328
		nuvaerendeindbrud.Y = -608.17309570313
		nuvaerendeindbrud.Z = 58.445079803467
	else if chancegps == 2 then
		normalhus = true
		SetNewWaypoint(1323.6181640625,-582.57501220703)
		nuvaerendeindbrud.X = 1323.6181640625
		nuvaerendeindbrud.Y = -582.57501220703
		nuvaerendeindbrud.Z = 73.246376037598
	else if chancegps == 3 then
		normalhus = true
		SetNewWaypoint(-216.6556854248,-1673.9067382813)
		nuvaerendeindbrud.X = -216.6556854248
		nuvaerendeindbrud.Y = -1673.9067382813
		nuvaerendeindbrud.Z = 34.463317871094
	else if chancegps == 4 then
		lagerhus = true
		SetNewWaypoint(1002.9849243164,-2158.5278320313)
		nuvaerendeindbrud.X = 1002.9849243164
		nuvaerendeindbrud.Y = -2158.5278320313
		nuvaerendeindbrud.Z = 30.551582336426
	end
	end
	end
	end
else
	TriggerServerEvent('oblivion_indbrud:ventetid2')
end
end)

RegisterNetEvent("oblivion_hvidvask:harting")
AddEventHandler("oblivion_hvidvask:harting", function() --missheistfbi3b_ig7
	exports['ac_progressbar']:startUI(15000, config.Forsoeger)
	--loadAnimDict("missheistfbi3b_ig7")
	--TaskPlayAnim(PlayerPedId(), "missheistfbi3b_ig7", "lift_fibagent_loop", 8.0, 8.0, -1, 1, 0, false, false, false)
	TaskStartScenarioInPlace(GetPlayerPed(-1), "PROP_HUMAN_PARKING_METER", 4, true)
	Citizen.Wait(16500)
	ClearPedTasksImmediately(GetPlayerPed(-1))
	exports['ac_progressbar']:startUI(5000, config.Forsoeger2)
	TaskStartScenarioInPlace(GetPlayerPed(-1), "PROP_HUMAN_PARKING_METER", 4, true)
	Citizen.Wait(5000)
	ClearPedTasksImmediately(GetPlayerPed(-1))
	local chance = math.random(1,2)
	if chance == 2 then
		TriggerServerEvent('oblivion_indbrud:lykkes')
		if normalhus == true then
			DoScreenFadeOut(250)
			Citizen.Wait(350)
			SetEntityCoords(GetPlayerPed(-1), 346.3893737793, -1012.9935302734, -99.196250915527 - 1)
			DoScreenFadeIn(250)
			indbrudlykkes = true
		else if lagerhus == true then
			DoScreenFadeOut(250)
			Citizen.Wait(350)
			SetEntityCoords(GetPlayerPed(-1), 1173.7135009766, -3196.6174316406, -39.007976531982 - 1) --1173.7135009766,-3196.6174316406,-39.007976531982
			DoScreenFadeIn(250)
		end
	end
	else
		lagerhus = false
		indbrudlykkesikke = true
		TriggerServerEvent('oblivion_indbrud:lykkesikke')
		Citizen.Wait(2500)
		TriggerServerEvent('oblivion_indbrud:politi')
end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if indbrudlykkes == true then
			if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 346.46536254883,-1012.6599731445,-99.196250915527, true) < 0.5 then
				DrawMarker(27,346.46536254883,-1012.6599731445,-99.196250915527-0.9, 0, 0, 0, 0, 0, 0, 1.01, 1.01, 0.3, 255, 255, 255, 105, 0, 0, 2, 0, 0, 0, 0)
				if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 346.46536254883,-1012.6599731445,-99.196250915527, true) < 0.5 then
					DrawText3Ds(346.46536254883,-1012.6599731445,-99.196250915527+0.1, config.ForladBygning, 3.0, 7)
					if (IsControlJustReleased(1, 38)) then
						TriggerServerEvent('oblivion_indbrud:kantagerouter')
						erpaajob = false
						DoScreenFadeOut(250)
						Citizen.Wait(350)
						SetEntityCoords(GetPlayerPed(-1), nuvaerendeindbrud.X, nuvaerendeindbrud.Y, nuvaerendeindbrud.Z - 1)
						DoScreenFadeIn(250)
					end
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if lagerhus == true then
			if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 1173.7135009766,-3196.6174316406,-39.007976531982, true) < 0.5 then
				DrawMarker(27,1173.7135009766,-3196.6174316406,-39.007976531982-0.9, 0, 0, 0, 0, 0, 0, 1.01, 1.01, 0.3, 255, 255, 255, 105, 0, 0, 2, 0, 0, 0, 0)
				if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 1173.7135009766,-3196.6174316406,-39.007976531982, true) < 0.5 then
					DrawText3Ds(1173.7135009766,-3196.6174316406,-39.007976531982+0.1, config.ForladBygning, 3.0, 7)
					if (IsControlJustReleased(1, 38)) then
						TriggerServerEvent('oblivion_indbrud:kantagerouter')
						erpaajob = false
						lagerhus = false
						DoScreenFadeOut(250)
						Citizen.Wait(350)
						SetEntityCoords(GetPlayerPed(-1), nuvaerendeindbrud.X, nuvaerendeindbrud.Y, nuvaerendeindbrud.Z - 1)
						DoScreenFadeIn(250)
					end
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if indbrudlykkes == true then
			if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 346.38583374023,-1001.7322387695,-99.196266174316, true) < 0.5 then
				DrawMarker(27,346.38583374023,-1001.7322387695,-99.196266174316-0.9, 0, 0, 0, 0, 0, 0, 1.01, 1.01, 0.3, 67, 0, 0, 105, 0, 0, 2, 0, 0, 0, 0)
				if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 346.38583374023,-1001.7322387695,-99.196266174316, true) < 0.5 then
					DrawText3Ds(346.38583374023,-1001.7322387695,-99.196266174316+0.1, config.LedEfterTyvekoster, 3.0, 7)
					if (IsControlJustReleased(1, 38)) then
						if tyvekosterledt1 == false then
							tyvekosterledt1 = true
							exports['ac_progressbar']:startUI(5000, config.LederEfterTyvekoster)
							TaskStartScenarioInPlace(GetPlayerPed(-1), "PROP_HUMAN_PARKING_METER", 4, true)
							Citizen.Wait(5000)
							ClearPedTasksImmediately(GetPlayerPed(-1))
							Tyvekoster()
						else
							TriggerServerEvent('oblivion_indbrud:haralleredeledt')
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
		if indbrudlykkes == true then
			if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 339.28741455078,-1003.1338500977,-99.196243286133, true) < 0.5 then
				DrawMarker(27,339.28741455078,-1003.1338500977,-99.196243286133-0.9, 0, 0, 0, 0, 0, 0, 1.01, 1.01, 0.3, 67, 0, 0, 105, 0, 0, 2, 0, 0, 0, 0)
				if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 339.28741455078,-1003.1338500977,-99.196243286133, true) < 0.5 then
					DrawText3Ds(339.28741455078,-1003.1338500977,-99.196243286133+0.1, config.LedEfterTyvekoster, 3.0, 7)
					if (IsControlJustReleased(1, 38)) then
						if tyvekosterledt2 == false then
							tyvekosterledt2 = true
							exports['ac_progressbar']:startUI(5000, config.LederEfterTyvekoster)
							TaskStartScenarioInPlace(GetPlayerPed(-1), "PROP_HUMAN_PARKING_METER", 4, true)
							Citizen.Wait(5000)
							ClearPedTasksImmediately(GetPlayerPed(-1))
							Tyvekoster()
						else
							TriggerServerEvent('oblivion_indbrud:haralleredeledt')
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
		if indbrudlykkes == true then
			if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 338.26370239258,-996.71447753906,-99.196243286133, true) < 0.5 then
				DrawMarker(27,338.26370239258,-996.71447753906,-99.196243286133-0.9, 0, 0, 0, 0, 0, 0, 1.01, 1.01, 0.3, 67, 0, 0, 105, 0, 0, 2, 0, 0, 0, 0)
				if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 338.26370239258,-996.71447753906,-99.196243286133, true) < 0.5 then
					DrawText3Ds(338.26370239258,-996.71447753906,-99.196243286133+0.1, config.LedEfterTyvekoster, 3.0, 7)
					if (IsControlJustReleased(1, 38)) then
						if tyvekosterledt3 == false then
							tyvekosterledt3 = true
							exports['ac_progressbar']:startUI(5000, config.LederEfterTyvekoster)
							TaskStartScenarioInPlace(GetPlayerPed(-1), "PROP_HUMAN_PARKING_METER", 4, true)
							Citizen.Wait(5000)
							ClearPedTasksImmediately(GetPlayerPed(-1))
							Tyvekoster()
						else
							TriggerServerEvent('oblivion_indbrud:haralleredeledt')
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
		if indbrudlykkes == true then
			if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 351.24841308594,-999.03631591797,-99.196243286133, true) < 0.5 then
				DrawMarker(27,351.24841308594,-999.03631591797,-99.196243286133-0.9, 0, 0, 0, 0, 0, 0, 1.01, 1.01, 0.3, 67, 0, 0, 105, 0, 0, 2, 0, 0, 0, 0)
				if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 351.24841308594,-999.03631591797,-99.196243286133, true) < 0.5 then
					DrawText3Ds(351.24841308594,-999.03631591797,-99.196243286133+0.1, config.LedEfterTyvekoster, 3.0, 7)
					if (IsControlJustReleased(1, 38)) then
						if tyvekosterledt4 == false then
							tyvekosterledt4 = true
							exports['ac_progressbar']:startUI(5000, config.LederEfterTyvekoster)
							TaskStartScenarioInPlace(GetPlayerPed(-1), "PROP_HUMAN_PARKING_METER", 4, true)
							Citizen.Wait(5000)
							ClearPedTasksImmediately(GetPlayerPed(-1))
							Tyvekoster()
						else
							TriggerServerEvent('oblivion_indbrud:haralleredeledt')
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
		if indbrudlykkes == true then
			if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 347.48889160156,-994.07263183594,-99.196182250977, true) < 0.5 then
				DrawMarker(27,347.48889160156,-994.07263183594,-99.196182250977-0.9, 0, 0, 0, 0, 0, 0, 1.01, 1.01, 0.3, 67, 0, 0, 105, 0, 0, 2, 0, 0, 0, 0)
				if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 347.48889160156,-994.07263183594,-99.196182250977, true) < 0.5 then
					DrawText3Ds(347.48889160156,-994.07263183594,-99.196182250977+0.1, config.LedEfterTyvekoster, 3.0, 7)
					if (IsControlJustReleased(1, 38)) then
						if tyvekosterledt5 == false then
							tyvekosterledt5 = true
							exports['ac_progressbar']:startUI(5000, config.LederEfterTyvekoster)
							TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_PARKING_METER", 0, true)
							Citizen.Wait(5000)
							ClearPedTasksImmediately(GetPlayerPed(-1))
							Tyvekoster()
						else
							TriggerServerEvent('oblivion_indbrud:haralleredeledt')
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
		if lagerhus == true then
			if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 1166.3138427734,-3199.0354003906,-39.007976531982, true) < 0.5 then
				DrawMarker(27,1166.3138427734,-3199.0354003906,-39.007976531982-0.9, 0, 0, 0, 0, 0, 0, 1.01, 1.01, 0.3, 67, 0, 0, 105, 0, 0, 2, 0, 0, 0, 0)
				if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 1166.3138427734,-3199.0354003906,-39.007976531982, true) < 0.5 then
					DrawText3Ds(1166.3138427734,-3199.0354003906,-39.007976531982+0.1, config.LedEfterTyvekoster, 3.0, 7)
					if (IsControlJustReleased(1, 38)) then
						if tyvekosterledtlagerhus1 == false then
							tyvekosterledtlagerhus1 = true
							exports['ac_progressbar']:startUI(5000, config.LederEfterTyvekoster)
							TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_PARKING_METER", 0, true)
							Citizen.Wait(5000)
							ClearPedTasksImmediately(GetPlayerPed(-1))
							Tyvekoster()
						else
							TriggerServerEvent('oblivion_indbrud:haralleredeledt')
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
		if lagerhus == true then
			if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 1161.2874755859,-3197.6118164063,-39.007976531982, true) < 0.5 then
				DrawMarker(27,1161.2874755859,-3197.6118164063,-39.007976531982-0.9, 0, 0, 0, 0, 0, 0, 1.01, 1.01, 0.3, 67, 0, 0, 105, 0, 0, 2, 0, 0, 0, 0)
				if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 1161.2874755859,-3197.6118164063,-39.007976531982, true) < 0.5 then
					DrawText3Ds(1161.2874755859,-3197.6118164063,-39.007976531982+0.1, config.LedEfterTyvekoster, 3.0, 7)
					if (IsControlJustReleased(1, 38)) then
						if tyvekosterledtlagerhus2 == false then
							tyvekosterledtlagerhus2 = true
							exports['ac_progressbar']:startUI(5000, config.LederEfterTyvekoster)
							TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_PARKING_METER", 0, true)
							Citizen.Wait(5000)
							ClearPedTasksImmediately(GetPlayerPed(-1))
							Tyvekoster()
						else
							TriggerServerEvent('oblivion_indbrud:haralleredeledt')
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
		if lagerhus == true then
			if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 1156.7775878906,-3196.5852050781,-39.007976531982, true) < 0.5 then
				DrawMarker(27,1156.7775878906,-3196.5852050781,-39.007976531982-0.9, 0, 0, 0, 0, 0, 0, 1.01, 1.01, 0.3, 67, 0, 0, 105, 0, 0, 2, 0, 0, 0, 0)
				if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 1156.7775878906,-3196.5852050781,-39.007976531982, true) < 0.5 then
					DrawText3Ds(1156.7775878906,-3196.5852050781,-39.007976531982+0.1, config.LedEfterTyvekoster, 3.0, 7)
					if (IsControlJustReleased(1, 38)) then
						if tyvekosterledtlagerhus3 == false then
							tyvekosterledtlagerhus3 = true
							exports['ac_progressbar']:startUI(5000, config.LederEfterTyvekoster)
							TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_PARKING_METER", 0, true)
							Citizen.Wait(5000)
							ClearPedTasksImmediately(GetPlayerPed(-1))
							Tyvekoster()
						else
							TriggerServerEvent('oblivion_indbrud:haralleredeledt')
						end
					end
				end
			end
		end
	end
end)


local vehicles = {
    {Model= "mule", X= 500.86889648438, Y= -1499.4459228516, Z= 37.048791503906-12, A= 29.288957595825},
}

function Indbrudbil()
    for _, item in pairs(vehicles) do
        RequestModel(GetHashKey(item.Model));
        while not HasModelLoaded(GetHashKey(item.Model)) do
            RequestModel(GetHashKey(item.Model));
            Wait(1)
        end
        local vehicle = CreateVehicle(GetHashKey(item.Model), item.X, item.Y, item.Z, item.A, false, false)
		SetVehicleCustomPrimaryColour(vehicle, 74, 74, 74)
    end
end



function Tyvekoster()
    local tyvekoster = math.random(1,16)
	if tyvekoster == 1 then
		TriggerServerEvent('oblivion_indbrud:tyvekoster1')
	else if tyvekoster == 2 then
		TriggerServerEvent('oblivion_indbrud:tyvekoster2')
	else if tyvekoster == 3 then
		TriggerServerEvent('oblivion_indbrud:tyvekoster3')
	else if tyvekoster == 4 then
		TriggerServerEvent('oblivion_indbrud:tyvekoster4')
	else if tyvekoster == 5 then
		TriggerServerEvent('oblivion_indbrud:tyvekoster5')
	else if tyvekoster == 6 then
		TriggerServerEvent('oblivion_indbrud:tyvekoster6')
	else if tyvekoster == 7 then
		TriggerServerEvent('oblivion_indbrud:tyvekoster7')
	else if tyvekoster == 8 then
		TriggerServerEvent('oblivion_indbrud:tyvekoster8')
	else if tyvekoster == 9 then
		TriggerServerEvent('oblivion_indbrud:tyvekoster9')
	else if tyvekoster == 10 then
		TriggerServerEvent('oblivion_indbrud:tyvekoster10')
	else if tyvekoster == 11 then
		TriggerServerEvent('oblivion_indbrud:tyvekoster11')
	else if tyvekoster == 12 then
		TriggerServerEvent('oblivion_indbrud:tyvekoster12')
	else if tyvekoster == 13 then
		TriggerServerEvent('oblivion_indbrud:tyvekoster13')
	else if tyvekoster == 14 then
		TriggerServerEvent('oblivion_indbrud:tyvekoster14')
	else if tyvekoster == 15 then
		TriggerServerEvent('oblivion_indbrud:tyvekoster15')
	else if tyvekoster == 16 then
		TriggerServerEvent('oblivion_indbrud:tyvekoster16')
	end
end
end
end
end
end
end
end
end
end
end
end
end
end
end
end
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
