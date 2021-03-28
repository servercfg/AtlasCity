vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","olsen_attachments")

local snsclip = true
local snsclip2 = true

-------------------------------------------------
--                   SNS                    --
-------------------------------------------------

Citizen.CreateThread(function ()
    while true do
        Citizen.Wait(1)
        if snsclip then
        local ply = GetPlayerPed(-1)
        local plyCoords = GetEntityCoords(ply, 0)
        for _, item in pairs(Config.snsclip) do
        local distance = GetDistanceBetweenCoords(item.x, item.y, item.z,  plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
            if(distance <= 1) then
            DrawText3Ds(item.x, item.y, item.z, "Tryk ~c~[~b~E~c~] ~w~for at lave et Extended Clip ~c~(~b~SNS~c~)")
            if IsControlJustReleased(1, 38) then
                exports['ac_progressbar']:startUI(2000, "Laver Extended Clip...")
                Citizen.Wait(2000)
                snsclip2 = false
            FreezeEntityPosition(PlayerPedId(), true)
            ClearPedTasksImmediately(GetPlayerPed(-1))
            TriggerServerEvent('olsen_attachments:extendedsnsfrem')
            FreezeEntityPosition(PlayerPedId(), false)
            Wait(1)
            snsclip2 = true
            end
           end
          end
        end
    end
end)

-------------------------------------------------
--                   PISTOL                    --
-------------------------------------------------

Citizen.CreateThread(function ()
    while true do
        Citizen.Wait(1)
        if snsclip2 then
        local ply = GetPlayerPed(-1)
        local plyCoords = GetEntityCoords(ply, 0)
        for _, item in pairs(Config.pistolclip) do
        local distance = GetDistanceBetweenCoords(item.x, item.y, item.z,  plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
            if(distance <= 1) then
            DrawText3Ds(item.x, item.y, item.z, "Tryk ~c~[~b~E~c~] ~w~for at lave et Extended Clip ~c~(~b~Pistol~c~)")
            if IsControlJustReleased(1, 38) then
                exports['ac_progressbar']:startUI(2000, "Laver Extended Clip...")
                Citizen.Wait(2000)
                snsclip = false
            FreezeEntityPosition(PlayerPedId(), true)
            ClearPedTasksImmediately(GetPlayerPed(-1))
            TriggerServerEvent('olsen_attachments:extendedpistolfrem')
            FreezeEntityPosition(PlayerPedId(), false)
            Wait(1)
            snsclip = true
            end
           end
          end
        end
    end
end)

Citizen.CreateThread(function ()
    while true do
        Citizen.Wait(1)
        if snsclip2 then
        local ply = GetPlayerPed(-1)
        local plyCoords = GetEntityCoords(ply, 0)
        for _, item in pairs(Config.pistolclip) do
        local distance = GetDistanceBetweenCoords(item.x, item.y, item.z,  plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
            if(distance <= 1) then
            DrawText3Ds(item.x, item.y, item.z-0.2, "Tryk ~c~[~b~F~c~] ~w~for at lave en Suppressor ~c~(~b~Pistol~c~)")
            if IsControlJustReleased(1, 23) then
                exports['ac_progressbar']:startUI(2000, "Laver Suppressor...")
                Citizen.Wait(2000)
                snsclip = false
            FreezeEntityPosition(PlayerPedId(), true)
            ClearPedTasksImmediately(GetPlayerPed(-1))
            TriggerServerEvent('olsen_attachments:supppistolfrem')
            FreezeEntityPosition(PlayerPedId(), false)
            Wait(1)
            snsclip = true
            end
           end
          end
        end
    end
end)

Citizen.CreateThread(function ()
    while true do
        Citizen.Wait(1)
        if snsclip2 then
        local ply = GetPlayerPed(-1)
        local plyCoords = GetEntityCoords(ply, 0)
        for _, item in pairs(Config.pistolclip) do
        local distance = GetDistanceBetweenCoords(item.x, item.y, item.z,  plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
            if(distance <= 1) then
            DrawText3Ds(item.x, item.y, item.z-0.4, "Tryk ~c~[~b~K~c~] ~w~for at lave et Skin ~c~(~b~Pistol~c~)")
            if IsControlJustReleased(1, 311) then
                exports['ac_progressbar']:startUI(2000, "Laver Skin...")
                Citizen.Wait(2000)
                snsclip = false
            FreezeEntityPosition(PlayerPedId(), true)
            ClearPedTasksImmediately(GetPlayerPed(-1))
            TriggerServerEvent('olsen_attachments:skinpistolfrem')
            FreezeEntityPosition(PlayerPedId(), false)
            Wait(1)
            snsclip = true
            end
           end
          end
        end
    end
end)


-------------------------------------------------
--                   HEAVY                    --
-------------------------------------------------

Citizen.CreateThread(function ()
    while true do
        Citizen.Wait(1)
        if snsclip2 then
        local ply = GetPlayerPed(-1)
        local plyCoords = GetEntityCoords(ply, 0)
        for _, item in pairs(Config.heavy) do
        local distance = GetDistanceBetweenCoords(item.x, item.y, item.z,  plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
            if(distance <= 1) then
            DrawText3Ds(item.x, item.y, item.z, "Tryk ~c~[~b~E~c~] ~w~for at lave et Extended Clip ~c~(~b~Heavy~c~)")
            if IsControlJustReleased(1, 38) then
                exports['ac_progressbar']:startUI(2000, "Laver Extended Clip...")
                Citizen.Wait(2000)
                snsclip = false
            FreezeEntityPosition(PlayerPedId(), true)
            ClearPedTasksImmediately(GetPlayerPed(-1))
            TriggerServerEvent('olsen_attachments:extendedheavyfrem')
            FreezeEntityPosition(PlayerPedId(), false)
            Wait(1)
            snsclip = true
            end
           end
          end
        end
    end
end)

Citizen.CreateThread(function ()
    while true do
        Citizen.Wait(1)
        if snsclip2 then
        local ply = GetPlayerPed(-1)
        local plyCoords = GetEntityCoords(ply, 0)
        for _, item in pairs(Config.heavy) do
        local distance = GetDistanceBetweenCoords(item.x, item.y, item.z,  plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
            if(distance <= 1) then
            DrawText3Ds(item.x, item.y, item.z-0.2, "Tryk ~c~[~b~F~c~] ~w~for at lave en Suppressor ~c~(~b~Heavy~c~)")
            if IsControlJustReleased(1, 23) then
                exports['ac_progressbar']:startUI(2000, "Laver Suppressor...")
                Citizen.Wait(2000)
                snsclip = false
            FreezeEntityPosition(PlayerPedId(), true)
            ClearPedTasksImmediately(GetPlayerPed(-1))
            TriggerServerEvent('olsen_attachments:suppheavyfrem')
            FreezeEntityPosition(PlayerPedId(), false)
            Wait(1)
            snsclip = true
            end
           end
          end
        end
    end
end)

-------------------------------------------------
--                   PISTOL50                    --
-------------------------------------------------

Citizen.CreateThread(function ()
    while true do
        Citizen.Wait(1)
        if snsclip2 then
        local ply = GetPlayerPed(-1)
        local plyCoords = GetEntityCoords(ply, 0)
        for _, item in pairs(Config.pistol50) do
        local distance = GetDistanceBetweenCoords(item.x, item.y, item.z,  plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
            if(distance <= 1) then
            DrawText3Ds(item.x, item.y, item.z, "Tryk ~c~[~b~E~c~] ~w~for at lave et Extended Clip ~c~(~b~Deagle~c~)")
            if IsControlJustReleased(1, 38) then
                exports['ac_progressbar']:startUI(2000, "Laver Extended Clip...")
                Citizen.Wait(2000)
                snsclip = false
            FreezeEntityPosition(PlayerPedId(), true)
            ClearPedTasksImmediately(GetPlayerPed(-1))
            TriggerServerEvent('olsen_attachments:extendeddeaglefrem')
            FreezeEntityPosition(PlayerPedId(), false)
            Wait(1)
            snsclip = true
            end
           end
          end
        end
    end
end)

Citizen.CreateThread(function ()
    while true do
        Citizen.Wait(1)
        if snsclip2 then
        local ply = GetPlayerPed(-1)
        local plyCoords = GetEntityCoords(ply, 0)
        for _, item in pairs(Config.pistol50) do
        local distance = GetDistanceBetweenCoords(item.x, item.y, item.z,  plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
            if(distance <= 1) then
            DrawText3Ds(item.x, item.y, item.z-0.2, "Tryk ~c~[~b~F~c~] ~w~for at lave en Suppressor ~c~(~b~Deagle~c~)")
            if IsControlJustReleased(1, 23) then
                exports['ac_progressbar']:startUI(2000, "Laver Suppressor...")
                Citizen.Wait(2000)
                snsclip = false
            FreezeEntityPosition(PlayerPedId(), true)
            ClearPedTasksImmediately(GetPlayerPed(-1))
            TriggerServerEvent('olsen_attachments:suppdeaglefrem')
            FreezeEntityPosition(PlayerPedId(), false)
            Wait(1)
            snsclip = true
            end
           end
          end
        end
    end
end)

-------------------------------------------------
--                   FUNCTIONS                 --
-------------------------------------------------

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