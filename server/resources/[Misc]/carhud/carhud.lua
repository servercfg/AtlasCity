local Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
    ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

local isUiOpen = false 
local speedBuffer  = {}
local velBuffer    = {}
local beltOn       = false
local wasInCar     = false

IsCar = function(veh)
        local vc = GetVehicleClass(veh)
        return (vc >= 0 and vc <= 7) or (vc >= 9 and vc <= 12) or (vc >= 17 and vc <= 20)
        end 

Fwv = function (entity)
        local hr = GetEntityHeading(entity) + 90.0
        if hr < 0.0 then hr = 360.0 + hr end
        hr = hr * 0.0174533
        return { x = math.cos(hr) * 2.0, y = math.sin(hr) * 2.0 }
      end
 
 
Citizen.CreateThread(function()
  while true do
  Citizen.Wait(0)
  
    local ped = GetPlayerPed(-1)
    local car = GetVehiclePedIsIn(ped)
    
    if car ~= 0 and (wasInCar or IsCar(car)) then
      wasInCar = true
             if isUiOpen == false and not IsPlayerDead(PlayerId()) then
                SendNUIMessage({
            	   displayWindow = 'true'
            	   })
                isUiOpen = true 			
            end

      if beltOn then DisableControlAction(0, 75) end

      speedBuffer[2] = speedBuffer[1]
      speedBuffer[1] = GetEntitySpeed(car)
      
      if speedBuffer[2] ~= nil 
         and not beltOn
         and GetEntitySpeedVector(car, true).y > 1.0  
         and speedBuffer[1] > 19.25 
         and (speedBuffer[2] - speedBuffer[1]) > (speedBuffer[1] * 0.255) then
         
        local co = GetEntityCoords(ped)
        local fw = Fwv(ped)
        SetEntityCoords(ped, co.x + fw.x, co.y + fw.y, co.z - 0.47, true, true, true)
        SetEntityVelocity(ped, velBuffer[2].x, velBuffer[2].y, velBuffer[2].z)
        Citizen.Wait(1)
        SetPedToRagdoll(ped, 1000, 1000, 0, 0, 0, 0)
      end
        
      velBuffer[2] = velBuffer[1]
      velBuffer[1] = GetEntityVelocity(car)
        
      if IsControlJustReleased(0, 48) and GetLastInputMethod(0) then
        beltOn = not beltOn 
        if beltOn then exports['mythic_notify']:DoHudText('success', 'Sikkerhedssele spændt', 9000) --TriggerEvent("pNotify:SendNotification", {text = "✅ Sikkerhedssele <b style='color: #5DB6E5'>spændt</b>.", type = "success", timeout = 1400, layout = "bottomCenter"})
		TriggerServerEvent('InteractSound_SV:PlayOnSource', 'buckle', 0.3)	
			SendNUIMessage({
			   displayWindow = 'false'
			   })
			isUiOpen = true 
		else 
			exports['mythic_notify']:DoHudText('error', 'Sikkerhedssele løsnet', 9000)
		--TriggerEvent("pNotify:SendNotification", {text = "⛔️ Sikkerhedssele <b style='color: #DB4646'>løsnet</b>.", type = "error", timeout = 1400, layout = "bottomCenter"}) 
        TriggerServerEvent('InteractSound_SV:PlayOnSource', 'unbuckle', 0.3)
			SendNUIMessage({
			   displayWindow = 'true'
			   })
			isUiOpen = true  
		end
      end
      
    elseif wasInCar then
      wasInCar = false
      beltOn = false
      speedBuffer[1], speedBuffer[2] = 0.0, 0.0
             if isUiOpen == true and not IsPlayerDead(PlayerId()) then
                SendNUIMessage({
            	   displayWindow = 'false'
            	   })
                isUiOpen = false 
            end
    end
    
  end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(100)
        if IsPlayerDead(PlayerId()) and isUiOpen == true then
            SendNUIMessage({
                    displayWindow = 'false'
               })
            isUiOpen = false
        end    

    end
end)   

Citizen.CreateThread(function()
  while true do Citizen.Wait(0)


    local MyPed = GetPlayerPed(-1)

  if(IsPedInAnyVehicle(MyPed, false))then

      drawTxt(0.616,1.263, 1.0,1.0,0.45, "SELE", 255, 0, 0, 255)
  end

      if beltOn then 
           drawTxt(0.616,1.263, 1.0,1.0,0.45, "SELE", 0, 255, 0, 255)
      end
  end
end)


local HUD = {
	
	Speed 			= 'kmh', -- Choose between "kmh" or "mph" (case sensitive) to display on the speedometer.

	SpeedIndicator 	= true, -- Displays a speedometer in either MPH or KMH depending on your preference.

	ParkIndicator 	= true, -- Displays vehicle gears as if the vehicle was AUTOMATIC transmission (Make sure that "CarGears" is set to FALSE if using this)

	Top 			= true, -- Displays the top panel ( Oil, DSC, Vehicle Plate, Fluid, AC )

	Plate 			= true, -- Displays the vehicle registration plate. (Set to TRUE if you wish to display the plate without the other goodies that "TOP" has)

	CarGears		= true, -- Displays vehicle gears as if the vehicle was manual transmission. (Make sure that "ParkIndicator" is set to FALSE if using this)

}

-- UI Location Control (Touching this is not recommended.)
local UI = { 

	x =  -0.001 ,	-- Base Screen Coords 	+ 	 x
	y = -0.001 ,	-- Base Screen Coords 	+ 	-y

}





-- ###################################
-- #                                 #
-- #          C   O   D   E          #
-- #                                 #
-- ###################################

-- DO NOT TOUCH THIS, It could break the resource.

Citizen.CreateThread(function()
	while true do Citizen.Wait(1)


		local MyPed = GetPlayerPed(-1)

		if(IsPedInAnyVehicle(MyPed, false))then

			local MyPedVeh = GetVehiclePedIsIn(GetPlayerPed(-1),false)
			local PlateVeh = GetVehicleNumberPlateText(MyPedVeh)
			local VehStopped = IsVehicleStopped(MyPedVeh)
			local VehEngineHP = GetVehicleEngineHealth(MyPedVeh) 
			local VehBodyHP = GetVehicleBodyHealth(MyPedVeh)
			local VehBurnout = IsVehicleInBurnout(MyPedVeh)
			local Gear = GetVehicleCurrentGear(MyPedVeh)
			local Running = IsVehicleDriveable(MyPedVeh, isOnFireCheck)

			if HUD.Speed == 'kmh' then
				Speed = GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false)) * 3.6
			elseif HUD.Speed == 'mph' then
				Speed = GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false)) * 2.236936
			else
				Speed = 0.0
			end

			if HUD.Top then
				drawTxt(UI.x + 0.520, UI.y + 1.264, 1.0,1.0,0.45, "~w~" .. PlateVeh, 255, 255, 255, 255)
				--drawTxt(UI.x + 0.514, UI.y + 1.245, 1.0,1.0,0.45, "ENGINE", 114, 219, 165,0)
  
				if VehBurnout then
					--drawTxt(UI.x + 0.535, UI.y + 1.266, 1.0,1.0,0.44, "~r~DSC", 255, 255, 255, 200)
				else
					--drawTxt(UI.x + 0.535, UI.y + 1.266, 1.0,1.0,0.44, "DSC", 255, 255, 255, 150)
				end	

				if (VehEngineHP > 0) and (VehEngineHP < 300) then
					--drawTxt(UI.x + 0.619, UI.y + 1.264, 1.0,1.0,0.45, "~y~Fluid", 255, 255, 255, 200)
					--drawTxt(UI.x + 0.514, UI.y + 1.264, 1.0,1.0,0.45, "~y~Oil", 255, 255, 255, 200)
					--drawTxt(UI.x + 0.645, UI.y + 1.264, 1.0,1.0,0.45, "~y~AC", 255, 255, 255, 200)
					--drawWarn(UI.x + 0.610, UI.y + 1.394, 1.0,1.0,0.39, "Tjek motoren", 255, 118, 0, 200)
					--drawRct(UI.x + 0.11,  UI.y + 0.898, 0.046,0.03,0,0,0,150)

				elseif VehEngineHP < 1 then 
					--drawRct(UI.x + 0.159, UI.y + 0.809, 0.005, 0,0,0,0,100)
					--drawTxt(UI.x + 0.619, UI.y + 1.264, 1.0,1.0,0.45, "~r~Fluid", 255, 255, 255, 200)
					--drawTxt(UI.x + 0.514, UI.y + 1.264, 1.0,1.0,0.45, "~r~Oil", 255, 255, 255, 200)
					--drawTxt(UI.x + 0.645, UI.y + 1.264, 1.0,1.0,0.45, "~r~AC", 255, 255, 255, 200)
					--drawWarn(UI.x + 0.610, UI.y + 1.394, 1.0,1.0,0.39, "Ring til Mekanikeren", 255, 118, 0, 200)
					--drawRct(UI.x + 0.11,  UI.y + 0.898, 0.046,0.03,0,0,0,150)

				else
					--drawTxt(UI.x + 0.619, UI.y + 1.264, 1.0,1.0,0.45, "Fluid", 255, 255, 255, 150)
					--drawTxt(UI.x + 0.514, UI.y + 1.264, 1.0,1.0,0.45, "Oil", 255, 255, 255, 150)
					--drawTxt(UI.x + 0.645, UI.y + 1.264, 1.0,1.0,0.45, "AC", 255, 255, 255, 150)
					--drawTxt(UI.x + 0.514, UI.y + 1.245, 1.0,1.0,0.45, "ENGINE", 87, 158, 113,0)
				end
				if HUD.ParkIndicator then
					if Running then
						--drawTxt(UI.x + 0.615, UI.y + 1.264, 1.0,1.0,0.45, "GEAR:", 255, 255, 255, 255)
					end
				end
			else
				if HUD.Plate then
					drawTxt(UI.x + 0.570, UI.y + 1.2624, 1.0,1.0,0.55, "~w~" .. PlateVeh, 255, 255, 255, 255) 
				end
				if HUD.ParkIndicator then

					if VehStopped then
						--drawTxt(UI.x + 0.643, UI.y + 1.34, 1.0,1.0,0.6, "~r~P", 255, 255, 255, 200)
					else
						--drawTxt(UI.x + 0.643, UI.y + 1.34, 1.0,1.0,0.6, "P", 255, 255, 255, 150)
					end
				end
			end
			
			if HUD.CarGears then
				if VehStopped and (Speed == 0) then
					drawTxt(UI.x + 0.645, UI.y + 1.264, 1.0,1.0,0.45, "P", 0, 255, 255, 255)
				elseif Gear < 1 then
					drawTxt(UI.x + 0.645, UI.y + 1.264, 1.0,1.0,0.45, "R", 255, 142, 0, 255)						
				elseif Gear == 1 then
					drawTxt(UI.x + 0.645, UI.y + 1.264, 1.0,1.0,0.45, "1", 255, 142, 0, 255)
				elseif Gear == 2 then
					drawTxt(UI.x + 0.645, UI.y + 1.264, 1.0,1.0,0.45, "2", 255, 142, 0, 255)
				elseif Gear == 3 then
					drawTxt(UI.x + 0.645, UI.y + 1.264, 1.0,1.0,0.45, "3", 255, 142, 0, 255)
				elseif Gear == 4 then
					drawTxt(UI.x + 0.645, UI.y + 1.264, 1.0,1.0,0.45, "4", 255, 142, 0, 255)
				elseif Gear == 5 then
					drawTxt(UI.x + 0.645, UI.y + 1.264, 1.0,1.0,0.45, "5", 255, 142, 0, 255)
				elseif Gear == 6 then
					drawTxt(UI.x + 0.645, UI.y + 1.264, 1.0,1.0,0.45, "6", 255, 142, 0, 255)
				elseif Gear == 7 then
					drawTxt(UI.x + 0.645, UI.y + 1.264, 1.0,1.0,0.45, "7", 255, 142, 0, 255)
				elseif Gear == 8 then
					drawTxt(UI.x + 0.645, UI.y + 1.264, 1.0,1.0,0.45, "8", 255, 142, 0, 255)
				end	
			end
			
			if HUD.SpeedIndicator then
				drawRct(UI.x + 0.015, 	UI.y + 0.770, 0.1406,0.03,0,0,0,140) -- Speed panel
				if HUD.Speed == 'kmh' then
					drawTxt(UI.x + 0.595, 	UI.y + 1.264, 1.0,1.0,0.45, " ~w~" .. math.ceil(Speed), 255, 255, 255, 255)
					drawTxt(UI.x + 0.569, 	UI.y + 1.264, 1.0,1.0,0.45, "~w~ KM/T ", 255, 255, 255, 255)
				elseif HUD.Speed == 'mph' then
					drawTxt(UI.x + 0.61, 	UI.y + 1.42, 1.0,1.0,0.64 , "~w~" .. math.ceil(Speed), 255, 255, 255, 255)
					drawTxt(UI.x + 0.633, 	UI.y + 1.432, 1.0,1.0,0.4, "~w~ mph", 255, 255, 255, 255)
				else
					drawTxt(UI.x + 0.81, 	UI.y + 1.42, 1.0,1.0,0.64 , [[Carhud ~r~ERROR~w~ ~c~in ~w~HUD Speed~c~ config (something else than ~y~'kmh'~c~ or ~y~'mph'~c~)]], 255, 255, 255, 255)
				end
			end
	
			if HUD.DamageSystem then

			end
			

		end		
	end
end)

function drawTxt(x,y ,width,height,scale, text, r,g,b,a)
    SetTextFont(4)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(2, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end

function drawWarn(x,y ,width,height,scale, text, r,g,b,a)
    SetTextFont(4)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(2, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end

function drawRct(x,y,width,height,r,g,b,a)
	DrawRect(x + width/2, y + height/2, width, height, r, g, b, a)
end
