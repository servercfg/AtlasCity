
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "CodeZ_Licenseplate")

RegisterNetEvent("RemovePlate")
AddEventHandler("RemovePlate", function()
    local source = source
    local user_id = vRP.getUserId({source})
    local new_weight = vRP.getInventoryWeight({user_id})+vRP.getItemWeight({"nummerplade"})
    if vRP.getInventoryItemAmount({user_id,"screwdriver"}) >= 1 then
        vRP.tryGetInventoryItem({user_id,"screwdriver",1,true})
        vRP.giveInventoryItem({user_id,"nummerplade",1,true})
        TriggerClientEvent("CodeZ_Licenseplate:RemovePlate", source)
    else
    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Du har ikke en skruetrækker', length = '5000', style = {}})
end
end)

RegisterNetEvent("AddPlate")
AddEventHandler("AddPlate", function()
    local source = source
    local user_id = vRP.getUserId({source})
    if vRP.getInventoryItemAmount({user_id,"nummerplade"}) >= 1 then
    vRP.tryGetInventoryItem({user_id,"nummerplade",1,true})
    TriggerClientEvent("CodeZ_Licenseplate:AddPlate", source)
   else
    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Du har ikke en nummerplade', length = '5000', style = {}})
end
end)