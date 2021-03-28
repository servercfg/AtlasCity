local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "olsen_dumpster")

RegisterServerEvent('olsen:startDumpsterTimer')
AddEventHandler('olsen:startDumpsterTimer', function(dumpster)
    startTimer(source, dumpster)
end)

RegisterServerEvent('olsen:giveDumpsterReward')
AddEventHandler('olsen:giveDumpsterReward', function()
    local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})

    local chance = math.random(1, 100)
    local antal = math.random(1, 3)

    if chance >= 95 and chance <= 100 then
        vRP.giveInventoryItem({user_id, "WEAPON_KNIFE", 1})
    elseif chance >=60 and chance <=100 then
        vRP.giveInventoryItem({user_id, "vodka", antal})
    elseif chance >=23 and chance <=100 then
        vRP.giveInventoryItem({user_id, "kebab", antal})
    elseif chance >=60 and chance <=100 then
        vRP.giveInventoryItem({user_id, "joint", antal})
    elseif chance >=22 and chance <=100 then
        vRP.giveInventoryItem({user_id, "donut", antal})
    elseif chance >=21 and chance <=100 then
        vRP.giveInventoryItem({user_id, "sandwich", antal})
    elseif chance >=60 and chance <=100 then
        vRP.giveInventoryItem({user_id, "tacos", antal})
    elseif chance >=11 and chance <=100 then
        vRP.giveInventoryItem({user_id, "hamburger", antal})
    elseif chance >=35 and chance <=100 then
        vRP.giveInventoryItem({user_id, "ol", antal})
    elseif chance >=1 and chance <=100 then
        vRP.giveInventoryItem({user_id, "redgull", antal})
    elseif chance >=77 and chance <=100 then
        vRP.giveInventoryItem({user_id, "strips", antal})
    end
end)


function startTimer(id, object)
    local timer = 10 * 60000

    while timer > 0 do
        Wait(1000)
        timer = timer - 1000
        if timer == 0 then
            TriggerClientEvent('olsen:removeDumpster', id, object)
        end
    end
end