local duffle = true -- do not use wip not working -- change if you dont want weapons out of a duffle-bag

local tafbw = true -- Text Above For Big Weapons - change if you dont want text above for the weapons you take out of the car 
local tafdb = true -- Text Above For Duffle-Bag -||-

local bwtxt = "Tager våben fra køretøjet"
local dbtxt = "Tager våben fra taske"
local dbtxterr = "Dette våben kan kun tages frem fra biler eller tasker"
local bwtxterr = "Dette våben kan kun tages frem fra en bil"
local swtxt = "* The person takes a weapon out. *"

-- list of weapons to be taken out of a car

bigweaponslist = {	
	"WEAPON_MICROSMG",
	"WEAPON_MINISMG",
	"WEAPON_SMG",
	"WEAPON_SMG_MK2",
	"WEAPON_ASSAULTSMG",
	"WEAPON_MG",
	"WEAPON_COMBATMG",
	"WEAPON_COMBATMG_MK2",
	"WEAPON_COMBATPDW",
	"WEAPON_GUSENBERG",
	"WEAPON_ASSAULTRIFLE",
	"WEAPON_ASSAULTRIFLE_MK2",
	"WEAPON_CARBINERIFLE",
	"WEAPON_CARBINERIFLE_MK2",
	"WEAPON_ADVANCEDRIFLE",
	"WEAPON_SPECIALCARBINE",
	"WEAPON_BULLPUPRIFLE",
	"WEAPON_COMPACTRIFLE",
	"WEAPON_PUMPSHOTGUN",
	"WEAPON_SWEEPERSHOTGUN",
	"WEAPON_SAWNOFFSHOTGUN",
	"WEAPON_BULLPUPSHOTGUN",
	"WEAPON_ASSAULTSHOTGUN",
	"WEAPON_MUSKET",
	"WEAPON_HEAVYSHOTGUN",
	"WEAPON_DBSHOTGUN",
	"WEAPON_SNIPERRIFLE",
	"WEAPON_HEAVYSNIPER",
	"WEAPON_HEAVYSNIPER_MK2",
	"WEAPON_MARKSMANRIFLE",
	"WEAPON_GRENADELAUNCHER",
	"WEAPON_GRENADELAUNCHER_SMOKE",
	"WEAPON_RPG",
	"WEAPON_MINIGUN",
	"WEAPON_FIREWORK",
	"WEAPON_RAILGUN",
	"WEAPON_HOMINGLAUNCHER",
	"WEAPON_COMPACTLAUNCHER",
	"WEAPON_SPECIALCARBINE_MK2",
	"WEAPON_BULLPUPRIFLE_MK2",
	"WEAPON_PUMPSHOTGUN_MK2",
	"WEAPON_MARKSMANRIFLE_MK2",
	"WEAPON_RAYPISTOL",
	"WEAPON_RAYCARBINE",
	"WEAPON_RAYMINIGUN",
	"WEAPON_DIGISCANNER"
}

local nbrDisplaying = 1


function Display(mePlayer, text, offset)
    local displaying = true

    -- Chat message
    if chatMessage then
        local coordsMe = GetEntityCoords(GetPlayerPed(mePlayer), false)
        local coords = GetEntityCoords(PlayerPedId(), false)
        local dist = Vdist2(coordsMe, coords)
        if dist < 2500 then
            TriggerEvent('chat:addMessage', {
                color = { color.r, color.g, color.b },
                multiline = true,
                args = { text}
            })
        end
    end

    Citizen.CreateThread(function()
        Wait(time*1000)
        displaying = false
    end)
    Citizen.CreateThread(function()
        nbrDisplaying = nbrDisplaying + 1
        print(nbrDisplaying)
        while displaying do
            Wait(0)
            local coordsMe = GetEntityCoords(GetPlayerPed(mePlayer), false)
            local coords = GetEntityCoords(PlayerPedId(), false)
            local dist = Vdist2(coordsMe, coords)
            if dist < 2500 then
                DrawText3D(coordsMe['x'], coordsMe['y'], coordsMe['z']+offset, text)
            end
        end
        nbrDisplaying = nbrDisplaying - 1
    end)
end


function DrawText3D(x,y,z, text)
    local onScreen,_x,_y = World3dToScreen2d(x,y,z)
    local px,py,pz = table.unpack(GetGameplayCamCoord())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 
    local scale = ((1/dist)*2)*(1/GetGameplayCamFov())*100

    if onScreen then

        -- Formalize the text
        SetTextColour(color.r, color.g, color.b, color.alpha)
        SetTextScale(0.0*scale, 0.55*scale)
        SetTextFont(font)
        SetTextProportional(1)
        SetTextCentre(true)
        if dropShadow then
            SetTextDropshadow(10, 100, 100, 100, 255)
        end

        -- Calculate width and height
        BeginTextCommandWidth("STRING")
        AddTextComponentString(text)
        local height = GetTextScaleHeight(0.55*scale, font)
        local width = EndTextCommandGetWidth(font)

        -- Diplay the text
        SetTextEntry("STRING")
        AddTextComponentString(text)
        EndTextCommandDisplayText(_x, _y)

        if background.enable then
            DrawRect(_x, _y+scale/45, width, height, background.color.r, background.color.g, background.color.b , background.color.alpha)
        end
    end
end

daw = false
bigWeaponOut = false

-- do not edit !!

Citizen.CreateThread(function()
	while true do
		Wait(250)

		playerPed = GetPlayerPed(-1)
		if playerPed then
			local weapon = GetSelectedPedWeapon(playerPed, true)
			local weapon2 = GetSelectedPedWeapon(playerPed, false)
			if daw == true then
				RemoveAllPedWeapons(playerPed, true)
			else
				if isWeaponBig(weapon) then
					local vehicle = VehicleInFront()
					if GetVehiclePedIsIn(playerPed, false) == 0 and DoesEntityExist(vehicle) and IsEntityAVehicle(vehicle) and bigWeaponOut == false then
						bigWeaponOut = true
						SetVehicleDoorOpen(vehicle, 5, false, false)
						if tafbw == true then
							local text = bwtxt
							TriggerServerEvent('3dme:shareDisplay', text)
						end
						Citizen.Wait(2000)
						SetVehicleDoorShut(vehicle, 5, false)
					else
						if duffle == true then
							if IsPedModel(playerPed,1885233650) and bigWeaponOut == false and GetVehiclePedIsIn(playerPed, false) == 0 then -- male
								--drawNotification("* " ..GetPedDrawableVariation(playerPed,5).. "," ..GetPedTextureVariation(playerPed,5).. "," ..GetPedPaletteVariation(playerPed,5).. " *")
								if GetPedDrawableVariation(playerPed,5) == 45 and GetPedTextureVariation(playerPed,5) == 0 and GetPedPaletteVariation(playerPed,5) == 0 then
								elseif GetPedDrawableVariation(playerPed,5) == 52 then
									bigWeaponOut = true
									if tafdb == true then
										local text = dbtxt
										TriggerServerEvent('3dme:shareDisplay', text)
									end
								else
									Wait(1)
									exports['mythic_notify']:DoHudText('error', '' .. dbtxterr .. '')
									SetCurrentPedWeapon(playerPed, -1569615261)
								end
							else	
								if IsPedModel(playerPed,-1667301416) and bigWeaponOut == false and GetVehiclePedIsIn(playerPed, false) == 0 then -- female
									--drawNotification("* " ..GetPedDrawableVariation(playerPed,5).. "," ..GetPedTextureVariation(playerPed,5).. "," ..GetPedPaletteVariation(playerPed,5).. " *")
									if GetPedDrawableVariation(playerPed,5) == 45 and GetPedTextureVariation(playerPed,5) == 0 and GetPedPaletteVariation(playerPed,5) == 0 then
									elseif GetPedDrawableVariation(playerPed,5) == 52 then
										bigWeaponOut = true
										if tafdb == true then
											local text = dbtxt
											TriggerServerEvent('3dme:shareDisplay', text)
										end
									else
										SetCurrentPedWeapon(playerPed, -1569615261)
									end
								else
									if bigWeaponOut == false and GetVehiclePedIsIn(playerPed, false) == 0 then
									Wait(1)
									exports['mythic_notify']:DoHudText('error', '' .. dbtxterr .. '')
									SetCurrentPedWeapon(playerPed, -1569615261)
									end
								end
							end
						else
							if bigWeaponOut == false and GetVehiclePedIsIn(playerPed, false) == 0 then
								Wait(1)
								exports['mythic_notify']:DoHudText('error', '' .. bwtxterr .. '')
								SetCurrentPedWeapon(playerPed, -1569615261)
							end
						end
					end
				end
			end
		end
	end
end)

-- do not edit !!

Citizen.CreateThread(function()
	while true do
		Wait(500)
		
		playerPed = GetPlayerPed(-1)
		if playerPed then
			local weapon = GetSelectedPedWeapon(playerPed, true)
			if not isWeaponBig(weapon) and bigWeaponOut == true then
				Wait(100)
				bigWeaponOut = false
			end
			--[[
			if IsPedModel(playerPed,1885233650) and bigWeaponOut == true then
				if GetPedDrawableVariation(playerPed,5) ~= 45 or GetPedTextureVariation(playerPed,5) ~= 0 or GetPedPaletteVariation(playerPed,5) ~= 0 then
					Wait(100)
					bigWeaponOut = false
				end
			end
			if IsPedModel(playerPed,-1667301416) and bigWeaponOut == true then
				if GetPedDrawableVariation(playerPed,5) ~= 45 or GetPedTextureVariation(playerPed,5) ~= 0 or GetPedPaletteVariation(playerPed,5) ~= 0 then
					Wait(100)
					bigWeaponOut = false
				end
			end
			]]--
		end
	end
end)

-- do not edit !!

function VehicleInFront()
	local player = PlayerPedId()
    local pos = GetEntityCoords(player)
    local entityWorld = GetOffsetFromEntityInWorldCoords(player, 0.0, 2.0, 0.0)
    local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 30, player, 0)
    local _, _, _, _, result = GetRaycastResult(rayHandle)
    return result
end

-- do not edit !!

function isWeaponBig(model)
	for _, bigWeapon in pairs(bigweaponslist) do
		if model == GetHashKey(bigWeapon) then
			return true
		end
	end

	return false
end