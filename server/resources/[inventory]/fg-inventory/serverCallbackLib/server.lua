vrpPV = {}
vrpPV.ServerCallbacks = {}

RegisterServerEvent('vrpPV:triggerServerCallback')
AddEventHandler('vrpPV:triggerServerCallback', function(name, requestId, ...)
	local _source = source

	vrpPV.TriggerServerCallback(name, requestID, _source, function(...)
		TriggerClientEvent('vrpPV:serverCallback', _source, requestId, ...)
	end, ...)
end)

vrpPV.RegisterServerCallback = function(name, cb)
	vrpPV.ServerCallbacks[name] = cb
end

vrpPV.TriggerServerCallback = function(name, requestId, source, cb, ...)
	if vrpPV.ServerCallbacks[name] ~= nil then
		vrpPV.ServerCallbacks[name](source, cb, ...)
	else
		print('vrpPV.TriggerServerCallback => [' .. name .. '] does not exist')
	end
end