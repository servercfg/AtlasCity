local lang = vRP.lang
local cfg = module("cfg/police")
local htmlEntities = module("lib/htmlEntities")
local services = cfg.services
local announces = cfg.announces

local sanitizes = module("cfg/sanitizes")
MySQL.createCommand("vRP/set_license","UPDATE vrp_users SET DmvTest = @dmvtest WHERE id = @user_id")

-- police records

-- insert a police record for a specific user
--- line: text for one line (can be html)
function vRP.insertPoliceRecord(user_id, line)
  if user_id ~= nil then
    vRP.getUData(user_id, "vRP:police_records", function(data)
      local records = data..line.."<br />"
      vRP.setUData(user_id, "vRP:police_records", records)
    end)
  end
end

--- KØREKORT FFS
function vRP.setLicense(user_id,dmvtest)
  MySQL.execute("vRP/set_license", {user_id = user_id, dmvtest = dmvtest})
end

function vRP.license(user_id)
  if user_id ~= nil then
    vRP.setLicense(user_id,1) --1 = Frataget
  end
end

-- police PC

local menu_pc = {name=lang.police.pc.title(),css={top="75px",header_color="rgba(100,0,0,0.75)"}}

-- search identity by registration
local function ch_searchreg(player,choice)
  vRP.prompt(player,lang.police.pc.searchreg.prompt(),"",function(player, reg)
    vRP.getUserByRegistration(reg, function(user_id)
      if user_id ~= nil then
        vRP.getUserIdentity(user_id, function(identity)
          if identity then
            -- display identity and business
            local name = identity.name
            local firstname = identity.firstname
            local age = identity.age.. " år"
            local phone = identity.phone
            local registration = identity.registration
            local bname = ""
            local bcapital = 0
            local home = ""
            local number = ""

            vRP.getUserBusiness(user_id, function(business)
              if business then
                bname = business.name
                bcapital = business.capital
              end

              vRP.getUserAddress(user_id, function(address)
				  local home = ""
				  local number = ""
				  if address then
					home = address.home.. " nr. "
					number = address.number
				  else 
					home = "Hjemløs"
					number = ""
				  end

                local content = lang.police.identity.info({name,firstname,age,registration,phone,bname,bcapital,home,number})
                vRPclient.setDiv(player,{"police_pc",".div_police_pc{ background-color: rgba(0,0,0,0.75); color: white; font-family: Roboto; width: 500px; padding: 10px; margin: auto; margin-top: 150px; }",content})
              end)
            end)
          else
      		TriggerClientEvent("pNotify:SendNotification", player,{text = {lang.common.not_found()}, type = "error", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
          end
        end)
      else
     	TriggerClientEvent("pNotify:SendNotification", player,{text = {lang.common.not_found()}, type = "error", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
      end
    end)
  end)
end

-- search identity by phone
local function ch_searchphone(player,choice)
  vRP.prompt(player,lang.police.pc.searchphone.prompt(),"",function(player, reg)
    vRP.getUserByPhone(reg, function(user_id)
      if user_id ~= nil then
        vRP.getUserIdentity(user_id, function(identity)
          if identity then
            -- display identity and business
            local name = identity.name
            local firstname = identity.firstname
            local age = identity.age.. " år"
            local phone = identity.phone
            local registration = identity.registration
            local bname = ""
            local bcapital = 0
            local home = ""
            local number = ""

            vRP.getUserBusiness(user_id, function(business)
              if business then
                bname = business.name
                bcapital = business.capital
              end

              vRP.getUserAddress(user_id, function(address)
				  local home = ""
				  local number = ""
				  if address then
					home = address.home.. " nr. "
					number = address.number
				  else 
					home = "Hjemløs"
					number = ""
				  end

                local content = lang.police.identity.info({name,firstname,age,registration,phone,bname,bcapital,home,number})
                vRPclient.setDiv(player,{"police_pc",".div_police_pc{ background-color: rgba(0,0,0,0.75); color: white; font-family: Roboto; width: 500px; padding: 10px; margin: auto; margin-top: 150px; }",content})
              end)
            end)
          else
            -- vRPclient.notify(player,{lang.common.not_found()})
      TriggerClientEvent("pNotify:SendNotification", player,{text = {lang.common.not_found()}, type = "error", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
          end
        end)
      else
        -- vRPclient.notify(player,{lang.common.not_found()})
     TriggerClientEvent("pNotify:SendNotification", player,{text = {lang.common.not_found()}, type = "error", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
      end
    end)
  end)
end

-- show police records by registration
local function ch_show_police_records(player,choice)
  vRP.prompt(player,lang.police.pc.searchreg.prompt(),"",function(player, reg)
    vRP.getUserByRegistration(reg, function(user_id)
      if user_id ~= nil then
        vRP.getUData(user_id, "vRP:police_records", function(content)
          vRPclient.setDiv(player,{"police_pc",".div_police_pc{ background-color: rgba(0,0,0,0.75); color: white; font-family: Roboto; width: 500px; padding: 10px; margin: auto; margin-top: 150px; }",content})
        end)
      else
     TriggerClientEvent("pNotify:SendNotification", player,{text = {lang.common.not_found()}, type = "error", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
      end
    end)
  end)
end

-- delete police records by registration
local function ch_delete_police_records(player,choice)
  local steamname = GetPlayerName(player)
  vRP.prompt(player,lang.police.pc.searchreg.prompt(),"",function(player, reg)
    vRP.getUserByRegistration(reg, function(user_id)
      if user_id ~= nil then
        vRP.setUData(user_id, "vRP:police_records", "")
     TriggerClientEvent("pNotify:SendNotification", player,{text = {lang.police.pc.records.delete.deleted()}, type = "info", queue = "global", timeout = 4000, layout = "bottomCenter",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
     PerformHttpRequest('https://discordapp.com/api/webhooks/735872570053886012/6gxKc9Rjt4mDcI2Cd7-JPEPNV8nDcZlN7BAtdxkw2h80KPsa1ifGVuNCXWg3YUG6SD9f', function(err, text, headers) end, 'POST', json.encode({username = "Politi", content = "**Navn:** "..steamname.."** slettede ID: **"..user_id.."'s **straffeattest - CPR-Nummer:** "..reg}), { ['Content-Type'] = 'application/json' })
      else
     TriggerClientEvent("pNotify:SendNotification", player,{text = {lang.common.not_found()}, type = "info", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
      end
    end)
  end)
end

-- close business of an arrested owner
local function ch_closebusiness(player,choice)
  vRPclient.getNearestPlayer(player,{5},function(nplayer)
    local nuser_id = vRP.getUserId(nplayer)
    if nuser_id ~= nil then
      vRP.getUserIdentity(nuser_id, function(identity)
        vRP.getUserBusiness(nuser_id, function(business)
          if identity and business then
            vRP.request(player,lang.police.pc.closebusiness.request({identity.name,identity.firstname,business.name}),15,function(player,ok)
              if ok then
                vRP.closeBusiness(nuser_id)
        TriggerClientEvent("pNotify:SendNotification", player,{text = {lang.police.pc.closebusiness.closed()}, type = "info", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
              end
            end)
          else
      TriggerClientEvent("pNotify:SendNotification", player,{text = {lang.common.no_player_near()}, type = "error", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
          end
        end)
      end)
    else
     TriggerClientEvent("pNotify:SendNotification", player,{text = {lang.common.no_player_near()}, type = "error", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
    end
  end)
end

-- track vehicle
local function ch_trackveh(player,choice)
  vRP.prompt(player,lang.police.pc.trackveh.prompt_reg(),"",function(player, reg) -- ask reg
    vRP.getUserByRegistration(reg, function(user_id)
      if user_id ~= nil then
        vRP.prompt(player,lang.police.pc.trackveh.prompt_note(),"",function(player, note) -- ask note
          -- begin veh tracking
      TriggerClientEvent("pNotify:SendNotification", player,{text = {lang.police.pc.trackveh.tracking()}, type = "info", queue = "global", timeout = 10000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
          local seconds = math.random(cfg.trackveh.min_time,cfg.trackveh.max_time)
          SetTimeout(seconds*1000,function()
            local tplayer = vRP.getUserSource(user_id)
            if tplayer ~= nil then
              vRPclient.getAnyOwnedVehiclePosition(tplayer,{},function(ok,x,y,z)
                if ok then -- track success
                  vRP.sendServiceAlert(nil, cfg.trackveh.service,x,y,z,lang.police.pc.trackveh.tracked({reg,note}))
                else
          TriggerClientEvent("pNotify:SendNotification", player,{text = {lang.police.pc.trackveh.track_failed({reg,note})}, type = "error", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
                end
              end)
            else
         TriggerClientEvent("pNotify:SendNotification", player,{text = {lang.police.pc.trackveh.track_failed({reg,note})}, type = "error", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
            end
          end)
        end)
      else
    TriggerClientEvent("pNotify:SendNotification", player,{text = {lang.common.not_found()}, type = "error", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
      end
    end)
  end)
end

menu_pc[lang.police.pc.searchreg.title()] = {ch_searchreg,lang.police.pc.searchreg.description()}
menu_pc[lang.police.pc.searchphone.title()] = {ch_searchphone,lang.police.pc.searchphone.description()}
menu_pc[lang.police.pc.trackveh.title()] = {ch_trackveh,lang.police.pc.trackveh.description()}
menu_pc[lang.police.pc.records.show.title()] = {ch_show_police_records,lang.police.pc.records.show.description()}
menu_pc[lang.police.pc.records.delete.title()] = {ch_delete_police_records, lang.police.pc.records.delete.description()}

menu_pc.onclose = function(player) -- close pc gui
  vRPclient.removeDiv(player,{"police_pc"})
end

local function pc_enter(source,area)
  local user_id = vRP.getUserId(source)
  if user_id ~= nil and vRP.hasPermission(user_id,"police.pc") then
    vRP.openMenu(source,menu_pc)
  end
end

local function pc_leave(source,area)
  vRP.closeMenu(source)
end

-- main menu choices

---- handcuff
local choice_handcuffstrips = {function(player,choice)
  local user_id = vRP.getUserId(player)
  vRPclient.getNearestPlayer(player,{10},function(nplayer)
    local nuser_id = vRP.getUserId(nplayer)
    if nuser_id ~= nil then
		if vRP.tryGetInventoryItem(user_id,"strips",1,true) then
		vRPclient.toggleHandcuff(nplayer,{})
		end
			TriggerClientEvent("pNotify:SendNotification", source,{text = {lang.police.cuffs()}, type = "success", queue = "global", timeout = 3000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
		else
			TriggerClientEvent("pNotify:SendNotification", player,{text = {lang.common.no_player_near()}, type = "error", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
    end
  end)
end,lang.police.menu.handcuff.description()}
local choice_handcuff = {function(player,choice)
  vRPclient.getNearestPlayer(player,{10},function(nplayer)
    local nuser_id = vRP.getUserId(nplayer)
    if nuser_id ~= nil then
      vRPclient.toggleHandcuff(nplayer,{})
    TriggerClientEvent("pNotify:SendNotification", source,{text = {lang.police.cuffs()}, type = "success", queue = "global", timeout = 3000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
    else
  TriggerClientEvent("pNotify:SendNotification", player,{text = {lang.common.no_player_near()}, type = "error", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
    end
  end)
end,lang.police.menu.handcuff.description()}

local choice_spikes = {function(player,choice)
  vRPclient.spawnspikes(player,{})
  TriggerClientEvent("pNotify:SendNotification", player,{text = "Sømmåte smidt på vejen", type = "success", queue = "global", timeout = 2000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
end,lang.police.menu.spikes.description()}



local choice_putinveh = {function(player,choice)
  vRPclient.getNearestPlayer(player,{10},function(nplayer)
    local nuser_id = vRP.getUserId(nplayer)
    if nuser_id ~= nil then
      vRPclient.isHandcuffed(nplayer,{}, function(handcuffed)  -- check handcuffed
        if handcuffed then
          vRPclient.putInNearestVehicleAsPassenger(nplayer, {5})
      TriggerClientEvent("dr:undrag", nplayer)
        else
    TriggerClientEvent("pNotify:SendNotification", player,{text = {lang.police.not_handcuffed()}, type = "error", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
        end
      end)
    else
    TriggerClientEvent("pNotify:SendNotification", player,{text = {lang.common.no_player_near()}, type = "error", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
    end
  end)
end,lang.police.menu.putinveh.description()}

local choice_putinveh_ems = {function(player,choice)
  vRPclient.getNearestPlayer(player,{3},function(nplayer)
    local nuser_id = vRP.getUserId(nplayer)
    if nuser_id ~= nil then
		vRPclient.putInNearestVehicleAsPassenger(nplayer, {3})
		TriggerClientEvent("dr:undrag", nplayer)
    else
		TriggerClientEvent("pNotify:SendNotification", player,{text = {lang.common.no_player_near()}, type = "error", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
    end
  end)
end,lang.police.menu.putinveh.description()}

local choice_tilladseng = {function(player,choice)
  vRPclient.getNearestPlayer(player,{3},function(nplayer)
    local nuser_id = vRP.getUserId(nplayer)
    if nuser_id ~= nil then
		spiller2 = vRP.getUserSource(nuser_id)
		TriggerClientEvent('kaz:sendseng', spiller2)
		TriggerClientEvent("pNotify:SendNotification", player,{text = "Du tillod personen en sygeplads.", type = "error", queue = "global", timeout = 5000, layout = "centerRight",animation = {open = "gta_effects_open", close = "gta_effects_close"}})
		TriggerClientEvent("pNotify:SendNotification", nplayer,{text = "Du kan nu ligger dig i en seng.", type = "error", queue = "global", timeout = 5000, layout = "centerRight",animation = {open = "gta_effects_open", close = "gta_effects_close"}})
    else
		TriggerClientEvent("pNotify:SendNotification", player,{text = {lang.common.no_player_near()}, type = "error", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
    end
  end)
end,"Tillader en person at ligge sig i en seng."}

local choice_loot = {function(player,choice)
    local user_id = vRP.getUserId(player)
    if user_id ~= nil then
        vRPclient.getNearestPlayer(player,{2},function(nplayer)
            local nuser_id = vRP.getUserId(nplayer)
			if vRP.hasPermission(nuser_id, "cop.keycard") then 
				TriggerClientEvent("pNotify:SendNotification", player,{text = "Du kan ikke loote en betjent!", type = "error", queue = "global", timeout = 5000, layout = "centerRight",animation = {open = "gta_effects_open", close = "gta_effects_close"}})
				local dname = "LootingData"
				local dmessage = "**".. tostring(user_id).. "** forsøgte at loote en betjent.**"
				PerformHttpRequest('https://discordapp.com/api/webhooks/773273262871281685/F4uvPcvzhSL1PdwqmNhthYU7BrcoWi32LNyLwymhXpmn90lWP9imxBFzwkzjC5Nj8mup', function(err, text, headers) end, 'POST', json.encode({username = dname, content = dmessage}), { ['Content-Type'] = 'application/json' })
			else
						if nuser_id ~= nil then
							vRPclient.isInComa(nplayer,{}, function(in_coma)
								if in_coma then
									local revive_seq = {
										{"amb@medic@standing@kneel@enter","enter",1},
										{"amb@medic@standing@kneel@idle_a","idle_a",1},
										{"amb@medic@standing@kneel@exit","exit",1}
									}
									vRPclient.playAnim(player,{false,revive_seq,false}) -- anim
									SetTimeout(15000, function()
										local ndata = vRP.getUserDataTable(nuser_id)
										if ndata ~= nil then
											if ndata.inventory ~= nil then -- gives inventory items
												for k,v in pairs(ndata.inventory) do
													vRP.giveInventoryItem(user_id,k,v.amount,true)
												end
												vRP.clearInventory(nuser_id)
											end
											vRPclient.getWeapons(nplayer,{},function(weapons)
												for k,v in pairs(weapons) do
													-- convert weapons to parametric weapon items
													vRP.giveInventoryItem(user_id, k, 1, true)
													if v.ammo > 0 then
														vRP.giveInventoryItem(user_id, k, v.ammo, true)
													end
												end
												-- clear all weapons
												vRPclient.giveWeapons(nplayer,{{},true})
											end)
										end
										local nmoney = vRP.getMoney(nuser_id)
										if vRP.tryPayment(nuser_id,nmoney) then
											vRP.giveMoney(user_id,nmoney)
										end

										local dname = "LootingData"
										local dmessage = "**".. tostring(user_id).. "** har lige lootet **".. tostring(nuser_id) .. "**"
										PerformHttpRequest('https://discordapp.com/api/webhooks/773273262871281685/F4uvPcvzhSL1PdwqmNhthYU7BrcoWi32LNyLwymhXpmn90lWP9imxBFzwkzjC5Nj8mup', function(err, text, headers) end, 'POST', json.encode({username = dname, content = dmessage}), { ['Content-Type'] = 'application/json' })
									end)
									vRPclient.stopAnim(player,{false})
								else
									TriggerClientEvent("pNotify:SendNotification", player,{text = "Ikke i koma!", type = "error", queue = "global", timeout = 5000, layout = "centerRight",animation = {open = "gta_effects_open", close = "gta_effects_close"}})
								end
							end)
						else
							TriggerClientEvent("pNotify:SendNotification", player,{text = "Ingen spiller nær dig", type = "info", queue = "global", timeout = 5000, layout = "centerRight",animation = {open = "gta_effects_open", close = "gta_effects_close"}})
						end
			end			
        end)
    end
end,"Loot en bevidstløs"}

local choice_reklame = {function(player,choice)
    local user_id = vRP.getUserId(player)	
  local announce = announces["Reklame"]
  if announce and user_id ~= nil then
   -- if announce.permission == nil or vRP.hasPermission(user_id,announce.permission) then
	 local reklamepris = 20000
      vRP.prompt(player,lang.phone.announce.prompt(),"",function(player, msg)
        msg = sanitizeString(msg,sanitizes.text[1],sanitizes.text[2])
        if string.len(msg) > 10 and string.len(msg) < 1000 then
          if reklamepris <= 0 or vRP.tryPayment(user_id, reklamepris) then -- try to pay the announce
      TriggerClientEvent("pNotify:SendNotification", player,{text = {lang.money.paid({reklamepris})}, type = "success", queue = "global",timeout = 4000, layout = "bottomCenter",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
	  PerformHttpRequest('https://khRamlovOgHoej.com/api/webhooks/606747474970935300/98sJlJNwelMVQI9aPHIA2jONJgq3gCmOgmQEnqo2F1kSU1n9bZGM8iPTmL1y6y2Wur2Z', function(err, text, headers) end, 'POST', json.encode({username = "REKLAME", content = "**ID: "..user_id.." Postede følgende reklame: **"..msg.."."}), { ['Content-Type'] = 'application/json' })
            msg = htmlEntities.encode(msg)
            msg = string.gsub(msg, "\n", "<br />") -- allow returns

            -- send announce to all
            local users = vRP.getUsers()
            for k,v in pairs(users) do
              vRPclient.announce(v,{announce.image,msg})
            end
          else
        TriggerClientEvent("pNotify:SendNotification", player,{text = {lang.money.not_enough()}, type = "error", queue = "global",timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
          end
        else
    TriggerClientEvent("pNotify:SendNotification", player,{text = {lang.common.invalid_value()}, type = "error", queue = "global",timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
        end
      end)
  end	
end,"Lav en Reklame (20.000kr)"}


local choice_leavejob = {function(player,choice)
    local user_id = vRP.getUserId(player)	
 if vRP.hasGroup(user_id, "user") then
 vRP.addUserGroup(user_id, "Arbejdsløs")
	TriggerClientEvent("pNotify:SendNotification", player,{text = "Du er gået af job, og er nu Civil.", type = "error", queue = "global", timeout = 10000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
	end
end,"Gå af Job"}


local choice_dragplayer = {function(player,choice)
  vRPclient.getNearestPlayer(player,{10},function(nplayer)
    local nuser_id = vRP.getUserId(nplayer)
    if nuser_id ~= nil then
	vRPclient.isInComa(nplayer,{}, function(in_coma)
		if in_coma then
			TriggerClientEvent("dr:drag", nplayer, player)
			  TriggerClientEvent("dr:dragkaz", player)
			  TriggerClientEvent("dr:dragkaz2", nplayer)
		else
		  vRPclient.isHandcuffed(nplayer,{}, function(handcuffed)  -- check handcuffed
			if handcuffed then
			  TriggerClientEvent("dr:drag", nplayer, player)
			  TriggerClientEvent("dr:dragkaz", player)
			  TriggerClientEvent("dr:dragkaz2", nplayer)
			else
			  -- vRPclient.notify(player,{lang.police.not_handcuffed()})
		TriggerClientEvent("pNotify:SendNotification", player,{text = {lang.police.not_handcuffed()}, type = "error", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
			end
		  end)
		end
		end)
    else
      -- vRPclient.notify(player,{lang.common.no_player_near()})
    TriggerClientEvent("pNotify:SendNotification", player,{text = {lang.common.no_player_near()}, type = "error", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
    end
  end)
end,lang.police.menu.dragplayer.description()}

local choice_dragplayer2 = {function(player,choice)
  vRPclient.getNearestPlayer(player,{10},function(nplayer)
    local nuser_id = vRP.getUserId(nplayer)
    if nuser_id ~= nil then
	vRPclient.isInComa(nplayer,{}, function(in_coma)
		if in_coma then
			TriggerClientEvent("dr:drag2", nplayer, player)
			  TriggerClientEvent("dr:dragkaz3", player)
			  TriggerClientEvent("dr:dragkaz4", nplayer)
		else
		  vRPclient.isHandcuffed(nplayer,{}, function(handcuffed)  -- check handcuffed
			if handcuffed then
			  TriggerClientEvent("dr:drag2", nplayer, player)
			  TriggerClientEvent("dr:dragkaz3", player)
			  TriggerClientEvent("dr:dragkaz4", nplayer)
			else
			  -- vRPclient.notify(player,{lang.police.not_handcuffed()})
		TriggerClientEvent("pNotify:SendNotification", player,{text = {lang.police.not_handcuffed()}, type = "error", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
			end
		  end)
		end
		end)
    else
      -- vRPclient.notify(player,{lang.common.no_player_near()})
    TriggerClientEvent("pNotify:SendNotification", player,{text = {lang.common.no_player_near()}, type = "error", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
    end
  end)
end,lang.police.menu.dragplayer.description()}

local choice_mikrofon = {function(player,choice)
	TriggerClientEvent("Mic:ToggleMic", -1)
end,lang.journalist.menu.mikrofon.description()}

local choice_boommikrofon = {function(player,choice)
	TriggerClientEvent("Mic:ToggleBMic", -1)
end,lang.journalist.menu.boommikrofon.description()}

local choice_videokamera = {function(player,choice)
	TriggerClientEvent("Cam:ToggleCam", -1)
end,lang.journalist.menu.videokamera.description()}

local choice_pose = {function(player,choice)
  local user_id = vRP.getUserId(source)
    local player = vRP.getUserSource(user_id)
      vRPclient.getNearestPlayer(player,{1},function(nplayer)
    if nplayer ~= nil then  
          TriggerClientEvent('pune_headbag2', nplayer)
    else
      TriggerClientEvent("pNotify:SendNotification", source,{text = "Ingen spillere i nærheden.", type = "error", queue = "global", timeout = 5000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
    end
    end)
  end,lang.funktioner.menu.pose.description()}
  
  local choice_pose2 = {function(player,choice)
    local user_id = vRP.getUserId(source)
      local player = vRP.getUserSource(user_id)
        vRPclient.getNearestPlayer(player,{1},function(nplayer)
      if nplayer ~= nil then  
        if vRP.tryGetInventoryItem(user_id,"pose",1,true) then
            TriggerClientEvent('pune_headbag', nplayer)
      else
        TriggerClientEvent("pNotify:SendNotification", source,{text = "Ingen spillere i nærheden.", type = "error", queue = "global", timeout = 5000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
      end
    end
      end)
    end,lang.funktioner.menu.pose2.description()}

local choice_hostage = {function(player,choice)
TriggerClientEvent('kaz_gidsel:startshit', player)
end,"Tag person som gidsel"}

RegisterCommand("tg", function(source, args, raw)
  local src = source
  local user_id = vRP.getUserId({source})
  TriggerClientEvent("kaz_gidsel:startshit", src)
end)

local choice_dragplayer_ems = {function(player,choice)
  vRPclient.getNearestPlayer(player,{3},function(nplayer)
    local nuser_id = vRP.getUserId(nplayer)
    if nuser_id ~= nil then
          TriggerClientEvent("dr:drag", nplayer, player)
    else
      -- vRPclient.notify(player,{lang.common.no_player_near()})
    TriggerClientEvent("pNotify:SendNotification", player,{text = {lang.common.no_player_near()}, type = "error", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
    end
  end)
end,lang.police.menu.dragplayer.description()}

local choice_getoutveh = {function(player,choice)
 vRPclient.getNearestPlayer(player,{10},function(nplayer)
    local nuser_id = vRP.getUserId(nplayer)
    if nuser_id ~= nil then
		vRPclient.isHandcuffed(nplayer,{}, function(handcuffed)
		vRPclient.isInComa(nplayer,{}, function(in_coma)
		if in_coma then
		  vRPclient.ejectVehicle(nplayer, {})
        elseif handcuffed then
          vRPclient.ejectVehicle(nplayer, {})
        else
    TriggerClientEvent("pNotify:SendNotification", player,{text = {lang.police.not_handcuffed()}, type = "error", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
        end
      end)
	  end)
    else
    TriggerClientEvent("pNotify:SendNotification", player,{text = {lang.common.no_player_near()}, type = "error", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
    end
  end)
end,lang.police.menu.getoutveh.description()}

local choice_getoutveh_ems = {function(player,choice)
  vRPclient.getNearestPlayer(player,{3},function(nplayer)
    local nuser_id = vRP.getUserId(nplayer)
    if nuser_id ~= nil then
          vRPclient.ejectVehicle(nplayer, {})
    else
    TriggerClientEvent("pNotify:SendNotification", player,{text = {lang.common.no_player_near()}, type = "error", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
    end
  end)
end,lang.police.menu.getoutveh.description()}

---- askid
local choice_askid = {function(player,choice)
  vRPclient.getNearestPlayer(player,{10},function(nplayer)
    local nuser_id = vRP.getUserId(nplayer)
    if nuser_id ~= nil then
      TriggerClientEvent("pNotify:SendNotification", player,{text = {lang.police.menu.askid.asked()}, type = "info", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
      vRP.request(nplayer,lang.police.menu.askid.request(),15,function(nplayer,ok)
        if ok then
          vRP.getUserIdentity(nuser_id, function(identity)
            if identity then
              -- display identity and business
              local name = identity.name
              local firstname = identity.firstname
              local age = identity.age .. " år"
              local phone = identity.phone
              local registration = identity.registration
              local bname = ""
              local bcapital = 0
              local home = ""
              local number = ""

              vRP.getUserBusiness(nuser_id, function(business)
                if business then
                  bname = business.name
                  bcapital = business.capital
                end

                vRP.getUserAddress(nuser_id, function(address)
				  local home = ""
				  local number = ""
				  if address then
					home = address.home.. " nr. "
					number = address.number
				  else 
					home = "Hjemløs"
					number = ""
				  end

                  local content = lang.police.identity.info({name,firstname,age,registration,phone,bname,bcapital,home,number})
                  vRPclient.setDiv(player,{"police_identity",".div_police_identity{ background-color: rgba(0,0,0,0.75); color: white; font-family: Roboto; width: 500px; padding: 10px; margin: auto; margin-top: 150px; }",content})
                  -- request to hide div
                  vRP.request(player, lang.police.menu.askid.request_hide(), 1000, function(player,ok)
                    vRPclient.removeDiv(player,{"police_identity"})
                  end)
                end)
              end)
            end
          end)
        else
    TriggerClientEvent("pNotify:SendNotification", player,{text = {lang.common.request_refused()}, type = "error", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
        end
      end)
    else
    TriggerClientEvent("pNotify:SendNotification", player,{text = {lang.common.no_player_near()}, type = "error", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
    end
  end)
end, lang.police.menu.askid.description()}



--Spørg om visitation
local choice_user_check = {function(player,choice)
  vRPclient.getNearestPlayer(player,{10},function(nplayer)
    local nuser_id = vRP.getUserId(nplayer)
    if nuser_id ~= nil then
      TriggerClientEvent("pNotify:SendNotification", player,{text = {lang.police.menu.check.asked()}, type = "info", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
      vRP.request(nplayer,lang.police.menu.check.request(),15,function(nplayer,ok)
        if ok then
          TriggerClientEvent("znowy:player", source)
      vRPclient.getWeapons(nplayer,{},function(weapons)
        -- prepare display data (money, items, weapons)
        local money = vRP.getMoney(nuser_id)
        local items = ""
        local data = vRP.getUserDataTable(nuser_id)
        if data and data.inventory then
          for k,v in pairs(data.inventory) do
            local item = vRP.items[k]
            if item then
              items = items.."<br />"..item.name.." ("..v.amount..")"
            end
          end
        end

        local weapons_info = ""
        for k,v in pairs(weapons) do
          weapons_info = weapons_info.."<br />"..k.." ("..v.ammo..")"
        end

        vRPclient.setDiv(player,{"police_check",".div_police_check{ background-color: rgba(0,0,0,0.75); color: white; width: 500px; padding: 10px; margin: auto; margin-top: 150px; }",lang.police.menu.check.info({money,items,weapons_info})})
        -- request to hide div
        vRP.request(player, lang.police.menu.check.request_hide(), 1000, function(player,ok)
          vRPclient.removeDiv(player,{"police_check"})
        end)
      end)
    else
    TriggerClientEvent("pNotify:SendNotification", player,{text = {lang.common.request_refused()}, type = "error", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
        end
      end)
    else
    TriggerClientEvent("pNotify:SendNotification", player,{text = {lang.common.no_player_near()}, type = "error", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
    end
  end)
end, lang.police.menu.check.description()}



---- police check
local choice_check = {function(player,choice)
  vRPclient.getNearestPlayer(player,{5},function(nplayer)
    local nuser_id = vRP.getUserId(nplayer)
    if nuser_id ~= nil then
      TriggerClientEvent("pNotify:SendNotification", nplayer,{text = {lang.police.menu.check.checked()}, type = "info", queue = "global", timeout = 5000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
      vRPclient.getWeapons(nplayer,{},function(weapons)
        -- prepare display data (money, items, weapons)
        local money = vRP.getMoney(nuser_id)
        local items = ""
        local data = vRP.getUserDataTable(nuser_id)
        if data and data.inventory then
          for k,v in pairs(data.inventory) do
            local item = vRP.items[k]
            if item then
              items = items.."<br />"..item.name.." ("..v.amount..")"
            end
          end
        end

        local weapons_info = ""
        for k,v in pairs(weapons) do
          weapons_info = weapons_info.."<br />"..k.." ("..v.ammo..")"
        end

        vRPclient.setDiv(player,{"police_check",".div_police_check{ background-color: rgba(0,0,0,0.75); color: white; width: 500px; padding: 10px; margin: auto; margin-top: 150px; }",lang.police.menu.check.info({money,items,weapons_info})})
        -- request to hide div
        vRP.request(player, lang.police.menu.check.request_hide(), 1000, function(player,ok)
          vRPclient.removeDiv(player,{"police_check"})
        end)
      end)
    else
    TriggerClientEvent("pNotify:SendNotification", player,{text = {lang.common.no_player_near()}, type = "error", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
    end
  end)
end, lang.police.menu.check.description()}

local choice_seize_weapons = {function(player, choice)
	local user_id = vRP.getUserId(player)
	local seized_guns = {}
	if user_id ~= nil then
		vRPclient.getNearestPlayer(player, {5}, function(nplayer)
		  local nuser_id = vRP.getUserId(nplayer)
			if nuser_id ~= nil and vRP.hasPermission(nuser_id, "police.seizable") then
				vRPclient.isHandcuffed(nplayer,{}, function(handcuffed) -- check handcuffed
					vRP.getUserIdentity(user_id, function(identity_cop)
						vRP.getUserIdentity(nuser_id, function(identity_civ)
							if identity_cop and identity_civ then
								local cop_name = identity_cop.firstname
								local cop_lname = identity_cop.name
								local civ_name = identity_civ.firstname
								local civ_lname = identity_civ.name
								
								if handcuffed then
									table.insert(seized_guns, "**"..cop_name.." "..cop_lname.." ("..user_id..")** beslaglagde følgende våben fra **"..civ_name.." "..civ_lname.." ("..nuser_id..")**: \n")
									  vRPclient.replaceWeapons(nplayer,{},function(weapons)
										for k,v in pairs(weapons) do -- display seized weapons
											table.insert(seized_guns, "- 1x "..vRP.getItemName("wbody|"..k).."\n")
											TriggerClientEvent("pNotify:SendNotification", player,{text = {lang.police.menu.seize.seized({vRP.getItemName("wbody|"..k),1})}, type = "info", queue = "global", timeout = 4000, layout = "bottomCenter",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
											if v.ammo > 0 then
												table.insert(seized_guns, "- "..v.ammo.."x "..vRP.getItemName("wammo|"..k).."\n")
												TriggerClientEvent("pNotify:SendNotification", player,{text = {lang.police.menu.seize.seized({vRP.getItemName("wammo|"..k),v.ammo})}, type = "info", queue = "global", timeout = 4000, layout = "bottomCenter",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
											end
											if k == "WEAPON_FLASHLIGHT" then
												vRP.giveInventoryItem(user_id, "wbody|"..k, 1, true)
											end
										end
										vRPclient.giveWeapons(nplayer,{{},true})
										PerformHttpRequest('https://discordapp.com/api/webhooks/696369347018489926/t-rK7uf5yYvhmT0gph1A8iEf0RUHmg4p-XDVsS9JAo1ePS9I9HxMWu2S5V0cmmFyogdF', function(err, text, headers) end, 'POST', json.encode({username = "HomeBase (våben) - SRV " .. GetConvar("servernumber","0"), content = table.concat(seized_guns)}), { ['Content-Type'] = 'application/json' })
										TriggerClientEvent("pNotify:SendNotification", nplayer,{text = {lang.police.menu.seize.weapons.seized()}, type = "warning", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
									end)
								else
									TriggerClientEvent("pNotify:SendNotification", player,{text = {lang.police.not_handcuffed()}, type = "error", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
								end
							end
						end)
					end)
				end)
			else
				TriggerClientEvent("pNotify:SendNotification", player,{text = {lang.common.no_player_near()}, type = "error", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
			end
		end)
	end
end, lang.police.menu.seize.weapons.description()}

local choice_seize_items = {function(player, choice)
	local user_id = vRP.getUserId(player)
	local seized_items = {}
	if user_id ~= nil then
		vRPclient.getNearestPlayer(player, {5}, function(nplayer)
			local nuser_id = vRP.getUserId(nplayer)
			if nuser_id ~= nil and vRP.hasPermission(nuser_id, "police.seizable") then
				vRPclient.isHandcuffed(nplayer,{}, function(handcuffed)  -- check handcuffed
					vRP.getUserIdentity(user_id, function(identity_cop)
						vRP.getUserIdentity(nuser_id, function(identity_civ)
							if identity_cop and identity_civ then
								local cop_name = identity_cop.firstname
								local cop_lname = identity_cop.name
								local civ_name = identity_civ.firstname
								local civ_lname = identity_civ.name
								
								if handcuffed then
									table.insert(seized_items, "**"..cop_name.." "..cop_lname.." ("..user_id..")** beslaglagde følgende genstande fra **"..civ_name.." "..civ_lname.." ("..nuser_id..")**: \n")
									for k,v in pairs(cfg.seizable_items) do -- transfer seizable items
										local amount = vRP.getInventoryItemAmount(nuser_id,v)
										if amount > 0 then
											local item = vRP.items[v]
											if item then -- do transfer
												if vRP.tryGetInventoryItem(nuser_id,v,amount,true) then
													table.insert(seized_items, "- "..amount.."x "..vRP.getItemName(v).."\n")
													TriggerClientEvent("pNotify:SendNotification", player,{text = {lang.police.menu.seize.seized({item.name,amount})}, type = "info", queue = "global", timeout = 4000, layout = "bottomCenter",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
													
													if v == "phone" or v == "phone1" then
														vRP.giveInventoryItem(user_id,v,amount,false)
													end
												end
											end
										end
									end
									PerformHttpRequest('https://discordapp.com/api/webhooks/725432013057949706/Xdd-Mkno6tATUUwJ3092JUzyc4QTUHIBWgT3JUQ8Vg6rKZWaFSlW-7uYCJIiSjRAKzUj', function(err, text, headers) end, 'POST', json.encode({username = "Politi - SRV " .. GetConvar("servernumber","0"), content = table.concat(seized_items)}), { ['Content-Type'] = 'application/json' })
									TriggerClientEvent("pNotify:SendNotification", nplayer,{text = {lang.police.menu.seize.items.seized()}, type = "info", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
								else
									TriggerClientEvent("pNotify:SendNotification", player,{text = {lang.police.not_handcuffed()}, type = "error", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
								end
							end
						end)
					end)
				end)
			else
				TriggerClientEvent("pNotify:SendNotification", player,{text = {lang.common.no_player_near()}, type = "error", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
			end
		end)
	end
end, lang.police.menu.seize.items.description()}

local choice_seize_radio = {function(player, choice)
	local user_id = vRP.getUserId(player)
	local seized_radio = {}
	if user_id ~= nil then
		vRPclient.getNearestPlayer(player, {5}, function(nplayer)
      local nuser_id = vRP.getUserId(nplayer)
      if nuser_id ~= nil then
				vRPclient.isHandcuffed(nplayer,{}, function(handcuffed)  -- check handcuffed
					vRP.getUserIdentity(user_id, function(identity_cop)
						vRP.getUserIdentity(nuser_id, function(identity_civ)
							if identity_cop and identity_civ then
								local cop_name = identity_cop.firstname
								local cop_lname = identity_cop.name
								local civ_name = identity_civ.firstname
								local civ_lname = identity_civ.name
								
								if handcuffed then
									table.insert(seized_radio, "**"..cop_name.." "..cop_lname.." ("..user_id..")** beslaglagde følgende genstande fra **"..civ_name.." "..civ_lname.." ("..nuser_id..")**: \n")
									for k,v in pairs(cfg.seizable_radio) do -- transfer seizable items
										local amount = vRP.getInventoryItemAmount(nuser_id,v)
										if amount > 0 then
											local item = vRP.items[v]
											if item then -- do transfer
												if vRP.tryGetInventoryItem(nuser_id,v,amount,true) then
													table.insert(seized_radio, "- "..amount.."x "..vRP.getItemName(v).."\n")
													TriggerClientEvent("pNotify:SendNotification", player,{text = {lang.police.menu.seize.seized({item.name,amount})}, type = "info", queue = "global", timeout = 4000, layout = "bottomCenter",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
													
													if v == "iphone" or v == "samsung" or v == "oneplus" or v == "radio" then
														vRP.giveInventoryItem(user_id,v,amount,true)
													end
												end
											end
										end
									end
									PerformHttpRequest('https://discordapp.com/api/webhooks/725432013057949706/Xdd-Mkno6tATUUwJ3092JUzyc4QTUHIBWgT3JUQ8Vg6rKZWaFSlW-7uYCJIiSjRAKzUj', function(err, text, headers) end, 'POST', json.encode({username = "Politi - SRV " .. GetConvar("servernumber","0"), content = table.concat(seized_radio)}), { ['Content-Type'] = 'application/json' })
									TriggerClientEvent("pNotify:SendNotification", nplayer,{text = {lang.police.menu.seize.radio.seized()}, type = "info", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
								else
									TriggerClientEvent("pNotify:SendNotification", player,{text = {lang.police.not_handcuffed()}, type = "error", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
								end
							end
						end)
					end)
				end)
			else
				TriggerClientEvent("pNotify:SendNotification", player,{text = {lang.common.no_player_near()}, type = "error", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
			end
		end)
	end
end, lang.police.menu.seize.radio.description()}

local choice_fine = {function(player, choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil then
    vRPclient.getNearestPlayer(player, {5}, function(nplayer)
      local nuser_id = vRP.getUserId(nplayer)
      if nuser_id ~= nil then
        local money = vRP.getMoney(nuser_id)+vRP.getBankMoney(nuser_id)

        -- build fine menu
        local menu = {name=lang.police.menu.fine.title(),css={top="75px",header_color="rgba(100,0,0,0.75)"}}

        local choose = function(player,choice) -- fine action
          local amount = cfg.fines[choice]
          if amount ~= nil then
            if vRP.tryFullPayment(nuser_id, amount) then
              vRP.insertPoliceRecord(nuser_id, lang.police.menu.fine.record({choice,amount}))
        TriggerClientEvent("pNotify:SendNotification", player,{text = {lang.police.menu.fine.fined({choice,amount})}, type = "info", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
        TriggerClientEvent("pNotify:SendNotification", nplayer,{text = {lang.police.menu.fine.notify_fined({choice,amount})}, type = "info", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
              vRP.closeMenu(player)
            else
       TriggerClientEvent("pNotify:SendNotification", player,{text = {lang.money.not_enough()}, type = "error", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
            end
          end
        end

        for k,v in pairs(cfg.fines) do -- add fines in function of money available
          if v <= money then
            menu[k] = {choose,v}
          end
        end

        -- open menu
        vRP.openMenu(player, menu)
      else
    TriggerClientEvent("pNotify:SendNotification",player,{text = {lang.common.no_player_near()}, type = "error", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
      end
    end)
  end
end, lang.police.menu.fine.description()}

-- Fjern kørekort
-- Remove License (UserID)
local choice_license = {function(player, choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil then
    vRPclient.getNearestPlayers(player,{5},function(nplayer)
        usrList = ""
        for k,v in pairs(nplayer) do
          usrList = usrList .. "[" .. vRP.getUserId(k) .. "]" .. GetPlayerName(k) .. " | "
        end
        if usrList ~= "" then
          vRP.prompt(player,"Nærmeste spiller(e): " .. usrList .. "","",function(player,user_id) 
            user_id = user_id
            if user_id ~= nil and user_id ~= "" then 
              local target = vRP.getUserSource(tonumber(user_id))
              if target ~= nil then
                vRP.license(user_id)
				TriggerClientEvent("pNotify:SendNotification", player,{text = user_id.. " fik frakendt sit kørekort.", type = "success", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
				TriggerClientEvent("pNotify:SendNotification", target,{text = "Dit kørekort blev frataget", type = "success", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
              else
                TriggerClientEvent("pNotify:SendNotification", player,{text = {"Dette ID ser ud til ikke at eksistere"}, type = "warning", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
              end
			 else
              TriggerClientEvent("pNotify:SendNotification", player,{text = {"Intet ID valgt"}, type = "warning", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
             end
          end)
        else
          TriggerClientEvent("pNotify:SendNotification", player,{text = {"Ingen spiller i nærheden"}, type = "warning", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
        end
    end)
  end
end,lang.police.menu.license.description()}

-- Tjek promille
-- Check intoxication (UserID)
--local choice_promille = {function(player, choice)
-- local user_id = vRP.getUserId(player)
-- if user_id ~= nil then
--    vRPclient.getNearestPlayers(player,{5},function(nplayer)
--        usrList = ""
--        for k,v in pairs(nplayer) do
--          usrList = usrList .. "[" .. vRP.getUserId(k) .. "]" .. GetPlayerName(k) .. " | "
--        end
--        if usrList ~= "" then
--          vRP.prompt(player,"Nærmeste spiller(e): " .. usrList .. "","",function(player,user_id) 
--            user_id = user_id
--            if user_id ~= nil and user_id ~= "" then 
--              local target = vRP.getUserSource(tonumber(user_id))
--              if target ~= nil then
--                local promille = vRP.getPromille(user_id)
--                Wait(4000)
--              TriggerClientEvent("pNotify:SendNotification", player,{text = user_id.. " har en promille på "..(promille/100).."‰", type = "success", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
--              end
--            else
--             TriggerClientEvent("pNotify:SendNotification", player,{text = {"Intet ID valgt"}, type = "warning", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
--            end
--        end)
--        else
--        TriggerClientEvent("pNotify:SendNotification", player,{text = {"Ingen spiller i nærheden"}, type = "warning", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
--      end
--    end)
--  end
--end,lang.police.menu.promille.description()}

-- search identity by registration
local choice_carsearch = {function(player, choice)
  vRP.prompt(player,lang.police.menu.searchcar.prompt(),"",function(player, reg)
    vRP.getUserByRegistration(reg, function(user_id)
      if user_id ~= nil then
        vRP.getUserIdentity(user_id, function(identity)
          if identity then
            -- display identity and business
            local name = identity.name
            local firstname = identity.firstname
            local age = identity.age.. " år"
            local phone = identity.phone
            local registration = identity.registration
            local bname = ""
            local bcapital = 0
            local home = ""
            local number = ""

            vRP.getUserBusiness(user_id, function(business)
              if business then
                bname = business.name
                bcapital = business.capital
              end

        vRP.getUserAddress(user_id, function(address)
          local home = ""
          local number = ""
          if address then
            home = address.home.. " nr. "
            number = address.number
          else 
			home = "Hjemløs"
			number = ""
          end

            local content = lang.police.identity.info({name,firstname,age,registration,phone,bname,bcapital,home,number})
            vRPclient.setDiv(player,{"police_identity",".div_police_identity{ background-color: rgba(0,0,0,0.75); color: white; font-family: Roboto; width: 500px; padding: 10px; margin: auto; margin-top: 150px; }",content})
            vRP.request(player, lang.police.menu.check.request_hide(), 1000, function(player,ok)
            vRPclient.removeDiv(player,{"police_identity"})
            end)
        end)
            end)
          else
     TriggerClientEvent("pNotify:SendNotification", player,{text = {lang.common.not_found()}, type = "error", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
          end
        end)
      else
     TriggerClientEvent("pNotify:SendNotification", player,{text = {lang.common.not_found()}, type = "error", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
      end
    end)
  end)
end, lang.police.menu.searchcar.description()}

local choice_store_weapons = {function(player, choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil then
    vRPclient.getWeapons(player,{},function(weapons)
      vRPclient.getAmmo(player,{},function(ammo)
        for k,v in pairs(weapons) do
            vRP.giveInventoryItem(user_id, k, 1, true)
        end
        for k,v in pairs(ammo) do
          if v.pistol > 0 then
            vRP.giveInventoryItem(user_id, "PISTOL_AMMO", v.pistol, true)
          end
          if v.shotgun > 0 then
            vRP.giveInventoryItem(user_id, "SHOTGUN_AMMO", v.shotgun, true)
          end
          if v.lmg > 0 then
            vRP.giveInventoryItem(user_id, "LMG_AMMO", v.lmg, true)
          end
          if v.rifle > 0 then
            vRP.giveInventoryItem(user_id, "RIFLE_AMMO", v.rifle, true)
          end
          if v.smg > 0 then
            vRP.giveInventoryItem(user_id, "SMG_AMMO", v.smg, true)
          end
          if v.sniper > 0 then 
            vRP.giveInventoryItem(user_id, "SNIPER_AMMO", v.sniper, true)
          end
        end

      -- clear all weapons
        vRPclient.giveWeapons(player,{{},true})
      end)
    end)
  end
end, lang.police.menu.store_weapons.description()}

local revive_seq = {
  {"amb@medic@standing@tendtodead@enter","enter",1},
  {"mini@cpr@char_a@cpr_str","cpr_pumpchest",1},
  {"amb@medic@standing@kneel@exit","exit",1}
}

local choice_revive = {function(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil then
    vRPclient.getNearestPlayer(player,{10},function(nplayer)
      local nuser_id = vRP.getUserId(nplayer)
      if nuser_id ~= nil then
        vRPclient.isInComa(nplayer,{}, function(in_coma)
          if in_coma then
            if vRP.tryGetInventoryItem(user_id,"medkit",1,true) then
              vRPclient.playAnim(player,{false,revive_seq,false}) -- anim
              SetTimeout(10000, function()
				
                vRPclient.varyHealth(nplayer,{50}) -- heal 50
				TriggerClientEvent("pNotify:SendNotification", nplayer,{text ="Du er blevet genoplivet af en Læge.", type = "success", queue = "global",timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
				TriggerClientEvent("pNotify:SendNotification", player,{text ="Personen blev genoplivet.", type = "success", queue = "global",timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
              end)
            end
          else
      TriggerClientEvent("pNotify:SendNotification", player,{text = {lang.emergency.menu.revive.not_in_coma()}, type = "error", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
          end
        end)
      else
    TriggerClientEvent("pNotify:SendNotification", player,{text = {lang.common.no_player_near()}, type = "error", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
      end
    end)
  end
end,lang.emergency.menu.revive.description()}

local heal_seq = {
  {"amb@prop_human_parking_meter@male@enter","enter",1},
  {"amb@prop_human_parking_meter@male@idle_a","idle_a",1},
  {"amb@prop_human_parking_meter@male@exit","exit",1}
}

local choice_heal = {function(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil then
    vRPclient.getNearestPlayer(player,{10},function(nplayer)
      local nuser_id = vRP.getUserId(nplayer)
      if nuser_id ~= nil then
        vRPclient.isInComa(nplayer,{}, function(in_coma)
          if not in_coma then
            if vRP.tryGetInventoryItem(user_id,"bandage",1,true) then
              vRPclient.playAnim(player,{false,heal_seq,false}) -- anim
              SetTimeout(7500, function()
				vRPclient.isInComa(nplayer,{}, function(in_coma2)
					if not in_coma2 then
						vRPclient.varyHealth(nplayer,{100}) -- heal 100
						TriggerClientEvent("pNotify:SendNotification", nplayer,{text ="Du er blevet helbredt af en Læge.", type = "success", queue = "global",timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
						TriggerClientEvent("pNotify:SendNotification", player,{text ="Personen blev helbredt.", type = "success", queue = "global",timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
					else
						TriggerClientEvent("pNotify:SendNotification", player,{text ="Personen døde under helbredelsen.", type = "success", queue = "global",timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
					end
				end)
              end)
            end
          else
			TriggerClientEvent("pNotify:SendNotification", player,{text = {lang.emergency.menu.heal.in_coma()}, type = "error", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
          end
        end)
      else
		TriggerClientEvent("pNotify:SendNotification", player,{text = {lang.common.no_player_near()}, type = "error", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
      end
    end)
  end
end,lang.emergency.menu.heal.description()}

local choice_udpump = {function(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil then
    vRPclient.getNearestPlayer(player,{10},function(nplayer)
      local nuser_id = vRP.getUserId(nplayer)
      if nuser_id ~= nil then
	    vRPclient.playAnim(player,{false,revive_seq,false})
		Citizen.Wait(9000)
		TriggerClientEvent('kaz_alkohol:ems', nplayer)
      else
		TriggerClientEvent("pNotify:SendNotification", player,{text = {lang.common.no_player_near()}, type = "error", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
      end
    end)
  end
end,"Udpump personen"}

local choice_alkotest = {function(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil then
    vRPclient.getNearestPlayer(player,{10},function(nplayer)
      local nuser_id = vRP.getUserId(nplayer)
      if nuser_id ~= nil then
		TriggerClientEvent("pNotify:SendNotification", player,{text = "Tester med alkometer", type = "error", queue = "global", timeout = 15000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
		TriggerClientEvent("pNotify:SendNotification", nplayer,{text = "Pust.....", type = "error", queue = "global", timeout = 15000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
		Citizen.Wait(15000)
		TriggerClientEvent('kaz_alkohol:alkotest', nplayer, player)
      else
		TriggerClientEvent("pNotify:SendNotification", player,{text = {lang.common.no_player_near()}, type = "error", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
      end
    end)
  end
end,"Alkotest personen"}

RegisterServerEvent('kaz_alkohol:alkotest2')
AddEventHandler('kaz_alkohol:alkotest2', function(player, drunklevel1)
drunklevel = drunklevel1
	if drunklevel ~= nil then
		TriggerClientEvent("pNotify:SendNotification", player,{text = "Alkometeret viser: "..drunklevel.." promille.", type = "error", queue = "global", timeout = 12000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
		TriggerClientEvent("pNotify:SendNotification", source,{text = "En betjent målte din promille.", type = "error", queue = "global", timeout = 12000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
	else
		TriggerClientEvent("pNotify:SendNotification", player,{text = "Ingen promille at vise.", type = "error", queue = "global", timeout = 12000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
	end
end)

-- add choices to the menu
vRP.registerMenuBuilder("main", function(add, data)
  local player = data.player

  local user_id = vRP.getUserId(player)
  if user_id ~= nil then
    local choices = {}

    if vRP.hasPermission(user_id,"police.menu") then
		choices[lang.police.title()] = {function(player,choice)
			vRP.buildMenu("police", {player = player}, function(menu)
				menu.name = lang.police.title()
				menu.css = {top="75px",header_color="rgba(2,0,49,0.75)"}

				if vRP.hasPermission(user_id,"emergency.revive") then
					menu[lang.emergency.menu.revive.title()] = choice_revive
				end
				if vRP.hasPermission(user_id,"police.check") then
					menu[lang.police.menu.check.title()] = choice_check
				end
				if vRP.hasPermission(user_id,"police.check") then
					menu[lang.police.menu.promille.title()] = choice_promille
				end
				if vRP.hasPermission(user_id,"police.seize.weapons") then
					menu[lang.police.menu.seize.weapons.title()] = choice_seize_weapons
				end
        if vRP.hasPermission(user_id,"police.drag") then
          menu[lang.police.menu.dragplayer.title()] = choice_dragplayer_ems
        end
				if vRP.hasPermission(user_id,"police.spikes") then
					menu[lang.police.menu.spikes.title()] = choice_spikes
				end
				if vRP.hasPermission(user_id,"police.spikes") then
					menu["Alkotest"] = choice_alkotest
				end
				if vRP.hasPermission(user_id,"police.seize.items") then
					menu[lang.police.menu.seize.items.title()] = choice_seize_items
				end
				if vRP.hasPermission(user_id,"police.license") then
					menu[lang.police.menu.license.title()] = choice_license
        end
				--if vRP.hasPermission(user_id,"police.carsearch") then
				--	menu[lang.police.menu.searchcar.title()] = choice_carsearch
			--	end
				vRP.openMenu(player,menu)
			end)
		end}
    end
	
	
	-- Funktioner menu
	if vRP.hasPermission(user_id,"user.askid") then
		choices[lang.funktioner.title()] = {function(player,choice)
			vRP.buildMenu("funktioner", {player = player}, function(menu)
				menu.name = lang.funktioner.title()
				menu.css = {top="75px",header_color="rgba(2,0,49,0.75)"}

				if vRP.hasPermission(user_id,"police.putinveh") then
					menu["Køretøj - Indsæt person"] = choice_putinveh
				end
				if vRP.hasPermission(user_id,"police.getoutveh") then
					menu["Køretøj - Fjern person"] = choice_getoutveh
				end
				if vRP.hasPermission(user_id,"police.drag") then
					menu["Løft person (Foran)"] = choice_dragplayer
				end
				if vRP.hasPermission(user_id,"police.drag") then
					menu["Løft person (Skulder)"] = choice_dragplayer2
				end
				--[[if vRP.hasPermission(user_id,"user.askid") then
					menu[lang.funktioner.menu.pose.title()] = choice_pose
        end]]
        --[[if vRP.hasPermission(user_id,"user.askid") then
					menu["Tag Radio/Telefon"] = choice_seize_radio
        end]]
        --[[if vRP.hasPermission(user_id,"user.askid") then
					menu["Tag Pose"] = choice_pose2
        end]]
				if vRP.hasPermission(user_id,"user.askid") then
					menu["Tag Gidsel"] = choice_hostage
				end
			--[[if vRP.hasPermission(user_id,"player.loot") then
					menu["Loot"] = choice_loot -- take the items of nearest player in coma
				end]]
				if vRP.hasPermission(user_id,"user.askid") then
					menu["Gå af Job"] = choice_leavejob 
        end
        if vRP.hasPermission(user_id, "user.askid") then
          menu["Gem Våben"] = choice_store_weapons
        end
				vRP.openMenu(player,menu)
			end)
		end}
    end
	
	    
    if vRP.hasPermission(user_id,"emergency.menu") then
		choices[lang.emergency.title()] = {function(player,choice)
			vRP.buildMenu("ems", {player = player}, function(menu)
				menu.name = lang.emergency.title()
				menu.css = {top="75px",header_color="rgba(1,92,83,0.75)"}
				  
				if vRP.hasPermission(user_id,"emergency.putinveh") then
					menu[lang.police.menu.putinveh.title()] = choice_putinveh_ems
				end
				if vRP.hasPermission(user_id,"emergency.getoutveh") then
					menu[lang.police.menu.getoutveh.title()] = choice_getoutveh_ems
				end
				if vRP.hasPermission(user_id,"emergency.drag") then
					menu[lang.police.menu.dragplayer.title()] = choice_dragplayer_ems
				end
				if vRP.hasPermission(user_id,"emergency.revive") then
					menu[lang.emergency.menu.revive.title()] = choice_revive
				end
				if vRP.hasPermission(user_id,"emergency.heal") then
					menu[lang.emergency.menu.heal.title()] = choice_heal
        end
        if vRP.hasPermission(user_id,"emergency.heal") then
					menu["Tillad Seng"] = choice_tilladseng
				end
				if vRP.hasPermission(user_id,"emergency.heal") then
					menu["Udpump"] = choice_udpump
				end
				vRP.openMenu(player,menu)
			end)
		end}
    end
	
--    if vRP.hasPermission(user_id,"police.askid") then
--      choices[lang.police.menu.askid.title()] = choice_askid
--    end
	
    if vRP.hasPermission(user_id, "user.askid") then
      choices[lang.police.menu.check.title()] = choice_user_check
    end

    add(choices)
  end
end)

local function build_client_points(source)
  -- PC
  for k,v in pairs(cfg.pcs) do
    local x,y,z = table.unpack(v)
    vRPclient.addMarker(source,{x,y,z-0.87,0.7,0.7,0.5,0,125,255,125,150})
    vRP.setArea(source,"vRP:police:pc"..k,x,y,z,1,1.5,pc_enter,pc_leave)
  end
end

-- build police points
AddEventHandler("vRP:playerSpawn",function(user_id, source, first_spawn)
	if first_spawn then
		build_client_points(source)
	end
end)

-- WANTED SYNC
local wantedlvl_players = {}

function vRP.getUserWantedLevel(user_id)
	return wantedlvl_players[user_id] or 0
end

-- receive wanted level
function tvRP.updateWantedLevel(level)
  local player = source
  local user_id = vRP.getUserId(player)
  if user_id ~= nil then
    local was_wanted = (vRP.getUserWantedLevel(user_id) > 0)
    wantedlvl_players[user_id] = level
    local is_wanted = (level > 0)

    -- send wanted to listening service
    if not was_wanted and is_wanted then
      vRPclient.getPosition(player, {}, function(x,y,z)
        vRP.sendServiceAlert(nil, cfg.wanted.service,x,y,z,lang.police.wanted({level}))
      end)
    end

    if was_wanted and not is_wanted then
      vRPclient.removeNamedBlip(-1, {"vRP:wanted:"..user_id}) -- remove wanted blip (all to prevent phantom blip)
    end
  end
end

-- delete wanted entry on leave
AddEventHandler("vRP:playerLeave", function(user_id, player)
  wantedlvl_players[user_id] = nil
  vRPclient.removeNamedBlip(-1, {"vRP:wanted:"..user_id})  -- remove wanted blip (all to prevent phantom blip)
end)

-- display wanted positions
local function task_wanted_positions()
  local listeners = vRP.getUsersByPermission("police.wanted")
  for k,v in pairs(wantedlvl_players) do -- each wanted player
    local player = vRP.getUserSource(tonumber(k))
    if player ~= nil and v ~= nil and v > 0 then
      vRPclient.getPosition(player, {}, function(x,y,z)
        for l,w in pairs(listeners) do -- each listening player
          local lplayer = vRP.getUserSource(w)
          if lplayer ~= nil then
            vRPclient.setNamedBlip(lplayer, {"vRP:wanted:"..k,x,y,z,cfg.wanted.blipid,cfg.wanted.blipcolor,lang.police.wanted({v})})
          end
        end
      end)
    end
  end

  SetTimeout(5000, task_wanted_positions)
end
task_wanted_positions()

-- Håndjern keybind
RegisterServerEvent('handcuff:checkjob')
AddEventHandler('handcuff:checkjob', function()
	local source = source
    local user_id = vRP.getUserId(source)
		TriggerClientEvent('cuff', source)
end)

RegisterServerEvent('handcuff:cuffHim')
AddEventHandler('handcuff:cuffHim', function()
	local source = source
	local user_id2 = vRP.getUserId(source)
	
	Citizen.Wait(1000)
	vRPclient.getNearestPlayer(source,{1.5},function(cplayer)
		if cplayer ~= nil then
			if vRP.hasPermission(user_id2,"police.handcuff") then
				vRPclient.isHandcuffed(cplayer,{}, function(handcuffed)
					if handcuffed then
						TriggerClientEvent('kaz_handjern:fjern', source)
						TriggerClientEvent("pNotify:SendNotification", source,{text = {"Personen fik løsnet sine håndjern."}, type = "info", queue = "global", timeout = 3000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
						vRPclient.toggleHandcuff(cplayer,{})
					else
						TriggerClientEvent('kaz_handjern:target', cplayer, source)
						TriggerClientEvent('kaz_handjern:player', source)
						TriggerClientEvent("pNotify:SendNotification", source,{text = {"Personen blev sat i håndjern."}, type = "info", queue = "global", timeout = 3000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},sounds = {sources = {"handcuff.ogg"},volume = 0.25,conditions = {"docVisible"}}, killer = true})
						TriggerClientEvent("pNotify:SendNotification", cplayer,{text = {"Du blev sat i håndjern."}, type = "info", queue = "global", timeout = 3000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},sounds = {sources = {"handcuff.ogg"},volume = 0.25,conditions = {"docVisible"}}, killer = true})
						Citizen.Wait(3000)
						vRPclient.toggleHandcuff(cplayer,{})
					end
				end)
			else
				vRPclient.isHandcuffed(cplayer,{}, function(handcuffed)
					if handcuffed then 
						vRPclient.toggleHandcuff(cplayer,{})
						TriggerClientEvent('kaz_handjern:fjern', source)
            TriggerClientEvent("pNotify:SendNotification", source,{text = {"Stripsne blev fjernet."}, type = "info", queue = "global", timeout = 3000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
					else
						if vRP.tryGetInventoryItem(user_id2,"strips",1,true) then
						TriggerClientEvent('kaz_handjern:target', cplayer, source)
						TriggerClientEvent('kaz_handjern:player', source)
            TriggerClientEvent("pNotify:SendNotification", source,{text = {"Personen blev sat i strips."}, type = "info", queue = "global", timeout = 3000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},sounds = {sources = {"handcuff.ogg"},volume = 0.25,conditions = {"docVisible"}}, killer = true})
						TriggerClientEvent("pNotify:SendNotification", cplayer,{text = {"Du blev sat i strips."}, type = "info", queue = "global", timeout = 3000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},sounds = {sources = {"handcuff.ogg"},volume = 0.25,conditions = {"docVisible"}}, killer = true})
						Citizen.Wait(3000)
						vRPclient.toggleHandcuff(cplayer,{})
						end
					end
				end)
			end
		end
	end)
end)