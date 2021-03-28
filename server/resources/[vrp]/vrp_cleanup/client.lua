checkTime = 60 --Minutes
deleteTime = 30 --Seconds

local enumerator = {
	__gc = function(enum)
		if enum.destructor and enum.handle then
			enum.destructor(enum.handle)
		end
		enum.destructor = nil
		enum.handle = nil
	end
}

local function getEntities(initFunc, moveFunc, disposeFunc)
	return coroutine.wrap(function()
		local iter, id = initFunc()
		if not id or id == 0 then
			disposeFunc(iter)
			return
		end
    
		local enum = {handle = iter, destructor = disposeFunc}
		setmetatable(enum, enumerator)
    
		local next = true
		repeat
		coroutine.yield(id)
		next, id = moveFunc(iter)
		until not next
  
		enum.destructor, enum.handle = nil, nil
		disposeFunc(iter)
	end)
end

function getVehicles()
  return getEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end

Citizen.CreateThread(function()
	while true do
		Wait(checkTime * 60000)
		exports['mythic_notify']:SendAlert('inform', 'Alle forladte køretøjer slettes om '..deleteTime..' sekunder!')
		SetTimeout(deleteTime * 1000, function()
			theVehicles = getVehicles()
			exports['mythic_notify']:SendAlert('error', 'Alle køretøjer som ikke blev brugt er blevet slettet!')
			for veh in theVehicles do
				if ( DoesEntityExist( veh ) ) then 
					if((GetPedInVehicleSeat(veh, -1)) == false) or ((GetPedInVehicleSeat(veh, -1)) == nil) or ((GetPedInVehicleSeat(veh, -1)) == 0)then
						Citizen.InvokeNative( 0xEA386986E786A54F, Citizen.PointerValueIntInitialized( veh ) )
					end
				end
			end
		end)
	end
end)