--------------------------------------------------------------------------------------------
------- Created by OGKUSH#2625  - Made for AltasCity FiveM - Owned by Olsen1157#5852 -------
--------------------------------------------------------------------------------------------

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "ac-watertank")

PurchaseDrink = function()
    acWT.TriggerServerCallback("ac-watertank:validatePurchase", function(validated)
        if validated then
            notification('success', 'Du købte et glas vand')

            Drink()
        else
            notification('error', 'Du har ikke nok kontanter, prøv venligst igen.')
        end
    end)
end

Drink = function()
	local timeStarted = GetGameTimer()

    WaitForModel(GetHashKey("prop_ld_flow_bottle"))

    local drinkEntity = CreateObject(GetHashKey("prop_ld_flow_bottle"), GetEntityCoords(PlayerPedId()),  true,  true, true)			

    AttachEntityToEntity(drinkEntity, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 18905), 0.12, 0.028, 0.018, -95.0, 20.0, -40.0, true, true, false, true, 1, true)
    
    while not HasAnimDictLoaded("mp_player_intdrink") do
        Citizen.Wait(0)

        RequestAnimDict("mp_player_intdrink")
    end

    cachedData["drinking"] = true

    Citizen.CreateThread(function()
        while GetGameTimer() - timeStarted < Config.DrinkingTime do
            Citizen.Wait(100)

            if not IsEntityPlayingAnim(PlayerPedId(), "mp_player_intdrink", "loop_bottle", 3) then
                TaskPlayAnim(PlayerPedId(), "mp_player_intdrink", "loop_bottle", 1.0, -1.0, 2000, 49, 0, 0, 0, 0)
            end

           TriggerServerEvent("vRP-thirst:setThirst")
        end

        cachedData["drinking"] = false

        DeleteEntity(drinkEntity)
    end)

    RemoveAnimDict("mp_player_intdrink")
    SetModelAsNoLongerNeeded(GetHashKey("prop_ld_flow_bottle"))
end

DrawScriptMarker = function(markerData)
    DrawMarker(markerData["type"] or 1, markerData["pos"] or vector3(0.0, 0.0, 0.0), 0.0, 0.0, 0.0, (markerData["type"] == 6 and -90.0 or markerData["rotate"] and -180.0) or 0.0, 0.0, 0.0, markerData["sizeX"] or 1.0, markerData["sizeY"] or 1.0, markerData["sizeZ"] or 1.0, markerData["r"] or 1.0, markerData["g"] or 1.0, markerData["b"] or 1.0, 100, false, true, 2, false, false, false, false)
end

WaitForModel = function(model)
    local DrawScreenText = function(text, red, green, blue, alpha)
        SetTextFont(4)
        SetTextScale(0.0, 0.5)
        SetTextColour(red, green, blue, alpha)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(1, 0, 0, 0, 255)
        SetTextDropShadow()
        SetTextOutline()
        SetTextCentre(true)
    
        BeginTextCommandDisplayText("STRING")
        AddTextComponentSubstringPlayerName(text)
        EndTextCommandDisplayText(0.5, 0.5)
    end

    if not IsModelValid(model) then
        return notification('inform', "Denne model eksistere ikke!")
    end

	if not HasModelLoaded(model) then
		RequestModel(model)
	end
	
	while not HasModelLoaded(model) do
		Citizen.Wait(0)
	end
end

-- NOTIFICATION FUNCITON
function notification(type ,msg)
	exports['mythic_notify']:SendAlert(type, msg)
end