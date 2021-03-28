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

Citizen.CreateThread(function()
    while true do
	Citizen.Wait(0)
			if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), -1262.4162597656,-656.33819580078,26.664106369019, true ) < 30 then
				DrawMarker(27,-1262.4162597656,-656.33819580078,26.664106369019-0.9,0,0,0,0,0,Rotation,4.001,4.0001,0.5001,255,0,0,200,0,0,0,true)
				if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -1262.4162597656,-656.33819580078,26.664106369019, true ) < 5 then
					DrawText3Ds(-1262.4162597656,-656.33819580078,26.664106369019+0.1, "~w~[~g~E~w~] for at gå til natklubben.", 3.0, 7)
					if IsControlJustPressed(1, 38) then
						local targetPed =GetPlayerPed(-1)
						local targetVeh = GetVehiclePedIsUsing(targetPed)
							if(IsPedInAnyVehicle(targetPed))then
								targetPed = targetVeh
							end
						DoScreenFadeOut(1000)
						while IsScreenFadingOut() do Citizen.Wait(0) end
						NetworkFadeOutEntity(GetPlayerPed(-1), true, false)
						Wait(1000)
						SetEntityCoordsNoOffset(targetPed, -1641.4266357422,-2990.0234375,-77.077697753906, 0, 0, 1)		
						SetEntityHeading(targetPed, 268.31323242188)
						NetworkFadeInEntity(GetPlayerPed(-1), 0)
						Wait(1000)
						SimulatePlayerInputGait(PlayerId(), 1.0, 100, 1.0, 1, 0)
						DoScreenFadeIn(1000)
						while IsScreenFadingIn() do Citizen.Wait(0)	end
					end
				end
			end
			if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -1641.4266357422,-2990.0234375,-77.077697753906, true ) < 30 then
				DrawMarker(27,-1641.4266357422,-2990.0234375,-77.077697753906-0.9,0,0,0,0,0,Rotation,4.001,4.0001,0.5001,255,0,0,200,0,0,0,true)
				if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -1641.4266357422,-2990.0234375,-77.077697753906, true ) < 5 then
					DrawText3Ds(-1641.4266357422,-2990.0234375,-77.077697753906+0.1, "~w~[~g~E~w~] for at gå ud fra natklubben.", 3.0, 7)
					if IsControlJustPressed(1, 38) then
						local targetPed =GetPlayerPed(-1)
						local targetVeh = GetVehiclePedIsUsing(targetPed)
							if(IsPedInAnyVehicle(targetPed))then
								targetPed = targetVeh
							end
						DoScreenFadeOut(1000)
						while IsScreenFadingOut() do Citizen.Wait(0) end
						NetworkFadeOutEntity(GetPlayerPed(-1), true, false)
						Wait(1000)
						SetEntityCoordsNoOffset(targetPed, -1262.4162597656,-656.33819580078,26.664106369019, 0, 0, 1)		
						SetEntityHeading(targetPed, 151.6213684082)
						NetworkFadeInEntity(GetPlayerPed(-1), 0)
						Wait(1000)
						SimulatePlayerInputGait(PlayerId(), 1.0, 100, 1.0, 1, 0)
						DoScreenFadeIn(1000)
						while IsScreenFadingIn() do Citizen.Wait(0)	end
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