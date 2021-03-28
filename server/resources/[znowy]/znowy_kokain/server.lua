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

RegisterNetEvent("znowy_drugs:start2")
AddEventHandler("znowy_drugs:start2", function()
    local source = source
    local user_id = vRP.getUserId({source})
    local new_weight = vRP.getInventoryWeight({user_id})+vRP.getItemWeight({"kokainblade"})
    if new_weight <= vRP.getInventoryMaxWeight({user_id}) then
        vRP.giveInventoryItem({user_id,"kokainblade",1,true})
        else
            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Du har ikke nok plads', length = '5000', style = {}})
    end
end)

RegisterNetEvent("znowy_drugs:start3")
AddEventHandler("znowy_drugs:start3", function()
    local source = source
    local user_id = vRP.getUserId({source})
    local new_weight = vRP.getInventoryWeight({user_id})+vRP.getItemWeight({"kokainblade"})
    if new_weight <= vRP.getInventoryMaxWeight({user_id}) then
        vRP.giveInventoryItem({user_id,"kokainblade",10,true})
        else
            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Du har ikke nok plads', length = '5000', style = {}})
    end
end)

RegisterNetEvent("znowy_drugs:omdan")
AddEventHandler("znowy_drugs:omdan", function()
    local source = source
    local user_id = vRP.getUserId({source})
    local new_weight = vRP.getInventoryWeight({user_id})+vRP.getItemWeight({"kokain"})
    if new_weight <= vRP.getInventoryMaxWeight({user_id}) then
        if vRP.getInventoryItemAmount({user_id,"kokainblade"}) >= 1 then
        vRP.tryGetInventoryItem({user_id,"kokainblade",1,true})
        vRP.giveInventoryItem({user_id,"kokain",1,true})
        else
            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Du har enten ikke mere plads eller så har mangler du kokainblade', length = '5000', style = {}})
        end
    end
end)

RegisterNetEvent("znowy_drugs:omdan2")
AddEventHandler("znowy_drugs:omdan2", function()
    local source = source
    local user_id = vRP.getUserId({source})
    local new_weight = vRP.getInventoryWeight({user_id})+vRP.getItemWeight({"kokain"})
    if new_weight <= vRP.getInventoryMaxWeight({user_id}) then
        if vRP.getInventoryItemAmount({user_id,"kokainblade"}) >= 10 then
        vRP.tryGetInventoryItem({user_id,"kokainblade",10,true})
        vRP.giveInventoryItem({user_id,"kokain",10,true})
        else
            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Du har enten ikke mere plads eller så har mangler du kokainblade', length = '5000', style = {}})
        end
    end
end)

RegisterNetEvent("znowy_drugs:salg")
AddEventHandler("znowy_drugs:salg", function()
    local source = source
    local user_id = vRP.getUserId({source})
    local new_weight = vRP.getInventoryWeight({user_id})+vRP.getItemWeight({"dirty_money"})
    if new_weight <= vRP.getInventoryMaxWeight({user_id}) then
        if vRP.getInventoryItemAmount({user_id,"kokain"}) >= 10 then
        vRP.tryGetInventoryItem({user_id,"kokain",10,true})
        vRP.giveInventoryItem({user_id,"dirty_money",4250,true})
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Du modtog 4250 i sorte penge', length = '5000', style = {}})
        else
            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Du har ikke nok kokain', length = '5000', style = {}})
        end
    end
end)