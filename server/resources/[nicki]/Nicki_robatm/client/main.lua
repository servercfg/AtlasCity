--          _____                    _____                    _____                    _____                    _____          
--         /\    \                  /\    \                  /\    \                  /\    \                  /\    \         
--        /::\____\                /::\    \                /::\    \                /::\____\                /::\    \        
--       /::::|   |                \:::\    \              /::::\    \              /:::/    /                \:::\    \       
--      /:::::|   |                 \:::\    \            /::::::\    \            /:::/    /                  \:::\    \      
--     /::::::|   |                  \:::\    \          /:::/\:::\    \          /:::/    /                    \:::\    \     
--    /:::/|::|   |                   \:::\    \        /:::/  \:::\    \        /:::/____/                      \:::\    \    
--   /:::/ |::|   |                   /::::\    \      /:::/    \:::\    \      /::::\    \                      /::::\    \   
--  /:::/  |::|   | _____    ____    /::::::\    \    /:::/    / \:::\    \    /::::::\____\________    ____    /::::::\    \  
-- /:::/   |::|   |/\    \  /\   \  /:::/\:::\    \  /:::/    /   \:::\    \  /:::/\:::::::::::\    \  /\   \  /:::/\:::\    \ 
--/:: /    |::|   /::\____\/::\   \/:::/  \:::\____\/:::/____/     \:::\____\/:::/  |:::::::::::\____\/::\   \/:::/  \:::\____\
--\::/    /|::|  /:::/    /\:::\  /:::/    \::/    /\:::\    \      \::/    /\::/   |::|~~~|~~~~~     \:::\  /:::/    \::/    /
-- \/____/ |::| /:::/    /  \:::\/:::/    / \/____/  \:::\    \      \/____/  \/____|::|   |           \:::\/:::/    / \/____/ 
--         |::|/:::/    /    \::::::/    /            \:::\    \                    |::|   |            \::::::/    /          
--         |::::::/    /      \::::/____/              \:::\    \                   |::|   |             \::::/____/           
--         |:::::/    /        \:::\    \               \:::\    \                  |::|   |              \:::\    \           
--         |::::/    /          \:::\    \               \:::\    \                 |::|   |               \:::\    \          
--         /:::/    /            \:::\    \               \:::\    \                |::|   |                \:::\    \         
--        /:::/    /              \:::\____\               \:::\____\               \::|   |                 \:::\____\        
--        \::/    /                \::/    /                \::/    /                \:|   |                  \::/    /        
--         \/____/                  \/____/                  \/____/                  \|___|                   \/____/        

function LocalPed()
    return GetPlayerPed(-1)
end

local clientCooldown = false

Citizen.CreateThread(function ()
    while true do
        Citizen.Wait(0)
        if clientCooldown then
            Citizen.Wait(150000)
            clientCooldown = false
        end 
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
                local playerCoords = GetEntityCoords(LocalPed())
                local ped = GetPlayerPed(-1)
                local pos = GetEntityCoords(PlayerPedId())
                for k,v in pairs(config.atm) do
                    if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, v.x, v.y, v.z, true ) < 2 then
                        if clientCooldown then
                        TriggerEvent("cooldown")
                        DrawText3Ds(v.x,v.y,v.z, "~r~Cooldown (15 minutter)", 3.0, 7)
                        else
                        DrawText3Ds(v.x,v.y,v.z, "Tryk ~g~[K]~s~ for at røve ~y~Hæveautomaten~s~ ", 3.0, 7)
                        if IsControlJustPressed(1, 311) then
							TriggerServerEvent("Nicki_robatm:CheckItem")
                                    end
                                end
                            end
                        end
                    end
                end)

RegisterNetEvent('Nicki_robatm:StartHack')
AddEventHandler('Nicki_robatm:StartHack', function()
	local ped = PlayerPedId()
	local playerPos = GetEntityCoords(player)
	local animDict = "random@atmrobberygen@male"
	local animName = "idle_a"
	
	RequestAnimDict(animDict)
	while not HasAnimDictLoaded(animDict) do
		Citizen.Wait(0)
	end
	
	exports['ac_progressbar']:startUI(12000, "TILSLUTTER ENHED")
	FreezeEntityPosition(PlayerPedId(), true)
	TaskPlayAnim(PlayerPedId(),animDict,animName,3.0,0.5,-1,31,1.0,0,0)
	Citizen.Wait(7500)
	TaskStartScenarioInPlace(PlayerPedId(), 'WORLD_HUMAN_STAND_MOBILE', 0, true)
	Citizen.Wait(4500)
	TriggerEvent("mhacking:show")
	TriggerEvent("mhacking:start",4,25,mycb)
	chance = math.random(1,5)
	if chance == 1 then 
		local plyPos = GetEntityCoords(GetPlayerPed(-1))
	TriggerServerEvent("olsen_robatm:warn", plyPos.x, plyPos.y, plyPos.z)
	exports['mythic_notify']:SendAlert('inform', 'Du er tilsluttet Hæveautomaten, Find de rigtige koder.', 5000)
	clientCooldown = true
	end
end)

function mycb(success, timeremaining)
	if success then
		local ped = PlayerPedId()
		print('Hacking Gennemført.')
		exports['mythic_notify']:SendAlert('success', 'Du gennemførte ATM Hack.')
		TriggerEvent('mhacking:hide')
		TriggerServerEvent("Nicki_robatm:Reward")
		ClearPedTasks(PlayerPedId())
		FreezeEntityPosition(PlayerPedId(), false)
	else
		print('Hacking Fejlet')
		exports['mythic_notify']:SendAlert('error', 'Du fejlede.', 15000)
		TriggerEvent('mhacking:hide')
		ClearPedTasks(PlayerPedId())
		FreezeEntityPosition(PlayerPedId(), false)
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
