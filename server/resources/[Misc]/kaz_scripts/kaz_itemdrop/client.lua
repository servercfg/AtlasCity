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
taske = false

local props = {
    ["wbody|WEAPON_PISTOL_MK2"]={prop='w_pi_pistol', rot=90.0},
    ["wbody|WEAPON_SNSPISTOL"]={prop='w_pi_sns_pistol', rot=90.0},
    ["wbody|WEAPON_REVOLVER"]={prop='w_pi_heavypistol', rot=90.0},
    ["wbody|WEAPON_PISTOL50"]={prop='w_pi_pistol50', rot=90.0},

    ["wbody|WEAPON_BAT"]={prop='w_me_bat', rot=90.0},
    ["wbody|WEAPON_KNIFE"]={prop='w_me_knife_01', rot=90.0},
    ["wbody|WEAPON_SWITCHBLADE"]={prop='w_me_knife_01', rot=90.0},
    ["wbody|WEAPON_CROWBAR"]={prop='w_me_crowbar', rot=90.0},
    ["wbody|WEAPON_GOLFCLUB"]={prop='w_me_gclub', rot=90.0},
    ["wbody|WEAPON_HAMMER"]={prop='w_me_hammer', rot=90.0},
    ["wbody|WEAPON_WRENCH"]={prop='prop_tool_wrench', rot=90.0},
    ["wbody|WEAPON_FLASHLIGHT"]={prop='w_at_ar_supp_02', rot=90.0},
    ["wbody|WEAPON_POOLCUE"]={prop='prop_pool_cue', rot=90.0},
    ["wbody|WEAPON_PETROLCAN"]={prop='w_am_jerrycan', rot=90.0},
    ["wbody|WEAPON_BALL"]={prop='prop_tennis_ball', rot=90.0},
    ["wbody|WEAPON_BATTLEAXE"]={prop='prop_ld_fireaxe', rot=90.0},
	["boombox"]={prop='prop_boombox_01', rot=270.0},
	["rosekaz"]={prop='prop_single_rose', rot=270.0},


    ["dirty_money"]={prop='prop_cash_case_01', rot=0.0,size={[1]='prop_anim_cash_note_b',[10000]='prop_anim_cash_pile_01',[50000]="prop_anim_cash_pile_02",[100000]='prop_cash_case_01'}},
    ["default"]={prop='prop_med_bag_01b', rot=0.0}
}

local bags = {}

RegisterNetEvent('kaz_itemdrop:load')
AddEventHandler('kaz_itemdrop:load', function(list)
    bags = list
    for k,v in pairs(list) do
        TriggerEvent('kaz_itemdrop:create',v,k)
    end
end)

RegisterNetEvent('kaz_itemdrop:create')
AddEventHandler('kaz_itemdrop:create', function(bag,count)
    bags[count] = bag
    local prop = getProp(bag.item)
    local hash = GetHashKey(prop.prop)
    if prop.size ~= nil then
        hash = getHighestProp(prop.size,bag.amount)
    else
        hash = GetHashKey(prop.prop)
    end
    RequestModel(hash)
    while not HasModelLoaded(hash) do
        Citizen.Wait(10)
    end
    local propspawned = CreateObject(hash, bag.coords.x, bag.coords.y, bag.coords.z, false, true, true)
    PlaceObjectOnGroundProperly(propspawned)
    SetEntityRotation(propspawned, prop.rot)
    Wait(100)
    FreezeEntityPosition(propspawned, true)
    SetEntityCollision(propspawned,false,false)
    bags[count].propspawned = propspawned
end)

RegisterNetEvent('kaz_itemdrop:update')
AddEventHandler('kaz_itemdrop:update', function(count,bag)
    bags[count] = bag
end)

RegisterNetEvent('kaz_itemdrop:remove')
AddEventHandler('kaz_itemdrop:remove', function(count)
    if bags[count].propspawned ~= nil then
        DeleteObject(bags[count].propspawned)
    end
    bags[count] = nil
end)

function getHighestProp(size, amount)
    local prop = size[1]
    local last = 0
    for k,v in pairs(size) do
        if tonumber(k) <= amount and tonumber(k) > last then
            last = tonumber(k)
            prop=v
        end
    end
    return GetHashKey(prop)
end

function getProp(item)
    for k,v in pairs(props) do
        if k == item then
            return props[k]
        end
    end
    return props["default"]
end

function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 0, 0, 0, 80)
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        if next(bags) == nil then
            Citizen.Wait(1000)
        end
        local lcoords = GetEntityCoords(PlayerPedId())
        local closeby = false
        for k,v in pairs(bags) do
            local distance = GetDistanceBetweenCoords(lcoords["x"],lcoords["y"],lcoords["z"], v.coords.x, v.coords.y, v.coords.z, true)
            if distance <= 2.0 then
                closeby = true
                DrawText3Ds(v.coords.x, v.coords.y, v.coords.z-0.65, "Tryk ~g~E~w~ for at samle ~b~"..v.amount.." "..v.display.."~w~ op")
                if IsControlJustPressed(0, 38) then

                    TriggerServerEvent("kaz_itemdrop:pickup",k)
                end
            end
        end
        if closeby == false then
            Citizen.Wait(1000)
        end
    end
end)


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10000)
		TriggerServerEvent('kaz_itemdrop:checkweight')
	end
end)

RegisterNetEvent('kaz_itemdrop:updatetaske')
AddEventHandler('kaz_itemdrop:updatetaske', function(boolean)
	if taske == false then 
		if boolean == true then 
        SetPedComponentVariation(GetPlayerPed(-1), 5, 41, 0, 0)
		taske = true 
		end
	else 
		if boolean == false then 
		SetPedComponentVariation(GetPlayerPed(-1), 5, 0, 0, 0)
		taske = false
		end
	end
end)
