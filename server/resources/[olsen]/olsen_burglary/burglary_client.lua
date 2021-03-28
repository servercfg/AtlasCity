vRP = Proxy.getInterface("vRP") 
vRPclient = Tunnel.getInterface("vRP", "olsen_burglary")

local Keys = {
  ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
  ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
  ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
  ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
  ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
  ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
  ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
  ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
}

local GUI = {} -- don't touch
GUI.Time = 0 -- don't touch
local PlayerData = {} -- don't touch
local showPro = false -- don't touch
local stealing = false -- don't touch
local peeking = false -- don't touch
local CurrentAction		= nil
local timer = false
local secsRemaining = nil
local savedDoor = nil
local doorTime = {}
peds = {}
local houseIn = nil
------------------------------------------------------
------------------------------------------------------
local chancePoliceNoti = 20 -- the procent police get notified (only numbers like 30, 10, 40. You get it.)
local useBlip = false -- if u want blip
local useInteractSound = false -- if you wanna use InteractSound (when u lockpick the door)
------------------------------------------------------
------------------------------------------------------

------ l o c a l e s ------
local noCar = "Intet køretøj i nærheden"
local text = "Dirk Døren" -- lockpick the door
local textUnlock = "~c~[~b~E~c~]~w~ Gå ind" -- enter the house
local insideText = "~c~[~b~E~c~]~w~ Gå ud" -- exit the door
local abortConfirm = "Du har annulleret drikningen af låsen "
local searchText = "~c~[~b~E~c~]~w~ Søg" -- search the spot
local emptyMessage = "Der er ingenting!" -- if you press E where it is empty
local emptyMessage3D = "~r~Tom" -- if the spot is empty
local closetText = "~c~[~b~E~c~]~w~ Kig ind i skabet" -- text at closet
local abortLock = "~c~[~b~E~c~]~w~ for at annullere dirkning af lås"
local noLockpickText = "Du har ikke noget dirkesæt!" -- if you don't have a lockpick and you try to do the burglary
local carUnlocked = "Du har låst bilen op"
local youFound = "Fra" -- when you steal something
local item = {'kebab', 'dirty_money', 'nicki_juvel', 'joint', 'rodvin', 'iphone', 'acetone', 'radio'}
local exitPos = {pos = {x = 1225.79, y = -727.90, z = 60.52, h = 0 }}
local lastDoor = 0
---------------------------

RegisterNetEvent('99kr-burglary:onUse')
AddEventHandler('99kr-burglary:onUse', function()
	local playerPed		= GetPlayerPed(-1)
  local coords		= GetEntityCoords(playerPed)
	if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
		local vehicle = nil

		if IsPedInAnyVehicle(playerPed, false) then
			vehicle = GetVehiclePedIsIn(playerPed, false)
		else
			vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
		end

    if DoesEntityExist(vehicle) then
      lockpicking = false
      ---print(lockpicking)
      randi = math.random(1, 10)
      if randi == 1 then
      TriggerServerEvent('olsen_burglary:lockpick')
      end
			TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_BUM_BIN", 0, true)
			  if useInteractSound then
			    TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 3.0, 'lockpick', 0.7)
			  end

			Citizen.CreateThread(function()
				ThreadID = GetIdOfThisThread()
				CurrentAction = 'lockpick'

				Citizen.Wait(22 * 1000)

        if CurrentAction ~= nil then
          procent(100)
					SetVehicleDoorsLocked(vehicle, 1)
					SetVehicleDoorsLockedForAllPlayers(vehicle, false)
					ClearPedTasksImmediately(playerPed)

          exports['mythic_notify']:SendAlert('inform', carUnlocked)
				end
				
				CurrentAction = nil
				--TerminateThisThread()
			end)
		end

		Citizen.CreateThread(function()
			Citizen.Wait(0)

			if CurrentAction ~= nil then
				SetTextComponentFormat('STRING')
				AddTextComponentString(abortLock)
				DisplayHelpTextFromStringLabel(0, 0, 1, -1)

				if IsControlJustReleased(0, Keys["X"]) then
					TerminateThread(ThreadID)
          exports['mythic_notify']:SendAlert('inform', abortConfirm)
					CurrentAction = nil
				end
			end

		end)
	end
end)




RegisterNetEvent('99kr-burglary:Lockpick')
AddEventHandler('99kr-burglary:Lockpick', function(xPlayer)
  lockpicking = true
  Citizen.Wait(100)
  lockpicking = false
end)

local burglaryPlaces = {
  
  ["Robban"] = {
    door = 1,
    locked = true,
    pos = { x = 1229.1, y = -725.47, z = 60.80, h = 89.98 }, -- door coords
    inside = { x = 346.52 , y = -1013.19 , z = -99.2, h = 357.81 }, -- Inside coords
    animPos = { x = 1229.53, y = -724.81, z = 60.96, h = 277.96 }, -- The animation position
    doorTime = {}
    },
  ["Grove Street 1"] = {
    door = 2,
    locked = true,
    pos = { x = 126.73, y = -1930.20, z = 22.0, h = 207.79 },  -- door coords
    inside = { x = 346.52 , y = -1013.19 , z = -99.2, h = 357.81 },  -- Inside the house coords
    animPos = { x = 126.73, y = -1930.00, z = 21.38, h = 207.79 }, -- The animation position
    doorTime = {}
  }, 
  ["Grove Street 2"] = {
    door = 3,
     locked = true,
    pos = { x = 85.58 , y = -1959.38 , z = 21.12, h = 220.54 },  -- door coords
    inside = { x = 346.52, y = -1013.19, z = -99.2, h = 357.81 },  -- Inside the house coords
    animPos = { x = 85.58 , y = -1959.38 , z = 21.12, h = 220.54 }, -- The animation position
    doorTime = {}
   }
}

local burglaryInside = {
[" køkkenbordet fandt du "] = { x = 342.23, y = -1003.29, z = -99.0,  amount = 0},
[" tv bord fandt du "] = { x = 338.14, y = -997.69,  z = -99.2,  amount = 0},
[" kommoden fandt du "] = { x = 350.91, y = -999.26,  z = -99.2,  amount = 0},
[" natbord fandt du "] = { x = 349.19, y = -994.83,  z = -99.2,  amount = 0},
[" bogreol fandt du "] = { x = 345.3,  y = -995.76,  z = -99.2,  amount = 0},
[" entre kommoden fandt du "] = { x = 346.14, y = -1001.55, z = -99.2,  amount = 0},
[" toiletskab fandt du "] = { x = 347.23, y = -994.09,  z = -99.2,  amount = 0},
[" i skuffen fandt du "] = { x = 339.23, y = -1003.35, z = -99.2,  amount = 0},
[" garderobeskab fandt du "] = { x = 351.24, y = -993.53,  z = -99.2,  amount = 0}

}

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(5)
    for k,v in pairs(burglaryPlaces) do
      local playerPed = PlayerPedId()
      local house = k
      local coords = GetEntityCoords(playerPed)
      local dist   = GetDistanceBetweenCoords(v.pos.x, v.pos.y, v.pos.z, coords.x, coords.y, coords.z, false)
    if GetClockHours() > 23  or GetClockHours() <= 22 then
      if dist <= 1.2 and v.locked == true then
          DrawText3D(v.pos.x, v.pos.y, v.pos.z, text, 0.4)                  
          if lockpicking == true then
            savedDoor = v.door
            houseIn = house
            v.doorTime = GetGameTimer() + 600 * 1000
            confMenu(house)
            for k, v in pairs(burglaryInside) do
              if v.amount < 1 then
              v.amount = v.amount + 1
              lockpicking = false
              end
            end
          end  
      else
        if dist <= 1.2 and timer == true then
         local secsRemaining = math.ceil((v.doorTime - GetGameTimer()) / 1000)
          secsRemaining = secsRemaining - 1
          if secsRemaining > 0 then
                DrawText3D(v.pos.x, v.pos.y, v.pos.z,'Vent venligst ~r~'..secsRemaining..'~w~ før du kan bryde ind', 0.4)
          else
            timer = false
            v.locked = true 
            doorTime = {}      
          end
          
        end
      end
    else 
      if dist <= 1.2 then
        breakTime = 23 - GetClockHours() 
      DrawText3D(v.pos.x, v.pos.y, v.pos.z, 'Du kan bryde ind i huset om ~r~' ..breakTime.. ' ~w~timer', 0.4) 
      end
    end
    end
  end
end)

Citizen.CreateThread(function()
  while stealing == false do
    Citizen.Wait(5)
    for k, v in pairs(burglaryInside) do
      local playerPed = PlayerPedId()
      local coords = GetEntityCoords(playerPed)
      local dist = GetDistanceBetweenCoords(v.x, v.y, v.z, coords.x, coords.y, coords.z, false)
      if dist <= 1.2 and v.amount > 0 then
        DrawText3D(v.x, v.y, v.z, searchText, 0.4)
        if dist <= 0.5 and IsControlJustPressed(0, Keys["E"]) then
          steal(k)
        end
      elseif v.amount < 1 and dist <= 1.2 then
        DrawText3D(v.x, v.y, v.z, emptyMessage3D, 0.4)
        if IsControlJustPressed(0, Keys["E"]) and dist <= 0.5 then
          exports['mythic_notify']:SendAlert('inform', emptyMessage)
        end
      end
    end
  end
end)


Citizen.CreateThread(function()
  while true do
    Citizen.Wait(5)
    for k, v in pairs(burglaryPlaces) do
      local playerPed = PlayerPedId()
      local coords = GetEntityCoords(playerPed)
      local house = k
      if GetDistanceBetweenCoords(v.inside.x, v.inside.y, v.inside.z, coords.x, coords.y, coords.z, false) <= 3.0 then
        DrawText3D(v.inside.x, v.inside.y, v.inside.z, insideText, 0.4)
        if GetDistanceBetweenCoords(v.inside.x, v.inside.y, v.inside.z, coords.x, coords.y, coords.z, false) <= 1.2 and IsControlJustPressed(0, Keys["E"]) then
          fade()
          teleport(exitPos)
          lastDoor = 0
          timer = true
          
        end
      end
    end
  end
end)


Citizen.CreateThread(function()
	while true do
    Citizen.Wait(6)
    if showPro == true then
      local playerPed = PlayerPedId()
		  local coords = GetEntityCoords(playerPed)
      DrawText3D(coords.x, coords.y, coords.z, TimeLeft .. '~b~%', 0.4)
    end
	end
end)

function confMenu(house)
  Citizen.Wait(6)
  local v = GetHouseValues(house, burglaryPlaces)
  exitPos = {pos ={x = v.pos.x, y = v.pos.y, z = v.pos.z, h = v.pos.h }}
  Citizen.CreateThread(function()
    LockpickAmount = true
        if LockpickAmount == true then
          HouseBreak(house)
          v.locked = false
          Citizen.Wait(math.random(15000,30000))
        else 
          exports['mythic_notify']:SendAlert('inform', noLockpickText)
      end
			
end)
end
    

function steal(k)
  local goods = item[math.random(#item)] 
  local values = GetHouseValues(k, burglaryInside)
  local playerPed = PlayerPedId()
  stealing = true
  FreezeEntityPosition(playerPed, true)
  TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_BUM_BIN", 0, true)
  Citizen.Wait(2000)
  procent(50)
  chance = math.random(1,5)
  if chance == 1 then
  TriggerServerEvent('99kr-burglary:Add', "dirty_money", math.random(1000,2500))
  end
  chance2 = math.random(1,5)
  TriggerServerEvent('99kr-burglary:Add', goods, chance2)
  exports['mythic_notify']:SendAlert('inform', youFound .. k ..' '.. chance2.. ' ' .. goods)
  values.amount = values.amount - 1
  ClearPedTasks(playerPed)
  FreezeEntityPosition(playerPed, false)
  stealing = false
end

function HouseBreak(house)
  local v = GetHouseValues(house, burglaryPlaces)
  local playerPed = PlayerPedId()
  fade()
  FreezeEntityPosition(playerPed, true)
  SetEntityCoords(playerPed, v.animPos.x, v.animPos.y, v.animPos.z - 0.98)
  SetEntityHeading(playerPed, v.animPos.h)
  loaddict("mini@safe_cracking")
  TaskPlayAnim(playerPed, "mini@safe_cracking", "idle_base", 3.5, - 8, - 1, 2, 0, 0, 0, 0, 0)
  if useInteractSound then
    TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 3.0, 'lockpick', 0.7)
  end
  procent(70)
  rand = math.random(1, 10)
  if rand == 1 then
    TriggerServerEvent('99kr-burglary:Remove', 'lockpick', 1)
  end  
  fade()
  ClearPedTasks(playerPed)
  FreezeEntityPosition(playerPed, false)
  SetCoords(playerPed, v.inside.x, v.inside.y, v.inside.z - 0.98)
  SetEntityHeading(playerPed, v.inside.h)
  chance = math.random(1,5)
  if chance == 1 then 
  local plyPos = GetEntityCoords(GetPlayerPed(-1))
  TriggerServerEvent("olsen_burglary:warn", plyPos.x, plyPos.y, plyPos.z)
end 
end

function ShowSubtitle(text)
  BeginTextCommandPrint("STRING")
  AddTextComponentSubstringPlayerName(text)
  EndTextCommandPrint(3500, 1)
end

function SetCoords(playerPed, x, y, z)
  SetEntityCoords(playerPed, x, y, z)
  Citizen.Wait(100)
  SetEntityCoords(playerPed, x, y, z)
end

function fade()
  DoScreenFadeOut(1000)
  Citizen.Wait(1000)
  DoScreenFadeIn(1000)
end

function loaddict(dict)
  while not HasAnimDictLoaded(dict) do
    RequestAnimDict(dict)
    Wait(10)
  end
end

function DrawText3D(x, y, z, text, scale)
  local onScreen,_x,_y=World3dToScreen2d(x,y,z)
  local px,py,pz=table.unpack(GetGameplayCamCoords())
  
  SetTextScale(0.35, 0.35)
  SetTextFont(4)
  SetTextProportional(1)
  SetTextColour(255, 255, 255, 255)
  SetTextEntry("STRING")
  SetTextCentre(1)
  AddTextComponentString(text)
  DrawText(_x,_y)
  local factor = (string.len(text)) / 370
  DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end

function procent(time)
  showPro = true
  TimeLeft = 0
  repeat
  TimeLeft = TimeLeft + 1 -- thank you (github.com/Loffes)
  Citizen.Wait(time)
  until(TimeLeft == 100)
  showPro = false
end

function teleport(confMenu)
  local values = GetHouseValues(house, burglaryPlaces)
  local playerPed = PlayerPedId()
  SetCoords(playerPed, confMenu.pos.x, confMenu.pos.y, confMenu.pos.z - 0.98)
  SetEntityHeading(playerPed, confMenu.pos.h)
  DoingBreak = false
end

function GetHouseValues(house, pair)
  for k, v in pairs(pair) do
    if k == house then
      return v
    end
  end
end

if useBlip then
  Citizen.CreateThread(function()
    for k, v in pairs(burglaryPlaces) do
       local blip = AddBlipForCoord(v.pos.x, v.pos.y, v.pos.z)
       SetBlipSprite (blip, 40)
       SetBlipDisplay(blip, 4)
       SetBlipScale (blip, 0.8)
       SetBlipColour (blip, 39)
       SetBlipAsShortRange(blip, true)
       BeginTextCommandSetBlipName("STRING")
       AddTextComponentString('Husrøverier')
       EndTextCommandSetBlipName(blip)
    end
  end)
end

RegisterNetEvent('99kr-burglary:Sound')
AddEventHandler('99kr-burglary:Sound', function(sound1, sound2)
PlaySoundFrontend(-1, sound1, sound2)
end)