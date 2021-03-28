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

--[[RegisterNetEvent("znowy_drugs:start2meth")
AddEventHandler("znowy_drugs:start2meth", function()
    local source = source
    local user_id = vRP.getUserId({source})
    local new_weight = vRP.getInventoryWeight({user_id})+vRP.getItemWeight({"kemikalier"})
    if new_weight <= vRP.getInventoryMaxWeight({user_id}) then
        vRP.giveInventoryItem({user_id,"kemikalier",1,true})
        else
            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Du har ikke nok plads', length = '5000', style = {}})
    end
end)

RegisterNetEvent("znowy_drugs:start3meth")
AddEventHandler("znowy_drugs:start3meth", function()
    local source = source
    local user_id = vRP.getUserId({source})
    local new_weight = vRP.getInventoryWeight({user_id})+vRP.getItemWeight({"kemikalier"})
    if new_weight <= vRP.getInventoryMaxWeight({user_id}) then
        vRP.giveInventoryItem({user_id,"kemikalier",10,true})
        else
            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Du har ikke nok plads', length = '5000', style = {}})
    end
end)

RegisterNetEvent("znowy_drugs:omdanmeth")
AddEventHandler("znowy_drugs:omdanmeth", function()
    local source = source
    local user_id = vRP.getUserId({source})
    local new_weight = vRP.getInventoryWeight({user_id})+vRP.getItemWeight({"meth"})
    if new_weight <= vRP.getInventoryMaxWeight({user_id}) then
        if vRP.getInventoryItemAmount({user_id,"kemikalier"}) >= 1 then
        vRP.tryGetInventoryItem({user_id,"kemikalier",1,true})
        vRP.giveInventoryItem({user_id,"meth",1,true})
        else
            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Du har enten ikke mere plads eller så har mangler du kemikalier', length = '5000', style = {}})
        end
    end
end)

RegisterNetEvent("znowy_drugs:omdan2meth")
AddEventHandler("znowy_drugs:omdan2meth", function()
    local source = source
    local user_id = vRP.getUserId({source})
    local new_weight = vRP.getInventoryWeight({user_id})+vRP.getItemWeight({"meth"})
    if new_weight <= vRP.getInventoryMaxWeight({user_id}) then
        if vRP.getInventoryItemAmount({user_id,"kemikalier"}) >= 10 then
        vRP.tryGetInventoryItem({user_id,"kemikalier",10,true})
        vRP.giveInventoryItem({user_id,"meth",10,true})
        else
            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Du har enten ikke mere plads eller så har mangler du kemikalier', length = '5000', style = {}})
        end
    end
end)]]

RegisterNetEvent("znowy_drugs:salgmeth")
AddEventHandler("znowy_drugs:salgmeth", function()
    local source = source
    local user_id = vRP.getUserId({source})
    local new_weight = vRP.getInventoryWeight({user_id})+vRP.getItemWeight({"dirty_money"})
    if new_weight <= vRP.getInventoryMaxWeight({user_id}) then
        if vRP.getInventoryItemAmount({user_id,"meth"}) >= 10 then
        vRP.tryGetInventoryItem({user_id,"meth",10,true})
        vRP.giveInventoryItem({user_id,"dirty_money",5000,true})
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Du modtog 5000 i sorte penge', length = '5000', style = {}})
        else
            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Du har ikke nok meth', length = '5000', style = {}})
        end
    end
end)