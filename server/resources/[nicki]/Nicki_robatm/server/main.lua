--          _____                    _____                    _____                    _____                    _____          
--         /\    \                  /\    \                  /\    \                  /\    \                  /\    \         
--        /::\____\                /::\    \                /::\    \                /::\____\                /::\    \        
--       /::::|   |                \:::\    \              /::::\    \              /:::/    /                \:::\    \       
--      /:::::|   |                 \:::\    \            /::::::\    \            /:::/    /                  \:::\    \      
--     /::::::|   |                  \:::\    \          /:::/\:::\    \          /:::/    /                    \:::\    \     
--    /:::/|::|   |                   \:::\    \        /:::/  \:::\    \        /:::/____/                      \:::\    \    
--   /:::/ |::|   |                   /::::\    \      /:::/    \:::\    \      /::::\    \                      /::::\    \   
--  /:::/  |::|   | _____    ____    /::::::\    \    /:::/    / \:::\    \    /::::::\____\________    ____    /::::::\    \  
-- /:::/   |::|   |/\    \  /\   \  /:::/\:::\    \  /:::/    /   \:::\    \  /:::/\:::::::::::\    \  /\   \  /:::/\:::\    \ 
--/:: /    |::|   /::\____\/::\   \/:::/  \:::\____\/:::/____/     \:::\____\/:::/  |:::::::::::\____\/::\   \/:::/  \:::\____\
--\::/    /|::|  /:::/    /\:::\  /:::/    \::/    /\:::\    \      \::/    /\::/   |::|~~~|~~~~~     \:::\  /:::/    \::/    /
-- \/____/ |::| /:::/    /  \:::\/:::/    / \/____/  \:::\    \      \/____/  \/____|::|   |           \:::\/:::/    / \/____/ 
--         |::|/:::/    /    \::::::/    /            \:::\    \                    |::|   |            \::::::/    /          
--         |::::::/    /      \::::/____/              \:::\    \                   |::|   |             \::::/____/           
--         |:::::/    /        \:::\    \               \:::\    \                  |::|   |              \:::\    \           
--         |::::/    /          \:::\    \               \:::\    \                 |::|   |               \:::\    \          
--         /:::/    /            \:::\    \               \:::\    \                |::|   |                \:::\    \         
--        /:::/    /              \:::\____\               \:::\____\               \::|   |                 \:::\____\        
--        \::/    /                \::/    /                \::/    /                \:|   |                  \::/    /        
--         \/____/                  \/____/                  \/____/                  \|___|                   \/____/        

local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","Nicki_robatm")

RegisterNetEvent('Nicki_robatm:CheckItem')
AddEventHandler('Nicki_robatm:CheckItem', function()
    local user_id = vRP.getUserId({source})
    if vRP.tryGetInventoryItem({user_id,"nicki_virus", 1}) then
   TriggerClientEvent('Nicki_robatm:StartHack', source)
else
    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Du har ikke nogen Virus'}, 15000)
    end
end)

RegisterServerEvent('olsen_robatm:warn')
AddEventHandler('olsen_robatm:warn', function(x,y,z)
	message = "En ATM er igang med at blive røvet. Check Gps!"
	TriggerEvent('dispatchpolice', x, y, z, message)
	TriggerClientEvent("pNotify:SendNotification", source,{text = "Du blev spottet, politiet er informeret!", type = "error", queue = "global", timeout = 8000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
end)


RegisterNetEvent('Nicki_robatm:Reward')
AddEventHandler('Nicki_robatm:Reward', function()
    local user_id = vRP.getUserId({source})
    reward = math.random(4000,7500)
    vRP.giveInventoryItem({user_id,"dirty_money",reward,true})
    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Du modtog '..reward..' Sorte penge!'}, 15000)
        end)

