UTKFleeca = {}
UTKFleeca.ServerCallbacks = {}

RegisterServerEvent('UTKFleeca:triggerServerCallback')
AddEventHandler('UTKFleeca:triggerServerCallback', function(name, requestId, ...)
	local _source = source

	UTKFleeca.TriggerServerCallback(name, requestID, _source, function(...)
		TriggerClientEvent('UTKFleeca:serverCallback', _source, requestId, ...)
	end, ...)
end)

UTKFleeca.RegisterServerCallback = function(name, cb)
	UTKFleeca.ServerCallbacks[name] = cb
end

UTKFleeca.TriggerServerCallback = function(name, requestId, source, cb, ...)
	if UTKFleeca.ServerCallbacks[name] ~= nil then
		UTKFleeca.ServerCallbacks[name](source, cb, ...)
	else
		print('UTKFleeca.TriggerServerCallback => [' .. name .. '] does not exist')
	end
end