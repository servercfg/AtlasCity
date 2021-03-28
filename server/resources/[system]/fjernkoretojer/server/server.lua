local Proxy = module("vrp", "lib/Proxy")
local Tunnel = module("vrp", "lib/Tunnel")

vRP = Proxy.getInterface("vRP")
AddEventHandler( 'chatMessage', function( source, n, msg )

    msg = string.lower( msg )
    
    if ( msg == "/sletbiler" or msg == "/fjernbiler" ) then 
    
        CancelEvent() 
        
        local user_id = vRP.getUserId({source})
        local player = vRP.getUserSource({user_id})
        if vRP.hasPermission({user_id,"atlas.admin"}) then
        TriggerClientEvent( 'atlas:sletallebiler', -1)
		 	local dname = "[ID - ".. tostring(user_id).. "] Anti-Abuse"
			local dmessage = "**SLET BILER** \n```\nID: ".. tostring(user_id).. "\nCommand: /sletbiler\n```"
			PerformHttpRequest('https://discordapp.com/api/webhooks/773266344338391050/JhaPwkok2JPKnzqnkd3VsJZr4E58SgXUJTfvtlGzrgzeEzhvtRnqv4ImiWFS8XoQ8pV3', function(err, text, headers) end, 'POST', json.encode({username = dname, content = dmessage}), { ['Content-Type'] = 'application/json' })
        end
    end
end )