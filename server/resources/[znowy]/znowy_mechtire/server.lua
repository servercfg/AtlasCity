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
vRPclient = Tunnel.getInterface("vRP","znowy_mechtire")

vRP.defInventoryItem({"tyre","Hjul","Reservehjul til udskiftning", function()
    
    local choices = {}
    
    choices["> Brug"] = {function(source,choice,mod)
        local source = source
        local user_id = vRP.getUserId({source})
        if user_id ~= nil then
            TriggerClientEvent("znowy_mechtire:perm2", source)
            vRP.closeMenu({source})
        else
        end
    end}

    return choices
end, 0.50})

RegisterNetEvent("znowy_mechtire:perm")
AddEventHandler("znowy_mechtire:perm", function()
    local source = source
    local user_id = vRP.getUserId({source})
    if vRP.hasGroup({user_id, "Mekaniker"}) then
        vRP.tryGetInventoryItem({user_id, "tyre",1})
        TriggerClientEvent("znowy_mechtire:function", source)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = "Ingen adgang!", length = '5000', style = {}})
    end
end)