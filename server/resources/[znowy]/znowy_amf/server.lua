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

RegisterNetEvent("znowy_drugs:startamf2")
AddEventHandler("znowy_drugs:startamf2", function()
    local source = source
    local user_id = vRP.getUserId({source})
    local new_weight = vRP.getInventoryWeight({user_id})+vRP.getItemWeight({"kemikalier2"})
    if new_weight <= vRP.getInventoryMaxWeight({user_id}) then
        vRP.giveInventoryItem({user_id,"kemikalier2",1,true})
        else
            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Du har ikke nok plads', length = '5000', style = {}})
    end
end)

RegisterNetEvent("znowy_drugs:startamf3")
AddEventHandler("znowy_drugs:startamf3", function()
    local source = source
    local user_id = vRP.getUserId({source})
    local new_weight = vRP.getInventoryWeight({user_id})+vRP.getItemWeight({"kemikalier2"})
    if new_weight <= vRP.getInventoryMaxWeight({user_id}) then
        vRP.giveInventoryItem({user_id,"kemikalier2",10,true})
        else
            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Du har ikke nok plads', length = '5000', style = {}})
    end
end)

RegisterNetEvent("znowy_drugs:omdanamf")
AddEventHandler("znowy_drugs:omdanamf", function()
    local source = source
    local user_id = vRP.getUserId({source})
    local new_weight = vRP.getInventoryWeight({user_id})+vRP.getItemWeight({"amf"})
    if new_weight <= vRP.getInventoryMaxWeight({user_id}) then
        if vRP.getInventoryItemAmount({user_id,"kemikalier2"}) >= 1 then
        vRP.tryGetInventoryItem({user_id,"kemikalier2",1,true})
        vRP.giveInventoryItem({user_id,"amf",1,true})
        else
            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Du har enten ikke mere plads eller så har mangler du kemikalier', length = '5000', style = {}})
        end
    end
end)

RegisterNetEvent("znowy_drugs:omdan2amf")
AddEventHandler("znowy_drugs:omdan2amf", function()
    local source = source
    local user_id = vRP.getUserId({source})
    local new_weight = vRP.getInventoryWeight({user_id})+vRP.getItemWeight({"amf"})
    if new_weight <= vRP.getInventoryMaxWeight({user_id}) then
        if vRP.getInventoryItemAmount({user_id,"kemikalier2"}) >= 10 then
        vRP.tryGetInventoryItem({user_id,"kemikalier2",10,true})
        vRP.giveInventoryItem({user_id,"amf",10,true})
        else
            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Du har enten ikke mere plads eller så har mangler du kemikalier', length = '5000', style = {}})
        end
    end
end)

RegisterNetEvent("znowy_drugs:salgamf")
AddEventHandler("znowy_drugs:salgamf", function()
    local source = source
    local user_id = vRP.getUserId({source})
    local new_weight = vRP.getInventoryWeight({user_id})+vRP.getItemWeight({"dirty_money"})
    if new_weight <= vRP.getInventoryMaxWeight({user_id}) then
        if vRP.getInventoryItemAmount({user_id,"amf"}) >= 10 then
        vRP.tryGetInventoryItem({user_id,"amf",10,true})
        vRP.giveInventoryItem({user_id,"dirty_money",4500,true})
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Du modtog 4500 i sorte penge', length = '5000', style = {}})
        else
            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Du har ikke nok AMF', length = '5000', style = {}})
        end
    end
end)