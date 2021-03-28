--[[
────────────────────────────────────────────────
─███████╗███╗───██╗ ██████╗ ██╗────██╗██╗───██╗─  
─╚══███╔╝████╗──██║██╔═══██╗██║────██║╚██╗─██╔╝─  
───███╔╝─██╔██╗─██║██║───██║██║─█╗─██║─╚████╔╝──   
──███╔╝──██║╚██╗██║██║───██║██║███╗██║──╚██╔╝───    
─███████╗██║─╚████║╚██████╔╝╚███╔███╔╝───██║────     
─╚══════╝╚═╝──╚═══╝─╚═════╝──╚══╝╚══╝────╚═╝────     
────────────────────────────────────────────────
]]-- 

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","znowy_drugs")

local start = true
local start2 = true
local start3 = true

local juvel = true
local guld = true
local dia = true

-------------------------------------------------
--                   HVIDVASK                    --
-------------------------------------------------

Citizen.CreateThread(function ()
    while true do
        Citizen.Wait(1)
        if start then
        local ply = GetPlayerPed(-1)
        local plyCoords = GetEntityCoords(ply, 0)
        for _, item in pairs(Config.Hvidvask) do
        local distance = GetDistanceBetweenCoords(item.x, item.y, item.z,  plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
            if(distance <= 1) then
            DrawText3Ds(item.x, item.y, item.z, "Tryk ~c~[~b~E~c~] ~w~for at hvidvaske ~c~(~r~x~b~1000~c~)")
            if IsControlJustReleased(1, 38) then
            start2 = false
            start3 = false
            exports['ac_progressbar']:startUI(2000, "Hvidvasker...")
            FreezeEntityPosition(PlayerPedId(), true)
            TaskStartScenarioInPlace(PlayerPedId(), 'PROP_HUMAN_PARKING_METER', 0, true)
            Citizen.Wait(2000)
            ClearPedTasksImmediately(GetPlayerPed(-1))
            TriggerServerEvent('znowy_drugs:hvidvask')
            FreezeEntityPosition(PlayerPedId(), false)
            Wait(1)
            start2 = true
            start3 = true
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
        for _, item in pairs(Config.Hvidvask) do
        local distance = GetDistanceBetweenCoords(item.x, item.y, item.z,  plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
            if(distance <= 1) then
            DrawText3Ds(item.x, item.y, item.z+0.10, "Tryk ~c~[~b~F~c~] ~w~for at hvidvaske ~c~(~r~x~b~5000~c~)")
            if IsControlJustReleased(1, 23) then
            start = false
            start3 = false
            exports['ac_progressbar']:startUI(18000, "Hvidvasker...")
            FreezeEntityPosition(PlayerPedId(), true)
            TaskStartScenarioInPlace(PlayerPedId(), 'PROP_HUMAN_PARKING_METER', 0, true)
            Citizen.Wait(18000)
            ClearPedTasksImmediately(GetPlayerPed(-1))
            TriggerServerEvent('znowy_drugs:hvidvask2')
            FreezeEntityPosition(PlayerPedId(), false)
            Wait(1)
            start = true
            start3 = true
            end
           end
          end
        end
    end
end)

Citizen.CreateThread(function ()
    while true do
        Citizen.Wait(1)
        if start3 then
        local ply = GetPlayerPed(-1)
        local plyCoords = GetEntityCoords(ply, 0)
        for _, item in pairs(Config.Hvidvask) do
        local distance = GetDistanceBetweenCoords(item.x, item.y, item.z,  plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
            if(distance <= 1) then
            DrawText3Ds(item.x, item.y, item.z+0.20, "Tryk ~c~[~b~K~c~] ~w~for at hvidvaske ~c~(~r~x~b~10000~c~)")
            if IsControlJustReleased(1, 311) then
            start = false
            start2 = false
            exports['ac_progressbar']:startUI(18000, "Hvidvasker...")
            FreezeEntityPosition(PlayerPedId(), true)
            TaskStartScenarioInPlace(PlayerPedId(), 'PROP_HUMAN_PARKING_METER', 0, true)
            Citizen.Wait(18000)
            ClearPedTasksImmediately(GetPlayerPed(-1))
            TriggerServerEvent('znowy_drugs:hvidvask3')
            FreezeEntityPosition(PlayerPedId(), false)
            Wait(1)
            start = true
            start2 = true
            end
           end
          end
        end
    end
end)

-------------------------------------------------
--             JUVEL, DIAMANT, GULD            --
-------------------------------------------------

Citizen.CreateThread(function ()
    while true do
        Citizen.Wait(1)
        if juvel then
        local ply = GetPlayerPed(-1)
        local plyCoords = GetEntityCoords(ply, 0)
        for _, item in pairs(Config.Juvel) do
        local distance = GetDistanceBetweenCoords(item.x, item.y, item.z,  plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
            if(distance <= 1) then
            DrawText3Ds(item.x, item.y, item.z, "Tryk ~c~[~b~E~c~] ~w~for at sælge en juvel")
            if IsControlJustReleased(1, 38) then
            guld = false
            dia = false
            exports['ac_progressbar']:startUI(2000, "Sælger...")
            FreezeEntityPosition(PlayerPedId(), true)
            TaskStartScenarioInPlace(PlayerPedId(), 'PROP_HUMAN_PARKING_METER', 0, true)
            Citizen.Wait(2000)
            ClearPedTasksImmediately(GetPlayerPed(-1))
            TriggerServerEvent('znowy_drugs:juvel')
            FreezeEntityPosition(PlayerPedId(), false)
            Wait(1)
            guld = true
            dia = true
            end
           end
          end
        end
    end
end)

Citizen.CreateThread(function ()
    while true do
        Citizen.Wait(1)
        if guld then
        local ply = GetPlayerPed(-1)
        local plyCoords = GetEntityCoords(ply, 0)
        for _, item in pairs(Config.Juvel) do
        local distance = GetDistanceBetweenCoords(item.x, item.y, item.z,  plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
            if(distance <= 1) then
            DrawText3Ds(item.x, item.y, item.z+0.10, "Tryk ~c~[~b~F~c~] ~w~for at sælge en guldbar")
            if IsControlJustReleased(1, 23) then
            juvel = false
            dia = false
            exports['ac_progressbar']:startUI(2000, "Sælger...")
            FreezeEntityPosition(PlayerPedId(), true)
            TaskStartScenarioInPlace(PlayerPedId(), 'PROP_HUMAN_PARKING_METER', 0, true)
            Citizen.Wait(2000)
            ClearPedTasksImmediately(GetPlayerPed(-1))
            TriggerServerEvent('znowy_drugs:guldbar')
            FreezeEntityPosition(PlayerPedId(), false)
            Wait(1)
            juvel = true
            dia = true
            end
           end
          end
        end
    end
end)

Citizen.CreateThread(function ()
    while true do
        Citizen.Wait(1)
        if dia then
        local ply = GetPlayerPed(-1)
        local plyCoords = GetEntityCoords(ply, 0)
        for _, item in pairs(Config.Juvel) do
        local distance = GetDistanceBetweenCoords(item.x, item.y, item.z,  plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
            if(distance <= 1) then
            DrawText3Ds(item.x, item.y, item.z+0.20, "Tryk ~c~[~b~K~c~] ~w~for at sælge en diamant box")
            if IsControlJustReleased(1, 311) then
            juvel = false
            guld = false
            exports['ac_progressbar']:startUI(2000, "Sælger...")
            FreezeEntityPosition(PlayerPedId(), true)
            TaskStartScenarioInPlace(PlayerPedId(), 'PROP_HUMAN_PARKING_METER', 0, true)
            Citizen.Wait(2000)
            ClearPedTasksImmediately(GetPlayerPed(-1))
            TriggerServerEvent('znowy_drugs:diamant')
            FreezeEntityPosition(PlayerPedId(), false)
            Wait(1)
            juvel = true
            guld = true
            end
           end
          end
        end
    end
end)

-------------------------------------------------
--                   SKUNK                     --
-------------------------------------------------

--[[Citizen.CreateThread(function ()
    while true do
        Citizen.Wait(1)
        local ply = GetPlayerPed(-1)
        local plyCoords = GetEntityCoords(ply, 0)
        for _, item in pairs(Config.Salgskunk) do
        local distance = GetDistanceBetweenCoords(item.x, item.y, item.z,  plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
            if(distance <= 1) then
            DrawText3Ds(item.x, item.y, item.z, "Tryk ~c~[~b~E~c~] ~w~for at sælge (10 stk)")
            if IsControlJustReleased(1, 38) then
            exports['ac_progressbar']:startUI(10000, "Sælger...")
            FreezeEntityPosition(PlayerPedId(), true)
            TaskStartScenarioInPlace(PlayerPedId(), 'PROP_HUMAN_PARKING_METER', 0, true)
            Citizen.Wait(10000)
            ClearPedTasksImmediately(GetPlayerPed(-1))
            TriggerServerEvent('znowy_drugs:salgskunk')
            FreezeEntityPosition(PlayerPedId(), false)
           end
          end
        end
    end
end) ]]


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