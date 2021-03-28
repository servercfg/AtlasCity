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

RegisterServerEvent('kasperr:triggerServerCallback')
AddEventHandler('kasperr:triggerServerCallback', function(name, requestId, ...)
	local _source = source

  kasperr.TriggerServerCallback(name, requestID, _source, function(...)
		TriggerClientEvent('kasperr:serverCallback', _source, requestId, ...)
	end, ...)
end)

kasperr.TriggerServerCallback = function(name, requestId, source, cb, ...)
  if kasperr.ServerCallbacks[name] ~= nil then
    kasperr.ServerCallbacks[name](source, cb, ...)
	else
		print('TriggerServerCallback => [' .. name .. '] does not exist')
	end
end

kasperr.RegisterServerCallback = function(name, cb)
  kasperr.ServerCallbacks[name] = cb
end

AddEventHandler('kasperr_base:getBaseObjects', function(cb)
	cb(kasperr)
end)