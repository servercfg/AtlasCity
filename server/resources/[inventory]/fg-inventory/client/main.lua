Keys = {
    ["ESC"] = 322,["F1"] = 288,["F2"] = 289,["F3"] = 170,["F5"] = 166,["F6"] = 167,["F7"] = 168,["F8"] = 169,["F9"] = 56,["~"] = 243,["1"] = 157,
	["2"] = 158,["3"] = 160,["4"] = 164,["5"] = 165,["6"] = 159,["7"] = 161,["8"] = 162,["9"] = 163,["-"] = 84,["="] = 83,["BACKSPACE"] = 177,
    ["TAB"] = 37,["Q"] = 44,["W"] = 32,["E"] = 38,["R"] = 45,["T"] = 245,["Y"] = 246,["U"] = 303,["P"] = 199,["["] = 39,["]"] = 40,["ENTER"] = 18,
	["CAPS"] = 137,["A"] = 34,["S"] = 8,["D"] = 9,["F"] = 23,["G"] = 47,["H"] = 74,["K"] = 311,["L"] = 182,["LEFTSHIFT"] = 21,["Z"] = 20,["X"] = 73,
	["C"] = 26,["V"] = 0,["B"] = 29,["N"] = 249,["M"] = 244,[","] = 82,["."] = 81,["LEFTCTRL"] = 36,["LEFTALT"] = 19,["SPACE"] = 22,["RIGHTCTRL"] = 70,
	["HOME"] = 213,["PAGEUP"] = 10,["PAGEDOWN"] = 11,["DELETE"] = 178,["LEFT"] = 174,["RIGHT"] = 175,["TOP"] = 27,["DOWN"] = 173,["NENTER"] = 201,
	["N4"] = 108,["N5"] = 60,["N6"] = 107,["N+"] = 96,["N-"] = 97,["N7"] = 117,["N8"] = 61,["N9"] = 118
}

isInInventory = false
--vRP = exports["vrp"]:getSharedObject()

vRP = Proxy.getInterface("vRP")

--[[Citizen.CreateThread(function()
    while true do
        if IsControlPressed(0, Config.OpenControl) then
            if not vRP.isInComa() and not vRP.isHandcuffed() then
                isPlyBehindVeh(function(data)
                    if data and vRP.getNearestOwnedVehicle(3) then
                        TriggerEvent("fg-inventory:openTrunkInventory")
                    else
                        openInventory()
                    end
                end)
            end
            while IsControlPressed(0, Config.OpenControl) do
                Citizen.Wait(0)
            end
        end
        Citizen.Wait(65)
    end
end)]]

Citizen.CreateThread(function()
    while true do
        if IsControlJustReleased(0, Config.OpenControl) then
            if not vRP.isInComa() and not vRP.isHandcuffed() then
                local ok, vtype, name = vRP.getNearestOwnedVehicle({3})
                isPlyBehindVeh(function(data)
                    if data and ok then
                        TriggerEvent("fg-inventory:openTrunkInventory")
                    else
                        openInventory()
                    end
                end)
            end
        end
        Citizen.Wait(0)
    end
end)

function openInventory()
    loadPlayerInventory()
    isInInventory = true
    SendNUIMessage(
        {
            action = "display",
            type = "normal"
        }
    )
    SetNuiFocus(true, true)
end


function closeInventory()
    SetTimecycleModifier('default')
    isInInventory = false
    SendNUIMessage(
        {
            action = "hide"
        }
    )
    SetNuiFocus(false, false)
end

function setWeight(weight, maxweight)
    SendNUIMessage({
        action = "setplyWeight", 
        text = "Vægt: " ..string.format("%.2f", weight).. " / "..string.format("%.2f", maxweight)
    })
end

RegisterNetEvent('fg-inventory:getWeight')
AddEventHandler('fg-inventory:getWeight', function(weight, maxweight)
    pweight = weight
    pmaxweight = maxweight
    setWeight(weight, maxweight)
end)

RegisterNUICallback("NUIFocusOff", function() closeInventory() end)

RegisterNUICallback("UseItem", function(data, cb)
    if type(data.number) == "number" and math.floor(data.number) == data.number then
        TriggerServerEvent('fg-inventory:server:useItem', data.item, tonumber(data.number))
        Citizen.Wait(0)
        loadPlayerInventory()

        cb("ok")
    end
end)

RegisterNUICallback("DropItem", function(data, cb)
    if type(data.number) == "number" and math.floor(data.number) == data.number then
        TriggerServerEvent('fg-inventory:dropItem', data.item, tonumber(data.number))
        Wait(0)
        loadPlayerInventory()
        cb("ok")
    end
end)

RegisterNUICallback("GiveItem", function(data, cb)
    if type(data.number) == "number" and math.floor(data.number) == data.number then
        TriggerServerEvent('fg-inventory:giveItem', data.item, tonumber(data.number))
        Wait(0)
        loadPlayerInventory()
        cb("ok")
    end
end)

function loadPlayerInventory()
    SetTimecycleModifier('hud_def_blur')
    vrpPV.TriggerServerCallback("fg-inventory:server:getPlayerInventory", function(data)
        local inventory = data.inventory
        local plyid = data.plyid
        local items = {}
        if inventory ~= nil then
            for _, item_v in pairs(inventory) do
                local usable = false
                local usableType = false
                if item_v.usableType ~= nil then
                    usable = true
                    usableType = item_v.usableType
                end
                items[#items + 1] = {
                    label = item_v.label,
                    name = item_v.name,
                    desc = item_v.desc,
                    limit = -1,
                    usable = usable,
                    usabletype = item_v.usableType,
                    choice = item_v.choice,
                    rare = 0,
                    canRemove = 1,
                    type = "item_standard",
                    count = item_v.amount,
                    weight = item_v.weight,
                    plyweight = item_v.plyweight,
                    plymaxweight = item_v.plymaxweight
                }
            end
        end
        SendNUIMessage({action = "setItems", itemList = items})
        SendNUIMessage({action = "setplyInfoText",text = "Inventar - "..plyid})
    end, GetPlayerServerId(PlayerId()))
end

function getQuantity(itemid)
    local p = promise.new()
    vrpPV.TriggerServerCallback("fg-inventory:getItem", function(data)
        p:resolve(data)
    end, itemid)
    return Citizen.Await(p)
end


function hasEnoughOfItem(itemid,amount)
    if itemid == nil or itemid == 0 or amount == nil or amount == 0 then return false end
    amount = tonumber(amount)

    if getQuantity(itemid) >= amount then
        return true
    end  

    return false
end

RegisterNUICallback("playsound", function(data)
    if (data) then
        PlaySoundFrontend(-1, data.name, "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
    end
end)

RegisterCommand('closeinv', function() 
    closeInventory() 
end)

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then 
        closeInventory() 
    end
end)

attachPropList = {

    ["crackpipe01"] = { 
        ["model"] = "prop_cs_crackpipe", ["bone"] = 28422, ["x"] = 0.0,["y"] = 0.05,["z"] = 0.0,["xR"] = 135.0,["yR"] = -100.0, ["zR"] = 0.0 
    },

    ["bong01"] = { 
        ["model"] = "prop_bong_01", ["bone"] = 18905, ["x"] = 0.11,["y"] = -0.23,["z"] = 0.01,["xR"] = -90.0,["yR"] = 0.0, ["zR"] = 0.0 
    },

    ["healthpack01"] = { 
        ["model"] = "prop_ld_health_pack", ["bone"] = 18905, ["x"] = 0.15,["y"] = 0.08,["z"] = 0.1,["xR"] = 180.0,["yR"] = 220.0, ["zR"] = 0.0 
    },

    ["briefcase01"] = { 
        ["model"] = "prop_ld_case_01", ["bone"] = 28422, ["x"] = 0.05,["y"] = 0.0,["z"] = 0.0,["xR"] = 135.0,["yR"] = -100.0, ["zR"] = 0.0 
    },

    ["prop_box_guncase_01a"] = { 
        ["model"] = "prop_box_guncase_01a", ["bone"] = 28422, ["x"] = 0.05,["y"] = 0.0,["z"] = 0.0,["xR"] = 135.0,["yR"] = -100.0, ["zR"] = 0.0 
    },

    ["cashcase3"] = { 
        ["model"] = "prop_cash_case_02", ["bone"] = 28422, ["x"] = -0.01,["y"] = -0.1,["z"] = -0.138,["xR"] = 0.0,["yR"] = 0.0, ["zR"] = 0.0 
    },

    ["con1"] = { 
        ["model"] = "prop_police_id_board", ["bone"] = 28422, ["x"] = 0,["y"] = 0,["z"] = 0.1,["xR"] = 0.0,["yR"] = 0.0, ["zR"] = 0.0 
    },

    ["EnginePart"] = { 
        ["model"] = "prop_cs_cardbox_01", ["bone"] = 28422, ["x"] = -0.01,["y"] = -0.1,["z"] = -0.138,["xR"] = 0.0,["yR"] = 0.0, ["zR"] = 0.0 
    },

    ["SuspensionPart"] = { 
        ["model"] = "prop_cs_cardbox_01", ["bone"] = 28422, ["x"] = -0.01,["y"] = -0.1,["z"] = -0.138,["xR"] = 0.0,["yR"] = 0.0, ["zR"] = 0.0 
    },

    ["DampenerPart"] = { 
        ["model"] = "prop_cs_cardbox_01", ["bone"] = 28422, ["x"] = -0.01,["y"] = -0.1,["z"] = -0.138,["xR"] = 0.0,["yR"] = 0.0, ["zR"] = 0.0 
    },

    ["TyrePart"] = { 
        ["model"] = "prop_cs_cardbox_01", ["bone"] = 28422, ["x"] = -0.01,["y"] = -0.1,["z"] = -0.138,["xR"] = 0.0,["yR"] = 0.0, ["zR"] = 0.0 
    },

    ["MetalPart"] = { 
        ["model"] = "prop_cs_cardbox_01", ["bone"] = 28422, ["x"] = -0.01,["y"] = -0.1,["z"] = -0.138,["xR"] = 0.0,["yR"] = 0.0, ["zR"] = 0.0 
    },

    ["AerodynamicsPart"] = { 
        ["model"] = "prop_cs_cardbox_01", ["bone"] = 28422, ["x"] = -0.01,["y"] = -0.1,["z"] = -0.138,["xR"] = 0.0,["yR"] = 0.0, ["zR"] = 0.0 
    },

    ["BrakingPart"] = { 
        ["model"] = "prop_cs_cardbox_01", ["bone"] = 28422, ["x"] = -0.01,["y"] = -0.1,["z"] = -0.138,["xR"] = 0.0,["yR"] = 0.0, ["zR"] = 0.0 
    },

    ["GearboxPart"] = { 
        ["model"] = "prop_cs_cardbox_01", ["bone"] = 28422, ["x"] = -0.01,["y"] = -0.1,["z"] = -0.138,["xR"] = 0.0,["yR"] = 0.0, ["zR"] = 0.0 
    },


    ["gunbox1"] = { 
        ["model"] = "prop_paper_bag_small", ["bone"] = 28422, ["x"] = 0.01,["y"] = 0.01,["z"] = 0.0,["xR"] = 0.0,["yR"] = 0.0, ["zR"] = 0.0 
    },

    ["drugtest02"] = { 
        ["model"] = "prop_mp_drug_pack_blue", ["bone"] = 28422, ["x"] = 0.01,["y"] = 0.01,["z"] = 0.0,["xR"] = 0.0,["yR"] = 0.0, ["zR"] = 0.0 
    },

    ["drugtest01"] = { 
        ["model"] = "prop_mp_drug_package", ["bone"] = 28422, ["x"] = 0.01,["y"] = 0.01,["z"] = 0.0,["xR"] = 0.0,["yR"] = 0.0, ["zR"] = 0.0 
    },

    ["cashcase01"] = { 
        ["model"] = "prop_paper_bag_small", ["bone"] = 28422, ["x"] = 0.05,["y"] = 0.0,["z"] = 0.0,["xR"] = 135.0,["yR"] = -100.0, ["zR"] = 0.0 
    },

    ["cashbag02"] = { 
        ["model"] = "prop_cs_heist_bag_01", ["bone"] = 28422, ["x"] = 0.05,["y"] = 0.0,["z"] = 0.0,["xR"] = 135.0,["yR"] = -100.0, ["zR"] = 0.0 
    },

    ["cashbag01"] = { 
        ["model"] = "prop_cs_heist_bag_01", ["bone"] = 24816, ["x"] = 0.15,["y"] = -0.4,["z"] = -0.38,["xR"] = 90.0,["yR"] = 0.0, ["zR"] = 0.0 
    },

    ["drugpackage01"] = { 
        ["model"] = "prop_meth_bag_01", ["bone"] = 28422, ["x"] = 0.1,["y"] = 0.0,["z"] = -0.01,["xR"] = 135.0,["yR"] = -100.0, ["zR"] = 40.0 
    },


    ["drugpackage02"] = { 
        ["model"] = "prop_weed_bottle", ["bone"] = 28422, ["x"] = 0.09,["y"] = 0.0,["z"] = -0.03,["xR"] = 135.0,["yR"] = -100.0, ["zR"] = 40.0 
    },





    ["bomb01"] = { 
        ["model"] = "prop_ld_bomb", ["bone"] = 28422, ["x"] = 0.22,["y"] = -0.01,["z"] = 0.0,["xR"] = -25.0,["yR"] = -100.0, ["zR"] = 0.0 
    },

    ["phone01"] = { 
        ["model"] = "prop_amb_phone", ["bone"] = 28422, ["x"] = 0.1,["y"] = 0.01,["z"] = 0.0,["xR"] = -255.0,["yR"] = -120.0, ["zR"] = 40.0 
    },

    ["money01"] = { 
        ["model"] = "prop_anim_cash_note", ["bone"] = 28422, ["x"] = 0.1,["y"] = 0.04,["z"] = 0.0,["xR"] = 25.0,["yR"] = 0.0, ["zR"] = 10.0 
    },

    ["armor01"] = { 
        ["model"] = "prop_armour_pickup", ["bone"] = 28422, ["x"] = 0.3,["y"] = 0.01,["z"] = 0.0,["xR"] = 255.0,["yR"] = -90.0, ["zR"] = 10.0 
    },

    ["terd01"] = { 
        ["model"] = "prop_big_shit_01", ["bone"] = 61839, ["x"] = 0.015,["y"] = 0.0,["z"] = -0.01,["xR"] = 3.0,["yR"] = -90.0, ["zR"] = 180.0 
    },

    ["boombox01"] = { 
        ["model"] = "prop_boombox_01", ["bone"] = 28422, ["x"] = 0.2,["y"] = 0.0,["z"] = 0.0,["xR"] = -35.0,["yR"] = -100.0, ["zR"] = 0.0 
    },

    ["bowlball01"] = { 
        ["model"] = "prop_bowling_ball", ["bone"] = 28422, ["x"] = 0.12,["y"] = 0.0,["z"] = 0.0,["xR"] = 75.0,["yR"] = 280.0, ["zR"] = -80.0 
    },

    ["bowlpin01"] = { 
        ["model"] = "prop_bowling_pin", ["bone"] = 28422, ["x"] = 0.12,["y"] = 0.0,["z"] = 0.0,["xR"] = 75.0,["yR"] = 280.0, ["zR"] = -80.0 
    },

    ["crate01"] = { 
        ["model"] = "hei_prop_heist_wooden_box", ["bone"] = 24816, ["x"] = 0.13,["y"] = 0.50,["z"] = 0.05,["xR"] = 45.0,["yR"] = 280.0, ["zR"] = -80.0 
    },

    ["tvcamera01"] = { 
        ["model"] = "prop_v_cam_01", ["bone"] = 57005, ["x"] = 0.13,["y"] = 0.25,["z"] = -0.03,["xR"] = -85.0,["yR"] = 0.0, ["zR"] = -80.0 
    },


        -- 18905 left hand - 57005 right hand
    ["tvmic01"] = { 
        ["model"] = "p_ing_microphonel_01", ["bone"] = 18905, ["x"] = 0.1,["y"] = 0.05,["z"] = 0.0,["xR"] = -85.0,["yR"] = -80.0, ["zR"] = -80.0 
    },

    ["golfbag01"] = { 
        ["model"] = "prop_golf_bag_01", ["bone"] = 24816, ["x"] = 0.12,["y"] = -0.3,["z"] = 0.0,["xR"] = -75.0,["yR"] = 190.0, ["zR"] = 92.0 
    },

    ["golfputter01"] = { 
        ["model"] = "prop_golf_putter_01", ["bone"] = 57005, ["x"] = 0.0,["y"] = -0.05,["z"] = 0.0,["xR"] = 90.0,["yR"] = -118.0, ["zR"] = 44.0 
    },

    ["golfiron01"] = { 
        ["model"] = "prop_golf_iron_01", ["bone"] = 57005, ["x"] = 0.125,["y"] = 0.04,["z"] = 0.0,["xR"] = 90.0,["yR"] = -118.0, ["zR"] = 44.0 
    },
    ["golfiron03"] = { 
        ["model"] = "prop_golf_iron_01", ["bone"] = 57005, ["x"] = 0.126,["y"] = 0.041,["z"] = 0.0,["xR"] = 90.0,["yR"] = -118.0, ["zR"] = 44.0 
    },
    ["golfiron05"] = { 
        ["model"] = "prop_golf_iron_01", ["bone"] = 57005, ["x"] = 0.127,["y"] = 0.042,["z"] = 0.0,["xR"] = 90.0,["yR"] = -118.0, ["zR"] = 44.0 
    },
    ["golfiron07"] = { 
        ["model"] = "prop_golf_iron_01", ["bone"] = 57005, ["x"] = 0.128,["y"] = 0.043,["z"] = 0.0,["xR"] = 90.0,["yR"] = -118.0, ["zR"] = 44.0 
    },      
    ["golfwedge01"] = { 
        ["model"] = "prop_golf_pitcher_01", ["bone"] = 57005, ["x"] = 0.17,["y"] = 0.04,["z"] = 0.0,["xR"] = 90.0,["yR"] = -118.0, ["zR"] = 44.0 
    },

    ["golfdriver01"] = { 
        ["model"] = "prop_golf_driver", ["bone"] = 57005, ["x"] = 0.14,["y"] = 0.00,["z"] = 0.0,["xR"] = 160.0,["yR"] = -60.0, ["zR"] = 10.0 
    }
    
}

function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end

attachedProp = 0
function removeAttachedProp()
    DeleteEntity(attachedProp)
    attachedProp = 0
end

RegisterNetEvent('attachPropDrugsObjectnoanim')
AddEventHandler('attachPropDrugsObjectnoanim', function(attachModelSent,boneNumberSent,x,y,z,xR,yR,zR)
    removeAttachedProp()

    attachModel = GetHashKey(attachModelSent)
    boneNumber = boneNumberSent
    SetCurrentPedWeapon(PlayerPedId(), 0xA2719263) 
    local bone = GetPedBoneIndex(PlayerPedId(), boneNumberSent)
    --local x,y,z = table.unpack(GetEntityCoords(PlayerPedId(), true))
    RequestModel(attachModel)
    while not HasModelLoaded(attachModel) do
        Citizen.Wait(100)
    end
    attachedProp = CreateObject(attachModel, 1.0, 1.0, 1.0, 1, 1, 0)
    AttachEntityToEntity(attachedProp, PlayerPedId(), bone, x, y, z, xR, yR, zR, 1, 1, 0, 0, 2, 1)
    Citizen.Wait(5000)
    removeAttachedProp()
end)

RegisterNetEvent('attachItemObjectnoanim')
AddEventHandler('attachItemObjectnoanim', function(item)
    TriggerEvent("attachPropDrugsObjectnoanim",attachPropList[item]["model"], attachPropList[item]["bone"], attachPropList[item]["x"], attachPropList[item]["y"], attachPropList[item]["z"], attachPropList[item]["xR"], attachPropList[item]["yR"], attachPropList[item]["zR"])
end)

function TaskItem(dictionary,animation,typeAnim,timer,message)
    if timer == nil then 
        timer = 0 
    end
    loadAnimDict( dictionary ) 
    TaskPlayAnim( PlayerPedId(), dictionary, animation, 8.0, 1.0, -1, typeAnim, 0, 0, 0, 0 )
    local timer = tonumber(timer)
    if timer > 0 then
        exports["np-taskbar"]:taskBar(timer,message,true)
    end
end

function isPlyBehindVeh(cb)
    local coordA = GetEntityCoords(GetPlayerPed(-1), 1)
    local coordB = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 100.0, 0.0)
    local targetVehicle = getVehicleInDirection(coordA, coordB)
    local entityCreatePoint = GetOffsetFromEntityInWorldCoords(targetVehicle, 0.0, -4.0, 0.0)
    local coords = GetEntityCoords(GetPlayerPed(-1))
    local aDist = GetDistanceBetweenCoords(coords["x"], coords["y"],coords["z"], entityCreatePoint["x"], entityCreatePoint["y"],entityCreatePoint["z"])
    cb(aDist < 2.0)
end

function getVehicleInDirection(coordFrom, coordTo)
    local offset = 0
    local rayHandle
    local vehicle

    for i = 0, 100 do
        rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z + offset, 10, PlayerPedId(), 0)   
        a, b, c, d, vehicle = GetRaycastResult(rayHandle)
        
        offset = offset - 1

        if vehicle ~= 0 then break end
    end
    
    local distance = Vdist2(coordFrom, GetEntityCoords(vehicle))
    
    if distance > 25 then vehicle = nil end

    return vehicle ~= nil and vehicle or 0
end

Citizen.CreateThread(function() while true do Citizen.Wait(30000) collectgarbage() end end)