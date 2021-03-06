
-- HOLD WEAPON HOLSTER ANIMATION --

Citizen.CreateThread( function()
    while true do
        Citizen.Wait(0)
        local ped = PlayerPedId()
        if not IsEntityInWater(ped) then
            local weaponHash = GetHashKey("WEAPON_COMBATPISTOL")
            if DoesEntityExist( ped ) and not IsEntityDead( ped ) and not IsPedInAnyVehicle(PlayerPedId(), true) and HasPedGotWeapon(ped, weaponHash, false) then
                DisableControlAction( 0, 20, true ) -- INPUT_MULTIPLAYER_INFO (Z)
                if not IsPauseMenuActive() then
                    loadAnimDict( "reaction@intimidation@cop@unarmed" )
                    if IsDisabledControlJustReleased( 0, 20 ) then -- INPUT_MULTIPLAYER_INFO (Z)
                        ClearPedTasks(ped)
                        SetEnableHandcuffs(ped, false)
                        SetCurrentPedWeapon(ped, GetHashKey("WEAPON_UNARMED"), true)
                    else
                        if IsDisabledControlJustPressed( 0, 20 ) and HasPedGotWeapon(ped, weaponHash, false) then -- INPUT_MULTIPLAYER_INFO (Z)
                            --delProps(ped)
                            SetEnableHandcuffs(ped, true)
                            SetCurrentPedWeapon(ped, GetHashKey("WEAPON_UNARMED"), true)
                            TaskPlayAnim(ped, "reaction@intimidation@cop@unarmed", "intro", 8.0, 2.0, -1, 50, 2.0, 0, 0, 0 )
                        end
                        if IsEntityPlayingAnim(GetPlayerPed(PlayerId()), "reaction@intimidation@cop@unarmed", "intro", 3) then
                            DisableActions(ped)
                        end
                    end
                end
            end
        end
    end
end )

function DisableActions(ped)
    DisableControlAction(1, 140, true)
    DisableControlAction(1, 141, true)
    DisableControlAction(1, 142, true)
    DisableControlAction(1, 37, true) -- Disables INPUT_SELECT_WEAPON (TAB)
    DisablePlayerFiring(ped, true) -- Disable weapon firing
end

cfg = {}

cfg.WeaponList = {
    453432689, --WEAPON_PISTOL
    -1716589765, --WEAPON_PISTOL50
    -771403250, --WEAPON_HEAVYPISTOL
    -1076751822, --WEAPON_SNSPISTOL
	--1593441988, --WEAPON_COMBATPISTOL
	-538741184, --WEAPON_SWITCHBLADE
	1317494643, --WEAPON_HAMMER
	---1951375401, --WEAPON_FLASHLIGHT
    -1716189206, --WEAPON_KNIFE
    -1834847097, --WEAPON_DAGGER
}

cfg.PedAbleToWalkWhileSwapping = true
cfg.UnarmedHash = -1569615261
IsCloseToLastVehicle = false

Citizen.CreateThread(function()
    local animDict = 'reaction@intimidation@1h'
    local animIntroName = 'intro'
    local animOutroName = 'outro'
    local animFlag = 0

    RequestAnimDict(animDict)

    while not HasAnimDictLoaded(animDict) do
        Citizen.Wait(100)
    end

    local lastWeapon = nil

    while true do
        Citizen.Wait(0)
        if not IsPedInAnyVehicle(PlayerPedId(), true) then
            local vehicle   = GetPlayersLastVehicle()
            local vehcoords = GetEntityCoords(vehicle)
            local mycoords  = GetEntityCoords(PlayerPedId())
            local distance  = GetDistanceBetweenCoords(vehcoords.x, vehcoords.y, vehcoords.z, mycoords.x, mycoords.y, mycoords.z)
            if distance < 1 then
                IsCloseToLastVehicle = true
            else
                IsCloseToLastVehicle = false
            end
            if IsCloseToLastVehicle == false then
                if cfg.PedAbleToWalkWhileSwapping then
                    animFlag = 48
                else
                    animFlag = 0
                end

                for i=1, #cfg.WeaponList do
                    if lastWeapon ~= nil and lastWeapon ~= cfg.WeaponList[i] and GetSelectedPedWeapon(GetPlayerPed(-1)) == cfg.WeaponList[i] then
                        SetCurrentPedWeapon(GetPlayerPed(-1), cfg.UnarmedHash, true)
                        TaskPlayAnim(GetPlayerPed(-1), animDict, animIntroName, 8.0, -8.0, 2700, animFlag, 0.0, false, false, false)
                        BlockControls = true
                        Citizen.Wait(1000)
                        SetCurrentPedWeapon(GetPlayerPed(-1), cfg.WeaponList[i], true)
                        Citizen.Wait(1500)
                        BlockControls = false
                    end

                    if lastWeapon ~= nil and lastWeapon == cfg.WeaponList[i] and GetSelectedPedWeapon(GetPlayerPed(-1)) == cfg.UnarmedHash then
                        SetCurrentPedWeapon(GetPlayerPed(-1), cfg.WeaponList[i], true)
                        TaskPlayAnim(GetPlayerPed(-1), animDict, animOutroName, 8.0, -8.0, 2100, animFlag, 0.0, false, false, false)
                        BlockControls = true
                        Citizen.Wait(1000)
                        SetCurrentPedWeapon(GetPlayerPed(-1), cfg.UnarmedHash, true)
                        Citizen.Wait(1500)
                        BlockControls = false
                    end
                end
            end
            lastWeapon = GetSelectedPedWeapon(GetPlayerPed(-1))
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if BlockControls == true then
            DisableControlAction(1, 140, true)
            DisableControlAction(1, 141, true)
            DisableControlAction(1, 142, true)
            DisableControlAction(0, 21, true)
            DisableControlAction(1, 37, true) -- Disables INPUT_SELECT_WEAPON (TAB)
            DisablePlayerFiring(GetPlayerPed(-1), true) -- Disable weapon firing
        end
    end
end)