-- unfreeze on spawn
AddEventHandler("vRP:playerSpawn", function(user_id, source, first_spawn)
	local player = source
	SetTimeout(35000,function() 
		TriggerClientEvent('vRPlf:Unfreeze',player,false)
	end)
end)