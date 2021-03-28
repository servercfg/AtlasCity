--[[
─────────────────────────────────────────────────────────────────────────────────────────────────────────
─██████──████████─██████████████─██████████████████─██████████████─██████████████─██████──────────██████─
─██░░██──██░░░░██─██░░░░░░░░░░██─██░░░░░░░░░░░░░░██─██░░░░░░░░░░██─██░░░░░░░░░░██─██░░██████████──██░░██─
─██░░██──██░░████─██░░██████░░██─████████████░░░░██─██░░██████░░██─██░░██████░░██─██░░░░░░░░░░██──██░░██─
─██░░██──██░░██───██░░██──██░░██─────────████░░████─██░░██──██░░██─██░░██──██░░██─██░░██████░░██──██░░██─
─██░░██████░░██───██░░██████░░██───────████░░████───██░░██──██░░██─██░░██──██░░██─██░░██──██░░██──██░░██─
─██░░░░░░░░░░██───██░░░░░░░░░░██─────████░░████─────██░░██──██░░██─██░░██──██░░██─██░░██──██░░██──██░░██─
─██░░██████░░██───██░░██████░░██───████░░████───────██░░██──██░░██─██░░██──██░░██─██░░██──██░░██──██░░██─
─██░░██──██░░██───██░░██──██░░██─████░░████─────────██░░██──██░░██─██░░██──██░░██─██░░██──██░░██████░░██─
─██░░██──██░░████─██░░██──██░░██─██░░░░████████████─██░░██████░░██─██░░██████░░██─██░░██──██░░░░░░░░░░██─
─██░░██──██░░░░██─██░░██──██░░██─██░░░░░░░░░░░░░░██─██░░░░░░░░░░██─██░░░░░░░░░░██─██░░██──██████████░░██─
─██████──████████─██████──██████─██████████████████─██████████████─██████████████─██████──────────██████─
─────────────────────────────────────────────────────────────────────────────────────────────────────────
]]--
holding = false

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "kaz_boombox")

Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
    ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

RegisterNetEvent('kaz_boombox:place_boombox')
AddEventHandler('kaz_boombox:place_boombox', function()
	if holding ~= true then 
        local boomModel = "prop_ghettoblast_02"
        local boomanimDict = "anim@heists@money_grab@briefcase"
        RequestModel(GetHashKey(boomModel))
        while not HasModelLoaded(GetHashKey(boomModel)) do
            Citizen.Wait(100)
        end
        
        while not HasAnimDictLoaded(boomanimDict) do
            RequestAnimDict(boomanimDict)
            Citizen.Wait(100)
        end
		TaskPlayAnim(PlayerPedId(), "anim@heists@money_grab@briefcase", "put_down_case", 8.0, -8.0, 1000, 1, 0, false, false, false)
		Citizen.Wait(1000)
        local plyCoords = GetOffsetFromEntityInWorldCoords(GetPlayerPed(PlayerId()), 0.0, 0.0, -1.0)
        local boomSpawned = CreateObject(GetHashKey(boomModel), plyCoords.x, plyCoords.y, plyCoords.z, 1, 1, 1)
        Citizen.Wait(1000)
        local netid = ObjToNet(boomSpawned)
        SetNetworkIdExistsOnAllMachines(netid, true)
        SetNetworkIdCanMigrate(netid, false)
		PlaceObjectOnGroundProperly(boomSpawned)
		Wait(100)
		FreezeEntityPosition(boomSpawned, true)
		SetEntityCollision(boomSpawned,true,false)
        holding = true
            while holding do 
            Citizen.Wait(0)
                local coords = GetEntityCoords(GetPlayerPed(PlayerId()), false)
				if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), plyCoords.x, plyCoords.y, plyCoords.z, true ) < 2 then
					DrawText3Ds(coords['x'], coords['y'], coords['z'], "[~g~E~w~] ~g~Spil~w~ [~y~H~w~]~y~ Volume ~w~[~r~G~w~] ~r~Sluk ~w~", 3.0, 7)
					local playerPed = PlayerPedId()
					local lCoords = GetEntityCoords(playerPed)
						if IsControlJustReleased(0, 58) then                
							TriggerServerEvent('kaz_boombox:remove_hifi', lCoords)
							TaskPlayAnim(PlayerPedId(), "anim@heists@money_grab@briefcase", "put_down_case", 8.0, -8.0, 1000, 1, 0, false, false, false)
							Citizen.Wait(1000)
							local netid = ObjToNet(boomSpawned)
							penis = netid
							ClearPedTasks(playerPed)
							DetachEntity(NetToObj(penis), 1, 1)
							DeleteEntity(NetToObj(penis))
							DeleteObject(NetToObj(penis))
							holding = false 
						end
						if IsControlJustReleased(0, 38) then    
						TriggerServerEvent('kaz_boombox:playnow', lCoords)
						end
						if IsControlJustReleased(0, 74) then    
						TriggerServerEvent('kaz_boombox:volumenow', lCoords)
						end
				elseif GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), plyCoords.x, plyCoords.y, plyCoords.z, true ) > 15 then 
					TriggerServerEvent('kaz_boombox:remove_hifi', plyCoords)
					local netid = ObjToNet(boomSpawned)
					penis = netid
					ClearPedTasks(playerPed)
					DetachEntity(NetToObj(penis), 1, 1)
					DeleteEntity(NetToObj(penis))
					DeleteObject(NetToObj(penis))
					holding = false 
				end
            end
	end
end)

RegisterNetEvent('kaz_boombox:animation')
AddEventHandler('kaz_boombox:animation', function()
		while not HasAnimDictLoaded("anim@heists@money_grab@briefcase") do
            RequestAnimDict("anim@heists@money_grab@briefcase")
            Citizen.Wait(100)
        end
TaskPlayAnim(PlayerPedId(), "anim@heists@money_grab@briefcase", "put_down_case", 8.0, -8.0, 1000, 1, 0, false, false, false)
end)

RegisterNetEvent('kaz_boombox:play_music')
AddEventHandler('kaz_boombox:play_music', function(id, object)
    if distance(object) < Config.distance then
        SendNUIMessage({
            transactionType = 'playSound',
            transactionData = id
        })
        Citizen.CreateThread(function()
            while true do
                Citizen.Wait(100)
                if distance(object) > Config.distance then
                    SendNUIMessage({
                        transactionType = 'stopSound'
                    })
                    break
                end
            end
        end)
    end
end)

RegisterNetEvent('kaz_boombox:stop_music')
AddEventHandler('kaz_boombox:stop_music', function(object)
    if distance(object) < Config.distance then
        SendNUIMessage({
            transactionType = 'stopSound'
        })
    end
end)

RegisterNetEvent('kaz_boombox:setVolume')
AddEventHandler('kaz_boombox:setVolume', function(volume, object)
    if distance(object) < Config.distance then
        SendNUIMessage({
            transactionType = 'volume',
            transactionData = volume
        })
    end
end)

function distance(object)
    local playerPed = PlayerPedId()
    local lCoords = GetEntityCoords(playerPed)
    local distance  = GetDistanceBetweenCoords(lCoords, object, true)
    return distance
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
  DrawRect(_x,_y+0.0125, 0.015+ factor/2, 0.03, 0, 0, 0, 68)
end