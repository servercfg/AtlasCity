function spawn(vehicleID, garageID, registration)
    Citizen.CreateThread(function()
        if Config.Garages[garageID] ~= nil then
            local vtype = Config.Garages[garageID].vehicles[vehicleID].vtype
            local model = Config.Garages[garageID].vehicles[vehicleID].model
            RequestModel(model)
            RequestModel(Config.DriverPed)

            local clearSpawnArea = GetClosestVehicle(Config.Garages[garageID].vehicle_spawn_location[1],Config.Garages[garageID].vehicle_spawn_location[2],Config.Garages[garageID].vehicle_spawn_location[3], 5.0, 0, 71)
            if DoesEntityExist(clearSpawnArea) then 
                exports['mythic_notify']:SendAlert('inform', 'Der holder en bil i vejen', 2500)
                return
            end 

            while (not HasModelLoaded(model)) do
                Citizen.Wait(1)
            end

            local offset=GetOffsetFromEntityInWorldCoords(PlayerPedId(), 50, 50, 0)
            local vehicle = CreateVehicle(model, Config.Garages[garageID].vehicle_spawn_location[1],Config.Garages[garageID].vehicle_spawn_location[2],Config.Garages[garageID].vehicle_spawn_location[3], Config.Garages[garageID].vehicle_spawn_location[4], true, false)

            SetVehicleOnGroundProperly(vehicle)
            SetEntityInvincible(vehicle,false)
            Citizen.InvokeNative(0xAD738C3085FE7E11, vehicle, true, true)
            SetVehicleHasBeenOwnedByPlayer(vehicle,true)
            LoadAllPathNodes(true)
            SetVehicleNumberPlateText(vehicle, "DK" .. registration)
            SetVehicleDirtLevel(vehicle, 0)
            TriggerEvent("vrp_garages:setVehicle", vtype, {vtype,model,vehicle})
            for i = 1, 14 do
                if DoesExtraExist(vehicle, i) ~= nil then
                    SetVehicleExtra(vehicle, i, 0)
                end
            end
        else
            exports['mythic_notify']:SendAlert('inform', 'Der opstod et problem. Kontakt venligst en administrator.', 2500)
        end
    end)
end

function NearGarage()
    local ply = GetPlayerPed(-1)
    local plyCoords = GetEntityCoords(ply, 0)
    for index, item in pairs(Config.Garages) do
      local distance =
        GetDistanceBetweenCoords(item.open_menu_location[1], item.open_menu_location[2], item.open_menu_location[3], plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
      if (distance <= 3) then
        return index
      end
    end
end

function NearDespawn()
    local ply = GetPlayerPed(-1)
    local plyCoords = GetEntityCoords(ply, 0)
    for index, item in pairs(Config.Garages) do
      local distance =
        GetDistanceBetweenCoords(item.vehicle_despawn_location[1], item.vehicle_despawn_location[2], item.vehicle_despawn_location[3], plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
      if (distance <= 3) then
        return index
      end
    end
end

function Despawn()
    local ply = GetPlayerPed(-1)
    local plyCoords = GetEntityCoords(ply, 0)
    local bil = GetVehiclePedIsIn(ply, false)
        SetEntityAsMissionEntity(bil, true, true)
        Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(bil))
end

function IsInVehicle()
    local ply = GetPlayerPed(-1)
    if IsPedSittingInAnyVehicle(ply) then
        return true
    else
        return false
    end
end

function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end

function round(num, numDecimalPlaces)
    local mult = 100^(numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end