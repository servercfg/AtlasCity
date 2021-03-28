local events = {
  'esx:getSharedObject',
  'esx_ambulancejob:revive',
  'esx_society:openBossMenu',
  'esx_truckerjob:pay',
  'esx_society:setJobSalary',
  'esx_joblisting:setJob',
  'esx_policejob:handcuff',
  'esx_policejob:OutVehicle',
  'esx_weashop:buyItem',
  'esx:spawnVehicle',
  'esx_vehicleshop:putStockItems',
  'esx_slotmachine:sv:2',
  'AdminMenu:giveCash',
  'AdminMenu:giveBank',
  'AdminMenu:giveDirtyMoney',
  'NB:recruterplayer',
  'hentailover:xdlol',
}

RegisterServerEvent('613cd851-bb4c-4825-8d4a-423caa7bf2c3')
AddEventHandler('613cd851-bb4c-4825-8d4a-423caa7bf2c3', function(name)
  local _source = source
  TriggerEvent('scrambler:injectionDetected', name, _source, false)
end)

Citizen.CreateThread(function()
	webhook = GetConvar("ac_webhook", "https://discordapp.com/api/webhooks/773262842207666186/1v4UGDqq50tUKG9p4ONVbOz6I5jNoKKmwn-TizzSGBDaonpT7zcNqnIACUf24dXZ1gEw")

	function SendWebhookMessage(webhook,message)
		if webhook ~= "none" then
			PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
		end
	end
	
	function GetPlayerNeededIdentifiers(player)
		local ids = GetPlayerIdentifiers(player)
		for i,theIdentifier in ipairs(ids) do
			if string.find(theIdentifier,"license:") or -1 > -1 then
				license = theIdentifier
			elseif string.find(theIdentifier,"steam:") or -1 > -1 then
				steam = theIdentifier
			end
		end
		if not steam then
			steam = "steam: missing"
		end
		return license, steam
	end

for i=1, #events, 1 do
  RegisterServerEvent(events[i])
  AddEventHandler(events[i], function()
    local _source = source
    TriggerEvent('scrambler:injectionDetected', events[i], _source, true)
  end)
 end

AddEventHandler('scrambler:injectionDetected', function(name, source, isServerEvent)

  local eventType = 'client'
  license, steam = GetPlayerNeededIdentifiers(source)
			username = GetPlayerName(source)
			id = source
      local user_id = vRP.getUserId({source})
      local player = vRP.getUserSource({user_id})
  if isServerEvent then
    eventType = 'server'
  end

  SendWebhookMessage(webhook,"**INJECTION DETECTED - Server 1** \n```\nUser:"..username.."\nId:"..user_id.."\n"..license.."\n"..steam.."\nAttempted to Execute: "..name.."\n```")
  end)
  end)