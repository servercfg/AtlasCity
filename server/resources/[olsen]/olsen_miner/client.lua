vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","olsen_miner")

local start = true
local start2 = true
local omdan = true
local omdan2 = true
local impacts = 0    

-------------------------------------------------
--                   ALU                    --
-------------------------------------------------

Citizen.CreateThread(function ()
    while true do
        Citizen.Wait(1)
        if start then
        local ply = GetPlayerPed(-1)
        local plyCoords = GetEntityCoords(ply, 0)
        for _, item in pairs(Config.aluore) do
        local distance = GetDistanceBetweenCoords(item.x, item.y, item.z,  plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
            if(distance <= 1) then
            DrawText3Ds(item.x, item.y, item.z, "Tryk ~c~[~b~E~c~] ~w~for at hakke Aluminium")
            if IsControlJustReleased(1, 38) then
            exports['ac_progressbar']:startUI(2000, "Hakker...")
            FreezeEntityPosition(PlayerPedId(), true)
            local ped = PlayerPedId()	
            RequestAnimDict("melee@large_wpn@streamed_core")
            TaskPlayAnim((ped), 'melee@large_wpn@streamed_core', 'ground_attack_on_spot', 8.0, 8.0, -1, 80, 0, 0, 0, 0)
            if impacts == 0 then
    pickaxe = CreateObject(GetHashKey("prop_tool_pickaxe"), 0, 0, 0, true, true, true)
    AttachEntityToEntity(pickaxe, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.18, -0.02, -0.02, 350.0, 100.00, 140.0, true, true, false, true, 1, true)
    Wait(1000)
    TaskPlayAnim((ped), 'melee@large_wpn@streamed_core', 'ground_attack_on_spot', 8.0, 8.0, -1, 80, 0, 0, 0, 0)
    Wait(1000)
    TaskPlayAnim((ped), 'melee@large_wpn@streamed_core', 'ground_attack_on_spot', 8.0, 8.0, -1, 80, 0, 0, 0, 0)
end	
            Citizen.Wait(2000)
            ClearPedTasksImmediately(GetPlayerPed(-1))
            TriggerServerEvent('olsen_miner:aluore')
            FreezeEntityPosition(PlayerPedId(), false)
            Wait(1)
            DeleteObject(pickaxe)
            end
           end
          end
        end
    end
end)

Citizen.CreateThread(function ()
    while true do
        Citizen.Wait(1)
        if omdan then
        local ply = GetPlayerPed(-1)
        local plyCoords = GetEntityCoords(ply, 0)
        for _, item in pairs(Config.alu) do
        local distance = GetDistanceBetweenCoords(item.x, item.y, item.z,  plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
            if(distance <= 1) then
            DrawText3Ds(item.x, item.y, item.z, "Tryk ~c~[~b~E~c~] ~w~for at fremstille Aluminium")
            if IsControlJustReleased(1, 38) then
            exports['ac_progressbar']:startUI(2000, "Fremstiller...")
            FreezeEntityPosition(PlayerPedId(), true)
            TaskStartScenarioInPlace(PlayerPedId(), 'PROP_HUMAN_PARKING_METER', 0, true)
            Citizen.Wait(2000)
            ClearPedTasksImmediately(GetPlayerPed(-1))
            TriggerServerEvent('olsen_miner:alu')
            FreezeEntityPosition(PlayerPedId(), false)
            Wait(1)
            end
           end
          end
        end
    end
end)

-------------------------------------------------
--                   GULD                    --
-------------------------------------------------

Citizen.CreateThread(function ()
    while true do
        Citizen.Wait(1)
        if start then
        local ply = GetPlayerPed(-1)
        local plyCoords = GetEntityCoords(ply, 0)
        for _, item in pairs(Config.guldore) do
        local distance = GetDistanceBetweenCoords(item.x, item.y, item.z,  plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
            if(distance <= 1) then
            DrawText3Ds(item.x, item.y, item.z, "Tryk ~c~[~b~E~c~] ~w~for at hakke guld")
            if IsControlJustReleased(1, 38) then
            start2 = false
            exports['ac_progressbar']:startUI(2000, "Hakker...")
            FreezeEntityPosition(PlayerPedId(), true)
            local ped = PlayerPedId()	
            RequestAnimDict("melee@large_wpn@streamed_core")
            TaskPlayAnim((ped), 'melee@large_wpn@streamed_core', 'ground_attack_on_spot', 8.0, 8.0, -1, 80, 0, 0, 0, 0)
            if impacts == 0 then
    pickaxe = CreateObject(GetHashKey("prop_tool_pickaxe"), 0, 0, 0, true, true, true)
    AttachEntityToEntity(pickaxe, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.18, -0.02, -0.02, 350.0, 100.00, 140.0, true, true, false, true, 1, true)
    Wait(1000)
    TaskPlayAnim((ped), 'melee@large_wpn@streamed_core', 'ground_attack_on_spot', 8.0, 8.0, -1, 80, 0, 0, 0, 0)
    Wait(1000)
    TaskPlayAnim((ped), 'melee@large_wpn@streamed_core', 'ground_attack_on_spot', 8.0, 8.0, -1, 80, 0, 0, 0, 0)
end	
            Citizen.Wait(2000)
            ClearPedTasksImmediately(GetPlayerPed(-1))
            TriggerServerEvent('olsen_miner:guldore')
            FreezeEntityPosition(PlayerPedId(), false)
            Wait(1)
            start2 = true
            DeleteObject(pickaxe)
            end
           end
          end
        end
    end
end)

Citizen.CreateThread(function ()
    while true do
        Citizen.Wait(1)
        if start2 then
        local ply = GetPlayerPed(-1)
        local plyCoords = GetEntityCoords(ply, 0)
        for _, item in pairs(Config.guldore) do
        local distance = GetDistanceBetweenCoords(item.x, item.y, item.z,  plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
            if(distance <= 1) then
            DrawText3Ds(item.x, item.y, item.z+0.10, "Tryk ~c~[~b~F~c~] ~w~for at hakke guld ~c~(~r~x~b~10~c~)")
            if IsControlJustReleased(1, 23) then
            start = false
            exports['ac_progressbar']:startUI(18000, "Hakker...")
            FreezeEntityPosition(PlayerPedId(), true)
            local ped = PlayerPedId()	
            RequestAnimDict("melee@large_wpn@streamed_core")
            TaskPlayAnim((ped), 'melee@large_wpn@streamed_core', 'ground_attack_on_spot', 8.0, 8.0, -1, 80, 0, 0, 0, 0)
            if impacts == 0 then
    pickaxe = CreateObject(GetHashKey("prop_tool_pickaxe"), 0, 0, 0, true, true, true)
    AttachEntityToEntity(pickaxe, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.18, -0.02, -0.02, 350.0, 100.00, 140.0, true, true, false, true, 1, true)
    Wait(1500)
    TaskPlayAnim((ped), 'melee@large_wpn@streamed_core', 'ground_attack_on_spot', 8.0, 8.0, -1, 80, 0, 0, 0, 0)
    Wait(1500)
    TaskPlayAnim((ped), 'melee@large_wpn@streamed_core', 'ground_attack_on_spot', 8.0, 8.0, -1, 80, 0, 0, 0, 0)
end	
            Citizen.Wait(18000)
            ClearPedTasksImmediately(GetPlayerPed(-1))
            TriggerServerEvent('olsen_miner:guldore2')
            FreezeEntityPosition(PlayerPedId(), false)
            Wait(1)
            start = true
            DeleteObject(pickaxe)
            end
           end
          end
        end
    end
end)

Citizen.CreateThread(function ()
    while true do
        Citizen.Wait(1)
        if omdan then
        local ply = GetPlayerPed(-1)
        local plyCoords = GetEntityCoords(ply, 0)
        for _, item in pairs(Config.guldfrem) do
        local distance = GetDistanceBetweenCoords(item.x, item.y, item.z,  plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
            if(distance <= 1) then
            DrawText3Ds(item.x, item.y, item.z, "Tryk ~c~[~b~E~c~] ~w~for at fremstille")
            if IsControlJustReleased(1, 38) then
            omdan2 = false
            exports['ac_progressbar']:startUI(2000, "Omdanner...")
            FreezeEntityPosition(PlayerPedId(), true)
            TaskStartScenarioInPlace(PlayerPedId(), 'PROP_HUMAN_PARKING_METER', 0, true)
            Citizen.Wait(2000)
            ClearPedTasksImmediately(GetPlayerPed(-1))
            TriggerServerEvent('olsen_miner:guldfrem')
            FreezeEntityPosition(PlayerPedId(), false)
            Wait(1)
            omdan2 = true
            end
           end
          end
        end
    end
end)

Citizen.CreateThread(function ()
    while true do
        Citizen.Wait(1)
        if omdan2 then
        local ply = GetPlayerPed(-1)
        local plyCoords = GetEntityCoords(ply, 0)
        for _, item in pairs(Config.guldfrem) do
        local distance = GetDistanceBetweenCoords(item.x, item.y, item.z,  plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
            if(distance <= 1) then
            DrawText3Ds(item.x, item.y, item.z+0.10, "Tryk ~c~[~b~F~c~] ~w~for at fremstille ~c~(~r~x~b~10~c~)")
            if IsControlJustReleased(1, 23) then
            omdan = false
            exports['ac_progressbar']:startUI(18000, "Fremstiller...")
            FreezeEntityPosition(PlayerPedId(), true)
            TaskStartScenarioInPlace(PlayerPedId(), 'PROP_HUMAN_PARKING_METER', 0, true)
            Citizen.Wait(18000)
            ClearPedTasksImmediately(GetPlayerPed(-1))
            TriggerServerEvent('olsen_miner:guldfrem2')
            FreezeEntityPosition(PlayerPedId(), false)
            Wait(1)
            omdan = true
            end
           end
          end
        end
    end
end)

Citizen.CreateThread(function ()
    while true do
        Citizen.Wait(1)
        local ply = GetPlayerPed(-1)
        local plyCoords = GetEntityCoords(ply, 0)
        for _, item in pairs(Config.guldsalg) do
        local distance = GetDistanceBetweenCoords(item.x, item.y, item.z,  plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
            if(distance <= 1) then
            DrawText3Ds(item.x, item.y, item.z, "Tryk ~c~[~b~E~c~] ~w~for at sælge guldbare (10 stk)")
            if IsControlJustReleased(1, 38) then
            exports['ac_progressbar']:startUI(10000, "Sælger...")
            FreezeEntityPosition(PlayerPedId(), true)
            TaskStartScenarioInPlace(PlayerPedId(), 'WORLD_HUMAN_CLIPBOARD', 0, true)
            Citizen.Wait(10000)
            ClearPedTasksImmediately(GetPlayerPed(-1))
            TriggerServerEvent('olsen_miner:guldsalg')
            FreezeEntityPosition(PlayerPedId(), false)
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