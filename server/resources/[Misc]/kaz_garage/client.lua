--[[
─────────────────────────────────────────────────────────────────────────────────────────────────────────
─██████──████████─██████████████─██████████████████─██████████████─██████████████─██████──────────██████─
─██░░██──██░░░░██─██░░░░░░░░░░██─██░░░░░░░░░░░░░░██─██░░░░░░░░░░██─██░░░░░░░░░░██─██░░██████████──██░░██─
─██░░██──██░░████─██░░██████░░██─████████████░░░░██─██░░██████░░██─██░░██████░░██─██░░░░░░░░░░██──██░░██─
─██░░██──██░░██───██░░██──██░░██─────────████░░████─██░░██──██░░██─██░░██──██░░██─██░░██████░░██──██░░██─
─██░░██████░░██───██░░██████░░██───────████░░████───██░░██──██░░██─██░░██──██░░██─██░░██──██░░██──██░░██─
─██░░░░░░░░░░██───██░░░░░░░░░░██─────████░░████─────██░░██──██░░██─██░░██──██░░██─██░░██──██░░██──██░░██─
─██░░██████░░██───██░░██████░░██───████░░████───────██░░██──██░░██─██░░██──██░░██─██░░██──██░░██──██░░██─
─██░░██──██░░██───██░░██──██░░██─████░░████─────────██░░██──██░░██─██░░██──██░░██─██░░██──██░░██████░░██─
─██░░██──██░░████─██░░██──██░░██─██░░░░████████████─██░░██████░░██─██░░██████░░██─██░░██──██░░░░░░░░░░██─
─██░░██──██░░░░██─██░░██──██░░██─██░░░░░░░░░░░░░░██─██░░░░░░░░░░██─██░░░░░░░░░░██─██░░██──██████████░░██─
─██████──████████─██████──██████─██████████████████─██████████████─██████████████─██████──────────██████─
─────────────────────────────────────────────────────────────────────────────────────────────────────────
]]--

-- STARTUP
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "kaz_garage")

KazRegisterArea = 0
KazCurrentCam = 0
KazCurrentShowCar2 = 0
KazCurrentLocationInUse = 0

KazName = " Garage"
r = "z"

KazMenuOpen = false

KazAreaInUse2 = {}
vehicles = {}
KazUsing = {}
KazVehicles = {}
KazCurrentGarage = {x=nil, y=nil, z=nil, h=nil}

RegisterNetEvent('KazGarage:GetVehicles')
RegisterNetEvent('KazGarage:LoadLocal2')
RegisterNetEvent('KazGarage:RemoveShowcar')
RegisterNetEvent('KazGarage:LoadServer2')
RegisterNetEvent('KazGarage:AreaUpdate')
RegisterNetEvent('KazGarage:LoadInUse2')
RegisterNetEvent('vrp_garages:setVehicle')

-- GARAGEFINDER, FOR AT REDUCERE FORBRUG
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(1000)
	if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
		for i = 1,cfg.KazGarageAmount do 
			if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), cfg.KazGarages[i].spawnx,cfg.KazGarages[i].spawny,cfg.KazGarages[i].spawnz, true ) < 30 then
				KazRegisterArea = i
			end
		end
	else
		for i = 1,cfg.KazGarageAmount do 
			if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), cfg.KazGarages[i].x,cfg.KazGarages[i].y,cfg.KazGarages[i].z, true ) < 10 then
				KazRegisterArea = i
			end
		end
	end
  end
end)

-- INDSÆTTER OM AREAS ER I BRUG PÅ SPAWN
Citizen.CreateThread(function()
	for i = 1,cfg.KazGarageAmount do
		KazAreaInUse2[i] = false
	end
	TriggerServerEvent('KazGarage:LoadInUse')
end)

-- CITIZEN // ÅBEN GARAGE // PARKER
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(1) 
		if KazRegisterArea ~= 0 then 
			if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
				for i = KazRegisterArea,KazRegisterArea do 
					if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), cfg.KazGarages[i].spawnx,cfg.KazGarages[i].spawny,cfg.KazGarages[i].spawnz, true ) < 30 then
						if KazAreaInUse2[cfg.KazGarages[i].sted] == false then
							DrawMarker(1, cfg.KazGarages[i].spawnx,cfg.KazGarages[i].spawny,cfg.KazGarages[i].spawnz-1.25, 1.0, 1.0, 0.5, 0, 0, 0, 3.5, 3.5, 1.5, 0, 150, 150, 255, false, true, 2, false, false, false, false)
						else
							DrawMarker(1, cfg.KazGarages[i].spawnx,cfg.KazGarages[i].spawny,cfg.KazGarages[i].spawnz-1.25, 1.0, 1.0, 0.5, 0, 0, 0, 3.5, 3.5, 1.5, 255, 0, 0, 255, false, true, 2, false, false, false, false)
						end
						if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), cfg.KazGarages[i].spawnx,cfg.KazGarages[i].spawny,cfg.KazGarages[i].spawnz, true ) < 2 then
							veh = GetVehiclePedIsIn(GetPlayerPed(-1), false)
							if GetPedInVehicleSeat(veh, -1) == GetPlayerPed(-1) then
								DrawText3Ds(cfg.KazGarages[i].spawnx,cfg.KazGarages[i].spawny,cfg.KazGarages[i].spawnz, "~w~[~b~E~w~] Parker Bilen", 3.0, 7)
								if IsControlJustPressed(1, 38) then
									local player = GetPlayerPed(-1)
									local bil = GetVehiclePedIsIn(player, false)
									local bilskaden = (GetVehicleEngineHealth(bil))
									local name = GetDisplayNameFromVehicleModel(GetEntityModel(bil))
									FreezeEntityPosition(bil, true)
									exports['ac_progressbar']:startUI(2500, "Parkere...") -- DISABLE HVIS I IKKE BRUGER ac_progressbar
									Citizen.Wait(1000)
									TaskLeaveVehicle(player, bil)
									Citizen.Wait(1000)
									  while DoesEntityExist(bil) do
										Citizen.Wait(500)
										SetEntityAsMissionEntity(bil, true, true)
										Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(bil))
										local vehtypes = {"car", "bike", "citybike", "default"}
										for _,v in pairs(vehtypes) do
											TriggerEvent("vrp_garages:setVehicle", v, nil)
										end
									  end
									if bilskaden ~= nil and player ~= nil and name ~= nil then 
										--TriggerServerEvent('kaz:savevehicle', player, name, bilskaden) -- DISABLE HVIS I IKKE BRUGER KAZ_DURABILITY
									end
								end
							end
						end
					end
				end
			else
				for i = KazRegisterArea,KazRegisterArea do 
					if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), cfg.KazGarages[i].x,cfg.KazGarages[i].y,cfg.KazGarages[i].z, true ) < 10 then
						DrawMarker(1, cfg.KazGarages[i].x,cfg.KazGarages[i].y,cfg.KazGarages[i].z-2.0, 1.0, 1.0, 0.5, 0, 0, 0, 1.5, 1.5, 1.5, 0, 150, 150, 255, false, true, 2, false, false, false, false)
						if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), cfg.KazGarages[i].x,cfg.KazGarages[i].y,cfg.KazGarages[i].z, true ) < 1 then
							DrawText3Ds(cfg.KazGarages[i].x,cfg.KazGarages[i].y,cfg.KazGarages[i].z, "~w~[~b~E~w~] Åben Garage", 3.0, 7)
							if IsControlJustPressed(1, 38) then
								if KazMenuOpen == false then 
									TriggerEvent('KazNewOpen', true)
									if cfg.KazGarages[i].height ~= nil then Kazheight = cfg.KazGarages[i].height else Kazheight = 4.0 end
									FreezeEntityPosition(GetPlayerPed(-1), true)
									KazSetCam(cfg.KazGarages[i].x,cfg.KazGarages[i].y,cfg.KazGarages[i].z+Kazheight, cfg.KazGarages[i].camh)
									KazCurrentGarage.spawnx = cfg.KazGarages[i].spawnx
									KazCurrentGarage.spawny = cfg.KazGarages[i].spawny
									KazCurrentGarage.spawnz = cfg.KazGarages[i].spawnz
									KazCurrentGarage.spawnh = cfg.KazGarages[i].spawnh
									MenuGarage()
									Menu.hidden = not Menu.hidden
									TriggerServerEvent('KazGarage:CheckForVeh')
									KazMenuOpen = true
									TriggerServerEvent('KazGarage:InUse', cfg.KazGarages[i].sted)
									KazCurrentLocationInUse = cfg.KazGarages[i].sted
								end
							end
						end
					Menu.renderGUI()
					end
				end
			end
		end
	end
end)

-- EVENTHANDLERS
AddEventHandler("KazGarage:GetVehicles", function(KazVehicleRetrieve)
    KazVehicles = {}
    KazVehicles = KazVehicleRetrieve
end)

AddEventHandler("KazGarage:RemoveShowcar", function()
 while DoesEntityExist(KazCurrentShowCar2) do
	Citizen.Wait(500)
	SetEntityAsMissionEntity(KazCurrentShowCar2, true, true )
	Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(KazCurrentShowCar2))
  end
end)

local z = "a"

AddEventHandler("KazGarage:LoadLocal2", function(vtype,name,vehicle_plate, vehicle_colorprimary, vehicle_colorsecondary, vehicle_pearlescentcolor, vehicle_wheelcolor, vehicle_plateindex, vehicle_neoncolor1, vehicle_neoncolor2, vehicle_neoncolor3, vehicle_windowtint, vehicle_wheeltype, vehicle_mods0, vehicle_mods1, vehicle_mods2, vehicle_mods3, vehicle_mods4, vehicle_mods5, vehicle_mods6, vehicle_mods7, vehicle_mods8, vehicle_mods9, vehicle_mods10, vehicle_mods11, vehicle_mods12, vehicle_mods13, vehicle_mods14, vehicle_mods15, vehicle_mods16, vehicle_turbo, vehicle_tiresmoke, vehicle_xenon, vehicle_mods23, vehicle_mods24, vehicle_neon0, vehicle_neon1, vehicle_neon2, vehicle_neon3, vehicle_bulletproof, vehicle_smokecolor1, vehicle_smokecolor2, vehicle_smokecolor3, vehicle_modvariation)
  while DoesEntityExist(KazCurrentShowCar2) do
	SetEntityAsMissionEntity(KazCurrentShowCar2, true, true )
	Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(KazCurrentShowCar2))
	Citizen.Wait(1)
  end
  if DoesEntityExist(KazCurrentShowCar2) == false then 
	  local vehicle = vehicles[vtype]
	  vehicle = vehicles[vtype]
		local mhash = GetHashKey(name)
		local i = 0
		while not HasModelLoaded(mhash) and i < 1000 do
		  RequestModel(mhash)
		  Citizen.Wait(10)
		  i = i+1
		end
		if HasModelLoaded(mhash) then
		  local KazCurrentShowCar = CreateVehicle(mhash, KazCurrentGarage.spawnx,KazCurrentGarage.spawny,KazCurrentGarage.spawnz+0.5, KazCurrentGarage.spawnh, false, false) 
		  KazCurrentShowCar2 = KazCurrentShowCar
		  SetVehicleOnGroundProperly(KazCurrentShowCar)
		  SetEntityInvincible(KazCurrentShowCar,true)
		  SetVehicleNumberPlateText(KazCurrentShowCar, vehicle_plate)
		  SetModelAsNoLongerNeeded(mhash)
		  local primarycolor = tonumber(vehicle_colorprimary)
		  local secondarycolor = tonumber(vehicle_colorsecondary)
		  local pearlescentcolor = vehicle_pearlescentcolor
		  local wheelcolor = vehicle_wheelcolor
		  local plateindex = tonumber(vehicle_plateindex)
		  local neoncolor = {vehicle_neoncolor1,vehicle_neoncolor2,vehicle_neoncolor3}
		  local windowtint = vehicle_windowtint
		  local wheeltype = tonumber(vehicle_wheeltype)
		  local mods0 = tonumber(vehicle_mods0)
		  local mods1 = tonumber(vehicle_mods1)
		  local mods2 = tonumber(vehicle_mods2)
		  local mods3 = tonumber(vehicle_mods3)
		  local mods4 = tonumber(vehicle_mods4)
		  local mods5 = tonumber(vehicle_mods5)
		  local mods6 = tonumber(vehicle_mods6)
		  local mods7 = tonumber(vehicle_mods7)
		  local mods8 = tonumber(vehicle_mods8)
		  local mods9 = tonumber(vehicle_mods9)
		  local mods10 = tonumber(vehicle_mods10)
		  local mods11 = tonumber(vehicle_mods11)
		  local mods12 = tonumber(vehicle_mods12)
		  local mods13 = tonumber(vehicle_mods13)
		  local mods14 = tonumber(vehicle_mods14)
		  local mods15 = tonumber(vehicle_mods15)
		  local mods16 = tonumber(vehicle_mods16)
		  local turbo = vehicle_turbo
		  local tiresmoke = vehicle_tiresmoke
		  local xenon = vehicle_xenon
		  local mods23 = tonumber(vehicle_mods23)
		  local mods24 = tonumber(vehicle_mods24)
		  local neon0 = vehicle_neon0
		  local neon1 = vehicle_neon1
		  local neon2 = vehicle_neon2
		  local neon3 = vehicle_neon3
		  local bulletproof = vehicle_bulletproof
		  local smokecolor1 = vehicle_smokecolor1
		  local smokecolor2 = vehicle_smokecolor2
		  local smokecolor3 = vehicle_smokecolor3
		  local variation = vehicle_modvariation
		  SetVehicleColours(KazCurrentShowCar, primarycolor, secondarycolor)
		  SetVehicleExtraColours(KazCurrentShowCar, tonumber(pearlescentcolor), tonumber(wheelcolor))
		  SetVehicleNumberPlateTextIndex(KazCurrentShowCar,plateindex)
		  SetVehicleNeonLightsColour(KazCurrentShowCar,tonumber(neoncolor[1]),tonumber(neoncolor[2]),tonumber(neoncolor[3]))
		  SetVehicleTyreSmokeColor(KazCurrentShowCar,tonumber(smokecolor1),tonumber(smokecolor2),tonumber(smokecolor3))
		  SetVehicleModKit(KazCurrentShowCar,0)
		  SetVehicleMod(KazCurrentShowCar, 0, mods0)
		  SetVehicleMod(KazCurrentShowCar, 1, mods1)
		  SetVehicleMod(KazCurrentShowCar, 2, mods2)
		  SetVehicleMod(KazCurrentShowCar, 3, mods3)
		  SetVehicleMod(KazCurrentShowCar, 4, mods4)
		  SetVehicleMod(KazCurrentShowCar, 5, mods5)
		  SetVehicleMod(KazCurrentShowCar, 6, mods6)
		  SetVehicleMod(KazCurrentShowCar, 7, mods7)
		  SetVehicleMod(KazCurrentShowCar, 8, mods8)
		  SetVehicleMod(KazCurrentShowCar, 9, mods9)
		  SetVehicleMod(KazCurrentShowCar, 10, mods10)
		  SetVehicleMod(KazCurrentShowCar, 11, mods11)
		  SetVehicleMod(KazCurrentShowCar, 12, mods12)
		  SetVehicleMod(KazCurrentShowCar, 13, mods13)
		  SetVehicleMod(KazCurrentShowCar, 14, mods14)
		  SetVehicleMod(KazCurrentShowCar, 15, mods15)
		  SetVehicleMod(KazCurrentShowCar, 16, mods16)
		  if turbo == "on" then
			ToggleVehicleMod(KazCurrentShowCar, 18, true)
		  else          
			ToggleVehicleMod(KazCurrentShowCar, 18, false)
		  end
		  if tiresmoke == "on" then
			ToggleVehicleMod(KazCurrentShowCar, 20, true)
		  else          
			ToggleVehicleMod(KazCurrentShowCar, 20, false)
		  end
		  if xenon == "on" then
			ToggleVehicleMod(KazCurrentShowCar, 22, true)
		  else          
			ToggleVehicleMod(KazCurrentShowCar, 22, false)
		  end
		  SetVehicleWheelType(KazCurrentShowCar, tonumber(wheeltype))
		  SetVehicleMod(KazCurrentShowCar, 23, mods23)
		  SetVehicleMod(KazCurrentShowCar, 24, mods24)
		  if neon0 == "on" then
			SetVehicleNeonLightEnabled(KazCurrentShowCar,0, true)
		  else
			SetVehicleNeonLightEnabled(KazCurrentShowCar,0, false)
		  end
		  if neon1 == "on" then
			SetVehicleNeonLightEnabled(KazCurrentShowCar,1, true)
		  else
			SetVehicleNeonLightEnabled(KazCurrentShowCar,1, false)
		  end
		  if neon2 == "on" then
			SetVehicleNeonLightEnabled(KazCurrentShowCar,2, true)
		  else
			SetVehicleNeonLightEnabled(KazCurrentShowCar,2, false)
		  end
		  if neon3 == "on" then
			SetVehicleNeonLightEnabled(KazCurrentShowCar,3, true)
		  else
			SetVehicleNeonLightEnabled(KazCurrentShowCar,3, false)
		  end
		  if bulletproof == "on" then
			SetVehicleTyresCanBurst(KazCurrentShowCar, false)
		  else
			SetVehicleTyresCanBurst(KazCurrentShowCar, true)
		  end
		  SetVehicleWindowTint(KazCurrentShowCar,tonumber(windowtint))
		  SetEntityCollision(KazCurrentShowCar, false, true)
		  FreezeEntityPosition(KazCurrentShowCar, true)
		end
	end
end)

AddEventHandler("KazGarage:LoadInUse2", function(KazAreaInUse)
KazAreaInUse2 = KazAreaInUse
end)

AddEventHandler("KazGarage:AreaUpdate", function(KazAreaInUse)
KazAreaInUse2 = KazAreaInUse
end)

AddEventHandler('vrp_garages:setVehicle', function(vtype, vehicle)
  vehicles[vtype] = vehicle
end)

AddEventHandler("KazGarage:LoadServer2", function(vtype,name,vehicle_plate, vehicle_colorprimary, vehicle_colorsecondary, vehicle_pearlescentcolor, vehicle_wheelcolor, vehicle_plateindex, vehicle_neoncolor1, vehicle_neoncolor2, vehicle_neoncolor3, vehicle_windowtint, vehicle_wheeltype, vehicle_mods0, vehicle_mods1, vehicle_mods2, vehicle_mods3, vehicle_mods4, vehicle_mods5, vehicle_mods6, vehicle_mods7, vehicle_mods8, vehicle_mods9, vehicle_mods10, vehicle_mods11, vehicle_mods12, vehicle_mods13, vehicle_mods14, vehicle_mods15, vehicle_mods16, vehicle_turbo, vehicle_tiresmoke, vehicle_xenon, vehicle_mods23, vehicle_mods24, vehicle_neon0, vehicle_neon1, vehicle_neon2, vehicle_neon3, vehicle_bulletproof, vehicle_smokecolor1, vehicle_smokecolor2, vehicle_smokecolor3, vehicle_modvariation)
	FreezeEntityPosition(GetPlayerPed(-1), false)
	KazMenuOpen = false
	TriggerServerEvent('KazGarage:NotInUse', KazCurrentLocationInUse)
	TriggerEvent('KazNewOpen', false)
  while DoesEntityExist(KazCurrentShowCar2) do
	Citizen.Wait(500)
	SetEntityAsMissionEntity(KazCurrentShowCar2, true, true )
	Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(KazCurrentShowCar2))
	TriggerEvent("vrp_garages:setVehicle", vtype, nil)
  end
  local vehicle = KazUsing[vtype]
  if vehicle and not IsVehicleDriveable(vehicle[3]) then
    SetVehicleHasBeenOwnedByPlayer(vehicle[3],false)
    Citizen.InvokeNative(0xAD738C3085FE7E11, vehicle[3], false, true) 
    SetVehicleAsNoLongerNeeded(Citizen.PointerValueIntInitialized(vehicle[3]))
    Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(vehicle[3]))
    KazUsing[vtype] = nil
  end
  vehicle = KazUsing[vtype]
  if vehicle == nil then
    local mhash = GetHashKey(name)
    local i = 0
    while not HasModelLoaded(mhash) and i < 10000 do
      RequestModel(mhash)
      Citizen.Wait(10)
      i = i+1
    end
    if HasModelLoaded(mhash) then
      local nveh = CreateVehicle(mhash, KazCurrentGarage.spawnx,KazCurrentGarage.spawny,KazCurrentGarage.spawnz+0.5, KazCurrentGarage.spawnh, true, false)
	  exports['ac_progressbar']:startUI(5000, "Klargører "..name.."...") -- DISABLE HVIS I IKKE BRUGER ac_progressbar
      SetVehicleOnGroundProperly(nveh)
      SetEntityInvincible(nveh,false)
      --SetPedIntoVehicle(GetPlayerPed(-1),nveh,-1)
	  TaskEnterVehicle(GetPlayerPed(-1), nveh, 10000, -1, 1, 1, 0)
      SetVehicleNumberPlateText(nveh, vehicle_plate)
      SetVehicleHasBeenOwnedByPlayer(nveh,true)
	  local nid = NetworkGetNetworkIdFromEntity(nveh)
      SetNetworkIdCanMigrate(nid,true)
	  KazUsing[vtype] = {vtype,name,nveh}
      SetModelAsNoLongerNeeded(mhash)
      local plate = plate
      local primarycolor = tonumber(vehicle_colorprimary)
      local secondarycolor = tonumber(vehicle_colorsecondary)
      local pearlescentcolor = vehicle_pearlescentcolor
      local wheelcolor = vehicle_wheelcolor
      local plateindex = tonumber(vehicle_plateindex)
      local neoncolor = {vehicle_neoncolor1,vehicle_neoncolor2,vehicle_neoncolor3}
      local windowtint = vehicle_windowtint
      local wheeltype = tonumber(vehicle_wheeltype)
      local mods0 = tonumber(vehicle_mods0)
      local mods1 = tonumber(vehicle_mods1)
      local mods2 = tonumber(vehicle_mods2)
      local mods3 = tonumber(vehicle_mods3)
      local mods4 = tonumber(vehicle_mods4)
      local mods5 = tonumber(vehicle_mods5)
      local mods6 = tonumber(vehicle_mods6)
      local mods7 = tonumber(vehicle_mods7)
      local mods8 = tonumber(vehicle_mods8)
      local mods9 = tonumber(vehicle_mods9)
      local mods10 = tonumber(vehicle_mods10)
      local mods11 = tonumber(vehicle_mods11)
      local mods12 = tonumber(vehicle_mods12)
      local mods13 = tonumber(vehicle_mods13)
      local mods14 = tonumber(vehicle_mods14)
      local mods15 = tonumber(vehicle_mods15)
      local mods16 = tonumber(vehicle_mods16)
      local turbo = vehicle_turbo
      local tiresmoke = vehicle_tiresmoke
      local xenon = vehicle_xenon
      local mods23 = tonumber(vehicle_mods23)
      local mods24 = tonumber(vehicle_mods24)
      local neon0 = vehicle_neon0
      local neon1 = vehicle_neon1
      local neon2 = vehicle_neon2
      local neon3 = vehicle_neon3
      local bulletproof = vehicle_bulletproof
      local smokecolor1 = vehicle_smokecolor1
      local smokecolor2 = vehicle_smokecolor2
      local smokecolor3 = vehicle_smokecolor3
      local variation = vehicle_modvariation
      SetVehicleColours(nveh, primarycolor, secondarycolor)
      SetVehicleExtraColours(nveh, tonumber(pearlescentcolor), tonumber(wheelcolor))
      SetVehicleNumberPlateTextIndex(nveh,plateindex)
      SetVehicleNeonLightsColour(nveh,tonumber(neoncolor[1]),tonumber(neoncolor[2]),tonumber(neoncolor[3]))
      SetVehicleTyreSmokeColor(nveh,tonumber(smokecolor1),tonumber(smokecolor2),tonumber(smokecolor3))
      SetVehicleModKit(nveh,0)
      SetVehicleMod(nveh, 0, mods0)
      SetVehicleMod(nveh, 1, mods1)
      SetVehicleMod(nveh, 2, mods2)
      SetVehicleMod(nveh, 3, mods3)
      SetVehicleMod(nveh, 4, mods4)
      SetVehicleMod(nveh, 5, mods5)
      SetVehicleMod(nveh, 6, mods6)
      SetVehicleMod(nveh, 7, mods7)
      SetVehicleMod(nveh, 8, mods8)
      SetVehicleMod(nveh, 9, mods9)
      SetVehicleMod(nveh, 10, mods10)
      SetVehicleMod(nveh, 11, mods11)
      SetVehicleMod(nveh, 12, mods12)
      SetVehicleMod(nveh, 13, mods13)
      SetVehicleMod(nveh, 14, mods14)
      SetVehicleMod(nveh, 15, mods15)
      SetVehicleMod(nveh, 16, mods16)
      if turbo == "on" then
        ToggleVehicleMod(nveh, 18, true)
      else          
        ToggleVehicleMod(nveh, 18, false)
      end
      if tiresmoke == "on" then
        ToggleVehicleMod(nveh, 20, true)
      else          
        ToggleVehicleMod(nveh, 20, false)
      end
      if xenon == "on" then
        ToggleVehicleMod(nveh, 22, true)
      else          
        ToggleVehicleMod(nveh, 22, false)
      end
    SetVehicleWheelType(nveh, tonumber(wheeltype))
      SetVehicleMod(nveh, 23, mods23)
      SetVehicleMod(nveh, 24, mods24)
      if neon0 == "on" then
        SetVehicleNeonLightEnabled(nveh,0, true)
      else
        SetVehicleNeonLightEnabled(nveh,0, false)
      end
      if neon1 == "on" then
        SetVehicleNeonLightEnabled(nveh,1, true)
      else
        SetVehicleNeonLightEnabled(nveh,1, false)
      end
      if neon2 == "on" then
        SetVehicleNeonLightEnabled(nveh,2, true)
      else
        SetVehicleNeonLightEnabled(nveh,2, false)
      end
      if neon3 == "on" then
        SetVehicleNeonLightEnabled(nveh,3, true)
      else
        SetVehicleNeonLightEnabled(nveh,3, false)
      end
      if bulletproof == "on" then
        SetVehicleTyresCanBurst(nveh, false)
      else
        SetVehicleTyresCanBurst(nveh, true)
      end
      SetVehicleWindowTint(nveh,tonumber(windowtint))
	  KazRandomAttempts = 0
	  while IsPedInAnyVehicle(GetPlayerPed(-1), false) == false do
	  	Citizen.Wait(1000)
		KazRandomAttempts = KazRandomAttempts+1
		if KazRandomAttempts >= 10 then 
			if IsVehicleSeatFree(nveh,-1) then
				TaskWarpPedIntoVehicle(GetPlayerPed(-1),nveh,-1)
			end
		end
	  end
	  if IsVehicleSeatFree(nveh,-1) then
		TaskWarpPedIntoVehicle(GetPlayerPed(-1),nveh,-1)
	  end
	  Citizen.Wait(100)
	  local player = GetPlayerPed(-1)
	  local bil = GetVehiclePedIsIn(player, false)
	  local vehID = GetDisplayNameFromVehicleModel(GetEntityModel(bil))
	  TriggerEvent('Kaz_Liveries:BilSpawned')
      --TriggerServerEvent('kaz:loadvehicle', vehID, player, bil)  -- DISABLE HVIS I IKKE BRUGER KAZ_DURABILITY
	  TriggerEvent("vrp_garages:setVehicle", vtype, {vtype,name,nveh})
    end
  else
    local cartype = ""
	if vtype == "car" then
        cartype = "bil"
	elseif vtype == "bike" then 
        cartype = "motorcykel"
	elseif vtype == "citybike" then
        cartype = "cykel"
	end
  TriggerEvent("pNotify:SendNotification",{text = "Du kan kun have én <b style='color:#B22222'>"..cartype.."</b> ude",type = "info",timeout = (2000),layout = "bottomCenter",queue = "global",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
  end
end)

local e = "K"

-- FUNKTIONER
function KazListVehicle(page)
    ped = GetPlayerPed(-1)
  selectedPage = page
    MenuTitle = "Køretøjer"
    ClearMenu()
  local count = 0
    for ind, value in pairs(KazVehicles) do
    if ((count >= (page*10)) and (count < ((page*10)+10))) then
        Menu.addButton(tostring(value.vehicle_name), "OptionVehicle", tostring(value.vehicle_model))
    end
    count = count + 1
    end   
    Menu.addButton("Næste","KazListVehicle",page+1)
  if page == 0 then
      Menu.addButton("Tilbage","MenuGarage",nil)
  else
      Menu.addButton("Tilbage","KazListVehicle",page-1)
  end
end

function MenuGarage()
    ped = GetPlayerPed(-1)
  selectedPage = 0
    MenuTitle = KazName -- MÅ IKKE ÆNDRES
    ClearMenu()
    Menu.addButton("Hent","KazListVehicle",selectedPage)
    Menu.addButton("Luk","CloseMenu",nil) 
end

function SpawnVehicle(vehID)
SetCamActive(KazCurrentCam, false)
DestroyCam(KazCurrentCam)
DetachCam(KazCurrentCam)
RenderScriptCams(false, true, 2000, true, true)
  while DoesEntityExist(KazCurrentShowCar2) do
	Citizen.Wait(500)
	SetEntityAsMissionEntity(KazCurrentShowCar2, true, true )
	Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(KazCurrentShowCar2))
  end
  local vehID = vehID
  local player = GetPlayerPed(-1)
  TriggerServerEvent('KazGarage:LoadServer', vehID)
  CloseMenu()
end

function Skiftnavn(vehID)
	local vehID = vehID
	TriggerServerEvent('ply_garages:SkiftNavn', vehID)
	CloseMenu()
  end  

function CloseMenu()
    Menu.hidden = true    
    TriggerServerEvent("KazGarage:CheckForVeh")
	SetCamActive(KazCurrentCam, false)
	DestroyCam(KazCurrentCam)
	DetachCam(KazCurrentCam)
	RenderScriptCams(false, true, 2000, true, true)
	FreezeEntityPosition(GetPlayerPed(-1), false)
	KazMenuOpen = false
	TriggerServerEvent('KazGarage:NotInUse', KazCurrentLocationInUse)
	TriggerEvent('KazNewOpen', false)
end


function OptionVehicle(vehID)
	local vehID = vehID
	  MenuTitle = "Valg"
	  ClearMenu()
	  Menu.addButton("Hent", "SpawnVehicle", vehID)
	  Menu.addButton("Skift Navn", "Skiftnavn", vehID)
	  Menu.addButton("Luk", "KazListVehicle", selectedPage)
  end

function KazSetCam(CamX, CamY, CamZ, CamH)
	if KazCurrentCam ~= 0 then 
		DestroyCam(KazCurrentCam)
	end
	KazCurrentCam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
	SetCamCoord(KazCurrentCam, CamX, CamY, CamZ, CamH)
	SetCamRot(KazCurrentCam, -21.637795701623, 0.0, CamH)
	SetCamActive(KazCurrentCam, true)
	RenderScriptCams(1, 1, 750, 1, 1)
end

function DrawText3Ds(x,y,z, text)
  local onScreen,_x,_y=World3dToScreen2d(x,y,z)
  local px,py,pz=table.unpack(GetGameplayCamCoords())
  SetTextScale(0.35, 0.35)
  SetTextFont(4)
  SetTextProportional(1)
  SetTextColour(255, 255, 255, 215)
  SetTextEntry("STRING")
  SetTextCentre(1)
  AddTextComponentString(text)
  DrawText(_x,_y)
  local factor = (string.len(text)) / 370
  DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end

Citizen.CreateThread(function()
  for _, item in pairs(cfg.KazGarages) do
	if not item.hidden then
      item.blip = AddBlipForCoord(item.x, item.y, item.z)
      SetBlipSprite(item.blip, 357)
      SetBlipAsShortRange(item.blip, true)
      SetBlipColour(item.blip, 3)
      SetBlipScale(item.blip, 0.6)
      BeginTextCommandSetBlipName("STRING")
      AddTextComponentString("Garage")
      EndTextCommandSetBlipName(item.blip)
	end
  end
end)
