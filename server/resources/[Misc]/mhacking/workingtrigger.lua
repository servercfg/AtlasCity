Citizen.CreateThread(function()
	while true do
	Citizen.Wait(0)
				if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), 1455.9028320313, 3182.9370117188, 40.414070129395, true ) < 40 then
					DrawMarker(27,1455.9028320313-0.5, 3182.9370117188, 40.414070129395-0.9,0,0,0,0,0,Rotation,1.501,1.5001,0.5001,255,0,0,200,0,0,0,true)
				end
				if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), 1455.9028320313, 3182.9370117188, 40.414070129395, true ) < 15 then
					DrawText3Ds(1455.9028320313-0.5,3182.9370117188,40.414070129395+0.2, "~w~Tryk ~g~[E] ~w~for funktion!", 3.0, 7)
					if IsControlJustPressed(1, 38) then -- 38 = E
						-- COMMAND UNDER
						TriggerEvent("mhacking:show")
						TriggerEvent("mhacking:start",6,40,mycb)
						-- COMMAND OVER
					end	
				end			
	end
end)

function mycb(success, timeremaining)
	if success then
		print('Success with '..timeremaining..'s remaining.')
		TriggerEvent('mhacking:hide')
	else
		print('Failure')
		TriggerEvent('mhacking:hide')
	end
end	