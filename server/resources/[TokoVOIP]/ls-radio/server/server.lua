local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","ls-radio")


RegisterServerEvent('ls-radio:connectCop')
AddEventHandler('ls-radio:connectCop', function(user)
    local source = source
    local user_id = vRP.getUserId({source})
	if vRP.hasPermission({user_id,"radio.access"}) then
		TriggerClientEvent("ls-radio:copConnect", source)
    else
        TriggerClientEvent("ls-radio:notAllowedCop", source)
    end
end)


vRP.defInventoryItem({"radio","Radio","", function()
	
	local choices = {}
	
	choices["> Brug"] = {function(player,choice,mod)
		local user_id = vRP.getUserId({player})
        if user_id ~= nil then
            TriggerClientEvent("ultimate15:radio_join", player)
            if vRP.hasInventoryItem({user_id,"radio", 1}) then
                vRP.closeMenu({player})
            else
            end
        end
    end}

	return choices
end, 0.50})

RegisterCommand("radio", function(source, args, raw)
    local source = source
    local user_id = vRP.getUserId({source})
    if vRP.hasInventoryItem({user_id,"radio", 1}) then
    TriggerClientEvent("ultimate15:radio_join", source)
else
    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Du har ikke nogen radio!', length = '5000', style = {}})
    end
  end)