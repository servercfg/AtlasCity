local cfg = module("cfg/survival")
local lang = vRP.lang

-- api

function vRP.getHunger(user_id)
  local data = vRP.getUserDataTable(user_id)
  if data then
    return data.hunger
  end

  return 0
end

function vRP.getThirst(user_id)
  local data = vRP.getUserDataTable(user_id)
  if data then
    return data.thirst
  end

  return 0
end

function tvRP.getHealth(user_id)
  local health = vRP.getUserDataTable(user_id)
  if data then
    return data.health
  end

  return 0
end

function vRP.setHunger(user_id,value)
  local data = vRP.getUserDataTable(user_id)
  if data then
    data.hunger = value
    if data.hunger < 0 then data.hunger = 0
    elseif data.hunger > 100 then data.hunger = 100 
    end

    -- update bar
    local source = vRP.getUserSource(user_id)
    vRPclient.setProgressBarValue(source, {"vRP:hunger",data.hunger})
    if data.hunger >= 100 then
      --vRPclient.setProgressBarText(source,{"vRP:hunger",lang.survival.starving()})
    else
      vRPclient.setProgressBarText(source,{"vRP:hunger",""})
    end
  end
end

function vRP.setThirst(user_id,value)
  local data = vRP.getUserDataTable(user_id)
  if data then
    data.thirst = value
    if data.thirst < 0 then data.thirst = 0
    elseif data.thirst > 100 then data.thirst = 100 
    end

    -- update bar
    local source = vRP.getUserSource(user_id)
    vRPclient.setProgressBarValue(source, {"vRP:thirst",data.thirst})
    if data.thirst >= 100 then
      --vRPclient.setProgressBarText(source,{"vRP:thirst",lang.survival.thirsty()})
    else
      vRPclient.setProgressBarText(source,{"vRP:thirst",""})
    end
  end
end

function vRP.setHealth(user_id,value)
  local data = vRP.getUserDataTable(user_id)
  if data then
    data.health = value
		if data.health < 0 then data.health = 0
		elseif data.health > 200 then data.health = 200 
		end

	  local myHealth = data.health - 100
	  
		-- update bar
		local source = vRP.getUserSource(user_id)
		vRPclient.setProgressBarValue(source, {"vRP:health",myHealth})
		vRPclient.setProgressBarText(source,{"vRP:health",""})
  end
end

function vRP.varyHunger(user_id, variation)
  local data = vRP.getUserDataTable(user_id)
  if data then
    local was_starving = data.hunger >= 100
    data.hunger = data.hunger + variation
    local is_starving = data.hunger >= 100

    -- apply overflow as damage
    local overflow = data.hunger-100
    if overflow > 0 then
      vRPclient.varyHealth(vRP.getUserSource(user_id),{-overflow*cfg.overflow_damage_factor})
    end

    if data.hunger < 0 then data.hunger = 0
    elseif data.hunger > 100 then data.hunger = 100 
    end

    -- set progress bar data
    local source = vRP.getUserSource(user_id)
    vRPclient.setProgressBarValue(source,{"vRP:hunger",data.hunger})
    if was_starving and not is_starving then
      vRPclient.setProgressBarText(source,{"vRP:hunger",""})
    elseif not was_starving and is_starving then
      --vRPclient.setProgressBarText(source,{"vRP:hunger",lang.survival.starving()})
    end
  end
end

function vRP.varyThirst(user_id, variation)
  local data = vRP.getUserDataTable(user_id)
  if data then
    local was_thirsty = data.thirst >= 100
    data.thirst = data.thirst + variation
    local is_thirsty = data.thirst >= 100

    -- apply overflow as damage
    local overflow = data.thirst-100
    if overflow > 0 then
      vRPclient.varyHealth(vRP.getUserSource(user_id),{-overflow*cfg.overflow_damage_factor})
    end

    if data.thirst < 0 then data.thirst = 0
    elseif data.thirst > 100 then data.thirst = 100 
    end

    -- set progress bar data
    local source = vRP.getUserSource(user_id)
    vRPclient.setProgressBarValue(source,{"vRP:thirst",data.thirst})
    if was_thirsty and not is_thirsty then
      vRPclient.setProgressBarText(source,{"vRP:thirst",""})
    elseif not was_thirsty and is_thirsty then
      --vRPclient.setProgressBarText(source,{"vRP:thirst",lang.survival.thirsty()})
    end
  end
end

function vRP.varyHealth(user_id, variation)
  local data = vRP.getUserDataTable(user_id)
  if data then
    if data.health ~= nil then
      data.health = data.health + variation
      local source = vRP.getUserSource(user_id)
      data.health = data.health + variation
      local myHealth = data.health - 100
      if (myHealth < 0) then 
        myHealth = 0
      end

      -- set progress bar data
      vRPclient.setProgressBarValue(source,{"vRP:health",myHealth})
    end
  end
end

-- tunnel api (expose some functions to clients)

function tvRP.varyHunger(variation)
  local user_id = vRP.getUserId(source)
  if user_id ~= nil then
    vRP.varyHunger(user_id,variation)
  end
end

function tvRP.varyThirst(variation)
  local user_id = vRP.getUserId(source)
  if user_id ~= nil then
    vRP.varyThirst(user_id,variation)
  end
end

function tvRP.varyHealth(variation)
  local user_id = vRP.getUserId(source)
  if user_id ~= nil then
    vRP.varyHealth(user_id,variation)
  end
end

function htask_update()
  for k,v in pairs(vRP.users) do
    vRP.varyHealth(v,-cfg.health_per_minute)
  end
  SetTimeout(500,htask_update)
end
htask_update()

function task_update()
  for k,v in pairs(vRP.users) do
    vRP.varyHunger(v,cfg.hunger_per_minute)
    vRP.varyThirst(v,cfg.thirst_per_minute)
  end
  SetTimeout(60000,task_update)
end
task_update()

-- init values
AddEventHandler("vRP:playerJoin",function(user_id,source,name,last_login)
  local data = vRP.getUserDataTable(user_id)
  if data.hunger == nil then
    data.hunger = 0
    data.thirst = 0
    data.health = 200
  end
end)

-- add survival progress bars on spawn
AddEventHandler("vRP:playerSpawn",function(user_id, source, first_spawn)
  local data = vRP.getUserDataTable(user_id)

  -- disable police
  vRPclient.setPolice(source,{cfg.police})
  -- set friendly fire
  vRPclient.setFriendlyFire(source,{cfg.pvp})

  --vRPclient.setProgressBar(source,{"vRP:hunger","minimap",htxt,255,170,43,1.0})
  --vRPclient.setProgressBar(source,{"vRP:thirst","minimap",ttxt,85,155,215,1.0})
  --vRPclient.setProgressBar(source,{"vRP:health","health",hgtxt,78,147,80,1.0})
  --vRPclient.setProgressBarText(source,{"vRP:hunger",""})
  --vRPclient.setProgressBarText(source,{"vRP:thirst",""})
  --vRPclient.setProgressBarText(source,{"vRP:health",""})
  vRP.setHunger(user_id, data.hunger)
  vRP.setThirst(user_id, data.thirst)
  vRP.setHealth(user_id, data.health)
end)

-- EMERGENCY

---- revive
local revive_seq = {
  {"amb@medic@standing@kneel@enter","enter",1},
  {"amb@medic@standing@kneel@idle_a","idle_a",2.5},
  {"amb@medic@standing@kneel@exit","exit",1}
}
local revive_seq2 = {
  {"amb@medic@standing@kneel@enter","enter",1},
  {"amb@medic@standing@kneel@idle_a","idle_a",5},
  {"amb@medic@standing@kneel@exit","exit",1}
}
local revive_seq3 = {
  {"amb@medic@standing@kneel@enter","enter",1},
  {"amb@medic@standing@kneel@idle_a","idle_a",7.5},
  {"amb@medic@standing@kneel@exit","exit",1}
}

local choice_firstaid = {function(player,choice)
    local user_id = vRP.getUserId(player)
  local firstaidLvl = math.floor(vRP.expToLevel(vRP.getExp(user_id,"lifesaving","firstaid")))
  if firstaidLvl >= 10 then
    if user_id ~= nil then
      vRPclient.getNearestPlayer(player,{10},function(nplayer)
        local nuser_id = vRP.getUserId(nplayer)
        if nuser_id ~= nil then
          vRPclient.isInComa(nplayer,{}, function(in_coma)
            if in_coma and not reviveNow then
              if vRP.tryGetInventoryItem(user_id,"firstaidkit",1,true) then
                if firstaidLvl <= 19 then
                  vRPclient.playAnim(player,{false,revive_seq3,false}) -- anim
                  TriggerClientEvent("pNotify:SendNotification", player,{text ="Du yder førstehjælp på en person.<br/>Level: <b>"..firstaidLvl.."</b> Tid: <b>5 minutter</b>.", type = "info", queue = "global",timeout = 4000, layout = "centerLeft",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
                  reviveNow = true
                  SetTimeout(300000, function()
                    vRPclient.varyHealth(nplayer,{40}) -- heal 40
                    TriggerClientEvent("pNotify:SendNotification", nplayer,{text ="Du er blevet genoplivet af en person.", type = "success", queue = "global",timeout = 4000, layout = "centerLeft",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
                    TriggerClientEvent("pNotify:SendNotification", player,{text ="Personen blev genoplivet.", type = "success", queue = "global",timeout = 4000, layout = "centerLeft",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
                  reviveNow = false
                  end)
                elseif firstaidLvl <= 29 then
                  vRPclient.playAnim(player,{false,revive_seq2,false}) -- anim
                  TriggerClientEvent("pNotify:SendNotification", player,{text ="Du yder førstehjælp på en person.<br/>Level: <b>"..firstaidLvl.."</b> Tid: <b>4 minutter </b>.", type = "info", queue = "global",timeout = 4000, layout = "centerLeft",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
                  reviveNow = true
                  SetTimeout(240000, function()
                    vRPclient.varyHealth(nplayer,{50}) -- heal 50
                    TriggerClientEvent("pNotify:SendNotification", nplayer,{text ="Du er blevet genoplivet af en person.", type = "success", queue = "global",timeout = 4000, layout = "centerLeft",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
                    TriggerClientEvent("pNotify:SendNotification", player,{text ="Personen blev genoplivet.", type = "success", queue = "global",timeout = 4000, layout = "centerLeft",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
                  reviveNow = false
                  end)
                else
                  vRPclient.playAnim(player,{false,revive_seq,false}) -- anim
                  TriggerClientEvent("pNotify:SendNotification", player,{text ="Du yder førstehjælp på en person.<br/>Level: <b>"..firstaidLvl.."</b> Tid: <b>3 minutter</b>.", type = "info", queue = "global",timeout = 4000, layout = "centerLeft",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
                  reviveNow = true
                  SetTimeout(180000, function()
                    vRPclient.varyHealth(nplayer,{60}) -- heal 60
                    TriggerClientEvent("pNotify:SendNotification", nplayer,{text ="Du er blevet genoplivet af en person.", type = "success", queue = "global",timeout = 4000, layout = "centerLeft",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
                    TriggerClientEvent("pNotify:SendNotification", player,{text ="Personen blev genoplivet.", type = "success", queue = "global",timeout = 4000, layout = "centerLeft",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
                  reviveNow = false
                  end)
                end
              end
            else
              TriggerClientEvent("pNotify:SendNotification", player,{text = {lang.emergency.menu.firstaid.not_in_coma()}, type = "error", queue = "global", timeout = 4000, layout = "centerLeft",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
            end
          end)
        else
          TriggerClientEvent("pNotify:SendNotification", player,{text = {lang.common.no_player_near()}, type = "error", queue = "global", timeout = 4000, layout = "centerLeft",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
        end
      end)
    end
  else
    TriggerClientEvent("pNotify:SendNotification", player,{text = "Du skal være mindst level 10 i førstehjælp, for at kunne udøve det!<br>Du er i level <b>"..firstaidLvl.."</b>.", type = "error", queue = "global", timeout = 4000, layout = "centerLeft",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}}) 
  end
end,lang.emergency.menu.firstaid.description()}



