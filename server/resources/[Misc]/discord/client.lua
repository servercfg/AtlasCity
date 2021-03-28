

Citizen.CreateThread(function() TriggerEvent('chat:addSuggestion', '/discord', 'Viser discord link.') end)
RegisterCommand("discord", function(source, args, rawCommandString)
    TriggerEvent('chatMessage', "^5[BacksideRP]", { 255, 0, 62 }, "Discord link | discord.gg/t4HBpRv")
end, false)

