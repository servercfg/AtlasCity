local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
--MySQL = module("vrp_mysql", "MySQL")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "sh_combatlogging")

RegisterServerEvent('baseevents:onPlayerDied')
RegisterServerEvent('baseevents:onPlayerKilled')
RegisterServerEvent('baseevents:onPlayerWasted')

AddEventHandler('baseevents:onPlayerKilled', function(killedBy, data, Weapon)
	local victim = source
	local user_id = vRP.getUserId({victim})
	local player = vRP.getUserSource({user_id})
	local killerx_id = vRP.getUserId({killedBy})
		if killerx_id ~= nil then
			PerformHttpRequest('https://discordapp.com/api/webhooks/773265225410805811/vWHU3Pm83mQCoxeZ05rsHWsdK7n51v3vwOBhjHQ8QPdjJmJmmfRQpq9gX_o0nf9eseF8', function(err, text, headers) end, 'POST', json.encode({username = "Kill", content = "```\n"..killerx_id.." dræbte "..user_id.." med HASHID: "..Weapon.."\n```"}), { ['Content-Type'] = 'application/json' })
		end
end)

AddEventHandler('baseevents:onPlayerDied', function(killedBy, pos)
	local victim = source
	local user_id = vRP.getUserId({victim})
	local player = vRP.getUserSource({user_id})
	
	PerformHttpRequest('https://discordapp.com/api/webhooks/773265225410805811/vWHU3Pm83mQCoxeZ05rsHWsdK7n51v3vwOBhjHQ8QPdjJmJmmfRQpq9gX_o0nf9eseF8', function(err, text, headers) end, 'POST', json.encode({username = "Kill", content = "```\nOffer ID: "..user_id.." \nBegik selvmord?```"}), { ['Content-Type'] = 'application/json' })
end)