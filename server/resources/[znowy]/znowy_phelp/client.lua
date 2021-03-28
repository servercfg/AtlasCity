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
vRPclient = Tunnel.getInterface("vRP","znowy_phelp")

function LocalPed()
    return GetPlayerPed(-1)
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        local ply = GetPlayerPed(-1)
        local plyCoords = GetEntityCoords(ply, 0)
        for _, item in pairs(Config.Open) do
        local distance = GetDistanceBetweenCoords(item.x, item.y, item.z,  plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
        if(distance <= 10) then
            DrawMarker(20, item.x,item.y,item.z-0.25, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 101, 153, 186, 100, false, true, 2, true, false, false, false)
            if(distance <= 1) then
            DrawText3Ds(item.x, item.y, item.z, "Tryk ~c~[~b~ENTER~c~] ~w~for åbne politiservicerings menu")
            if IsControlJustReleased(1, 191) then
            TriggerServerEvent("znowy_phelp:start")
          end
        end
    end
      end
    end
end)



-------------------------------------------------
--                     UI                      --
-------------------------------------------------

RegisterNetEvent("znowy:OpenUIMenu")
AddEventHandler("znowy:OpenUIMenu", function()
    SetNuiFocus(true, true)
    Citizen.Wait(100)
    SendNUIMessage({
        type = "openUIMenu",
    })
end)

RegisterNUICallback("CloseMenu", function(data, callback)
    SetNuiFocus(false, false)
    callback("ok")
end)

RegisterNUICallback("Choose1", function(data, callback)
    SetNuiFocus(false, false)
    callback("ok")
    TriggerEvent("znowy_wash:wash")
end)

RegisterNUICallback("Choose2", function(data, callback)
    SetNuiFocus(false, false)
    callback("ok")
    TriggerEvent("znowy_repair:repair")
end)

RegisterNUICallback("Choose3", function(data, callback)
    SetNuiFocus(false, false)
    callback("ok")
    exports['ac_progressbar']:startUI(5000, "Farver køretøj")
    Citizen.Wait(5000)
    local playerPed = GetPlayerPed(-1)
    local vehicle = GetVehiclePedIsIn(playerPed)
    SetVehicleColours(vehicle, 12, 12)
end)

RegisterNUICallback("Choose4", function(data, callback)
    SetNuiFocus(false, false)
    callback("ok")
    exports['ac_progressbar']:startUI(5000, "Farver køretøj")
    Citizen.Wait(5000)
    local playerPed = GetPlayerPed(-1)
    local vehicle = GetVehiclePedIsIn(playerPed)
    SetVehicleColours(vehicle, 131, 131)
end)

RegisterNUICallback("Choose5", function(data, callback)
    SetNuiFocus(false, false)
    callback("ok")
    exports['ac_progressbar']:startUI(5000, "Farver køretøj")
    Citizen.Wait(5000)
    local playerPed = GetPlayerPed(-1)
    local vehicle = GetVehiclePedIsIn(playerPed)
    SetVehicleColours(vehicle, 27, 27)
end)

RegisterNUICallback("Choose6", function(data, callback)
    SetNuiFocus(false, false)
    callback("ok")
    exports['ac_progressbar']:startUI(5000, "Farver køretøj")
    Citizen.Wait(5000)
    local playerPed = GetPlayerPed(-1)
    local vehicle = GetVehiclePedIsIn(playerPed)
    SetVehicleColours(vehicle, 83, 83)
end)

RegisterNUICallback("Choose7", function(data, callback)
    SetNuiFocus(false, false)
    callback("ok")
    exports['ac_progressbar']:startUI(5000, "Farver køretøj")
    Citizen.Wait(5000)
    local playerPed = GetPlayerPed(-1)
    local vehicle = GetVehiclePedIsIn(playerPed)
    SetVehicleColours(vehicle, 13, 13)
end)

RegisterNUICallback("Choose8", function(data, callback)
    SetNuiFocus(false, false)
    callback("ok")
    exports['ac_progressbar']:startUI(5000, "Farver køretøj")
    Citizen.Wait(5000)
    local playerPed = GetPlayerPed(-1)
    local vehicle = GetVehiclePedIsIn(playerPed)
    SetVehicleColours(vehicle, 128, 128)
end)

RegisterNUICallback("Choose9", function(data, callback)
    SetNuiFocus(false, false)
    callback("ok")
    exports['ac_progressbar']:startUI(5000, "Farver køretøj")
    Citizen.Wait(5000)
    local playerPed = GetPlayerPed(-1)
    local vehicle = GetVehiclePedIsIn(playerPed)
    SetVehicleColours(vehicle, 42, 42)
end)

-------------------------------------------------
--                   EVENTS                    --
-------------------------------------------------

RegisterNetEvent("znowy_repair:repair")
AddEventHandler("znowy_repair:repair", function()
    vehicle = GetVehiclePedIsIn(LocalPed())
    exports['ac_progressbar']:startUI(5000, "Reparere dit køretøj...")
    FreezeEntityPosition(vehicle, true)
    Citizen.Wait(5000)
    SetEntityAsMissionEntity(vehicle, true, true)
    SetVehicleBodyHealth(vehicle, 9999)
    SetVehicleFixed(vehicle)
    FreezeEntityPosition(vehicle, false)
    exports['mythic_notify']:DoHudText('inform', 'Køretøj repareret', 9000)
end)

RegisterNetEvent('znowy_wash:wash')
AddEventHandler('znowy_wash:wash', function()
      vehicle = GetVehiclePedIsIn(LocalPed())
      exports['ac_progressbar']:startUI(5000, "Vasker køretøj...")
      FreezeEntityPosition(vehicle, true)
      Citizen.Wait(5000)
      SetVehicleDirtLevel(GetVehiclePedIsIn(GetPlayerPed(-1),false), 0.0)
      SetVehicleUndriveable(GetVehiclePedIsIn(GetPlayerPed(-1),false), false)
      exports['mythic_notify']:DoHudText('inform', 'Køretøj vasket', 9000)
      FreezeEntityPosition(vehicle, false)
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