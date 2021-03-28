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
vRPclient = Tunnel.getInterface("vRP", "kaz_scripts")

police = false
radaractive = false

RegisterNetEvent("kaz_radar:godkendt")
AddEventHandler("kaz_radar:godkendt", function(state) 
	if state == "sandt" then 
	police = true
	else
	police = false
	end
end)

Citizen.CreateThread(function()
    while true do
        TriggerServerEvent('kaz_radar:tjekperm')
		Citizen.Wait(1000)
	end
end)

lock0 = true

local radar =
{
	shown = false,
	freeze = false,
	info = "~w~Plade: ~w~0 | ~w~Model: ~w~0",
	info2 = "~w~Fart: ~w~0 km/t",
	minSpeed = 5.0,
	maxSpeed = 75.0,
}

function DrawAdvancedText(x,y ,w,h,sc, text, r,g,b,a,font,jus)
    SetTextFont(font)
    SetTextProportional(0)
    SetTextScale(sc, sc)
	N_0x4e096588b13ffeca(jus)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
	DrawText(x - 0.1+w, y - 0.02+h)
end

Citizen.CreateThread( function()	
	while true do
		Wait(0)
		playerPed = GetPlayerPed(-1)
		if police == true then 
			if playerPed then 
					if ( IsDisabledControlPressed( 1, 36 ) and IsDisabledControlJustPressed( 1, 244 ) ) then 	
						if radar.shown == true then 
							radar.shown = false
						else 
							radar.shown = true 
						end
					end			
					if radar.shown == true and IsControlJustPressed(1, 38) then --38 = E
						if radar.freeze then radar.freeze = false else radar.freeze = true end
					end
					if radar.shown then
						if lock0 == true then 
							DrawAdvancedText(0.507, 0.823, 0.020, 0.0028, 0.4, "", 26, 255, 0, 255, 6, 0)
						end
						if radar.freeze == false then
							local player = GetPlayerPed(-1)
							local coordA = GetOffsetFromEntityInWorldCoords(player, 0.0, 1.0, 1.0)
							local coordB = GetOffsetFromEntityInWorldCoords(player, 0.0, 105.0, 0.0)
							local frontcar = Cast_3dRayPointToPoint(coordA, coordB, 3.0, 10, player, 500)
							local a, b, c, d, e = GetRaycastResult(frontcar)
							DrawAdvancedText(0.195, 0.680, -0.005, 0.0028, 0.4, "Låst op", 26, 255, 0, 255, 6, 0)
								if IsEntityAVehicle(e) then	
									local fmodel = GetDisplayNameFromVehicleModel(GetEntityModel(e))
									local fvspeed = GetEntitySpeed(e)*3.6
									local fplate = GetVehicleNumberPlateText(e)
									if lock80 == true then 
										if fvspeed >= 80 then 
											radar.freeze = true 
										end
									elseif lock130 == true then 
										if fvspeed >= 130 then 
											radar.freeze = true
										end
									end		
									radar.info = string.format("~w~Plade: ~w~%s | ~w~Model: ~w~%s", fplate, fmodel, math.ceil(fvspeed))
									radar.info2 = string.format("~w~Fart: ~w~%s km/t", math.ceil(fvspeed))
								end
						else
							DrawAdvancedText(0.195, 0.680, -0.005, 0.0028, 0.4, "Låst", 255, 0, 0, 255, 6, 0)
						end
						DrawAdvancedText(0.180, 0.710, 0.009, 0.0028, 0.4, radar.info, 255, 255, 255, 255, 6, 0)
						DrawAdvancedText(0.180, 0.740, 0.009, 0.0028, 0.4, radar.info2, 255, 255, 255, 255, 6, 0)
					end	
				end
			end
	end
end)

