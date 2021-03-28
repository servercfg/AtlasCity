local toghud = true
local isTokovoip = false
local delay = 350

RegisterCommand('hud', function(source, args, rawCommand)
    if toghud then 
        toghud = false
    else
        toghud = true
    end
end)

RegisterNetEvent('hud:toggleui')
AddEventHandler('hud:toggleui', function(show)
    if show == true then
        toghud = true
    else
        toghud = false
    end
end)

Citizen.CreateThread(function()
    while true do
        if toghud == true then
            if (not IsPedInAnyVehicle(PlayerPedId(), false) )then
                DisplayRadar(0)
            else
                DisplayRadar(1)
            end
        else
            DisplayRadar(0)
        end 
        TriggerServerEvent("ac:dataUI")
        delay = 800
        Citizen.Wait(delay)
    end
end)

--[[Citizen.CreateThread(function()
    local minimap = RequestScaleformMovie("minimap")
    SetRadarBigmapEnabled(true, false)
    delay = 1
    Wait(delay)
    SetRadarBigmapEnabled(false, false)
        while true do
            delay = 3
             Wait(delay)
            Citizen.InvokeNative(0xF6E48914C7A8694E, minimap, "SETUP_HEALTH_ARMOUR")
            Citizen.InvokeNative(0xC3D0841A0CC546A6,3)
            Citizen.InvokeNative(0xC6796A8FFA375E53 )
        end
    end)--]]

Citizen.CreateThread(function()
    while true do
        delay = 3
        Citizen.Wait(delay)

    local player = PlayerPedId()
    local health = (GetEntityHealth(player) - 100)
    local armor = GetPedArmour(player)
    local stamina = 100 - GetPlayerSprintStaminaRemaining(PlayerId()) -- GetPlayerUnderwaterTimeRemaining(PlayerId()) * 4

        SendNUIMessage({
            action = 'updateStatusHud',
            show = toghud,
            health = health,
            armour = armor,
            stamina = stamina,
            oxygen = 4.45 * (GetPlayerUnderwaterTimeRemaining(PlayerId())),
        })
        delay = 500
        Citizen.Wait(delay)
    end
end)

--[[Citizen.CreateThread(function()
    while true do
        Citizen.Wait(100)
        if isTokovoip then
            SendNUIMessage({
                action = 'voice-color',
                isTalking = exports.tokovoip_script:getPlayerData(GetPlayerServerId(PlayerId()), 'voip:talking')
            })
        else
            SendNUIMessage({
                action = 'voice-color',
                isTalking = NetworkIsPlayerTalking(PlayerId())
            })
        end
    end
end)
--[[
Citizen.CreateThread(function()
    local currLevel = 1
    while true do
        Citizen.Wait(0)
        if IsControlJustReleased(1, 20) then
            if isTokovoip == true then
                currLevel =  exports.tokovoip_script:getPlayerData(GetPlayerServerId(PlayerId()), 'voip:mode')
                if currLevel == 1 then
                    SendNUIMessage({
                        action = 'set-voice',
                        value = 66
                    })
                elseif currLevel == 2 then
                    SendNUIMessage({
                        action = 'set-voice',
                        value = 33
                    })
                elseif currLevel == 3 then
                    SendNUIMessage({
                        action = 'set-voice',
                        value = 100
                    })
                end
            else
                currLevel = (currLevel + 1) % 3
                if currLevel == 0 then
                    SendNUIMessage({
                        action = 'set-voice',
                        value = 66
                    })
                elseif currLevel == 1 then
                    SendNUIMessage({
                        action = 'set-voice',
                        value = 100
                    })
                elseif currLevel == 2 then
                    SendNUIMessage({
                        action = 'set-voice',
                        value = 33
                    })
                end
            end
        end
    end
end)]]

RegisterNetEvent("ac_givData")
AddEventHandler("ac_givData", function (Hunger, Thirst)
    Hunger = tonumber(100-Hunger)
    Thirst = tonumber(100-Thirst)
    SendNUIMessage({
        action = "updateStatusHud",
        show = toghud,
        hunger = Hunger,
        thirst = Thirst,
    })
end)

