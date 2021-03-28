RegisterNetEvent("atlas:sletallebiler")
AddEventHandler("atlas:sletallebiler", function ()
    TriggerEvent("chatMessage", "[BacksideRP]", {19, 173, 240}, "Alle forladte køretøjer slettes om 1 minut!")
    Wait(60000)
    local totalvehc = 0
    local notdelvehc = 0

    for vehicle in EnumerateVehicles() do
        if (not IsPedAPlayer(GetPedInVehicleSeat(vehicle, -1))) then SetVehicleHasBeenOwnedByPlayer(vehicle, false) SetEntityAsMissionEntity(vehicle, false, false) DeleteVehicle(vehicle)
            if (DoesEntityExist(vehicle)) then DeleteVehicle(vehicle) end
            if (DoesEntityExist(vehicle)) then notdelvehc = notdelvehc + 1 end
        end
        totalvehc = totalvehc + 1 
    end
    local vehfrac = totalvehc - notdelvehc .. " / " .. totalvehc
    Citizen.Trace("Du har lige slettet "..vehfrac.." biler på serveren!")
end)