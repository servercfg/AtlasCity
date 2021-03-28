local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","olsen_attachments")

RegisterNetEvent("olsen_attachments:extendedsnsfrem")
AddEventHandler("olsen_attachments:extendedsnsfrem", function()
    local source = source
    local user_id = vRP.getUserId({source})
    local new_weight = vRP.getInventoryWeight({user_id})+vRP.getItemWeight({"extendedsns2"})
    if new_weight <= vRP.getInventoryMaxWeight({user_id}) then
        if vRP.getInventoryItemAmount({user_id,"alu"}) >= 35 then
            vRP.tryGetInventoryItem({user_id,"alu",35,true})
            vRP.giveInventoryItem({user_id,"extendedsns2",1,true})
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Du modtog Extended Clip til en SNS Pistol', length = '5000', style = {}})
        else
            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Du har ikke nok plads eller har du ikke nok Aluminium', length = '5000', style = {}})
        end
    end
end)

RegisterNetEvent("olsen_attachments:extendedpistolfrem")
AddEventHandler("olsen_attachments:extendedpistolfrem", function()
    local source = source
    local user_id = vRP.getUserId({source})
    local new_weight = vRP.getInventoryWeight({user_id})+vRP.getItemWeight({"extendedpistol"})
    if new_weight <= vRP.getInventoryMaxWeight({user_id}) then
        if vRP.getInventoryItemAmount({user_id,"alu"}) >= 35 then
            vRP.tryGetInventoryItem({user_id,"alu",35,true})
            vRP.giveInventoryItem({user_id,"extendedpistol",1,true})
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Du modtog Extended Clip til en Pistol', length = '5000', style = {}})
        else
            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Du har ikke nok plads eller har du ikke nok Aluminium', length = '5000', style = {}})
        end
    end
end)

RegisterNetEvent("olsen_attachments:supppistolfrem")
AddEventHandler("olsen_attachments:supppistolfrem", function()
    local source = source
    local user_id = vRP.getUserId({source})
    local new_weight = vRP.getInventoryWeight({user_id})+vRP.getItemWeight({"supppistol"})
    if new_weight <= vRP.getInventoryMaxWeight({user_id}) then
        if vRP.getInventoryItemAmount({user_id,"alu"}) >= 75 then
            vRP.tryGetInventoryItem({user_id,"alu",75,true})
            vRP.giveInventoryItem({user_id,"supppistol",1,true})
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Du modtog Suppressor til en Pistol', length = '5000', style = {}})
        else
            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Du har ikke nok plads eller har du ikke nok Aluminium', length = '5000', style = {}})
        end
    end
end)

RegisterNetEvent("olsen_attachments:skinpistolfrem")
AddEventHandler("olsen_attachments:skinpistolfrem", function()
    local source = source
    local user_id = vRP.getUserId({source})
    local new_weight = vRP.getInventoryWeight({user_id})+vRP.getItemWeight({"skinpistol"})
    if new_weight <= vRP.getInventoryMaxWeight({user_id}) then
        if vRP.getInventoryItemAmount({user_id,"guldbar"}) >= 15 then
            vRP.tryGetInventoryItem({user_id,"guldbar",15,true})
            vRP.giveInventoryItem({user_id,"skinpistol",1,true})
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Du modtog Skin til en Pistol', length = '5000', style = {}})
        else
            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Du har ikke nok plads eller har du ikke nok Aluminium', length = '5000', style = {}})
        end
    end
end)

RegisterNetEvent("olsen_attachments:extendedheavyfrem")
AddEventHandler("olsen_attachments:extendedheavyfrem", function()
    local source = source
    local user_id = vRP.getUserId({source})
    local new_weight = vRP.getInventoryWeight({user_id})+vRP.getItemWeight({"extendedheavypistol"})
    if new_weight <= vRP.getInventoryMaxWeight({user_id}) then
        if vRP.getInventoryItemAmount({user_id,"alu"}) >= 35 then
            vRP.tryGetInventoryItem({user_id,"alu",35,true})
            vRP.giveInventoryItem({user_id,"extendedheavypistol",1,true})
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Du modtog Extended Clip til en Heavy Pistol', length = '5000', style = {}})
        else
            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Du har ikke nok plads eller har du ikke nok Aluminium', length = '5000', style = {}})
        end
    end
end)

RegisterNetEvent("olsen_attachments:suppheavyfrem")
AddEventHandler("olsen_attachments:suppheavyfrem", function()
    local source = source
    local user_id = vRP.getUserId({source})
    local new_weight = vRP.getInventoryWeight({user_id})+vRP.getItemWeight({"suppheavypistol"})
    if new_weight <= vRP.getInventoryMaxWeight({user_id}) then
        if vRP.getInventoryItemAmount({user_id,"alu"}) >= 75 then
            vRP.tryGetInventoryItem({user_id,"alu",75,true})
            vRP.giveInventoryItem({user_id,"suppheavypistol",1,true})
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Du modtog Suppressor til en Heavy Pistol', length = '5000', style = {}})
        else
            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Du har ikke nok plads eller har du ikke nok Aluminium', length = '5000', style = {}})
        end
    end
end)

RegisterNetEvent("olsen_attachments:extendeddeaglefrem")
AddEventHandler("olsen_attachments:extendeddeaglefrem", function()
    local source = source
    local user_id = vRP.getUserId({source})
    local new_weight = vRP.getInventoryWeight({user_id})+vRP.getItemWeight({"extended50pistol"})
    if new_weight <= vRP.getInventoryMaxWeight({user_id}) then
        if vRP.getInventoryItemAmount({user_id,"alu"}) >= 35 then
            vRP.tryGetInventoryItem({user_id,"alu",35,true})
            vRP.giveInventoryItem({user_id,"extended50pistol",1,true})
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Du modtog Extended Clip til en Heavy Pistol', length = '5000', style = {}})
        else
            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Du har ikke nok plads eller har du ikke nok Aluminium', length = '5000', style = {}})
        end
    end
end)

RegisterNetEvent("olsen_attachments:suppdeaglefrem")
AddEventHandler("olsen_attachments:suppdeaglefrem", function()
    local source = source
    local user_id = vRP.getUserId({source})
    local new_weight = vRP.getInventoryWeight({user_id})+vRP.getItemWeight({"supp50pistol"})
    if new_weight <= vRP.getInventoryMaxWeight({user_id}) then
        if vRP.getInventoryItemAmount({user_id,"alu"}) >= 75 then
            vRP.tryGetInventoryItem({user_id,"alu",75,true})
            vRP.giveInventoryItem({user_id,"supp50pistol",1,true})
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Du modtog Suppressor til en Heavy Pistol', length = '5000', style = {}})
        else
            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Du har ikke nok plads eller har du ikke nok Aluminium', length = '5000', style = {}})
        end
    end
end)