vrpPV = {}
vrpPV.CurrentRequestId          = 0
vrpPV.ServerCallbacks           = {}

vrpPV.TriggerServerCallback = function(name, cb, ...)
	vrpPV.ServerCallbacks[vrpPV.CurrentRequestId] = cb

	TriggerServerEvent('vrpPV:triggerServerCallback', name, vrpPV.CurrentRequestId, ...)

	if vrpPV.CurrentRequestId < 65535 then
		vrpPV.CurrentRequestId = vrpPV.CurrentRequestId + 1
	else
		vrpPV.CurrentRequestId = 0
	end
end

RegisterNetEvent('vrpPV:serverCallback')
AddEventHandler('vrpPV:serverCallback', function(requestId, ...)
	vrpPV.ServerCallbacks[requestId](...)
	vrpPV.ServerCallbacks[requestId] = nil
end)