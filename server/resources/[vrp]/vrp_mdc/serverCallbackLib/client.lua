oMarkez = {}
oMarkez.CurrentRequestId          = 0
oMarkez.ServerCallbacks           = {}

oMarkez.TriggerServerCallback = function(name, cb, ...)
	oMarkez.ServerCallbacks[oMarkez.CurrentRequestId] = cb

	TriggerServerEvent('oMarkez:triggerServerCallback', name, oMarkez.CurrentRequestId, ...)

	if oMarkez.CurrentRequestId < 65535 then
		oMarkez.CurrentRequestId = oMarkez.CurrentRequestId + 1
	else
		oMarkez.CurrentRequestId = 0
	end
end

RegisterNetEvent('oMarkez:serverCallback')
AddEventHandler('oMarkez:serverCallback', function(requestId, ...)
	oMarkez.ServerCallbacks[requestId](...)
	oMarkez.ServerCallbacks[requestId] = nil
end)