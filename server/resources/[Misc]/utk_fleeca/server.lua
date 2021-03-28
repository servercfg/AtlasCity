local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")

Doors = {
    ["F1"] = {{loc = vector3(312.93, -284.45, 54.16), h = 160.91, txtloc = vector3(312.93, -284.45, 54.16), obj = nil, locked = true}, {loc = vector3(310.93, -284.44, 54.16), txtloc = vector3(310.93, -284.44, 54.16), state = nil, locked = true}},
    ["F2"] = {{loc = vector3(148.76, -1045.89, 29.37), h = 158.54, txtloc = vector3(148.76, -1045.89, 29.37), obj = nil, locked = true}, {loc = vector3(146.61, -1046.02, 29.37), txtloc = vector3(146.61, -1046.02, 29.37), state = nil, locked = true}},
    ["F3"] = {{loc = vector3(-1209.66, -335.15, 37.78), h = 213.67, txtloc = vector3(-1209.66, -335.15, 37.78), obj = nil, locked = true}, {loc = vector3(-1211.07, -336.68, 37.78), txtloc = vector3(-1211.07, -336.68, 37.78), state = nil, locked = true}},
    ["F4"] = {{loc = vector3(-2957.26, 483.53, 15.70), h = 267.73, txtloc = vector3(-2957.26, 483.53, 15.70), obj = nil, locked = true}, {loc = vector3(-2956.68, 481.34, 15.70), txtloc = vector3(-2956.68, 481.34, 15.7), state = nil, locked = true}},
    ["F5"] = {{loc = vector3(-351.97, -55.18, 49.04), h = 159.79, txtloc = vector3(-351.97, -55.18, 49.04), obj = nil, locked = true}, {loc = vector3(-354.15, -55.11, 49.04), txtloc = vector3(-354.15, -55.11, 49.04), state = nil, locked = true}},
    ["F6"] = {{loc = vector3(1174.24, 2712.47, 38.09), h = 160.91, txtloc = vector3(1174.24, 2712.47, 38.09), obj = nil, locked = true}, {loc = vector3(1176.40, 2712.75, 38.09), txtloc = vector3(1176.40, 2712.75, 38.09), state = nil, locked = true}},
}

RegisterServerEvent("utk_fh:startcheck")
AddEventHandler("utk_fh:startcheck", function(bank)
    local _source = source
    local copcount = 0
    local Players = vRP.getUsers()

    for i = 1, #Players, 1 do
        local xPlayer = vRP.getUserId({Players[i]})

       --[[ if vRP.hasPermission({xPlayer, UTK.PolicePermission}) then
            copcount = copcount + 1
        end
    end[[]]
    local xPlayer = vRP.getUserId({_source})
    local item = vRP.getInventoryItemAmount({xPlayer,"id_card_f"})
    local cops = vRP.getUsersByPermission({UTK.PolicePermission})
    copcount = #cops


    if copcount >= UTK.mincops then
        if item >= 1 then
            if not UTK.Banks[bank].onaction == true then
                if (os.time() - UTK.cooldown) > UTK.Banks[bank].lastrobbed then
                    UTK.Banks[bank].onaction = true
                    vRP.tryGetInventoryItem({xPlayer,"id_card_f",1})
                    TriggerClientEvent("utk_fh:outcome", _source, true, bank)
                    --TriggerClientEvent("utk_fh:policenotify", -1, bank)
                else
                    TriggerClientEvent("utk_fh:outcome", _source, false, "Denne bank er fornyligt røvet. Du skal vente "..math.floor((UTK.cooldown - (os.time() - UTK.Banks[bank].lastrobbed)) / 60)..":"..math.fmod((UTK.cooldown - (os.time() - UTK.Banks[bank].lastrobbed)), 60))
                end
            else
                TriggerClientEvent("utk_fh:outcome", _source, false, "Denne bank bliver i øjeblikket røvet.")
            end
        else
            TriggerClientEvent("utk_fh:outcome", _source, false, "Du har ikke et nøglekort.")
        end
    else
        TriggerClientEvent("utk_fh:outcome", _source, false, "Der er ikke nok politi i byen.")
    end
end
end)

RegisterServerEvent("utk_fh:lootup")
AddEventHandler("utk_fh:lootup", function(var, var2)
    TriggerClientEvent("utk_fh:lootup_c", -1, var, var2)
end)

RegisterServerEvent("utk_fh:openDoor")
AddEventHandler("utk_fh:openDoor", function(coords, method)
    TriggerClientEvent("utk_fh:openDoor_c", -1, coords, method)
end)

RegisterServerEvent("utk_fh:toggleDoor")
AddEventHandler("utk_fh:toggleDoor", function(key, state)
    Doors[key][1].locked = state
    TriggerClientEvent("utk_fh:toggleDoor", -1, key, state)
end)

RegisterServerEvent("utk_fh:toggleVault")
AddEventHandler("utk_fh:toggleVault", function(key, state)
    Doors[key][2].locked = state
    TriggerClientEvent("utk_fh:toggleVault", -1, key, state)
end)

RegisterServerEvent("utk_fh:updateVaultState")
AddEventHandler("utk_fh:updateVaultState", function(key, state)
    Doors[key][2].state = state
end)

RegisterServerEvent("utk_fh:startLoot")
AddEventHandler("utk_fh:startLoot", function(data, name, players)
    local _source = source
    TriggerClientEvent("utk_fh:startLoot_c", _source, data, name)
end)

RegisterServerEvent("utk_fh:stopHeist")
AddEventHandler("utk_fh:stopHeist", function(name)
    TriggerClientEvent("utk_fh:stopHeist_c", -1, name)
end)

RegisterServerEvent("utk_fh:rewardCash")
AddEventHandler("utk_fh:rewardCash", function()
    local xPlayer = vRP.getUserId({source})
    local reward = math.random(UTK.mincash, UTK.maxcash)

    if UTK.black then
        vRP.giveInventoryItem({xPlayer,UTK.blackmoney, reward})
    else
        vRP.giveMoney({xPlayer,reward})
    end
end)

RegisterServerEvent("utk_fh:setCooldown")
AddEventHandler("utk_fh:setCooldown", function(name)
    UTK.Banks[name].lastrobbed = os.time()
    UTK.Banks[name].onaction = false
    TriggerClientEvent("utk_fh:resetDoorState", -1, name)
end)

UTKFleeca.RegisterServerCallback("utk_fh:getBanks", function(source, cb)
    cb(UTK.Banks, Doors)
end)

UTKFleeca.RegisterServerCallback("utk_fh:checkSecond", function(source, cb)
    local xPlayer = vRP.getUserId({source})
    local item = vRP.getInventoryItemAmount({xPlayer,"secure_card",1})

    if item >= 1 then
        vRP.tryGetInventoryItem({xPlayer,"secure_card",1})
        cb(true)
    else
        cb(false)
    end
end)

-- Cop System
RegisterServerEvent('utk_fh:CheckCop')
AddEventHandler('utk_fh:CheckCop', function()
	local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})
	if vRP.hasPermission({user_id,"police.service"}) then
		TriggerClientEvent('utk_oh:IsCop',user_id)
	else
		TriggerClientEvent('utk_oh:IsNOTCop',user_id)
	end
end)



RegisterServerEvent('olsen_fleeca:warn')
AddEventHandler('olsen_fleeca:warn', function(x,y,z)
	message = "Bank røveri i Fleeca bank. Tjek GPS!"
	TriggerEvent('dispatchpolice', x, y, z, message)
	TriggerClientEvent("pNotify:SendNotification", source,{text = "Alarmen er gået, politiet er informeret!", type = "error", queue = "global", timeout = 8000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
end)
