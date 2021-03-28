vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","olsen_fjernvaben")

Citizen.CreateThread(function ()
    while true do
        Citizen.Wait(1)
        local ply = GetPlayerPed(-1)
        local plyCoords = GetEntityCoords(ply, 0)
        for _, item in pairs(Config.Fjernvaben) do
        local distance = GetDistanceBetweenCoords(item.x, item.y, item.z,  plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
        if(distance <= 8) then
             DrawMarker(20, item.x,item.y,item.z-0.25, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 101, 153, 186, 100, false, true, 2, true, false, false, false)
                    if(distance <= 1) then
            DrawText3Ds(item.x, item.y, item.z, "Tryk ~c~[~b~E~c~] ~w~for at lægge dine våben ind i våbenskabet")
            if IsControlJustReleased(1, 38) then
            exports['ac_progressbar']:startUI(10000, "Lægger Våben...")
            FreezeEntityPosition(PlayerPedId(), true)
            local dict, anim = 'mini@repair', 'fixing_a_player'
	
            RequestAnimDict(dict)
            while not HasAnimDictLoaded(dict) do
                Citizen.Wait(0)
            end
        
            TaskPlayAnim(GetPlayerPed(-1), 'mini@repair', 'fixing_a_player', 8.0, -8, -1, 49, 0, 0, 0, 0)
            Citizen.Wait(10000)
            ClearPedTasksImmediately(GetPlayerPed(-1))
            TriggerServerEvent('olsen_fjernvaben:fjernvaben')
            FreezeEntityPosition(PlayerPedId(), false)
           end
          end
        end
        end
    end
end) 

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