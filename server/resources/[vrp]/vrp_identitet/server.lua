-------------------------------------
------- MADE BY OGKUSH#2526 ---------
-------------------------------------

local Proxy = module("vrp","lib/Proxy")
local Tunnel = module("vrp", "lib/Tunnel")

vRP = Proxy.getInterface("vRP","vrp_identitet")

vRPclient = Tunnel.getInterface("vrp","vrp_identitet")


RegisterServerEvent("vrp_identitet:open")
AddEventHandler("vrp_identitet:open", function()
    -- FORMATAR
    function format_thousand(v)
        local s = string.format("%d", math.floor(v))
        local pos = string.len(s) % 3
        if pos == 0 then pos = 3 end
            return string.sub(s, 1, pos)
        .. string.gsub(string.sub(s, pos+1), "(...)", ".%1")
    end

    local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})
    local arbejde = vRP.getUserGroupByType({user_id,"job"})
    local kontanter = format_thousand(math.floor(vRP.getMoney({user_id})))
    local bankkonto = format_thousand(math.floor(vRP.getBankMoney({user_id})))
    TriggerClientEvent("vrp_identitet:open:c", player,kontanter,bankkonto,user_id,arbejde)
end)