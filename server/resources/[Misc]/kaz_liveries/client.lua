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

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "kaz_liveries")

KazLiveriesCurrent = nil
KazMenuOpened = false
LiveriesAntalValgt = 1

RegisterNetEvent('Kaz_Liveries:Bought')
RegisterNetEvent('Kaz_Liveries:BilSpawned')
RegisterNetEvent('Kaz_Liveries:ApplyLivery')

Citizen.CreateThread(function()
    while true do
    Citizen.Wait(1)
		if KazLiveriesCurrent ~= nil then 
			for i = KazLiveriesCurrent,KazLiveriesCurrent do
				if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), cfg.LiveriesLokation[i].x,cfg.LiveriesLokation[i].y,cfg.LiveriesLokation[i].z, true ) < 15 then
					incar = IsPedInAnyVehicle(GetPlayerPed(-1), false) 
					if incar == 1 then 
						DrawMarker(1, cfg.LiveriesLokation[i].x,cfg.LiveriesLokation[i].y,cfg.LiveriesLokation[i].z-0.7,0,0,0,0,0,0,4.501,4.5001,0.5001,102,204,0,200,0,0,0,true)
						if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), cfg.LiveriesLokation[i].x,cfg.LiveriesLokation[i].y,cfg.LiveriesLokation[i].z, true ) < 3 then
							drawTxt("Tryk [~g~E~w~] for at åbne Liverymenuen.",0,1,0.5,0.82,0.6,255,255,255,255)
							if IsControlJustPressed(1, 38) then
								local ped = GetPlayerPed(-1)
								local car = GetVehiclePedIsUsing(ped)
								SetVehicleModKit(car, 0)
								AntalLiveries = GetNumVehicleMods(car, 48)
								if  AntalLiveries ~= nil then
									if AntalLiveries > 0 then
										LiveriesAntalValgt = 1
										KazMenuOpened = true
										Metode = 1
										KazOpenMenu(AntalLiveries, Metode)
									else
										AndenLiveries = GetVehicleLiveryCount(car)
										if AndenLiveries ~= nil and AndenLiveries ~= 0 then 
											LiveriesAntalValgt = 1
											KazMenuOpened = true
											Metode = 2
											KazOpenMenu(AndenLiveries, Metode)
										else
											TriggerEvent("pNotify:SendNotification",{text = "Bilen har ingen Liveries.",type = "error",timeout = (8000),layout = "bottomCenter",queue = "global",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
										end
									end
								end
								Citizen.Wait(200)
							end
						end
					end
				end
			end
		end
	end
end)

function KazOpenMenu(AntalLiveries2, Metode)
	while KazMenuOpened == true do
		Citizen.Wait(1)
		local ped = GetPlayerPed(-1)
		local car = GetVehiclePedIsUsing(ped)
		local yoffset = 0.2
		local xoffset = 0.2
		local NytOffset = 0.215
		local LiveriesTitle = "Liveries" -- MÅ IKKE ÆNDRES!!
		SetTextFont(4)
		SetTextScale(0.0, 0.5)
		SetTextColour(255, 255, 255, 200)
		SetTextDropshadow(0, 0, 0, 0, 255)
		SetTextEdge(1, 0, 0, 0, 255)
		SetTextDropShadow()
		SetTextOutline()
		SetTextCentre(true)
		SetTextProportional(0)
		SetTextEntry("STRING")
		AddTextComponentString(LiveriesTitle)
		DrawText(xoffset, yoffset)
		DrawRect(xoffset, 0.215, yoffset+0.015, 0.05, 0, 0, 0, 200)
		AntalOnLivery = 0
		for i = 1,AntalLiveries2 do
			local screen_w = 0
			local screen_h = 0
			screen_w, screen_h =  GetScreenResolution(0, 0)
			
			if i == LiveriesAntalValgt then 
				boxColor = {255,255,255,50}
				SetTextColour(0, 0, 0, 255)
			else
				boxColor = {0,0,0,150}
				SetTextColour(255, 255, 255, 255)
			end
			SetTextFont(0)
			SetTextScale(0.0,0.35)
			SetTextCentre(true)
			SetTextEdge(0, 0, 0, 0, 0)
			SetTextEntry("STRING") 
			AntalOnLivery = AntalOnLivery+1
			AddTextComponentString("Livery "..tostring(AntalOnLivery).."")
			local xoffset = 0.2
			local xmin = 0.0
			local xmax = 0.3
			local ymin = 0.05
			local ymax = 0.05
			NytOffset = NytOffset + 0.05
			local ymin2 = ymin * (AntalOnLivery + 0.01) +yoffset
			DrawText(xoffset, ymin2)
			DrawRect(xoffset, NytOffset, yoffset+0.015, 0.05, boxColor[1],boxColor[2],boxColor[3],boxColor[4])	
		end
		if IsControlJustPressed(1, 173) then
			if LiveriesAntalValgt < AntalLiveries2 then
				LiveriesAntalValgt = LiveriesAntalValgt+1
			end
		elseif IsControlJustPressed(1, 172) then
			if LiveriesAntalValgt > 1 then 
				LiveriesAntalValgt = LiveriesAntalValgt-1
			end
		elseif IsControlJustPressed(1, 202) then
			KazCloseMenu()
		elseif IsControlJustPressed(1, 176) then
			local ok, vtype, name = vRP.getNearestOwnedVehicle({7})
			if name ~= nil then 
				TriggerServerEvent('Kaz_Liveries:BuyNow', LiveriesAntalValgt, Metode, name)
			else
				TriggerEvent("pNotify:SendNotification",{text = "Du ejer ikke køretøjet!",type = "error",timeout = (8000),layout = "bottomCenter",queue = "global",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
			end
		end
		drawTxt("[ENTER]: Køb Livery - Pris: "..cfg.LiveriesPris.."",0,1,0.5,0.82,0.4,255,255,255,255)
		drawTxt("[PILE-TASTER]: Bevæg Menu",0,1,0.5,0.85,0.4,255,255,255,255)
		drawTxt("[BACKSPACE]: Luk Menu",0,1,0.5,0.88,0.4,255,255,255,255)
		DrawRect(0.5, 0.865, 0.15, 0.10, 0, 0, 0, 200)
		if Metode == 1 then 
			SetVehicleMod(car, 48, LiveriesAntalValgt, true)
		elseif Metode == 2 then 
			SetVehicleLivery(car, LiveriesAntalValgt)
		end
	end
end

function KazCloseMenu()
	if KazMenuOpened == true then 
		KazMenuOpened = false
	end
end

Citizen.CreateThread(function()
    while true do
    Citizen.Wait(1000)
		KazPlaceFound = false
		for i = 1,cfg.LiveriesLocations do
			if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), cfg.LiveriesLokation[i].x,cfg.LiveriesLokation[i].y,cfg.LiveriesLokation[i].z, true ) < 15 then
				KazLiveriesCurrent = i
				KazPlaceFound = true
			end
		end
		if KazPlaceFound == false then
			KazLiveriesCurrent = nil
			if KazMenuOpened == true then
				KazCloseMenu()
			end
			KazMenuOpened = false
		end
	end
end)

AddEventHandler('Kaz_Liveries:Bought', function()
	KazCloseMenu()
	TriggerEvent("pNotify:SendNotification",{text = "Du købte liveriet til din bil.",type = "success",timeout = (8000),layout = "bottomCenter",queue = "global",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
end)

AddEventHandler('Kaz_Liveries:BilSpawned', function()
	Citizen.Wait(1000)
	local ped = GetPlayerPed(-1)
	local car = GetVehiclePedIsUsing(ped)
	if car ~= nil then 
		SetVehicleModKit(car, 0)
		AntalLiveries = GetNumVehicleMods(car, 48)
		if AntalLiveries ~= nil and AntalLiveries > 0 then
			Metode = 1
			local ok, vtype, name = vRP.getNearestOwnedVehicle({7})
			if name ~= nil then 
				TriggerServerEvent('Kaz_Liveries:LoadCar', Metode, name)
			end
		else
			AndenLiveries = GetVehicleLiveryCount(car)
			if AndenLiveries ~= nil and AndenLiveries ~= 0 then
				Metode = 2
				local ok, vtype, name = vRP.getNearestOwnedVehicle({7})
				if name ~= nil then 
					TriggerServerEvent('Kaz_Liveries:LoadCar', Metode, name)
				end
			end
		end
	end
end)

AddEventHandler('Kaz_Liveries:ApplyLivery', function(MetodeHentet2, LiveryHentet2)
MetodeHentet = tonumber(MetodeHentet2)
LiveryHentet = tonumber(LiveryHentet2)
local ped = GetPlayerPed(-1)
local car = GetVehiclePedIsUsing(ped)
local ok, vtype, name = vRP.getNearestOwnedVehicle({7})
	if car ~= nil and name ~= nil then 
		SetVehicleModKit(car, 0)
		if MetodeHentet == 1 then 
			SetVehicleMod(car, 48, LiveryHentet, true)
			TriggerEvent("pNotify:SendNotification",{text = "Livery Påsat",type = "success",timeout = (3000),layout = "bottomCenter",queue = "global",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
		elseif MetodeHentet == 2 then 
			SetVehicleLivery(car, LiveryHentet)
			TriggerEvent("pNotify:SendNotification",{text = "Livery Påsat",type = "success",timeout = (3000),layout = "bottomCenter",queue = "global",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
		end
	end
end)
		
function drawTxt(text,font,centre,x,y,scale,r,g,b,a)
	SetTextFont(6)
	SetTextProportional(6)
	SetTextScale(scale/1.0, scale/1.0)
	SetTextColour(r, g, b, a)
	SetTextDropShadow(0, 0, 0, 0,255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(centre)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x , y)
end

Citizen.CreateThread(function()
  for _, item in pairs(cfg.LiveriesLokation) do
	if not item.hidden then
      item.blip = AddBlipForCoord(item.x, item.y, item.z)
      SetBlipSprite(item.blip, 488)
      SetBlipAsShortRange(item.blip, true)
      SetBlipColour(item.blip, 2)
      SetBlipScale(item.blip, 0.8)
      BeginTextCommandSetBlipName("STRING")
      AddTextComponentString("Liveries")
      EndTextCommandSetBlipName(item.blip)
	end
  end
end)
