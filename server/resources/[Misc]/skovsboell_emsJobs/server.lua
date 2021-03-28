--███████╗██╗  ██╗ ██████╗ ██╗   ██╗███████╗██████╗  ██████╗ ███████╗██╗     ██╗     
--██╔════╝██║ ██╔╝██╔═══██╗██║   ██║██╔════╝██╔══██╗██╔═══██╗██╔════╝██║     ██║     
--███████╗█████╔╝ ██║   ██║██║   ██║███████╗██████╔╝██║   ██║█████╗  ██║     ██║     
--╚════██║██╔═██╗ ██║   ██║╚██╗ ██╔╝╚════██║██╔══██╗██║   ██║██╔══╝  ██║     ██║     
--███████║██║  ██╗╚██████╔╝ ╚████╔╝ ███████║██████╔╝╚██████╔╝███████╗███████╗███████╗
--╚══════╝╚═╝  ╚═╝ ╚═════╝   ╚═══╝  ╚══════╝╚═════╝  ╚═════╝ ╚══════╝╚══════╝╚══════╝
------------------------CREDITS------------------------
--   Copyright 2019 ©Skovsbøll. All rights reserved  --
-------------------------------------------------------

MySQL = module("vrp_mysql", "MySQL")
local Proxy = module("vrp", "lib/Proxy")
local Tunnel = module("vrp", "lib/Tunnel")

vRP = Proxy.getInterface("vRP")

status = false

RegisterServerEvent('skovsboell:status')
AddEventHandler('skovsboell:status', function ()
    local source = source
    TriggerClientEvent("skovsboell_status_c", source, status)
end)

RegisterServerEvent('skovsboell:startet')
AddEventHandler('skovsboell:startet', function ()
    status = true
    TriggerClientEvent("skovsboell_status_c", -1, status)
end)

RegisterServerEvent('skovsboell:stop')
AddEventHandler('skovsboell:stop', function ()
    status = false
    TriggerClientEvent("skovsboell_status_c", -1, status)
end)

RegisterServerEvent('skovsboell:EmsCheckJob')
AddEventHandler('skovsboell:EmsCheckJob', function()
    local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})

    if vRP.hasGroup({user_id,"EMS-Job"}) then
        TriggerEvent("skovsboell:startet")
        TriggerClientEvent("skovsboell_EmsHelp",player)
    else
        TriggerClientEvent("pNotify:SendNotification", source,{text = "Du er ikke læge", type = "success", queue = "global", timeout = 5000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
    end
end)

RegisterServerEvent('skovsboell:SavedByEms')
AddEventHandler('skovsboell:SavedByEms', function()
    local source = source
    local user_id = vRP.getUserId({source})
    local amount = math.random( 5000,7500 )
    vRP.giveBankMoney({user_id,amount})
    TriggerClientEvent("pNotify:SendNotification", source,{text = "Modtog <b style='color: #4E9350'>"..amount.." DKK</b> for at have hjulpet den tilskadekommet.", type = "success", queue = "global", timeout = 5000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
    TriggerEvent("skovsboell:stop")
end)