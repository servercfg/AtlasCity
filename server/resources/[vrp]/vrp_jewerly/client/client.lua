-------------------------------------------------------
-----------    Script converted by Nicki    -----------
                ---   21/05/2020	---
   ---  Copyright 2019 Nicki. All rights reserved	---
-------------------Discord:Nicki#3629--------------------

local holdingup = false
local store = ""
local secondsRemaining = 0
local IsEverythingTrue = false
local blipRobbery = nil
local jewlBlip = {}
local jewlBlip_robbed = {}
soundid = GetSoundId()

Citizen.CreateThread(function()
	for k,v in pairs(cfg.holdups)do
		local ve = v.position

		local blip = AddBlipForCoord(ve.x, ve.y, ve.z)
		SetBlipSprite(blip, 439)
		SetBlipScale(blip, 0.6)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('Vangelico Juvelbutik')
		EndTextCommandSetBlipName(blip)
	end
end)

function holdup_DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function holdup_drawTxt(x,y ,width,height,scale, text, r,g,b,a, outline)
    SetTextFont(0)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    if(outline)then
	    SetTextOutline()
	end
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end

function drawTxt(text, font, centre, x, y, scale, r, g, b, a)
	SetTextFont(font)
	SetTextProportional(0)
	SetTextScale(scale, scale)
	SetTextColour(r, g, b, a)
	SetTextDropShadow(0, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(centre)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x, y)
end

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
    local factor = (string.len(text)) / 500
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 0, 0, 0, 80)
end

local stores = cfg.holdups

RegisterNetEvent('vrp_jewerly:currentlyrobbing')
AddEventHandler('vrp_jewerly:currentlyrobbing', function(robb)
	holdingup = true
	store = robb
	secondsRemaining = cfg.seconds
	--alarm = true
end)


RegisterNetEvent('vrp_jewerly:toofarlocal')
AddEventHandler('vrp_jewerly:toofarlocal', function(robb)
	holdingup = false
	exports['mythic_notify']:SendAlert('error', 'Røveriet blev afbrudt, du modtog intet.')
--	TriggerEvent("pNotify:SendNotification",{text = "Røveriet blev afbrudt, du modtog <b style='color:#ff0000'>intet</b>.",type = "warning",timeout = (3000),layout = "centerLeft",queue = "global",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
	robbingName = ""
	secondsRemaining = 0
	--alarm = false
end)

RegisterNetEvent('vrp_jewerly:playerdiedlocal')
AddEventHandler('vrp_jewerly:playerdiedlocal', function(robb)
	holdingup = false
	exports['mythic_notify']:SendAlert('error', 'Du døde! Røveriet blev afbrudt.')
--	TriggerEvent("pNotify:SendNotification",{text = "<b style='color:#ff0000'>Du døde! Røveriet blev afbrudt</b>.",type = "warning",timeout = (3000),layout = "centerLeft",queue = "global",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
	robbingName = ""
	secondsRemaining = 0
end)

RegisterNetEvent('vrp_jewerly:robberycomplete')
AddEventHandler('vrp_jewerly:robberycomplete', function(reward)
	holdingup = false
	exports['mythic_notify']:SendAlert('success', 'Røveriet blev gennemført, du modtog '..reward..' DKK')
--	TriggerEvent("pNotify:SendNotification",{text = "Røveriet blev gennemført, du modtog <b style='color:#3db1ff'>"..reward.."</b> $",type = "success",timeout = (3000),layout = "centerLeft",queue = "global",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
	store = ""
	secondsRemaining = 0
end)

Citizen.CreateThread(function()
	while( true ) do
		if alarm then
			TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, "detector", 0.75)
			end
		Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function()
	while true do
		if holdingup then
			Citizen.Wait(1000)
			if(secondsRemaining > 0)then
				secondsRemaining = secondsRemaining - 1
			end
		end

		Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function()
	while true do
		local pos = GetEntityCoords(GetPlayerPed(-1), true)
		for k,v in pairs(stores)do
			local pos2 = v.position
			if(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) < 15.0)then
				if IsPlayerWantedLevelGreater(PlayerId(),0) or ArePlayerFlashingStarsAboutToDrop(PlayerId()) then
					local wanted = GetPlayerWantedLevel(PlayerId())
					Citizen.Wait(5000)
					SetPlayerWantedLevel(PlayerId(), wanted, 0)
					SetPlayerWantedLevelNow(PlayerId(), 0)
				end
			end
		end
		Citizen.Wait(0)
	end
end)

function loadAnimDict( dict )  
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end 

Citizen.CreateThread(function()
	while true do
		local pos = GetEntityCoords(GetPlayerPed(-1), true)
		for k,v in pairs(stores)do
			local pos2 = v.position
			if(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) < 3.0) then
				if not holdingup then
					DrawMarker(20, v.position.x, v.position.y, v.position.z-0.25, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 48, 3, 105, 100, false, true, 2, true, false, false, false)
				--	DrawMarker(27, v.position.x, v.position.y, v.position.z - 1.0, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 1555, 0, 0,255, 0, 0, 0,0)
				--	drawTxt('[~g~E~s~] for at røve butikken', 0, 1, 0.5, 0.8, 0.6, 255, 255, 255, 255)
					DrawText3Ds(v.position.x, v.position.y, v.position.z, "Tryk ~b~[E]~s~ for at røve butikken")
					
					if(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) < 2.0) then
						if(IsControlJustReleased(1, 51))then
							TriggerServerEvent('vrp_jewerly:rob', k, pos.x, pos.y, pos.z)
						end
					end
				end
			end
		end

		if holdingup then
			for i=1, #cfg.Blips2, 1 do
				if (GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), cfg.Blips2[i].x, cfg.Blips2[i].y, cfg.Blips2[i].z, true) < 0.5 ) then
					if not jewlBlip_robbed[i] then
	
						DrawText3Ds(cfg.Blips2[i].x, cfg.Blips2[i].y, cfg.Blips2[i].z, "~b~[E]~s~ - Stjæl Juvel")
	
						if IsControlJustReleased(1, 51) then

							local player = GetPlayerPed( -1 )

							if not HasNamedPtfxAssetLoaded("scr_jewelheist") then
                RequestNamedPtfxAsset("scr_jewelheist")
			  end

							while not HasNamedPtfxAssetLoaded("scr_jewelheist") do
                Citizen.Wait(0)
              end

              SetPtfxAssetNextCall("scr_jewelheist")
							loadAnimDict( "missheist_jewel" )
							TaskPlayAnim( player, "missheist_jewel", "smash_case", 8.0, 1.0, -1, 2, 0, 0, 0, 0 )
							Citizen.Wait(250)
							TriggerServerEvent('InteractSound_SV:PlayOnSource', 'glass', 0.05)
							Citizen.Wait(200)
							StartParticleFxLoopedAtCoord("scr_jewel_cab_smash", cfg.Blips2[i].x, cfg.Blips2[i].y, cfg.Blips2[i].z, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
							DrawSubtitleTimed(5000, 1)
							Citizen.Wait(5000)
							ClearPedTasksImmediately(GetPlayerPed(-1))
							RemoveBlip(jewlBlip[i])
							TriggerServerEvent('vrp_jewerly:random')
							for k,v in pairs(stores)do
							local pos2 = v.position
							PlaySoundFromCoord(soundid, "VEHICLES_HORNS_AMBULANCE_WARNING", v.position.x, v.position.y, v.position.z)
							PlaySound(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
							jewlBlip_robbed[i] = true

							for _,v in ipairs(jewlBlip_robbed) do
								print(v)
						    if not v then
					        IsEverythingTrue = false
								else
									IsEverythingTrue = true
						    end
							end
						end

					end
				end
			end
		end

			if IsEverythingTrue then
				holdingup = false
				for i=1, #cfg.Blips2, 1 do
						jewlBlip_robbed[i] = false
				end

				TriggerServerEvent('vrp_jewerly:endrob')
				TriggerEvent('skinchanger:getSkin', function(skin)
           if skin.sex == 0 then
              local clothesSkin = { ['bags_1'] = 41, ['bags_2'] = 0   }
              TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
            else
              local clothesSkin = { ['bags_1'] = 41, ['bags_2'] = 0 }
              TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
             end
          end)
				end

			local pos2 = stores[store].position

			if (GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -622.566, -230.183, 38.057, true) > 11.5 ) then
				TriggerServerEvent('vrp_jewerly:toofar')
				StopSound(soundid)
				holdingup = false

				for i=1, #cfg.Blips2, 1 do
					RemoveBlip(jewlBlip_robbed[i])
				end

				for i=1, #cfg.Blips2, 1 do
						jewlBlip_robbed[i] = false
				end
			end
		end

		Citizen.Wait(0)
	end
end)

RegisterNetEvent('vrp_jewerly:togliblip')
AddEventHandler('vrp_jewerly:togliblip', function(robb)
	for i=1, #cfg.Blips2, 1 do
		RemoveBlip(jewlBlip_robbed[i])
	end
end)