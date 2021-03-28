local lastTackleTime = 0
local isPolice = false
local tackleLib, tackleAnim, tackleVictimAnim = 'missmic2ig_11', 'mic_2_ig_11_intro_goon', 'mic_2_ig_11_intro_p_one'
local isTackling, isGettingTackled, isRagdoll = false, false, false

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10)
        
        if IsControlPressed(1, 21) and IsControlJustPressed(1, 311) and not isTackling and not IsPedInAnyVehicle(GetPlayerPed(-1), false) and GetGameTimer() - lastTackleTime > 10 * 1000 then
                Citizen.Wait(10)
                TriggerServerEvent('kaos:tryTackle')
            end
        end
    end)

    function loadAnimDict(dict)
        RequestAnimDict(dict)
        while not HasAnimDictLoaded(dict) do
            Citizen.Wait(10)
        end
    end

        Citizen.CreateThread(function()
            loadAnimDict(tackleLib)
            while true do
                Citizen.Wait(0)
        
                if isRagdoll then
                    SetPedToRagdoll(GetPlayerPed(-1), 1000, 1000, 0, 0, 0, 0)
                end
            end
        end)
        

        RegisterNetEvent('kaos:getTackled')
        AddEventHandler('kaos:getTackled', function(target)
            loadAnimDict(tackleLib)
            isGettingTackled = true
        
            local playerPed, targetPed = GetPlayerPed(-1), GetPlayerPed(GetPlayerFromServerId(target))
        
            AttachEntityToEntity(GetPlayerPed(-1), targetPed, 11816, 0.25, 0.5, 0.0, 0.5, 0.5, 180.0, false, false, false, false, 2, false)
            TaskPlayAnim(playerPed, tackleLib, tackleVictimAnim, 8.0, -8.0, 3000, 0, 0, false, false, false)
        
            Citizen.Wait(3000)
        
            DetachEntity(playerPed, true, false)
        
            isRagdoll = true
            Citizen.Wait(3000)
            isRagdoll = false
        
            isGettingTackled = false
        end)
        
        RegisterNetEvent('kaos:playTackle')
        AddEventHandler('kaos:playTackle', function()
            loadAnimDict(tackleLib)
            local playerPed = GetPlayerPed(-1)
        
            TaskPlayAnim(playerPed, tackleLib, tackleAnim, 8.0, -8.0, 3000, 0, 0, false, false, false)
        
            Citizen.Wait(3000)
        
            isTackling = false
        end)
    