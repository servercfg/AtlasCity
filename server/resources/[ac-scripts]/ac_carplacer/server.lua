AddEventHandler("vRP:playerSpawn", function(user_id, source, first_spawn)
	if first_spawn then
		TriggerClientEvent("ac_carplacer:place", source)
	end
end)
