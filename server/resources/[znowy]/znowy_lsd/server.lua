--[[
────────────────────────────────────────────────
─███████╗███╗───██╗ ██████╗ ██╗────██╗██╗───██╗─  
─╚══███╔╝████╗──██║██╔═══██╗██║────██║╚██╗─██╔╝─  
───███╔╝─██╔██╗─██║██║───██║██║─█╗─██║─╚████╔╝──   
──███╔╝──██║╚██╗██║██║───██║██║███╗██║──╚██╔╝───    
─███████╗██║─╚████║╚██████╔╝╚███╔███╔╝───██║────     
─╚══════╝╚═╝──╚═══╝─╚═════╝──╚══╝╚══╝────╚═╝────     
────────────────────────────────────────────────
]]-- 

local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","znowy_drugs")

RegisterNetEvent("znowy_drugs:start2coke")
AddEventHandler("znowy_drugs:start2coke", function()
    local source = source
    local user_id = vRP.getUserId({source})
    local new_weight = vRP.getInventoryWeight({user_id})+vRP.getItemWeight({"syre"})
    if new_weight <= vRP.getInventoryMaxWeight({user_id}) then
        vRP.giveInventoryItem({user_id,"syre",1,true})
        else
            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Du har ikke nok plads', length = '5000', style = {}})
    end
end)

RegisterNetEvent("znowy_drugs:start3coke")
AddEventHandler("znowy_drugs:start3coke", function()
    local source = source
    local user_id = vRP.getUserId({source})
    local new_weight = vRP.getInventoryWeight({user_id})+vRP.getItemWeight({"syre"})
    if new_weight <= vRP.getInventoryMaxWeight({user_id}) then
        vRP.giveInventoryItem({user_id,"syre",10,true})
        else
            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Du har ikke nok plads', length = '5000', style = {}})
    end
end)

RegisterNetEvent("znowy_drugs:omdancoke")
AddEventHandler("znowy_drugs:omdancoke", function()
    local source = source
    local user_id = vRP.getUserId({source})
    local new_weight = vRP.getInventoryWeight({user_id})+vRP.getItemWeight({"amf"})
    if new_weight <= vRP.getInventoryMaxWeight({user_id}) then
        if vRP.getInventoryItemAmount({user_id,"syre"}) >= 1 then
        vRP.tryGetInventoryItem({user_id,"syre",1,true})
        vRP.giveInventoryItem({user_id,"lsd",1,true})
        else
            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Du har enten ikke mere plads eller så har mangler du syre', length = '5000', style = {}})
        end
    end
end)

RegisterNetEvent("znowy_drugs:omdan2coke")
AddEventHandler("znowy_drugs:omdan2coke", function()
    local source = source
    local user_id = vRP.getUserId({source})
    local new_weight = vRP.getInventoryWeight({user_id})+vRP.getItemWeight({"lsd"})
    if new_weight <= vRP.getInventoryMaxWeight({user_id}) then
        if vRP.getInventoryItemAmount({user_id,"syre"}) >= 10 then
        vRP.tryGetInventoryItem({user_id,"syre",10,true})
        vRP.giveInventoryItem({user_id,"lsd",10,true})
        else
            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Du har enten ikke mere plads eller så har mangler du syre', length = '5000', style = {}})
        end
    end
end)

RegisterNetEvent("znowy_drugs:salgcoke")
AddEventHandler("znowy_drugs:salgcoke", function()
    local source = source
    local user_id = vRP.getUserId({source})
    local new_weight = vRP.getInventoryWeight({user_id})+vRP.getItemWeight({"dirty_money"})
    if new_weight <= vRP.getInventoryMaxWeight({user_id}) then
        if vRP.getInventoryItemAmount({user_id,"lsd"}) >= 10 then
        vRP.tryGetInventoryItem({user_id,"lsd",10,true})
        vRP.giveInventoryItem({user_id,"dirty_money",3500,true})
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Du modtog 3500 i sorte penge', length = '5000', style = {}})
        else
            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Du har ikke nok LSD', length = '5000', style = {}})
        end
    end
end)