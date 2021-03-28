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

RegisterNetEvent("znowy_drugs:hvidvask")
AddEventHandler("znowy_drugs:hvidvask", function()
    local source = source
    local user_id = vRP.getUserId({source})
    local new_weight = vRP.getInventoryWeight({user_id})+vRP.getItemWeight({"dirty_money"})
    if new_weight <= vRP.getInventoryMaxWeight({user_id}) then
        if vRP.getInventoryItemAmount({user_id,"dirty_money"}) >= 1000 then
        vRP.tryGetInventoryItem({user_id,"dirty_money",1000,true})
        vRP.giveMoney({user_id,700})
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Du modtog 700DKK', length = '5000', style = {}})
        else
            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Du har ikke nok sorte penge', length = '5000', style = {}})
        end
    end
end)


RegisterNetEvent("znowy_drugs:hvidvask2")
AddEventHandler("znowy_drugs:hvidvask2", function()
    local source = source
    local user_id = vRP.getUserId({source})
    local new_weight = vRP.getInventoryWeight({user_id})+vRP.getItemWeight({"dirty_money"})
    if new_weight <= vRP.getInventoryMaxWeight({user_id}) then
        if vRP.getInventoryItemAmount({user_id,"dirty_money"}) >= 5000 then
        vRP.tryGetInventoryItem({user_id,"dirty_money",5000,true})
        vRP.giveMoney({user_id,3500})
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Du modtog 3500DKK', length = '5000', style = {}})
        else
            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Du har ikke nok sorte penge', length = '5000', style = {}})
        end
    end
end)

RegisterNetEvent("znowy_drugs:hvidvask3")
AddEventHandler("znowy_drugs:hvidvask3", function()
    local source = source
    local user_id = vRP.getUserId({source})
    local new_weight = vRP.getInventoryWeight({user_id})+vRP.getItemWeight({"dirty_money"})
    if new_weight <= vRP.getInventoryMaxWeight({user_id}) then
        if vRP.getInventoryItemAmount({user_id,"dirty_money"}) >= 10000 then
        vRP.tryGetInventoryItem({user_id,"dirty_money",10000,true})
        vRP.giveMoney({user_id,7000})
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Du modtog 7000DKK', length = '5000', style = {}})
        else
            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Du har ikke nok sorte penge', length = '5000', style = {}})
        end
    end
end)

RegisterNetEvent("znowy_drugs:juvel")
AddEventHandler("znowy_drugs:juvel", function()
    local source = source
    local user_id = vRP.getUserId({source})
    local new_weight = vRP.getInventoryWeight({user_id})+vRP.getItemWeight({"dirty_money"})
    if new_weight <= vRP.getInventoryMaxWeight({user_id}) then
        if vRP.getInventoryItemAmount({user_id,"nicki_juvel"}) >= 1 then
        vRP.tryGetInventoryItem({user_id,"nicki_juvel",1,true})
        vRP.giveInventoryItem({user_id,"dirty_money",2000,true})
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Du modtog 2000 i sorte penge', length = '5000', style = {}})
        else
            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Du har ikke nok juveller', length = '5000', style = {}})
        end
    end
end)

RegisterNetEvent("znowy_drugs:guldbar")
AddEventHandler("znowy_drugs:guldbar", function()
    local source = source
    local user_id = vRP.getUserId({source})
    local new_weight = vRP.getInventoryWeight({user_id})+vRP.getItemWeight({"dirty_money"})
    if new_weight <= vRP.getInventoryMaxWeight({user_id}) then
        if vRP.getInventoryItemAmount({user_id,"gold_bar"}) >= 1 then
        vRP.tryGetInventoryItem({user_id,"gold_bar",1,true})
        vRP.giveInventoryItem({user_id,"dirty_money",1500,true})
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Du modtog 1500 i sorte penge', length = '5000', style = {}})
        else
            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Du har ikke nok guldbarre', length = '5000', style = {}})
        end
    end
end)

RegisterNetEvent("znowy_drugs:diamant")
AddEventHandler("znowy_drugs:diamant", function()
    local source = source
    local user_id = vRP.getUserId({source})
    local new_weight = vRP.getInventoryWeight({user_id})+vRP.getItemWeight({"dirty_money"})
    if new_weight <= vRP.getInventoryMaxWeight({user_id}) then
        if vRP.getInventoryItemAmount({user_id,"dia_box"}) >= 1 then
        vRP.tryGetInventoryItem({user_id,"dia_box",1,true})
        vRP.giveInventoryItem({user_id,"dirty_money",1850,true})
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Du modtog 1850 i sorte penge', length = '5000', style = {}})
        else
            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Du har ikke nok diamant box', length = '5000', style = {}})
        end
    end
end)

RegisterNetEvent("znowy_drugs:salgskunk")
AddEventHandler("znowy_drugs:salgskunk", function()
    local source = source
    local user_id = vRP.getUserId({source})
    local new_weight = vRP.getInventoryWeight({user_id})+vRP.getItemWeight({"dirty_money"})
    if new_weight <= vRP.getInventoryMaxWeight({user_id}) then
        if vRP.getInventoryItemAmount({user_id,"klump10"}) >= 10 then
        vRP.tryGetInventoryItem({user_id,"klump10",10,true})
        vRP.giveInventoryItem({user_id,"dirty_money",3000,true})
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Du modtog 3000 i sorte penge', length = '5000', style = {}})
        else
            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Du har ikke nok plads', length = '5000', style = {}})
        end
    end
end)