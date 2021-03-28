local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")

RegisterServerEvent("ac:dataUI")
AddEventHandler("ac:dataUI", function ()
    local user_id = vRP.getUserId({source})
    TriggerClientEvent("ac_givData",source,vRP.getHunger({user_id}),vRP.getThirst({user_id}))
end)
