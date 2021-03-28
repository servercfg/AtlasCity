local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","znowy_drugs")

RegisterCommand("shield", function(source, args, raw)
    local src = source
    local user_id = vRP.getUserId({source})
    if vRP.hasPermission({user_id, "police.pc"}) then
    TriggerClientEvent("shield:TogglePoliceShield", src)
else
    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Ikke adgang', length = '5000', style = {}})
    end
end)