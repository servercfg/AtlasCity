--[[
  __  __           _            _                 _  __                         _____  
 |  \/  |         | |          | |               | |/ /                        |  __ \ 
 | \  / | __ _  __| | ___      | |__  _   _      | ' / __ _ ___ _ __   ___ _ __| |__) |
 | |\/| |/ _` |/ _` |/ _ \     | '_ \| | | |     |  < / _` / __| '_ \ / _ \ '__|  _  / 
 | |  | | (_| | (_| |  __/     | |_) | |_| |     | . \ (_| \__ \ |_) |  __/ |  | | \ \ 
 |_|  |_|\__,_|\__,_|\___|     |_.__/ \__, |     |_|\_\__,_|___/ .__/ \___|_|  |_|  \_\
                                       __/ |                   | |                     
                                      |___/                    |_|                     

  Author: Kasper Rasmussen
  Steam: https://steamcommunity.com/id/kasperrasmussen
]]

kasperr = {}
kasperr.ServerCallbacks = {}
kasperr.CurrentRequestId = 0

kasperr.TriggerServerCallback = function(name, cb, ...)
	kasperr.ServerCallbacks[kasperr.CurrentRequestId] = cb

	TriggerServerEvent('kasperr:triggerServerCallback', name, kasperr.CurrentRequestId, ...)

	if kasperr.CurrentRequestId < 65535 then
		kasperr.CurrentRequestId = kasperr.CurrentRequestId + 1
	else
		kasperr.CurrentRequestId = 0
	end
end

RegisterNetEvent('kasperr:serverCallback')
AddEventHandler('kasperr:serverCallback', function(requestId, ...)
	kasperr.ServerCallbacks[requestId](...)
	kasperr.ServerCallbacks[requestId] = nil
end)

AddEventHandler('kasperr_base:getBaseObjects', function(cb)
	cb(kasperr)
end)