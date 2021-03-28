local yyy1 = 0.36
local yyy2 = 0.36
local yyy3 = 0.36
local yyy4 = 0.36

local rrr1 = 152
local ggg1 = 212
local bbb1 = 224

local rrr2 = 152
local ggg2 = 212
local bbb2 = 224

local rrr3 = 152
local ggg3 = 212
local bbb3 = 224

local rrr4 = 152
local ggg4 = 212
local bbb4 = 224

local open = false
local pin1 = false
local pin2 = false
local pin3 = false
local pin4 = false

local ranPin1 = (math.random(3250, 3550) * 0.0001)
local ranPin2 = (math.random(3250, 3550) * 0.0001)
local ranPin3 = (math.random(3250, 3550) * 0.0001)
local ranPin4 = (math.random(3250, 3550) * 0.0001)

RegisterNetEvent('hjalte:open')
AddEventHandler('hjalte:open', function()
	local coords = GetEntityCoords(GetPlayerPed(-1))
	local valid = IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) --Boolean True eller False, radius på 5
	if valid then
		TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BUM_BIN", 0, true)
		open = true
		yyy1 = 0.36
		yyy2 = 0.36
		yyy3 = 0.36
		yyy4 = 0.36

		rrr1 = 152
		ggg1 = 212
		bbb1 = 224

		rrr2 = 152
		ggg2 = 212
		bbb2 = 224

		rrr3 = 152
		ggg3 = 212
		bbb3 = 224

		rrr4 = 152
		ggg4 = 212
		bbb4 = 224

		pin1 = false
		pin2 = false
		pin3 = false
		pin4 = false

		-- Tilfældige pins
		ranPin1 = (math.random(3250, 3550) * 0.0001)
		ranPin2 = (math.random(3250, 3550) * 0.0001)
		ranPin3 = (math.random(3250, 3550) * 0.0001)
		ranPin4 = (math.random(3250, 3550) * 0.0001)
	else
    TriggerEvent("pNotify:SendNotification",{text = "Inten køretøj i nærheden!",type = "warning",timeout = (5000),layout = "centerRight",queue = "global",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer=true})
	end
end)


local txd = CreateRuntimeTxd('Lockpick')
local tx = CreateRuntimeTextureFromImage(txd, 'Lockpick', "background.png")

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if open then

			----------------
			--- BAGGRUND ---
			----------------

			DrawRect(0.9325, 0.3725, 0.113, 0.1915, 0, 0, 0, 255)
			DrawSprite('Lockpick', 'Lockpick', 0.9325, 0.3725, 0.113, 0.1915, 0.0, 255, 255, 255, 180)

			----------
			-- PINS --
			----------


			DrawRect(0.972, yyy1, 0.004, 0.04, rrr1, ggg1, bbb1, 180)
			
			DrawRect(0.959, yyy2, 0.004, 0.04, rrr2, ggg2, bbb2, 180)
			
			DrawRect(0.9455, yyy3, 0.004, 0.04, rrr3, ggg3, bbb3, 180)
			
			DrawRect(0.932, yyy4, 0.004, 0.04, rrr4, ggg4, bbb4, 180)


			local coords = GetEntityCoords(GetPlayerPed(-1))

	  DrawText3Ds(coords.x, coords.y, coords.z-0.05, "[~g~Q~s~] - For at rykke pinden")
	  
	  DrawText3Ds(coords.x, coords.y, coords.z-0.15, "[~g~H~s~] - For at låse pinden")

	  DrawText3Ds(coords.x, coords.y, coords.z-0.25, "[~g~X~s~] - For at stoppe")

			-- Stop med "X"
			DisableControlAction(0, 73, true)

			if IsDisabledControlJustPressed(0, 73) then
				open = false
				pin1 = false
				pin2 = false
				pin3 = false
				pin4 = false
				rrr1 = 152
				ggg1 = 212
				bbb1 = 224
				rrr2 = 152
				ggg2 = 212
				bbb2 = 224
				rrr3 = 152
				ggg3 = 212
				bbb3 = 224
				rrr4 = 152
				ggg4 = 212
				bbb4 = 224
				yyy1 = 0.36
				yyy2 = 0.36
				yyy3 = 0.36
				yyy4 = 0.36
				DisableControlAction(0, 73, false)
				ranPin1 = (math.random(3250, 3550) * 0.0001)
				ranPin2 = (math.random(3250, 3550) * 0.0001)
				ranPin3 = (math.random(3250, 3550) * 0.0001)
				ranPin4 = (math.random(3250, 3550) * 0.0001)
				ClearPedTasksImmediately(GetPlayerPed(-1))
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if open then
			if not pin1 and not pin2 and not pin3 and not pin4 then
				if (yyy1 <= ranPin1) and (ranPin1 - 0.004 <= yyy1) then
					rrr1 = 76
					ggg1 = 175
					bbb1 = 0
					if IsControlJustPressed(0, 311) then
						TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 3.0, 'PinSucc', 0.8)
						pin1 = true
						yyy1 = 0.33
						rrr1 = 14
						ggg1 = 113
						bbb1 = 139
					end
				else
					rrr1 = 152
					ggg1 = 212
					bbb1 = 224
					if IsControlJustPressed(0, 311) then
						TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 3.0, 'PinFail', 0.8)
						rrr1 = 175
						ggg1 = 0
						bbb1 = 0
						Citizen.Wait(50)
						rrr1 = 152
						ggg1 = 212
						bbb1 = 224
						Citizen.Wait(50)
						rrr1 = 175
						ggg1 = 0
						bbb1 = 0
						Citizen.Wait(50)
						rrr3 = 152
						ggg3 = 212
						bbb3 = 224
					end
				end
			elseif pin1 and not pin2 and not pin3 and not pin4 then
				if (yyy2 <= ranPin2) and (ranPin2 - 0.004 <= yyy2) then
					rrr2 = 76
					ggg2 = 175
					bbb2 = 0
					if IsControlJustPressed(0, 311) then
						TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 3.0, 'PinSucc', 0.8)
						pin2 = true
						yyy2 = 0.33
						rrr2 = 14
						ggg2 = 113
						bbb2 = 139
					end
				else
					rrr2 = 152
					ggg2 = 212
					bbb2 = 224
					if IsControlJustPressed(0, 311) then
						TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 3.0, 'PinFail', 0.8)
						rrr2 = 175
						ggg2 = 0
						bbb2 = 0
						Citizen.Wait(50)
						rrr2 = 152
						ggg2 = 212
						bbb2 = 224
						Citizen.Wait(50)
						rrr2 = 175
						ggg2 = 0
						bbb2 = 0
						Citizen.Wait(50)
						rrr2 = 152
						ggg2 = 212
						bbb2 = 224
						pin1 = false
					end
				end
			elseif pin1 and pin2 and not pin3 and not pin4 then
				if (yyy3 <= ranPin3) and (ranPin3 - 0.004 <= yyy3) then
					rrr3 = 76
					ggg3 = 175
					bbb3 = 0
					if IsControlJustPressed(0, 311) then
						TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 3.0, 'PinSucc', 0.8)
						pin3 = true
						yyy3 = 0.33
						rrr3 = 14
						ggg3 = 113
						bbb3 = 139
					end
				else
					rrr3 = 152
					ggg3 = 212
					bbb3 = 224
					if IsControlJustPressed(0, 311) then
						TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 3.0, 'PinFail', 0.8)
						rrr3 = 175
						ggg3 = 0
						bbb3 = 0
						Citizen.Wait(50)
						rrr3 = 152
						ggg3 = 212
						bbb3 = 224
						Citizen.Wait(50)
						rrr3 = 175
						ggg3 = 0
						bbb3 = 0
						Citizen.Wait(50)
						rrr3 = 152
						ggg3 = 212
						bbb3 = 224
						pin2 = false
					end
				end
			elseif pin1 and pin2 and pin3 and not pin4 then
				if (yyy4 <= ranPin4) and (ranPin4 - 0.004 <= yyy4) then
					rrr4 = 76
					ggg4 = 175
					bbb4 = 0
					if IsControlJustPressed(0, 311) then
						TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 3.0, 'PinSucc', 0.8)
						pin4 = true
						yyy4 = 0.33
						rrr4 = 14
						ggg4 = 113
						bbb4 = 139
					end
				else
					rrr4 = 152
					ggg4 = 212
					bbb4 = 224
					if IsControlJustPressed(0, 311) then
						TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 3.0, 'PinFail', 0.8)
						rrr4 = 175
						ggg4 = 0
						bbb4 = 0
						Citizen.Wait(50)
						rrr4 = 152
						ggg4 = 212
						bbb4 = 224
						Citizen.Wait(50)
						rrr4 = 175
						ggg4 = 0
						bbb4 = 0
						Citizen.Wait(50)
						rrr4 = 152
						ggg4 = 212
						bbb4 = 224
						pin3 = false
					end
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if open then

			----------------
			--- RYK PINS ---
			----------------

			if not pin1 and not pin2 and not pin3 and not pin4 then
				if IsControlJustPressed(0, 44) then
					if (yyy1 - 0.003) >= (0.36 - 0.04) then
						yyy1 = yyy1 - 0.003
						Citizen.Wait(10)
						if (yyy1 - 0.003) >= (0.36 - 0.04) then
							yyy1 = yyy1 - 0.003
							Citizen.Wait(10)
							if (yyy1 - 0.003) >= (0.36 - 0.04) then
								yyy1 = yyy1 - 0.003
								Citizen.Wait(10)
								if (yyy1 - 0.003) >= (0.36 - 0.04) then
									yyy1 = yyy1 - 0.003
									Citizen.Wait(10)
									if (yyy1 - 0.003) >= (0.36 - 0.04) then
										yyy1 = yyy1 - 0.003
										Citizen.Wait(10)
									end
								end
							end
						end
					end
				end
			elseif pin1 and not pin2 and not pin3 and not pin4 then
				if IsControlJustPressed(0, 44) then
					if (yyy2 - 0.003) >= (0.36 - 0.04) then
						yyy2 = yyy2 - 0.003
						Citizen.Wait(10)
						if (yyy2 - 0.003) >= (0.36 - 0.04) then
							yyy2 = yyy2 - 0.003
							Citizen.Wait(10)
							if (yyy2 - 0.003) >= (0.36 - 0.04) then
								yyy2 = yyy2 - 0.003
								Citizen.Wait(10)
								if (yyy2 - 0.003) >= (0.36 - 0.04) then
									yyy2 = yyy2 - 0.003
									Citizen.Wait(10)
									if (yyy2 - 0.003) >= (0.36 - 0.04) then
										yyy2 = yyy2 - 0.003
										Citizen.Wait(10)
									end
								end
							end
						end
					end
				end
			elseif pin1 and pin2 and not pin3 and not pin4 then
				if IsControlJustPressed(0, 44) then
					if (yyy3 - 0.003) >= (0.36 - 0.04) then
						yyy3 = yyy3 - 0.003
						Citizen.Wait(10)
						if (yyy3 - 0.003) >= (0.36 - 0.04) then
							yyy3 = yyy3 - 0.003
							Citizen.Wait(10)
							if (yyy3 - 0.003) >= (0.36 - 0.04) then
								yyy3 = yyy3 - 0.003
								Citizen.Wait(10)
								if (yyy3 - 0.003) >= (0.36 - 0.04) then
									yyy3 = yyy3 - 0.003
									Citizen.Wait(10)
									if (yyy3 - 0.003) >= (0.36 - 0.04) then
										yyy3 = yyy3 - 0.003
										Citizen.Wait(10)
									end
								end
							end
						end
					end
				end
			elseif pin1 and pin2 and pin3 and not pin4 then
				if IsControlJustPressed(0, 44) then
					if (yyy4 - 0.003) >= (0.36 - 0.04) then
						yyy4 = yyy4 - 0.003
						Citizen.Wait(10)
						if (yyy4 - 0.003) >= (0.36 - 0.04) then
							yyy4 = yyy4 - 0.003
							Citizen.Wait(10)
							if (yyy4 - 0.003) >= (0.36 - 0.04) then
								yyy4 = yyy4 - 0.003
								Citizen.Wait(10)
								if (yyy4 - 0.003) >= (0.36 - 0.04) then
									yyy4 = yyy4 - 0.003
									Citizen.Wait(10)
									if (yyy4 - 0.003) >= (0.36 - 0.04) then
										yyy4 = yyy4 - 0.003
										Citizen.Wait(10)
									end
								end
							end
						end
					end
				end
			elseif pin1 and pin2 and pin3 and pin4 then
				open = false
				pin1 = false
				pin2 = false
				pin3 = false
				pin4 = false
				rrr1 = 152
				ggg1 = 212
				bbb1 = 224
				rrr2 = 152
				ggg2 = 212
				bbb2 = 224
				rrr3 = 152
				ggg3 = 212
				bbb3 = 224
				rrr4 = 152
				ggg4 = 212
				bbb4 = 224
				yyy1 = 0.36
				yyy2 = 0.36
				yyy3 = 0.36
				yyy4 = 0.36


				-- Åbner køretøjet
				local playerPed = PlayerPedId()
				local coords    = GetEntityCoords(playerPed)
				local vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
				local plate = GetVehicleNumberPlateText(vehicle)

				SetVehicleDoorsLocked(vehicle, 1)
				PlayVehicleDoorOpenSound(vehicle, 0)
				SetVehicleDoorsLockedForAllPlayers(vehicle, false)
				ClearPedTasksImmediately(playerPed)
				DisableControlAction(0, 73, false)
        TriggerEvent("pNotify:SendNotification",{text = "Du dirkede låsen op",type = "info",timeout = (5000),layout = "centerRight",queue = "global",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer=true})

				ranPin1 = (math.random(3250, 3550) * 0.0001)
				ranPin2 = (math.random(3250, 3550) * 0.0001)
				ranPin3 = (math.random(3250, 3550) * 0.0001)
				ranPin4 = (math.random(3250, 3550) * 0.0001)
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		if open then
			if not pin1 then
				if yyy1 < 0.36 then
					yyy1 = yyy1 + 0.0002
				end
			end
			if not pin2 then
				if yyy2 < 0.36 then
					yyy2 = yyy2 + 0.0002
				end
			end
			if not pin3 then
				if yyy3 < 0.36 then
					yyy3 = yyy3 + 0.0002
				end
			end
			if not pin4 then
				if yyy4 < 0.36 then
					yyy4 = yyy4 + 0.0002
				end
			end
		end
	end
end)

function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 255)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
  end