acWT = {}
acWT.CurrentRequestId          = 0
acWT.ServerCallbacks           = {}

acWT.TriggerServerCallback = function(name, cb, ...)
	acWT.ServerCallbacks[acWT.CurrentRequestId] = cb

	TriggerServerEvent('acWT:triggerServerCallback', name, acWT.CurrentRequestId, ...)

	if acWT.CurrentRequestId < 65535 then
		acWT.CurrentRequestId = acWT.CurrentRequestId + 1
	else
		acWT.CurrentRequestId = 0
	end
end

RegisterNetEvent('acWT:serverCallback')
AddEventHandler('acWT:serverCallback', function(requestId, ...)
	acWT.ServerCallbacks[requestId](...)
	acWT.ServerCallbacks[requestId] = nil
end)