UTKFleeca = {}
UTKFleeca.CurrentRequestId          = 0
UTKFleeca.ServerCallbacks           = {}

UTKFleeca.TriggerServerCallback = function(name, cb, ...)
	UTKFleeca.ServerCallbacks[UTKFleeca.CurrentRequestId] = cb

	TriggerServerEvent('UTKFleeca:triggerServerCallback', name, UTKFleeca.CurrentRequestId, ...)

	if UTKFleeca.CurrentRequestId < 65535 then
		UTKFleeca.CurrentRequestId = UTKFleeca.CurrentRequestId + 1
	else
		UTKFleeca.CurrentRequestId = 0
	end
end

RegisterNetEvent('UTKFleeca:serverCallback')
AddEventHandler('UTKFleeca:serverCallback', function(requestId, ...)
	UTKFleeca.ServerCallbacks[requestId](...)
	UTKFleeca.ServerCallbacks[requestId] = nil
end)