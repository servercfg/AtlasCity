local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","olsen_reklame")

AddEventHandler('chatMessage', function(source, name, message)
    splitmessage = stringsplit(message, " ");

    if string.lower(splitmessage[1]) == "/pa" then
        local user_id = vRP.getUserId({source})
        CancelEvent()
    local playerName = GetPlayerName(source)
   if vRP.hasGroup({user_id,"Politi-Job"}) then
    TriggerClientEvent('chat:addMessage', -1, {
        template = '<div style="font-family:Courier New; padding: 0.5vw; margin: 0.5vw; background-color: rgba(7, 85, 188, 0.6); border-radius: 3px;"></i><strong>👮 Besked fra Politiet:</strong><br> '.. string.sub(message,string.len(splitmessage[1])+1)..'<br></div>',
        args = { fal, msg }
    })
    PerformHttpRequest('https://discordapp.com/api/webhooks/773265724118138931/9Tr3g42YQbAKayX5hz79WliuT8jMD97BxyeyQW6WnuZIR_2r8e7SHc756cJv4rXoYYOH', function(err, text, headers) end, 'POST', json.encode({username = "Reklame Logs", content = "**ID: "..user_id.." **skrev en Politi besked ".. string.sub(message,string.len(splitmessage[1])+1)}), { ['Content-Type'] = 'application/json' })
else
    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Du er ikke Politi', length = 2500})
      end
  end
end, false)

AddEventHandler('chatMessage', function(source, name, message)
    splitmessage = stringsplit(message, " ");

    if string.lower(splitmessage[1]) == "/emsa" then
        local user_id = vRP.getUserId({source})
        CancelEvent()
    local playerName = GetPlayerName(source)
   if vRP.hasGroup({user_id,"EMS-Job"}) then
    TriggerClientEvent('chat:addMessage', -1, {
        template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(246, 246, 63, 0.6); border-radius: 3px;"></i><strong>👨‍⚕️ Besked fra Sundhedsvæsenet:</strong><br> '.. string.sub(message,string.len(splitmessage[1])+1)..'<br></div>',
        args = { fal, msg }
    })
    PerformHttpRequest('https://discordapp.com/api/webhooks/773265724118138931/9Tr3g42YQbAKayX5hz79WliuT8jMD97BxyeyQW6WnuZIR_2r8e7SHc756cJv4rXoYYOH', function(err, text, headers) end, 'POST', json.encode({username = "Reklame Logs", content = "**ID: "..user_id.." **skrev en EMS besked ".. string.sub(message,string.len(splitmessage[1])+1)}), { ['Content-Type'] = 'application/json' })
else
    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Du er ikke EMS', length = 2500})
      end
   end
end, false)

function stringsplit(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t={} ; i=1
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        t[i] = str
        i = i + 1
    end
    return t
end