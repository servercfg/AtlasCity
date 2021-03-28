--------------------------------------------------------------------------------------------
------- Created by OGKUSH#2625  - Made for AltasCity FiveM - Owned by Olsen1157#5852 -------
--------------------------------------------------------------------------------------------

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "ac-watertank")

cachedData = {}

-- Notification
function hintToDisplay(text)
    SetTextComponentFormat("STRING")
    AddTextComponentString(text)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

Citizen.CreateThread(function()
	while true do
		local sleepThread = 500

		local ped = PlayerPedId()
		local pedCoords = GetEntityCoords(ped)

		local closestTank = GetClosestObjectOfType(pedCoords, 5.0, Config.TankModel, false)

		if DoesEntityExist(closestTank) then
			sleepThread = 5

			local markerCoords = GetOffsetFromEntityInWorldCoords(closestTank, 0.0, -0.2, 1.0)
			local distanceCheck = #(pedCoords - markerCoords)

			if distanceCheck <= 1.0 then
				local drinkable, displayText = not cachedData["drinking"], cachedData["drinking"] and "Drikker..." or "~INPUT_DETONATE~ Tag et glas vand " .. Config.WaterPrice .. ",-"

				--DisplayHelpText(displayText)
				hintToDisplay(displayText)
				if drinkable then
					if IsControlJustPressed(0, 47) then
						PurchaseDrink()
					end
				end
			end
		end

		Citizen.Wait(sleepThread)
	end
end)
