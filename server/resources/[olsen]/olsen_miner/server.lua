local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","olsen_miner")

RegisterNetEvent("olsen_miner:aluore")
AddEventHandler("olsen_miner:aluore", function()
    local source = source
    local user_id = vRP.getUserId({source})
    local new_weight = vRP.getInventoryWeight({user_id})+vRP.getItemWeight({"aluore"})
    reward = math.random(1,10)
    if new_weight <= vRP.getInventoryMaxWeight({user_id}) then
        vRP.giveInventoryItem({user_id,"aluore",reward,true})
        else
            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Du har ikke nok plads', length = '5000', style = {}})
    end
end)

RegisterNetEvent("olsen_miner:alu")
AddEventHandler("olsen_miner:alu", function()
    local source = source
    local user_id = vRP.getUserId({source})
    local new_weight = vRP.getInventoryWeight({user_id})+vRP.getItemWeight({"alu"})
    reward = math.random(1,10)
    if new_weight <= vRP.getInventoryMaxWeight({user_id}) then
        if vRP.getInventoryItemAmount({user_id,"aluore"}) >= reward then
        vRP.tryGetInventoryItem({user_id,"aluore",reward,true})
        vRP.giveInventoryItem({user_id,"alu",reward,true})
        else
            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Du har enten ikke mere plads eller så har mangler du aluore', length = '5000', style = {}})
        end
    end
end)

RegisterNetEvent("olsen_miner:guldore")
AddEventHandler("olsen_miner:guldore", function()
    local source = source
    local user_id = vRP.getUserId({source})
    local new_weight = vRP.getInventoryWeight({user_id})+vRP.getItemWeight({"guldmalm"})
    if new_weight <= vRP.getInventoryMaxWeight({user_id}) then
        vRP.giveInventoryItem({user_id,"guldmalm",1,true})
        else
            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Du har ikke nok plads', length = '5000', style = {}})
    end
end)

RegisterNetEvent("olsen_miner:guldore2")
AddEventHandler("olsen_miner:guldore2", function()
    local source = source
    local user_id = vRP.getUserId({source})
    local new_weight = vRP.getInventoryWeight({user_id})+vRP.getItemWeight({"guldmalm"})
    if new_weight <= vRP.getInventoryMaxWeight({user_id}) then
        vRP.giveInventoryItem({user_id,"guldmalm",10,true})
        else
            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Du har ikke nok plads', length = '5000', style = {}})
    end
end)

RegisterNetEvent("olsen_miner:guldfrem")
AddEventHandler("olsen_miner:guldfrem", function()
    local source = source
    local user_id = vRP.getUserId({source})
    local new_weight = vRP.getInventoryWeight({user_id})+vRP.getItemWeight({"guldbar"})
    if new_weight <= vRP.getInventoryMaxWeight({user_id}) then
        if vRP.getInventoryItemAmount({user_id,"guldmalm"}) >= 1 then
        vRP.tryGetInventoryItem({user_id,"guldmalm",1,true})
        vRP.giveInventoryItem({user_id,"guldbar",1,true})
        else
            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Du har enten ikke mere plads eller så har mangler du guldmalm', length = '5000', style = {}})
        end
    end
end)

RegisterNetEvent("olsen_miner:guldfrem2")
AddEventHandler("olsen_miner:guldfrem2", function()
    local source = source
    local user_id = vRP.getUserId({source})
    local new_weight = vRP.getInventoryWeight({user_id})+vRP.getItemWeight({"guldbar"})
    if new_weight <= vRP.getInventoryMaxWeight({user_id}) then
        if vRP.getInventoryItemAmount({user_id,"guldmalm"}) >= 10 then
        vRP.tryGetInventoryItem({user_id,"guldmalm",10,true})
        vRP.giveInventoryItem({user_id,"guldbar",10,true})
        else
            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Du har enten ikke mere plads eller så har mangler du guldmalm', length = '5000', style = {}})
        end
    end
end)

RegisterNetEvent("olsen_miner:guldsalg")
AddEventHandler("olsen_miner:guldsalg", function()
    local source = source
    local user_id = vRP.getUserId({source})
    local new_weight = vRP.getInventoryWeight({user_id})+vRP.getItemWeight({"dirty_money"})
    if new_weight <= vRP.getInventoryMaxWeight({user_id}) then
        if vRP.getInventoryItemAmount({user_id,"guldbar"}) >= 10 then
        vRP.tryGetInventoryItem({user_id,"guldbar",10,true})
        vRP.giveBankMoney({user_id, 4500})
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Du modtog 4500DKK', length = '5000', style = {}})
        else
            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Du har ikke nok Guldbare', length = '5000', style = {}})
        end
    end
end)