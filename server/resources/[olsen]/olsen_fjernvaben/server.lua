local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","olsen_fjernvaben")

RegisterNetEvent("olsen_fjernvaben:fjernvaben")
AddEventHandler("olsen_fjernvaben:fjernvaben", function(player)
    local source = source
    local user_id = vRP.getUserId({source})
    if vRP.hasPermission({user_id, "police.pc"}) then
        vRPclient.giveWeapons(source,{{},true})
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Du har sat dine våben i et våbenskab', length = '5000', style = {}})
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Du har ikke nøglerne til våbenskabet', length = '5000', style = {}})
    end
end)