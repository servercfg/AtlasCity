acWT = {}
acWT.ServerCallbacks = {}

RegisterServerEvent('acWT:triggerServerCallback')
AddEventHandler('acWT:triggerServerCallback', function(name, requestId, ...)
	local _source = source

	acWT.TriggerServerCallback(name, requestID, _source, function(...)
		TriggerClientEvent('acWT:serverCallback', _source, requestId, ...)
	end, ...)
end)

acWT.RegisterServerCallback = function(name, cb)
	acWT.ServerCallbacks[name] = cb
end

acWT.TriggerServerCallback = function(name, requestId, source, cb, ...)
	if acWT.ServerCallbacks[name] ~= nil then
		acWT.ServerCallbacks[name](source, cb, ...)
	else
		print(''..GetCurrentResourceName()..' => [' .. name .. '] does not exist')
	end
end