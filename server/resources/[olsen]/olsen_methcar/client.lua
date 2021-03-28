vRP = Proxy.getInterface("vRP") 
vRPclient = Tunnel.getInterface("vRP", "olsen_methcar")

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
local started = false
local displayed = false
local progress = 0
local CurrentVehicle 
local pause = false
local selection = 0
local quality = 0

local LastCar

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

RegisterNetEvent('olsen_methcar:stop')
AddEventHandler('olsen_methcar:stop', function()
	started = false
	exports['mythic_notify']:SendAlert('inform', 'Produktionen Stoppede...')
	FreezeEntityPosition(LastCar, false)
end)
RegisterNetEvent('olsen_methcar:stopfreeze')
AddEventHandler('olsen_methcar:stopfreeze', function(id)
	FreezeEntityPosition(id, false)
end)
RegisterNetEvent('olsen_methcar:notify')
AddEventHandler('olsen_methcar:notify', function(message)
	exports['mythic_notify']:SendAlert('inform', message)
end)

RegisterNetEvent('olsen_methcar:startprod')
AddEventHandler('olsen_methcar:startprod', function()
	exports['mythic_notify']:SendAlert('inform', 'Starter Produktionen...')
	started = true
	FreezeEntityPosition(CurrentVehicle,true)
	displayed = false
	print('Started Meth production')
	exports['mythic_notify']:SendAlert('inform', 'Meth Produktionen startede')
	SetPedIntoVehicle(GetPlayerPed(-1), CurrentVehicle, 3)
	SetVehicleDoorOpen(CurrentVehicle, 2)
end)

RegisterNetEvent('olsen_methcar:blowup')
AddEventHandler('olsen_methcar:blowup', function(posx, posy, posz)
	AddExplosion(posx, posy, posz + 2,23, 20.0, true, false, 1.0, true)
	if not HasNamedPtfxAssetLoaded("core") then
		RequestNamedPtfxAsset("core")
		while not HasNamedPtfxAssetLoaded("core") do
			Citizen.Wait(1)
		end
	end
	SetPtfxAssetNextCall("core")
	local fire = StartParticleFxLoopedAtCoord("ent_ray_heli_aprtmnt_l_fire", posx, posy, posz-0.8 , 0.0, 0.0, 0.0, 0.8, false, false, false, false)
	Citizen.Wait(6000)
	StopParticleFxLooped(fire, 0)
	
end)


RegisterNetEvent('olsen_methcar:smoke')
AddEventHandler('olsen_methcar:smoke', function(posx, posy, posz, bool)

	if bool == 'a' then

		if not HasNamedPtfxAssetLoaded("core") then
			RequestNamedPtfxAsset("core")
			while not HasNamedPtfxAssetLoaded("core") do
				Citizen.Wait(1)
			end
		end
		SetPtfxAssetNextCall("core")
		local smoke = StartParticleFxLoopedAtCoord("exp_grd_flare", posx, posy, posz + 1.7, 0.0, 0.0, 0.0, 2.0, false, false, false, false)
		SetParticleFxLoopedAlpha(smoke, 0.8)
		SetParticleFxLoopedColour(smoke, 0.0, 0.0, 0.0, 0)
		Citizen.Wait(22000)
		StopParticleFxLooped(smoke, 0)
	else
		StopParticleFxLooped(smoke, 0)
	end

end)
RegisterNetEvent('olsen_methcar:drugged')
AddEventHandler('olsen_methcar:drugged', function()
	SetTimecycleModifier("drug_drive_blend01")
	SetPedMotionBlur(GetPlayerPed(-1), true)
	SetPedMovementClipset(GetPlayerPed(-1), "MOVE_M@DRUNK@SLIGHTLYDRUNK", true)
	SetPedIsDrunk(GetPlayerPed(-1), true)

	Citizen.Wait(300000)
	ClearTimecycleModifier()
end)



Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		
		playerPed = GetPlayerPed(-1)
		local pos = GetEntityCoords(GetPlayerPed(-1))
		if IsPedInAnyVehicle(playerPed) then
			
			
			CurrentVehicle = GetVehiclePedIsUsing(PlayerPedId())

			car = GetVehiclePedIsIn(playerPed, false)
			LastCar = GetVehiclePedIsUsing(playerPed)
	
			local model = GetEntityModel(CurrentVehicle)
			local modelName = GetDisplayNameFromVehicleModel(model)
			
			if modelName == 'JOURNEY' and car then
				
					if GetPedInVehicleSeat(car, -1) == playerPed then
						if started == false then
							if displayed == false then
								DisplayHelpText("Tryk ~INPUT_THROW_GRENADE~ for at starte meth produktionen")
								displayed = true
							end
						end
						if IsControlJustReleased(0, Keys['G']) then
							if pos.y >= 3500 then
								if IsVehicleSeatFree(CurrentVehicle, 3) then
									TriggerServerEvent('olsen_methcar:start')	
									progress = 0
									pause = false
									selection = 0
									quality = 0
									
								else
									DisplayHelpText('Køretøjet er allerede optaget')
								end
							else
								exports['mythic_notify']:SendAlert('error', 'Du er for tæt for byen, kør længere nordpå for at starte methproduktion')
							end
							
							
							
							
		
						end
					end
					
				
				
			
			end
			
		else

				
				if started then
					started = false
					displayed = false
					TriggerEvent('olsen_methcar:stop')
					print('Stopped making drugs')
					FreezeEntityPosition(LastCar,false)
				end
		end
		
		if started == true then
			
			if progress < 96 then
				Citizen.Wait(6000)
				if not pause and IsPedInAnyVehicle(playerPed) then
					progress = progress +  1
					exports['mythic_notify']:SendAlert('inform', 'Meth Produktion: ' .. progress .. '%')
					Citizen.Wait(6000) 
				end

				--
				--   EVENT 1
				--
				if progress > 22 and progress < 24 then
					pause = true
					if selection == 0 then
						TriggerEvent("pNotify:SendNotification",{text = "Propanrøret lækker, hvad skal du gøre? <br> 1. Fix ved brug af tape <br> 2. Lad det være <br> 3. Erstat <br> Tryk på nummeret med den valgmulighed, du gerne vil bruge",type = "error",timeout = (5000),layout = "centerRight",queue = "global",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
						--exports['mythic_notify']:SendAlert('inform', 'Propanrøret lækker, hvad skal du gøre?')
                       -- exports['mythic_notify']:SendAlert('inform', '1. Fix ved brug af tape ')
                      --  exports['mythic_notify']:SendAlert('inform', '2. Lad det være ')
                      --  exports['mythic_notify']:SendAlert('inform', '3. Erstat det')
                      --  exports['mythic_notify']:SendAlert('inform', 'Tryk på nummeret med den valgmulighed, du gerne vil bruge')
                    end
                    if selection == 1 then
                        print("Valgte 1")
                        exports['mythic_notify']:SendAlert('inform', 'Tapen stoppede lækken en smule')
                        quality = quality - 3
                        pause = false
                    end
                    if selection == 2 then
                        print("Valgte 2")
                        exports['mythic_notify']:SendAlert('inform', 'Propantanken sprang i luften, du fejlede...')
                        TriggerServerEvent('olsen_methcar:blow', pos.x, pos.y, pos.z)
                        SetVehicleEngineHealth(CurrentVehicle, 0.0)
                        quality = 0
                        started = false
                        displayed = false
                        ApplyDamageToPed(GetPlayerPed(-1), 10, false)
                        print('Stoppede med at lave stoffer')
                    end
                    if selection == 3 then
                        print("Valgte 3")
                        exports['mythic_notify']:SendAlert('inform', 'Godt arbejde, røret var ikke i god stand')
						pause = false
						quality = quality + 5
					end
				end
				--
				--   EVENT 5
				--
				if progress > 30 and progress < 32 then
					pause = true
					if selection == 0 then
						TriggerEvent("pNotify:SendNotification",{text = "Du spildte en flaske acetone på gulvet, hvad skal du gøre? <br> 1. Åben vinduerne for at fjerne lugten <br> 2. Lad det være <br> 3. Tag en gasmaske på <br> Tryk på nummeret med den valgmulighed, du gerne vil bruge",type = "error",timeout = (5000),layout = "centerRight",queue = "global",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
						--exports['mythic_notify']:SendAlert('inform', 'Du spildte en flaske acetone på gulvet, hvad skal du gøre?')
                        --exports['mythic_notify']:SendAlert('inform', '1. Åben vinduerne for at fjerne lugten')
                        --exports['mythic_notify']:SendAlert('inform', '2. Lad det være')
                        --exports['mythic_notify']:SendAlert('inform', '3. Tag en maske på med luftfilter')
                       -- exports['mythic_notify']:SendAlert('inform', 'Tryk på nummeret med den valgmulighed, du gerne vil bruge')
                    end
                    if selection == 1 then
                        print("Valgte 1")
                        exports['mythic_notify']:SendAlert('inform', 'Du åbnede vinduerne for at fjerne lugten')
                        quality = quality - 1
                        pause = false
                    end
                    if selection == 2 then
                        print("Valgte 2")
                        exports['mythic_notify']:SendAlert('inform', 'Du blev skæv af at inhalere for meget acetone')
                        pause = false
                        TriggerEvent('olsen_methcar:drugged')
                    end
                    if selection == 3 then
                        print("Valgte 3")
                        exports['mythic_notify']:SendAlert('inform', 'Det er en nem måde at fixe problemet på.. tror jeg')
						SetPedPropIndex(playerPed, 1, 26, 7, true)
						pause = false
					end
				end
				--
				--   EVENT 2
				--
				if progress > 38 and progress < 40 then
					pause = true
					if selection == 0 then
						TriggerEvent("pNotify:SendNotification",{text = "Meth produktet bliver for hurtigt fast, hvad skal du gøre? <br> 1. Hæv trykket <br> 2. Hæv temperaturen <br> 3. Sænk trykket <br> Tryk på nummeret med den valgmulighed, du gerne vil bruge",type = "error",timeout = (5000),layout = "centerRight",queue = "global",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
						--exports['mythic_notify']:SendAlert('inform', 'Meth produktet bliver for hurtigt fast, hvad skal du gøre? ')
                        --exports['mythic_notify']:SendAlert('inform', '1. Hæv trykket')
                       -- exports['mythic_notify']:SendAlert('inform', '2. Hæv temperaturen')
                       -- exports['mythic_notify']:SendAlert('inform', '3. Sænk trykket')
                       -- exports['mythic_notify']:SendAlert('inform', 'Tryk på nummeret med den valgmulighed, du gerne vil bruge')
                    end
                    if selection == 1 then
                        print("Valgte 1")
                        exports['mythic_notify']:SendAlert('inform', 'Du hævede trykket og propanen begyndte at slippe ud, du sænkede det, og det holder for nu')
                        pause = false
                    end
                    if selection == 2 then
                        print("Valgte 2")
                        exports['mythic_notify']:SendAlert('inform', 'Det hjalp at hæve temperaturen...')
                        quality = quality + 5
                        pause = false
                    end
                    if selection == 3 then
                        print("Valgte 3")
                        exports['mythic_notify']:SendAlert('inform', 'At sænke trykket gjorde det bare værre...')
						pause = false
						quality = quality -4
					end
				end
				--
				--   EVENT 8 - 3
				--
				if progress > 41 and progress < 43 then
					pause = true
					if selection == 0 then
						TriggerEvent("pNotify:SendNotification",{text = "Du hælder ved et uheld for meget acetone, hvad gør du? <br> 1. Ingen ting <br> 2. Forsøg at suge det ud ved hjælp af sprøjte <br> 3. Tilføj mere lithium for at afbalancere det <br> Tryk på nummeret med den valgmulighed, du gerne vil bruge",type = "error",timeout = (5000),layout = "centerRight",queue = "global",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
						--exports['mythic_notify']:SendAlert('inform', 'You accidentally pour too much acetone, what do you do?')	
						--exports['mythic_notify']:SendAlert('inform', '1. Do nothing')
						--exports['mythic_notify']:SendAlert('inform', '2. Try to sucking it out using syringe')
						--exports['mythic_notify']:SendAlert('inform', '3. Add more lithium to balance it out')
						--exports['mythic_notify']:SendAlert('inform', 'Press the number of the option you want to do')
					end
					if selection == 1 then
						print("Slected 1")
						exports['mythic_notify']:SendAlert('inform', 'Methen lugter ikke meget som acetone')
						quality = quality - 3
						pause = false
					end
					if selection == 2 then
						print("Slected 2")
						exports['mythic_notify']:SendAlert('inform', 'Det fungerede lidt, men der er stadig for meget')
						pause = false
						quality = quality - 1
					end
					if selection == 3 then
						print("Slected 3")
						exports['mythic_notify']:SendAlert('inform', 'Du afbalancerede begge kemikalier, og det er godt igen')
						pause = false
						quality = quality + 3
					end
				end
				--
				--   EVENT 3
				--
				if progress > 46 and progress < 49 then
					pause = true
					if selection == 0 then
						TriggerEvent("pNotify:SendNotification",{text = "Du fandt nogle vandfarver, hvad gør du? <br> 1. Tilføj det <br> 2. Læg dem væk <br> 3. Drik det <br> Tryk på nummeret med den valgmulighed, du gerne vil bruge",type = "error",timeout = (5000),layout = "centerRight",queue = "global",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
						--exports['mythic_notify']:SendAlert('inform', 'You found some water coloring, what do you do?')	
						--exports['mythic_notify']:SendAlert('inform', '1. Add it in')
						--exports['mythic_notify']:SendAlert('inform', '2. Put it away')
						--exports['mythic_notify']:SendAlert('inform', '3. Drink it')
						--exports['mythic_notify']:SendAlert('inform', 'Press the number of the option you want to do')
					end
					if selection == 1 then
						print("Slected 1")
						exports['mythic_notify']:SendAlert('inform', 'God idé, folk kan lide farver')
						quality = quality + 4
						pause = false
					end
					if selection == 2 then
						print("Slected 2")
						exports['mythic_notify']:SendAlert('inform', 'Ja, det ødelægger måske smagen af ​​meth')
						pause = false
					end
					if selection == 3 then
						print("Slected 3")
						exports['mythic_notify']:SendAlert('inform', 'Du har det lidt underlig og føler dig svimmel, men det er alt sammen godt')
						pause = false
					end
				end
				--
				--   EVENT 4
				--
				if progress > 55 and progress < 58 then
					pause = true
					if selection == 0 then
						TriggerEvent("pNotify:SendNotification",{text = "Filteret er tilstoppet, hvad gør du? <br> 1. Rengør det med trykluft <br> 2. Udskift filteret <br> 3. Rengør det med en tandbørste <br> Tryk på nummeret med den valgmulighed, du gerne vil bruge",type = "error",timeout = (5000),layout = "centerRight",queue = "global",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
						--exports['mythic_notify']:SendAlert('inform', 'The filter is clogged, what do you do?')	
						--exports['mythic_notify']:SendAlert('inform', '1. Clean it using compressed air')
						--exports['mythic_notify']:SendAlert('inform', '2. Replace the filter')
						--exports['mythic_notify']:SendAlert('inform', '3. Clean it using a tooth brush')
						--exports['mythic_notify']:SendAlert('inform', 'Press the number of the option you want to do')
					end
					if selection == 1 then
						print("Slected 1")
						exports['mythic_notify']:SendAlert('inform', 'Trykluften sprøjtede den flydende meth ud over dig')
						quality = quality - 2
						pause = false
					end
					if selection == 2 then
						print("Slected 2")
						exports['mythic_notify']:SendAlert('inform', 'Udskiftning af det var sandsynligvis den bedste løsning')
						pause = false
						quality = quality + 3
					end
					if selection == 3 then
						print("Slected 3")
						exports['mythic_notify']:SendAlert('inform', 'Dette fungerede ganske godt, men det er stadig lidt snavset')
						pause = false
						quality = quality - 1
					end
				end
				--
				--   EVENT 5
				--
				if progress > 58 and progress < 60 then
					pause = true
					if selection == 0 then
						TriggerEvent("pNotify:SendNotification",{text = "Du spildte en flaske acetone på jorden, hvad gør du? <br> 1. Åbn vinduerne for at slippe af med lugten <br> 2. Lad det være <br> 3. Tag en maske på <br> Tryk på nummeret med den valgmulighed, du gerne vil bruge",type = "error",timeout = (5000),layout = "centerRight",queue = "global",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
						--exports['mythic_notify']:SendAlert('inform', 'You spilled a bottle of acetone on the ground, what do you do?')	
						--exports['mythic_notify']:SendAlert('inform', '1. Open the windows to get rid of the smell')
						--exports['mythic_notify']:SendAlert('inform', '2. Leave it be')
						--exports['mythic_notify']:SendAlert('inform', '3. Put on a mask with airfilter')
						--exports['mythic_notify']:SendAlert('inform', 'Press the number of the option you want to do')
					end
					if selection == 1 then
						print("Slected 1")
						exports['mythic_notify']:SendAlert('inform', 'Du åbnede vinduerne for at slippe af med lugten')
						quality = quality - 1
						pause = false
					end
					if selection == 2 then
						print("Slected 2")
						exports['mythic_notify']:SendAlert('inform', 'Du blev høj ved at indånde for meget acetone')
						pause = false
						TriggerEvent('olsen_methcar:drugged')
					end
					if selection == 3 then
						print("Slected 3")
						exports['mythic_notify']:SendAlert('inform', 'Det er en nem måde at løse problemet på, håber jeg')
						SetPedPropIndex(playerPed, 1, 26, 7, true)
						pause = false
					end
				end
				--
				--   EVENT 1 - 6
				--
				if progress > 63 and progress < 65 then
					pause = true
					if selection == 0 then
						TriggerEvent("pNotify:SendNotification",{text = "Propanrøret lækker, hvad gør du? <br> 1. Fix ved hjælp af tape <br> 2. Lad det være <br> 3. Erstat det <br> Tryk på nummeret med den valgmulighed, du gerne vil bruge",type = "error",timeout = (5000),layout = "centerRight",queue = "global",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
						--exports['mythic_notify']:SendAlert('inform', 'The propane pipe is leaking, what do you do?')	
						--exports['mythic_notify']:SendAlert('inform', '1. Fix using tape')
						--exports['mythic_notify']:SendAlert('inform', '2. Leave it be ')
						--exports['mythic_notify']:SendAlert('inform', '3. Replace it')
						--exports['mythic_notify']:SendAlert('inform', 'Press the number of the option you want to do')
					end
					if selection == 1 then
						print("Slected 1")
						exports['mythic_notify']:SendAlert('inform', 'Tapen stoppede lidt lækagen')
						quality = quality - 3
						pause = false
					end
					if selection == 2 then
						print("Slected 2")
						exports['mythic_notify']:SendAlert('inform', 'Propan-tanken sprængte, du ødelagde produktionen...')
						TriggerServerEvent('olsen_methcar:blow', pos.x, pos.y, pos.z)
						SetVehicleEngineHealth(CurrentVehicle, 0.0)
						quality = 0
						started = false
						displayed = false
						ApplyDamageToPed(GetPlayerPed(-1), 10, false)
						print('Stopped making drugs')
					end
					if selection == 3 then
						print("Slected 3")
						exports['mythic_notify']:SendAlert('inform', 'Godt arbejde, røret var ikke i god stand')
						pause = false
						quality = quality + 5
					end
				end
				--
				--   EVENT 4 - 7
				--
				if progress > 71 and progress < 73 then
					pause = true
					if selection == 0 then
						TriggerEvent("pNotify:SendNotification",{text = "Filteret er tilstoppet, hvad gør du? <br> 1. Rengør det med trykluft <br> 2. Udskift filteret <br> 3. Rengør det med en tandbørste <br> Tryk på nummeret med den valgmulighed, du gerne vil bruge",type = "error",timeout = (5000),layout = "centerRight",queue = "global",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
						--exports['mythic_notify']:SendAlert('inform', 'The filter is clogged, what do you do?')	
						--exports['mythic_notify']:SendAlert('inform', '1. Clean it using compressed air')
						--exports['mythic_notify']:SendAlert('inform', '2. Replace the filter')
						--exports['mythic_notify']:SendAlert('inform', '3. Clean it using a tooth brush')
						--exports['mythic_notify']:SendAlert('inform', 'Press the number of the option you want to do')
					end
					if selection == 1 then
						print("Slected 1")
						exports['mythic_notify']:SendAlert('inform', 'Trykluften sprøjtede den flydende meth ud over dig')
						quality = quality - 2
						pause = false
					end
					if selection == 2 then
						print("Slected 2")
						exports['mythic_notify']:SendAlert('inform', 'Udskiftning af det var sandsynligvis den bedste løsning')
						pause = false
						quality = quality + 3
					end
					if selection == 3 then
						print("Slected 3")
						exports['mythic_notify']:SendAlert('inform', 'Dette fungerede ganske godt, men det er stadig lidt snavset')
						pause = false
						quality = quality - 1
					end
				end
				--
				--   EVENT 8
				--
				if progress > 76 and progress < 78 then
					pause = true
					if selection == 0 then
						TriggerEvent("pNotify:SendNotification",{text = "Du hælder ved et uheld for meget acetone, hvad gør du? <br> 1. Ingen ting <br> 2. Forsøg at suge det ud ved hjælp af sprøjte <br> 3. Tilføj mere lithium for at afbalancere det <br> Tryk på nummeret med den valgmulighed, du gerne vil bruge",type = "error",timeout = (5000),layout = "centerRight",queue = "global",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
						--exports['mythic_notify']:SendAlert('inform', 'You accidentally pour too much acetone, what do you do?')	
						--exports['mythic_notify']:SendAlert('inform', '1. Do nothing')
						--exports['mythic_notify']:SendAlert('inform', '2. Try to sucking it out using syringe')
						--exports['mythic_notify']:SendAlert('inform', '3. Add more lithium to balance it out')
						--exports['mythic_notify']:SendAlert('inform', 'Press the number of the option you want to do')
					end
					if selection == 1 then
						print("Slected 1")
						exports['mythic_notify']:SendAlert('inform', 'Methen lugter ikke meget som acetone')
						quality = quality - 3
						pause = false
					end
					if selection == 2 then
						print("Slected 2")
						exports['mythic_notify']:SendAlert('inform', 'Det fungerede lidt, men der er stadig for meget')
						pause = false
						quality = quality - 1
					end
					if selection == 3 then
						print("Slected 3")
						exports['mythic_notify']:SendAlert('inform', 'Du afbalancerede begge kemikalier, og det er godt igen')
						pause = false
						quality = quality + 3
					end
				end
				--
				--   EVENT 9
				--
				if progress > 82 and progress < 84 then
					pause = true
					if selection == 0 then
						TriggerEvent("pNotify:SendNotification",{text = "Du skal lægge en kæmpe dej, hvad gør du? <br> 1. Prøv at holde lorten inde <br> 2. Gå udenfor og skid <br> 3. Skid indenfor <br> Tryk på nummeret med den valgmulighed, du gerne vil bruge",type = "error",timeout = (5000),layout = "centerRight",queue = "global",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
						--exports['mythic_notify']:SendAlert('inform', 'Du skal lægge en kæmpe dej, hvad gør du?')
                        --exports['mythic_notify']:SendAlert('inform', '1. Prøv at holde lortet inde')
                        --exports['mythic_notify']:SendAlert('inform', '2. Gå udenfor og skid')
                        --exports['mythic_notify']:SendAlert('inform', '3. Skid indenfor')
                        --exports['mythic_notify']:SendAlert('inform', 'Press the number of the option you want to do')
                    end
                    if selection == 1 then
                        print("Slected 1")
                        exports['mythic_notify']:SendAlert('inform', 'Godt gjort, arbejde først, skidning senere')
                        quality = quality + 1
                        pause = false
                    end
                    if selection == 2 then
                        print("Slected 2")
                        exports['mythic_notify']:SendAlert('inform', 'Imens du var udenfor, faldt glasset af bordet, og spildte udover hele gulvet ...')
                        pause = false
                        quality = quality - 2
                    end
                    if selection == 3 then
                        print("Slected 3")
                        exports['mythic_notify']:SendAlert('inform', 'Luften lugter af lort nu, meth-produktet lugter af lort nu')
						pause = false
						quality = quality - 1
					end
				end
				--
				--   EVENT 10
				--
				if progress > 88 and progress < 90 then
					pause = true
					if selection == 0 then
						TriggerEvent("pNotify:SendNotification",{text = "Tilføjer du nogle glasstykker til methen, så det ser ud til at du har mere af det? <br> 1. Ja! <br> 2. No! <br> 3. Tilføj mere lithium for at afbalancere det <br> Tryk på nummeret med den valgmulighed, du gerne vil bruge",type = "error",timeout = (5000),layout = "centerRight",queue = "global",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
						--exports['mythic_notify']:SendAlert('inform', 'Do you add some glass pieces to the meth so it looks like you have more of it?')	
						--exports['mythic_notify']:SendAlert('inform', '1. Yes!')
						--exports['mythic_notify']:SendAlert('inform', '2. No')
						--exports['mythic_notify']:SendAlert('inform', '3. Hvad hvis jeg tilføjer meth til glassen i stedet?')
						--exports['mythic_notify']:SendAlert('inform', 'Press the number of the option you want to do')
					end
					if selection == 1 then
						print("Slected 1")
						exports['mythic_notify']:SendAlert('inform', 'Nu fik du lidt mere meth ud af det')
						quality = quality + 1
						pause = false
					end
					if selection == 2 then
						print("Slected 2")
						exports['mythic_notify']:SendAlert('inform', 'Du er en god drug dealer, dit produkt er af høj kvalitet')
						pause = false
						quality = quality + 1
					end
					if selection == 3 then
						print("Slected 3")
						exports['mythic_notify']:SendAlert('inform', 'Det er lidt for meget, der er mere glas end meth men ok')
						pause = false
						quality = quality - 1
					end
				end
				
				
				
				
				
				
				
				if IsPedInAnyVehicle(playerPed) then
					TriggerServerEvent('olsen_methcar:make', pos.x,pos.y,pos.z)
					if pause == false then
						selection = 0
						quality = quality + 1
						progress = progress +  math.random(1, 2)
						exports['mythic_notify']:SendAlert('inform', 'Meth Produktion: ' .. progress .. '%')
					end
				else
					TriggerEvent('olsen_methcar:stop')
				end

			else
				TriggerEvent('olsen_methcar:stop')
				progress = 100
				exports['mythic_notify']:SendAlert('inform', 'Meth Produktion: ' .. progress .. '%')
				exports['mythic_notify']:SendAlert('inform', 'Produktion Færdiggjort')
				TriggerServerEvent('olsen_methcar:finish', quality)
				FreezeEntityPosition(LastCar, false)
			end	
			
		end
		
	end
end)
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
			if IsPedInAnyVehicle(GetPlayerPed(-1)) then
			else
				if started then
					started = false
					displayed = false
					TriggerEvent('olsen_methcar:stop')
					print('Stopped making drugs')
					FreezeEntityPosition(LastCar,false)
				end		
			end
	end

end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)		
		if pause == true then
			if IsControlJustReleased(0, Keys['1']) then
				selection = 1
				exports['mythic_notify']:SendAlert('inform', 'Du valgte valgmulighed 1')
			end
			if IsControlJustReleased(0, Keys['2']) then
				selection = 2
				exports['mythic_notify']:SendAlert('inform', 'Du valgte valgmulighed 2')
			end
			if IsControlJustReleased(0, Keys['3']) then
				selection = 3
				exports['mythic_notify']:SendAlert('inform', 'Du valgte valgmulighed 3')
			end
		end

	end
end)




