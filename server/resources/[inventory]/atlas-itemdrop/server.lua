local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","atlas-itemdrop")
MySQL = module("vrp_mysql", "MySQL")

local bagtimer = 1200
local bagcount = 0
local bags = {}

AddEventHandler("vRP:playerSpawn", function(user_id, source, first_spawn)
    if first_spawn then
        TriggerClientEvent("atlas-itemdrop:load", source, bags)
    end
end)

RegisterServerEvent("atlas-itemdrop:pickup")
AddEventHandler("atlas-itemdrop:pickup", function(count)
    local bag = bags[count]
    if bags[count] ~= nil then
        bags[count] = nil
        local user_id = vRP.getUserId({source})

        local item_weight = vRP.getItemWeight({bag.item})
        local weight = vRP.getInventoryWeight({user_id})
        local max_weight = vRP.getInventoryMaxWeight({user_id})
        local left = max_weight-weight
        if max_weight-weight > item_weight*bag.amount then
            vRP.giveInventoryItem({user_id,bag.item,bag.amount,true})
            vRPclient.playAnim(source,{true,{{"pickup_object","pickup_low",1}},false})
            TriggerClientEvent('atlas-itemdrop:remove',-1,count)
        else
            if left >= item_weight then
                local amount = math.floor(left/item_weight)
                vRP.giveInventoryItem({user_id,bag.item,amount,true})
                bag.amount = bag.amount-amount
                bags[count] = bag
                vRPclient.playAnim(source,{true,{{"pickup_object","pickup_low",1}},false})
                TriggerClientEvent("atlas-itemdrop:update",-1,count,bag)
            else
                bags[count] = bag
                TriggerClientEvent("pNotify:SendNotification", source,{text = "Du har ikke nok plads til "..(item_weight*bag.amount).." kg", type = "error", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_open", close = "gta_effects_close"}})
            end
        end
    end
end)

RegisterServerEvent("atlas-itemdrop:drop")
AddEventHandler("atlas-itemdrop:drop", function(source,item,amount)
    bagcount = bagcount+1
    local source = source

    local display = vRP.getItemName({item})
    vRPclient.getPosition(source, {}, function(x,y,z)
        bags[bagcount] = {display = display,amount = amount,item = item,coords={x=x,y=y,z=z},timer=bagtimer }
        TriggerClientEvent('atlas-itemdrop:create',-1,bags[bagcount],bagcount)
    end)
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        for k,v in pairs(bags) do
            if v.timer > 0 then
                v.timer = v.timer-1
            else
                TriggerClientEvent('atlas-itemdrop:remove',-1,k)
                bags[k] = nil
            end
        end
    end
end)