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

ligger = false
sengnr = 0
currentbed = 0

local seng = {
{x= 278.7735, y= -1338.738, z= 24.51952}, 
{x= 281.0681, y= -1336.042, z= 24.51952}, 
{x= 262.1974, y= -1339.96, z= 24.5544}, 
{x= 249.4937, y= -1355.328, z= 24.5544}, 
}

local iseng = {
{x= 279.38397216797, y= -1338.2058105469, z= 23.537803649902}, 
{x= 281.72473144531, y= -1335.5074462891, z= 23.537809371948}, 
{x= 263.8616027832, y= -1341.5063476563, z= 23.5378074646}, 
{x= 250.73637390137, y= -1357.2139892578, z= 23.5378074646}, 
}


function ply_drawTxt(text,font,centre,x,y,scale,r,g,b,a)
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
	DrawText(x,y)
end

function DrawText3Ds(x,y,z, text)
	local onScreen,_x,_y=World3dToScreen2d(x,y,z)

	if onScreen then
		SetTextScale(0.35, 0.35)
		SetTextFont(4)
		SetTextProportional(1)
		SetTextColour(255, 255, 255, 215)
		SetTextEntry("STRING")
		SetTextCentre(1)
		AddTextComponentString(text)
		DrawText(_x,_y)
		local factor = (string.len(text)) / 350
		DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 0, 0, 0, 100)
	end
end

local doctorped = ""
RegisterNetEvent("kaz_hospital:place")
AddEventHandler("kaz_hospital:place", function()
	RequestModel(GetHashKey("s_m_m_doctor_01"))
	while not HasModelLoaded(GetHashKey("s_m_m_doctor_01")) do
		Wait(1)
	end 
	doctorped =  CreatePed(4, 0xd47303ac, 308.275390625,-595.48864746094,43.283985137939-0.99,66.383, false, true)
	SetEntityHeading(doctorped, 66.383)
	FreezeEntityPosition(doctorped, true)
	SetEntityInvincible(doctorped, true)
	SetBlockingOfNonTemporaryEvents(doctorped, true)
end)

local doctorped2 = ""
RegisterNetEvent("kaz_hospital:place")
AddEventHandler("kaz_hospital:place", function()
	RequestModel(GetHashKey("s_m_m_doctor_01"))
	while not HasModelLoaded(GetHashKey("s_m_m_doctor_01")) do
		Wait(1)
	end 
	doctorped2 =  CreatePed(4, 0xd47303ac, 1826.5502929688,3686.392578125,34.271060943604-0.99,260.584, false, true)
	SetEntityHeading(doctorped2, 260.584)
	FreezeEntityPosition(doctorped2, true)
	SetEntityInvincible(doctorped2, true)
	SetBlockingOfNonTemporaryEvents(doctorped2, true)
end)

local doctorped3 = ""
RegisterNetEvent("kaz_hospital:place")
AddEventHandler("kaz_hospital:place", function()
	RequestModel(GetHashKey("s_m_m_doctor_01"))
	while not HasModelLoaded(GetHashKey("s_m_m_doctor_01")) do
		Wait(1)
	end 
	doctorped3 =  CreatePed(4, 0xd47303ac, -251.78254699707,6335.3793945313,32.427177429199-0.99,171.415, false, true)
	SetEntityHeading(doctorped3, 171.415)
	FreezeEntityPosition(doctorped3, true)
	SetEntityInvincible(doctorped3, true)
	SetBlockingOfNonTemporaryEvents(doctorped3, true)
end)

local usedbeds = {}

local beds = {
	1631638868,
	2117668672,
	-1091386327,
}
local checkedin = 0 

local inbed = false
local bednew = 0
local pause = 0
local ems1 = 0
local dead = false
local venter = false

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if pause ~= 0 then if pause > 0 then pause = pause-1 end end
		if checkedin == 0 then
			local coords = GetEntityCoords(PlayerPedId(),true)
			if (Vdist(coords["x"], coords["y"], coords["z"], 306.71255493164,-594.9736328125,43.283988952637) < 1.2) then
				if pause == 0 then
					DrawMarker(20, 306.71255493164,-594.9736328125,43.283988952637-0.2, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 0.5, 83, 255, 87, 200, 0, 0, 0, 100)
					DrawText3Ds(306.71255493164,-594.9736328125,43.283988952637+0.2,"[~g~E~w~] for tjekke ind")
					if IsControlJustReleased(1, Keys["E"]) then
						local health = GetEntityHealth(PlayerPedId())
						pause = 5000
						loadAnimDict("mp_common")
						TaskPlayAnim(PlayerPedId(), "mp_common", "givetake1_a", 8.0, 8.0, -1, 1, 0, false, false, false)
						TaskPlayAnim(doctorped, "mp_common", "givetake2_a", 8.0, 8.0, -1, 1, 0, false, false, false)
						Citizen.Wait(2500)
						TriggerEvent("pNotify:SendNotification",{text = "Tjekker ID", type = "success", timeout = (4000),  layout = "bottomCenter", queue = "global"})
						ClearPedTasks(PlayerPedId())
						TaskStartScenarioInPlace(doctorped, "WORLD_HUMAN_CLIPBOARD")
						Citizen.Wait(10000)
						ClearPedTasks(doctorped)
							if ems1 > 0 then
								TriggerEvent("pNotify:SendNotification",{text = "Ringer til Kollega!", type = "error", timeout = (4000),  layout = "bottomCenter", queue = "global"})
								Citizen.Wait(3000)
								TaskStartScenarioInPlace(doctorped, "WORLD_HUMAN_STAND_MOBILE")
								Citizen.Wait(7500)
								ClearPedTasks(doctorped)
								TriggerEvent("pNotify:SendNotification",{text = "Kollega på vej.", type = "error", timeout = (4000),  layout = "bottomCenter", queue = "global"})
								TriggerServerEvent('kaz_hospital:ringop')
							else
								if health > 105 then
									TriggerEvent("pNotify:SendNotification",{text = "Du kan nu lægge dig.", type = "error", timeout = (4000),  layout = "bottomCenter", queue = "global"})
									checkedin = 18000
								else
									TriggerEvent("pNotify:SendNotification",{text = "Gå til operationsstuen.", type = "error", timeout = (4000),  layout = "bottomCenter", queue = "global"})
									dead = true
									checkedin = 18000
								end
							end
					end
				end
			end
		else
			if inbed == false then
				if checkedin > 0 then
					checkedin = checkedin-1
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if pause ~= 0 then if pause > 0 then pause = pause-1 end end
		if checkedin == 0 then
			local coords = GetEntityCoords(PlayerPedId(),true)
			if (Vdist(coords["x"], coords["y"], coords["z"], 1828.3651123047,3685.9035644531,34.271015167236) < 1.2) then
				if pause == 0 then
					DrawMarker(20, 1828.3651123047,3685.9035644531,34.271015167236-0.2, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 0.5, 83, 255, 87, 200, 0, 0, 0, 100)
					DrawText3Ds(1828.3651123047,3685.9035644531,34.271015167236+0.2,"[~g~E~w~] for tjekke ind")
					if IsControlJustReleased(1, Keys["E"]) then
						local health = GetEntityHealth(PlayerPedId())
						pause = 5000
						loadAnimDict("mp_common")
						TaskPlayAnim(PlayerPedId(), "mp_common", "givetake1_a", 8.0, 8.0, -1, 1, 0, false, false, false)
						TaskPlayAnim(doctorped2, "mp_common", "givetake2_a", 8.0, 8.0, -1, 1, 0, false, false, false)
						Citizen.Wait(2500)
						TriggerEvent("pNotify:SendNotification",{text = "Tjekker ID", type = "success", timeout = (4000),  layout = "bottomCenter", queue = "global"})
						ClearPedTasks(PlayerPedId())
						TaskStartScenarioInPlace(doctorped2, "WORLD_HUMAN_CLIPBOARD")
						Citizen.Wait(10000)
						ClearPedTasks(doctorped2)
							if ems1 > 0 then
								TriggerEvent("pNotify:SendNotification",{text = "Ringer til Kollega!", type = "error", timeout = (4000),  layout = "bottomCenter", queue = "global"})
								Citizen.Wait(3000)
								TaskStartScenarioInPlace(doctorped2, "WORLD_HUMAN_STAND_MOBILE")
								Citizen.Wait(7500)
								ClearPedTasks(doctorped2)
								TriggerEvent("pNotify:SendNotification",{text = "Kollega på vej.", type = "error", timeout = (4000),  layout = "bottomCenter", queue = "global"})
								TriggerServerEvent('kaz_hospital:ringop')
							else
								if health > 105 then
									TriggerEvent("pNotify:SendNotification",{text = "Du kan nu lægge dig.", type = "error", timeout = (4000),  layout = "bottomCenter", queue = "global"})
									checkedin = 18000
								else
									TriggerEvent("pNotify:SendNotification",{text = "Gå til operationsstuen.", type = "error", timeout = (4000),  layout = "bottomCenter", queue = "global"})
									dead = true
									checkedin = 18000
								end
							end
					end
				end
			end
		else
			if inbed == false then
				if checkedin > 0 then
					checkedin = checkedin-1
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if pause ~= 0 then if pause > 0 then pause = pause-1 end end
		if checkedin == 0 then
			local coords = GetEntityCoords(PlayerPedId(),true)
			if (Vdist(coords["x"], coords["y"], coords["z"], -251.93446350098,6334.234375,32.427169799805) < 1.2) then
				if pause == 0 then
					DrawMarker(20, -251.93446350098,6334.234375,32.427169799805-0.2, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 0.5, 83, 255, 87, 200, 0, 0, 0, 100)
					DrawText3Ds(-251.93446350098,6334.234375,32.427169799805+0.2,"[~g~E~w~] for tjekke ind")
					if IsControlJustReleased(1, Keys["E"]) then
						local health = GetEntityHealth(PlayerPedId())
						pause = 5000
						loadAnimDict("mp_common")
						TaskPlayAnim(PlayerPedId(), "mp_common", "givetake1_a", 8.0, 8.0, -1, 1, 0, false, false, false)
						TaskPlayAnim(doctorped3, "mp_common", "givetake2_a", 8.0, 8.0, -1, 1, 0, false, false, false)
						Citizen.Wait(2500)
						TriggerEvent("pNotify:SendNotification",{text = "Tjekker ID", type = "success", timeout = (4000),  layout = "bottomCenter", queue = "global"})
						ClearPedTasks(PlayerPedId())
						TaskStartScenarioInPlace(doctorped3, "WORLD_HUMAN_CLIPBOARD")
						Citizen.Wait(10000)
						ClearPedTasks(doctorped3)
							if ems1 > 0 then
								TriggerEvent("pNotify:SendNotification",{text = "Ringer til Kollega!", type = "error", timeout = (4000),  layout = "bottomCenter", queue = "global"})
								Citizen.Wait(3000)
								TaskStartScenarioInPlace(doctorped3, "WORLD_HUMAN_STAND_MOBILE")
								Citizen.Wait(7500)
								ClearPedTasks(doctorped3)
								TriggerEvent("pNotify:SendNotification",{text = "Kollega på vej.", type = "error", timeout = (4000),  layout = "bottomCenter", queue = "global"})
								TriggerServerEvent('kaz_hospital:ringop')
							else
								if health > 105 then
									TriggerEvent("pNotify:SendNotification",{text = "Du kan nu lægge dig.", type = "error", timeout = (4000),  layout = "bottomCenter", queue = "global"})
									checkedin = 18000
								else
									TriggerEvent("pNotify:SendNotification",{text = "Gå til operationsstuen.", type = "error", timeout = (4000),  layout = "bottomCenter", queue = "global"})
									dead = true
									checkedin = 18000
								end
							end
					end
				end
			end
		else
			if inbed == false then
				if checkedin > 0 then
					checkedin = checkedin-1
				end
			end
		end
	end
end)


local laybed = 0
Citizen.CreateThread(function()
	while true do
	Citizen.Wait(1000) 
		local coords = GetEntityCoords(PlayerPedId(),true)
		for k,v in pairs(beds) do
			local bed = GetClosestObjectOfType(coords["x"], coords["y"], coords["z"], 2.0, v, false, false, false)
			if bed ~= 0 then
			bednew = bed
			currentbed = v
			end
		end
	end
end)


Citizen.CreateThread(function()
	while true do 
	Citizen.Wait(1)
		if bednew ~= 0 then 
		local bcoords = GetEntityCoords(bednew, true)
		local Kcoords = GetEntityCoords(PlayerPedId(),true)
			if (Vdist(bcoords["x"],bcoords["y"],bcoords["z"]+0.75, Kcoords["x"], Kcoords["y"], Kcoords["z"]) < 2) then
				if inbed == false then
					if usedbeds[math.floor(bcoords["x"])] == nil then
						DrawText3Ds(bcoords["x"],bcoords["y"],bcoords["z"]+0.50,"[~g~E~w~] for at lægge dig på ryggen")
						if IsControlJustReleased(1, Keys["E"]) then
							Citizen.Wait(0)
							ClearPedTasksImmediately(PlayerPedId())
							FreezeEntityPosition(PlayerPedId(),true)
							if currentbed == -1091386327 then 
								TaskStartScenarioAtPosition(PlayerPedId(), "WORLD_HUMAN_SUNBATHE_BACK", bcoords["x"],bcoords["y"],bcoords["z"]+1.2, GetEntityHeading(bednew), 0, true,true)
							else
								TaskStartScenarioAtPosition(PlayerPedId(), "WORLD_HUMAN_SUNBATHE_BACK", bcoords["x"],bcoords["y"],bcoords["z"]+1.40, GetEntityHeading(bednew), 0, true,true)
							end
							TriggerServerEvent("kaz_hospital:sendstatus",math.floor(bcoords["x"]),true)
							inbed = true
							laybed = bednew
						end
					end
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do 
	Citizen.Wait(1)
		if bednew ~= 0 then 
		local bcoords = GetEntityCoords(bednew, true)
		local Kcoords = GetEntityCoords(PlayerPedId(),true)
			if (Vdist(bcoords["x"],bcoords["y"],bcoords["z"]+0.75, Kcoords["x"], Kcoords["y"], Kcoords["z"]) < 2) then
				if inbed == false then
					if usedbeds[math.floor(bcoords["x"])] == nil then
						DrawText3Ds(bcoords["x"],bcoords["y"],bcoords["z"]+0.40,"[~g~F~w~] for at lægge dig på maven")
						if IsControlJustReleased(1, Keys["F"]) then
							Citizen.Wait(0)
							ClearPedTasksImmediately(PlayerPedId())
							FreezeEntityPosition(PlayerPedId(),true)
							if currentbed == -1091386327 then 
								TaskStartScenarioAtPosition(PlayerPedId(), "WORLD_HUMAN_SUNBATHE", bcoords["x"],bcoords["y"],bcoords["z"]+1.2, GetEntityHeading(bednew), 0, true,true)
							else
								TaskStartScenarioAtPosition(PlayerPedId(), "WORLD_HUMAN_SUNBATHE", bcoords["x"],bcoords["y"],bcoords["z"]+1.40, GetEntityHeading(bednew), 0, true,true)
							end
							TriggerServerEvent("kaz_hospital:sendstatus",math.floor(bcoords["x"]),true)
							inbed = true
							laybed = bednew
						end
					end
				end
			end
		end
	end
end)


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(4500)
		if inbed and checkedin > 0 then
			local health = GetEntityHealth(PlayerPedId())
			  if health > 0 then 
				if health <= 199 then
					SetEntityHealth(PlayerPedId(),health+5)
				end
			else
				if (Vdist(GetEntityCoords(GetPlayerPed(-1)), 326.9192199707,-569.87915039063,44.198055267334) < 1) then 
				TriggerServerEvent('kaz_hospital:pedspawn')
				Citizen.Wait(50000)
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if inbed then
				if checkedin == 0 then 
					ply_drawTxt("[~r~E~w~]~r~ Du healer ikke, snak med lægen.",4,1,0.5,0.95,0.6,255,255,255,255)
				else
					if dead == true then 
						if (Vdist(GetEntityCoords(GetPlayerPed(-1)), 326.9192199707,-569.87915039063,44.198055267334) < 1) then 
							ply_drawTxt("~r~Vent på lægen.",4,1,0.5,0.95,0.6,255,255,255,255)
							venter = true
						else 
							ply_drawTxt("[~r~E~w~]~r~ Du er i koma, gå til operationsstuen.",4,1,0.5,0.95,0.6,255,255,255,255)
						end
					else
						ply_drawTxt("[~r~E~w~]~r~ for at gå ud af sengen",4,1,0.5,0.95,0.6,255,255,255,255)
					end
				end
				if IsControlJustReleased(1, Keys["E"]) then
					if venter == false then 
						local bcoords = GetEntityCoords(laybed)
						SetEntityCoordsNoOffset(PlayerPedId(),bcoords["x"]-1.2,bcoords["y"],bcoords["z"],0,0,1)
						FreezeEntityPosition(PlayerPedId(),false)
						SetEntityHeading(PlayerPedId(),GetEntityHeading(laybed)-180)
						TriggerServerEvent("kaz_hospital:sendstatus",math.floor(bcoords["x"]),false)
						inbed = false
						laybed = 0
					end
				end
		end
	end
end)

function loadAnimDict( dict )
	while ( not HasAnimDictLoaded( dict ) ) do
		RequestAnimDict( dict )
		Citizen.Wait( 5 )
	end
end

RegisterNetEvent('kaz_hospital:load')
AddEventHandler('kaz_hospital:load', function(list)
	usedbeds = list
end)

RegisterNetEvent('kaz_hospital:status')
AddEventHandler('kaz_hospital:status', function(key,bed)
	usedbeds[key] = bed
end)

RegisterNetEvent('kaz:sendems')
AddEventHandler('kaz:sendems', function(ems)
ems1 = ems
end)
						

RegisterNetEvent('kaz_hospital:pedspawnreturnall')
AddEventHandler('kaz_hospital:pedspawnreturnall', function()
	if (Vdist(GetEntityCoords(GetPlayerPed(-1)), 331.81954956055,-579.8505859375,43.317253112793) < 50) then 
		RequestModel(GetHashKey("s_m_m_doctor_01"))
		while not HasModelLoaded(GetHashKey("s_m_m_doctor_01")) do
			Wait(1)
		end 
		driver2 =  CreatePed(4, 0xd47303ac, 334.31652832031,-569.2314453125,43.317497253418-1,156.3279876709, false, true)
		SetEntityInvincible(driver2, true)
		SetBlockingOfNonTemporaryEvents(driver2, true)
			Citizen.Wait(2000)
			TaskGoStraightToCoord(driver2, 333.37210083008,-572.18005371094,43.317401885986, 1.0, 2000, 0, 0)
			Citizen.Wait(2000)
			TaskGoStraightToCoord(driver2, 327.20846557617,-569.01416015625,43.317398071289, 1.0, 4500, 0, 0)
			Citizen.Wait(4500)
			SetEntityCoords(driver2,  327.20846557617,-569.01416015625,43.317398071289-1)
			SetEntityHeading(driver2, 163.28500366211)
			FreezeEntityPosition(driver2, true)
	end
end)

RegisterNetEvent('kaz_hospital:pedspawnreturn')
AddEventHandler('kaz_hospital:pedspawnreturn', function()
Citizen.Wait(10000)
player = GetEntityCoords(GetPlayerPed(-1))
TriggerServerEvent('kaz_hospital:videre')
Citizen.Wait(32000)
SetEntityHealth(PlayerPedId(),150)
venter = false
dead = false
end)

RegisterNetEvent('kaz_hospital:pedtilbagereturn')
AddEventHandler('kaz_hospital:pedtilbagereturn', function()	
	if (Vdist(GetEntityCoords(GetPlayerPed(-1)), GetEntityCoords(driver2).x, GetEntityCoords(driver2).y, GetEntityCoords(driver2).z) < 50) then 
		RequestAnimDict("mini@cpr@char_a@cpr_str")
			while not HasAnimDictLoaded("mini@cpr@char_a@cpr_str") do
				Citizen.Wait(1000)
			end
				TaskStartScenarioInPlace(driver2, "PROP_HUMAN_PARKING_METER")
				Citizen.Wait(30000)
				ClearPedTasksImmediately(driver2)
			FreezeEntityPosition(driver2, false)
			TaskGoStraightToCoord(driver2, 333.37210083008,-572.18005371094,43.317401885986, 1.0, 5000, 0, 0)
			Citizen.Wait(5000)
			TaskGoStraightToCoord(driver2, 334.31652832031,-569.2314453125,43.317497253418, 1.0, 5000, 0, 0)
			Citizen.Wait(5000)
			DeleteEntity(driver2)
	end
end)
		
		
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)	
		if ligger == false then 
			for i = 1,4 do 
				if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), seng[i].x, seng[i].y, seng[i].z, true ) < 2 then
				DrawText3Ds(seng[i].x,seng[i].y,seng[i].z+0.5, "~w~Tryk [~g~E~w~] for at ~g~lægge~w~ dig.", 3.0, 7)
					if IsControlJustPressed(1, 38) then
						FreezeEntityPosition(GetPlayerPed(-1),true)
						TaskStartScenarioAtPosition(PlayerPedId(), "WORLD_HUMAN_SUNBATHE_BACK", seng[i].x,seng[i].y,seng[i].z+1,70.87, 0, true,true)
						ligger = true
						sengnr = i
					end	
				end
			end
		elseif ligger == true then 
			for i = 1,4 do
				if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), iseng[i].x, iseng[i].y, iseng[i].z, true ) < 20 then			
					if sengnr == i then 
					ply_drawTxt("~w~Tryk [~r~Z~w~] for at ~r~rejse~w~ dig.",4,1,0.5,0.95,0.6,255,255,255,255)
						if IsControlJustPressed(1, 48) then
							FreezeEntityPosition(GetPlayerPed(-1),false)
							SetEntityCoords(GetPlayerPed(-1), iseng[i].x,iseng[i].y,iseng[i].z)
							ClearPedTasksImmediately(GetPlayerPed(-1))
							sengnr = 0
							ligger = false
						end	
					end			
				end
			end
		end
	end
end)

RegisterNetEvent('kaz:sendseng')
AddEventHandler('kaz:sendseng', function()
checkedin = 18000 
end)


