--[[
─────────────────────────────────────────────────────────────────────────────────────────────────────────
─██████──████████─██████████████─██████████████████─██████████████─██████████████─██████──────────██████─
─██░░██──██░░░░██─██░░░░░░░░░░██─██░░░░░░░░░░░░░░██─██░░░░░░░░░░██─██░░░░░░░░░░██─██░░██████████──██░░██─
─██░░██──██░░████─██░░██████░░██─████████████░░░░██─██░░██████░░██─██░░██████░░██─██░░░░░░░░░░██──██░░██─
─██░░██──██░░██───██░░██──██░░██─────────████░░████─██░░██──██░░██─██░░██──██░░██─██░░██████░░██──██░░██─
─██░░██████░░██───██░░██████░░██───────████░░████───██░░██──██░░██─██░░██──██░░██─██░░██──██░░██──██░░██─
─██░░░░░░░░░░██───██░░░░░░░░░░██─────████░░████─────██░░██──██░░██─██░░██──██░░██─██░░██──██░░██──██░░██─
─██░░██████░░██───██░░██████░░██───████░░████───────██░░██──██░░██─██░░██──██░░██─██░░██──██░░██──██░░██─
─██░░██──██░░██───██░░██──██░░██─████░░████─────────██░░██──██░░██─██░░██──██░░██─██░░██──██░░██████░░██─
─██░░██──██░░████─██░░██──██░░██─██░░░░████████████─██░░██████░░██─██░░██████░░██─██░░██──██░░░░░░░░░░██─
─██░░██──██░░░░██─██░░██──██░░██─██░░░░░░░░░░░░░░██─██░░░░░░░░░░██─██░░░░░░░░░░██─██░░██──██████████░░██─
─██████──████████─██████──██████─██████████████████─██████████████─██████████████─██████──────────██████─
─────────────────────────────────────────────────────────────────────────────────────────────────────────
]]--

local beds = {}

AddEventHandler("vRP:playerSpawn", function(user_id, source, first_spawn)
    if first_spawn then
        TriggerClientEvent("kaz_hospital:place", source)
    end
    TriggerClientEvent('kaz_hospital:load', source, beds)
end)

AddEventHandler("vRP:playerLeave",function(user_id,source)
    for k,v in pairs(beds) do
        if v == source then
            beds[k] = nil
            TriggerClientEvent('kaz_hospital:status', -1,k,nil)
        end
    end
end)

RegisterServerEvent('kaz_hospital:sendstatus')
AddEventHandler('kaz_hospital:sendstatus', function(id,used)
    beds[id] = (used) and source or nil
    TriggerClientEvent('kaz_hospital:status', -1, id,beds[id])
end)

RegisterServerEvent('kaz_hospital:ringop')
AddEventHandler('kaz_hospital:ringop', function()
x = 308.30285644531
y = -595.42260742188
z = 43.291584014893
message = "Der står en og mangler hjælp på hospitalet."
TriggerEvent('dispatchems', x, y, z, message)
end)

RegisterServerEvent('kaz_hospital:pedspawn')
AddEventHandler('kaz_hospital:pedspawn', function()
local source = source
TriggerClientEvent('kaz_hospital:pedspawnreturnall', -1)
TriggerClientEvent('kaz_hospital:pedspawnreturn', source)
end)

RegisterServerEvent('kaz_hospital:videre')
AddEventHandler('kaz_hospital:videre', function()
local source = source
TriggerClientEvent('kaz_hospital:pedtilbagereturn', -1)
end)