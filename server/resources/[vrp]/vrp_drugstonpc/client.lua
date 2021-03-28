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

playerHasDrugs = false
local selling = false
local secondsRemaining = 0
local rejected = false
local antal = 0

Citizen.CreateThread(function()
while true do
  if selling then
    Citizen.Wait(1000)
    if(secondsRemaining > 0)then
      secondsRemaining = secondsRemaining - 1
    end
  end

  Citizen.Wait(0)
end
end)

currentped = nil

local has = true
Citizen.CreateThread(function()

while true do
  Wait(0)
  if playerHasDrugs == true and IsPedInAnyVehicle(GetPlayerPed(-1)) == false then
  local player = GetPlayerPed(-1)
  local playerloc = GetEntityCoords(player, 0)
  local handle, ped = FindFirstPed()
  local success
  repeat
    success, ped = FindNextPed(handle)
    local pos = GetEntityCoords(ped)
    local distance = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, playerloc['x'], playerloc['y'], playerloc['z'], true)
    if IsPedInAnyVehicle(GetPlayerPed(-1)) == false then
      if DoesEntityExist(ped)then
        if IsPedDeadOrDying(ped) == false then
          if IsPedInAnyVehicle(ped) == false then
            local pedType = GetPedType(ped)
            if pedType ~= 28 and IsPedAPlayer(ped) == false then
              currentped = pos
              if distance <= 1 and ped  ~= GetPlayerPed(-1) and ped ~= oldped and not IsPedFleeing(ped) and not IsPedInMeleeCombat(ped) then
              local pedstatus = GetEntityCoords(ped)
                DrawText3Ds(pedstatus.x,pedstatus.y,pedstatus.z+0.25, "~w~Tryk [~b~K~w~] for at sælge.", 3.0, 7)  
                if IsControlJustPressed(1, 311) then
                  -- Citizen.Trace("See if wants to buy")
                  if has then
                    oldped = ped
                    SetEntityAsMissionEntity(ped)
                    ClearPedTasks(ped)
                    FreezeEntityPosition(ped,true)
                    local random = math.random(1, 12)
                    if random == 3 or random == 7 or random == 11 or random == 5 then
                      TriggerEvent("pNotify:SendNotification",{text = "Personen ville ikke købe.",type = "error",timeout = (5000),layout = "centerRight",queue = "global",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
                      selling = false
                      SetEntityAsMissionEntity(ped)
                      SetPedAsNoLongerNeeded(ped)
                      local randomReport = math.random(1, 5)
            if randomReport == 3 then
              local plyPos = GetEntityCoords(GetPlayerPed(-1))
              TriggerServerEvent('vRP_drugNPC:policia',plyPos.x, plyPos.y, plyPos.z)
              Citizen.Wait(3000)
              TaskStartScenarioInPlace(hospitalped1, "WORLD_HUMAN_STAND_MOBILE")
            end
                    elseif random ~= 3 or random ~= 7 or random ~= 11 or random ~= 5 then
                      TaskStandStill(ped, 9.0)
                      pos1 = GetEntityCoords(ped)
                      TriggerEvent("currentlySelling")
                      antal = math.random(1, 15)
                      TriggerServerEvent('drugs:item', antal)
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  until not success
  EndFindPed(handle)
end
end
end)

local blah = false
Citizen.CreateThread(function()

while true do
  Wait(0)
  local player = GetPlayerPed(-1)

  if selling then
    local player = GetPlayerPed(-1)
    local playerloc = GetEntityCoords(player, 0)
    drawTxt(0.90, 1.40, 1.0,1.0,0.4, "Forhandler: ~b~" .. secondsRemaining .. "~w~ sekunder tilbage.", 255, 255, 255, 255)
    local distance = GetDistanceBetweenCoords(pos1.x, pos1.y, pos1.z, playerloc['x'], playerloc['y'], playerloc['z'], true)

    if distance > 6 then
      TriggerEvent("pNotify:SendNotification",{text = "Forhandling afbrudt, du for langt væk.",type = "error",timeout = (5000),layout = "centerRight",queue = "global",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
      selling = false

      SetEntityAsMissionEntity(oldped)
      SetPedAsNoLongerNeeded(oldped)
    end
    if secondsRemaining == 0 then
      blah = true
      end
    end
    if rejected then
      drawTxt(0.90, 1.40, 1.0,1.0,0.4, "Personen ~r~afslog ~w~dit tilbud. ~r~", 255, 255, 255, 255)
    end
  end
  end)

  Citizen.CreateThread(function()

  while true do
    Wait(0)
    if blah then
      antal = antal
      TriggerServerEvent('drugs:money', antal)
      blah = false
      selling = false
    end
  end
  end)

Citizen.CreateThread(function()
  while true do
    Wait(10000)
    TriggerServerEvent('drugs:checkitem')
  end
end)

  RegisterNetEvent('currentlySelling')
  AddEventHandler('currentlySelling', function()
  selling = true
  secondsRemaining = 5
  end)

  RegisterNetEvent('cancel')
  AddEventHandler('cancel', function()
  blah = false
  end)

  RegisterNetEvent('done')
  AddEventHandler('done', function()
  selling = false

  secondsRemaining = 0

  end)

  function DisplayHelpText(str)
    SetTextComponentFormat("STRING")
    AddTextComponentString(str)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
  end

  function DrawSpecialText(m_text)
    ClearPrints()
    SetTextEntry_2("STRING")
    AddTextComponentString(m_text)
    DrawSubtitleTimed(250, 1)
  end


  function drawTxt(x,y ,width,height,scale, text, r,g,b,a, outline)
    SetTextFont(0)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    if(outline)then
      SetTextOutline()
    end
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
  end

  RegisterNetEvent('nomore')
  AddEventHandler('nomore', function()
  has = false
  end)

RegisterNetEvent('playerhasdrugs')
AddEventHandler('playerhasdrugs', function()
  playerHasDrugs = true
end)

RegisterNetEvent('playerhasnodrugs')
AddEventHandler('playerhasnodrugs', function()
  playerHasDrugs = false
end)

function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())

    SetTextScale(0.32, 0.32)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 255)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 0, 0, 0, 80)
end
