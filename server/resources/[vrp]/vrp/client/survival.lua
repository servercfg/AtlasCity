
-- drunk = false

local UI = { 

  x =  0.000 ,  -- Base Screen Coords   +    x
  y = -0.001 ,  -- Base Screen Coords   +   -y

}

-- api

function tvRP.varyHealth(variation)
  local ped = GetPlayerPed(-1)

  local n = math.floor(GetEntityHealth(ped)+variation)
  SetEntityHealth(ped,n)
end

function tvRP.getHealth()
  return GetEntityHealth(GetPlayerPed(-1))
end

function tvRP.setHealth(health)
  local n = math.floor(health)
  SetEntityHealth(GetPlayerPed(-1),n)
end

function tvRP.setFriendlyFire(flag)
  NetworkSetFriendlyFireOption(flag)
  SetCanAttackFriendly(GetPlayerPed(-1), flag, flag)
end

function tvRP.setPolice(flag)
  local player = PlayerId()
  SetPoliceIgnorePlayer(player, not flag)
  SetDispatchCopsForPlayer(player, flag)
end

-- impact thirst and hunger when the player is running (every 5 seconds)
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(5000)

    if IsPlayerPlaying(PlayerId()) then
      local ped = GetPlayerPed(-1)

      -- variations for one minute
      local vthirst = 0
      local vhunger = 0

      -- on foot, increase thirst/hunger in function of velocity
      if IsPedOnFoot(ped) and not tvRP.isNoclip() then
        local factor = math.min(tvRP.getSpeed(),10)

        vthirst = vthirst+1*factor
        vhunger = vhunger+0.5*factor
      end

      -- in melee combat, increase
      if IsPedInMeleeCombat(ped) then
        vthirst = vthirst+10
        vhunger = vhunger+5
      end

      -- injured, hurt, increase
      if IsPedHurt(ped) or IsPedInjured(ped) then
        vthirst = vthirst+2
        vhunger = vhunger+1
      end

      -- do variation
      if vthirst ~= 0 then
        vRPserver.varyThirst({vthirst/12.0})
      end

      if vhunger ~= 0 then
        vRPserver.varyHunger({vhunger/12.0})
      end
    end
  end
end)

-- COMA SYSTEM

local in_coma = false
local coma_left = cfg.coma_duration*60

Citizen.CreateThread(function() -- coma thread
  while true do
    Citizen.Wait(0)
    local ped = GetPlayerPed(-1)
    
    local health = GetEntityHealth(ped)
    if health <= cfg.coma_threshold and coma_left > 0 then
      if not in_coma then -- go to coma state
        if IsEntityDead(ped) then -- if dead, resurrect
          local x,y,z = tvRP.getPosition()
          NetworkResurrectLocalPlayer(x, y, z, true, true, false)
          Citizen.Wait(0)
        end

        -- coma state
        in_coma = true
        vRPserver.updateHealth({cfg.coma_threshold}) -- force health update
        SetEntityHealth(ped, cfg.coma_threshold)
        SetEntityInvincible(ped,true)
        tvRP.playScreenEffect(cfg.coma_effect,-1)
        tvRP.ejectVehicle()
        tvRP.setRagdoll(true)
      else -- in coma
        -- maintain life
        if health < cfg.coma_threshold then 
          SetEntityHealth(ped, cfg.coma_threshold) 
        end
      end
	  
	  

      drawTxt(UI.x + 0.9002, UI.y + 1.375, 1.0,1.0,0.65, "Du kan genopstå om: ~b~"..coma_left.." ~w~sekunder.", 255, 255, 255, 255)
  		DisableControlAction(0, 24, true) -- attack
  		DisableControlAction(0, 25, true) -- aim
  		DisableControlAction(0, 37, true) -- weapon wheel
  		DisableControlAction(0, 44, true) -- cover
  		DisableControlAction(0, 45, true) -- reload
  		DisableControlAction(0, 140, true) -- light attack
  		DisableControlAction(0, 141, active) -- heavy attack
  		DisableControlAction(0, 142, active) -- alternative attack
  		DisablePlayerFiring(GetPlayerPed(-1), true) -- Disable weapon firing
    else
      if in_coma then -- get out of coma state
		drawTxt(UI.x + 0.9002, UI.y + 1.375, 1.0,1.0,0.65, "~w~Tryk [~b~H~w~] for at Genopstå.", 255, 255, 255, 255)
		if IsControlJustPressed(1, 74) then
			in_coma = false
			SetEntityInvincible(ped,false)
			tvRP.setRagdoll(false)
			tvRP.stopScreenEffect(cfg.coma_effect)
			ShakeGameplayCam("DEATH_FAIL_IN_EFFECT_SHAKE", 1.200)

						if coma_left <= 0 then
				local health = GetEntityHealth(ped)
					if health > cfg.coma_threshold then 
						-- do nothing
					else
						SetEntityHealth(ped, 0)
					end
					end

			SetTimeout(5000, function()  -- able to be in coma again after coma death after 5 seconds
			  coma_left = cfg.coma_duration*60
			end)
		end	
      end
    end
  end
end)

function tvRP.isInComa()
  return in_coma
end

-- kill the player if in coma
function tvRP.killComa()
  if in_coma then
    coma_left = 0
  end
end

Citizen.CreateThread(function() -- coma decrease thread
  while true do 
    Citizen.Wait(1000)
    if in_coma then
      coma_left = coma_left-1
    end
  end
end)

Citizen.CreateThread(function() -- disable health regen, conflicts with coma system
  while true do
    Citizen.Wait(100)
    -- prevent health regen
    SetPlayerHealthRechargeMultiplier(PlayerId(), 0)
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

timeleft = 0

Citizen.CreateThread(function() 
  while true do
    Citizen.Wait(10000)
		if timeleft > 0 then 
			timeleft = timeleft-10000
				if timeleft <= 0 and drunk == true then 
					ShakeGameplayCam("DRUNK_SHAKE", 0.0)
					ClearTimecycleModifier()
					SetPedMotionBlur(GetPlayerPed(-1), false)
					drunklevel = 0.0
					drunk = false
				end
		end
	end
end)


drunklevel = 0.0
RegisterNetEvent('kaz_alkohol:drik');
AddEventHandler('kaz_alkohol:drik', function()
	drunk = true
	local prop = "prop_cs_whiskey_bottle"
	local plyCoords = GetOffsetFromEntityInWorldCoords(GetPlayerPed(PlayerId()), 0.0, 0.0, -4.0)
    local propspawned = CreateObject(GetHashKey(prop), plyCoords.x, plyCoords.y, plyCoords.z, 1, 1, 1)
	Citizen.Wait(100)
    local netid = ObjToNet(propspawned)
    prop_net = netid
    AttachEntityToEntity(propspawned, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 0xeb95), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0, 0, 0, 0, 0, true)
	timeleft =  timeleft+180000
	drunklevel = drunklevel+0.1
	ShakeGameplayCam("DRUNK_SHAKE", drunklevel)
		if drunklevel >= 1.0 then
			if not HasAnimSetLoaded("MOVE_M@DRUNK@VERYDRUNK") then
				RequestAnimSet("MOVE_M@DRUNK@VERYDRUNK")
				while not HasAnimSetLoaded("MOVE_M@DRUNK@VERYDRUNK") do
				Citizen.Wait(0)
				end
			end
			SetPedConfigFlag(GetPlayerPed(-1), 100, true)
			SetPedMovementClipset(GetPlayerPed(-1), "MOVE_M@DRUNK@VERYDRUNK", 1.0)
			SetTimecycleModifier("spectator5")
			SetPedMotionBlur(GetPlayerPed(-1), true)
		end
	Citizen.Wait(2500)
	local netid = ObjToNet(propspawned)
	penis = netid
	local ped = GetPlayerPed(-1)
	ClearPedTasks(ped)
	DetachEntity(NetToObj(penis), 1, 1)
	DeleteEntity(NetToObj(penis))
	DeleteObject(NetToObj(penis))
end)

RegisterNetEvent('kaz_alkohol:ems');
AddEventHandler('kaz_alkohol:ems', function()
ShakeGameplayCam("DRUNK_SHAKE", 0.0)
ClearTimecycleModifier()
SetPedMotionBlur(GetPlayerPed(-1), false)
drunklevel = 0.0
drunk = false
ClearTimecycleModifier()
ResetScenarioTypesEnabled()
ResetPedMovementClipset(GetPlayerPed(-1), 0)
SetPedIsDrunk(GetPlayerPed(-1), false)
SetPedMotionBlur(GetPlayerPed(-1), false)
end)

RegisterNetEvent('kaz_alkohol:alkotest');
AddEventHandler('kaz_alkohol:alkotest', function(player)
drunklevel1 = drunklevel
TriggerServerEvent('kaz_alkohol:alkotest2', player, drunklevel1)
end)
