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
local omdan = true
local omdan2 = true

-------------------------------------------------
--                   METH                    --
-------------------------------------------------

--[[Citizen.CreateThread(function ()
    while true do
        Citizen.Wait(1)
        if start then
        local ply = GetPlayerPed(-1)
        local plyCoords = GetEntityCoords(ply, 0)
        for _, item in pairs(Config.Coords) do
        local distance = GetDistanceBetweenCoords(item.x, item.y, item.z,  plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
            if(distance <= 1) then
            DrawText3Ds(item.x, item.y, item.z, "Tryk ~c~[~b~E~c~] ~w~for at høste")
            if IsControlJustReleased(1, 38) then
            start2 = false
            exports['ac_progressbar']:startUI(2000, "Høster...")
            FreezeEntityPosition(PlayerPedId(), true)
            TaskStartScenarioInPlace(PlayerPedId(), 'PROP_HUMAN_PARKING_METER', 0, true)
            Citizen.Wait(2000)
            ClearPedTasksImmediately(GetPlayerPed(-1))
            TriggerServerEvent('znowy_drugs:start2meth')
            FreezeEntityPosition(PlayerPedId(), false)
            Wait(1)
            start2 = true
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
        for _, item in pairs(Config.Coords) do
        local distance = GetDistanceBetweenCoords(item.x, item.y, item.z,  plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
            if(distance <= 1) then
            DrawText3Ds(item.x, item.y, item.z+0.06, "Tryk ~c~[~b~F~c~] ~w~for at høste ~c~(~r~x~b~10~c~)")
            if IsControlJustReleased(1, 23) then
            start = false
            exports['ac_progressbar']:startUI(18000, "Høster...")
            FreezeEntityPosition(PlayerPedId(), true)
            TaskStartScenarioInPlace(PlayerPedId(), 'PROP_HUMAN_PARKING_METER', 0, true)
            Citizen.Wait(18000)
            ClearPedTasksImmediately(GetPlayerPed(-1))
            TriggerServerEvent('znowy_drugs:start3meth')
            FreezeEntityPosition(PlayerPedId(), false)
            Wait(1)
            start = true
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
        for _, item in pairs(Config.Omdan) do
        local distance = GetDistanceBetweenCoords(item.x, item.y, item.z,  plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
            if(distance <= 1) then
            DrawText3Ds(item.x, item.y, item.z, "Tryk ~c~[~b~E~c~] ~w~for at omdanne")
            if IsControlJustReleased(1, 38) then
            omdan2 = false
            exports['ac_progressbar']:startUI(2000, "Omdanner...")
            FreezeEntityPosition(PlayerPedId(), true)
            TaskStartScenarioInPlace(PlayerPedId(), 'PROP_HUMAN_PARKING_METER', 0, true)
            Citizen.Wait(2000)
            ClearPedTasksImmediately(GetPlayerPed(-1))
            TriggerServerEvent('znowy_drugs:omdanmeth')
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
        for _, item in pairs(Config.Omdan) do
        local distance = GetDistanceBetweenCoords(item.x, item.y, item.z,  plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
            if(distance <= 1) then
            DrawText3Ds(item.x, item.y, item.z+0.06, "Tryk ~c~[~b~F~c~] ~w~for at omdanne ~c~(~r~x~b~10~c~)")
            if IsControlJustReleased(1, 23) then
            omdan = false
            exports['ac_progressbar']:startUI(18000, "Omdanner...")
            FreezeEntityPosition(PlayerPedId(), true)
            TaskStartScenarioInPlace(PlayerPedId(), 'PROP_HUMAN_PARKING_METER', 0, true)
            Citizen.Wait(18000)
            ClearPedTasksImmediately(GetPlayerPed(-1))
            TriggerServerEvent('znowy_drugs:omdan2meth')
            FreezeEntityPosition(PlayerPedId(), false)
            Wait(1)
            omdan = true
            end
           end
          end
        end
    end
end)]]

--[[Citizen.CreateThread(function ()
    while true do
        Citizen.Wait(1)
        local ply = GetPlayerPed(-1)
        local plyCoords = GetEntityCoords(ply, 0)
        for _, item in pairs(Config.Salg) do
        local distance = GetDistanceBetweenCoords(item.x, item.y, item.z,  plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
            if(distance <= 1) then
            DrawText3Ds(item.x, item.y, item.z, "Tryk ~c~[~b~E~c~] ~w~for at sælge (10 stk)")
            if IsControlJustReleased(1, 38) then
            exports['ac_progressbar']:startUI(10000, "Sælger...")
            FreezeEntityPosition(PlayerPedId(), true)
            --TaskStartScenarioInPlace(PlayerPedId(), 'mp_common', 0, true)
            TriggerEvent('animation')
            Citizen.Wait(10000)
            ClearPedTasksImmediately(GetPlayerPed(-1))
            TriggerServerEvent('znowy_drugs:salgmeth')
            FreezeEntityPosition(PlayerPedId(), false)
           end
          end
        end
    end
end) ]]

RegisterNetEvent('animation')
AddEventHandler('animation', function()
  	local pid = PlayerPedId()
  	RequestAnimDict("anim@mp_player_intmenu@key_fob@")
  	while (not HasAnimDictLoaded("anim@mp_player_intmenu@key_fob@")) do Citizen.Wait(0) end
	TaskPlayAnim(pid,"anim@mp_player_intmenu@key_fob@","fob_click",100.0, 200.0, 0.3, 120, 0.2, 0, 0, 0)
    Wait(1500)
     ClearPedTasksImmediately(GetPlayerPed(-1))
    TaskPlayAnim(pid,"anim@mp_player_intmenu@key_fob@","fob_click",100.0, 200.0, 0.3, 120, 0.2, 0, 0, 0)
    Wait(1500)
     ClearPedTasksImmediately(GetPlayerPed(-1))
    TaskPlayAnim(pid,"anim@mp_player_intmenu@key_fob@","fob_click",100.0, 200.0, 0.3, 120, 0.2, 0, 0, 0)
    Wait(1500)
     ClearPedTasksImmediately(GetPlayerPed(-1))
    TaskPlayAnim(pid,"anim@mp_player_intmenu@key_fob@","fob_click",100.0, 200.0, 0.3, 120, 0.2, 0, 0, 0)
    Wait(1500)
     ClearPedTasksImmediately(GetPlayerPed(-1))
    TaskPlayAnim(pid,"anim@mp_player_intmenu@key_fob@","fob_click",100.0, 200.0, 0.3, 120, 0.2, 0, 0, 0)
    Wait(1500)
     ClearPedTasksImmediately(GetPlayerPed(-1))
    TaskPlayAnim(pid,"anim@mp_player_intmenu@key_fob@","fob_click",100.0, 200.0, 0.3, 120, 0.2, 0, 0, 0)
    Wait(1500)
	 ClearPedTasksImmediately(GetPlayerPed(-1))
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