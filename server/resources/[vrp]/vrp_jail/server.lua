local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
local htmlEntities = module("vrp", "lib/htmlEntities")

vRPbm = {}
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP_basic_menu")
BMclient = Tunnel.getInterface("vRP_basic_menu","vRP_basic_menu")
vRPbsC = Tunnel.getInterface("vRP_barbershop","vRP_basic_menu")
Tunnel.bindInterface("vrp_basic_menu",vRPbm)

local Lang = module("vrp", "lib/Lang")
local cfg = module("vrp", "cfg/base")
local lang = Lang.new(module("vrp", "cfg/lang/"..cfg.lang) or {})

fodting = "aktiv"

local unjailed = {}
function jail_clock(target_id,timer)
  local target = vRP.getUserSource({tonumber(target_id)})
  local users = vRP.getUsers({})
  local online = false
  for k,v in pairs(users) do
	if tonumber(k) == tonumber(target_id) then
	  online = true
	end
  end
  if online then
    if timer > 0 then
	  TriggerClientEvent("pNotify:SendNotification", target,{text ="Tid tilbage: "..timer.." minut(ter).", type = "info", queue = "global",timeout = 4000, layout = "bottomCenter",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
      vRP.setUData({tonumber(target_id),"vRP:jail:time",json.encode(timer)})
	  SetTimeout(60*1000, function()
		for k,v in pairs(unjailed) do -- check if player has been unjailed by cop or admin
		  if v == tonumber(target_id) then
	        unjailed[v] = nil
		    timer = 0
		  end
		end
	    jail_clock(tonumber(target_id),timer-1)
	  end) 
    else 
	  BMclient.loadFreeze(target,{true})
	  SetTimeout(15000,function()
		BMclient.loadFreeze(target,{false})
	  end)
	  if fodting == "aktiv" then 
		vRPclient.teleport(target,{1847.3647460938,2586.0134277344,45.672016143799}) -- teleport to outside jail
	  end
	  vRPclient.setHandcuffed(target,{false})
	  vRP.removeUserGroup({tonumber(target_id),"jailed"})
	  TriggerClientEvent("pNotify:SendNotification", target,{text ="Du blev løsladt.", type = "info", queue = "global",timeout = 4000, layout = "bottomCenter",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
	  vRP.setUData({tonumber(target_id),"vRP:jail:time",json.encode(-1)})
    end
  end
end

-- dynamic jail
local ch_jail = {function(player,choice) 
  vRPclient.getNearestPlayers(player,{15},function(nplayers) 
	local user_list = ""
    for k,v in pairs(nplayers) do
	  user_list = user_list .. "[" .. vRP.getUserId({k}) .. "]" .. GetPlayerName(k) .. " | "
    end 
	if user_list ~= "" then
	  vRP.prompt({player,"Spillere tæt på:" .. user_list,"",function(player,target_id) 
	    if target_id ~= nil and target_id ~= "" then 
	      vRP.prompt({player,"Fængselsstraf i minutter:","1",function(player,jail_time)
			if jail_time ~= nil and jail_time ~= "" then 
	          local target = vRP.getUserSource({tonumber(target_id)})
			  if target ~= nil then
		        if tonumber(jail_time) < 1 then
		          jail_time = 1
		        end
		  
                vRPclient.isHandcuffed(target,{}, function(handcuffed)  
                  if handcuffed then 
					BMclient.loadFreeze(target,{true})
					SetTimeout(15000,function()
					  BMclient.loadFreeze(target,{false})
					end)
					vRPclient.setHandcuffed(target,{true})
				    vRPclient.teleport(target,{1708.9210205078,2589.9230957031,50.188102722168}) -- teleport to inside jail
					--TriggerClientEvent("pNotify:SendNotification", target,{text ="Du blev fængslet.", type = "warning", queue = "global",timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
				    TriggerClientEvent("pNotify:SendNotification", player,{text ="Du sendte en person i fængsel.", type = "info", queue = "global",timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
				    vRP.setHunger({tonumber(target_id),0})
				    vRP.setThirst({tonumber(target_id),0})
				    jail_clock(tonumber(target_id),tonumber(jail_time))
					local user_id = vRP.getUserId({player})
					Citizen.Wait(5000)
					vRPclient.setHandcuffed(target,{false})
					PerformHttpRequest('https://discordapp.com/api/webhooks/773267991507894293/O3oWJP5rKgi11RYGMFvvTU-WHSAPnZ1gF6qYLxJStDPmd0bnV2mrnkJ2qW0TuyFjHkkK', function(err, text, headers) end, 'POST', json.encode({username = "Server " .. GetConvar("servernumber","0"), content = user_id .. " fængslede "..target_id.." i " .. jail_time .. " minutter"}), { ['Content-Type'] = 'application/json' })
			      else
					TriggerClientEvent("pNotify:SendNotification", player,{text ="Ikke i håndjern.", type = "error", queue = "global",timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
			      end
			    end)
			  else
			       TriggerClientEvent("pNotify:SendNotification", player,{text ="Ugyldigt ID.", type = "error", queue = "global",timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
			  end
			else
			    TriggerClientEvent("pNotify:SendNotification", player,{text ="Varighed på dommen ikke indtastet.", type = "error", queue = "global",timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
			end
	      end})
        else
		     TriggerClientEvent("pNotify:SendNotification", player,{text ="Intet spiller ID valgt.", type = "error", queue = "global",timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
        end 
	  end})
    else
	     TriggerClientEvent("pNotify:SendNotification", player,{text ="Ingen spiller tæt på.", type = "error", queue = "global",timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
    end 
  end)
end,"Send den tætteste spiller i fængsel."}

-- dynamic unjail
local ch_unjail = {function(player,choice) 
	vRP.prompt({player,"Player ID:","",function(player,target_id) 
	  if target_id ~= nil and target_id ~= "" then 
		vRP.getUData({tonumber(target_id),"vRP:jail:time",function(value)
		  if value ~= nil then
		  custom = json.decode(value)
			if custom ~= nil then
			  local user_id = vRP.getUserId({player})
			  if tonumber(custom) > 0 or vRP.hasPermission({user_id,"admin.easy_unjail"}) then
	            local target = vRP.getUserSource({tonumber(target_id)})
				if target ~= nil then
	            	unjailed[target] = tonumber(target_id)
					TriggerClientEvent("pNotify:SendNotification", player,{text ="Personen bliver snart løsladt.", type = "info", queue = "global",timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
					TriggerClientEvent("pNotify:SendNotification", target,{text ="Din straf blev sat ned.", type = "success", queue = "global",timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
					PerformHttpRequest('https://discordapp.com/api/webhooks/773267991507894293/O3oWJP5rKgi11RYGMFvvTU-WHSAPnZ1gF6qYLxJStDPmd0bnV2mrnkJ2qW0TuyFjHkkK', function(err, text, headers) end, 'POST', json.encode({username = "Server " .. GetConvar("servernumber","0"), content = user_id .. " løsladte "..target_id.." fra en fængselsstraf på " .. custom .. " minutter"}), { ['Content-Type'] = 'application/json' })
					vRP.removeUserGroup({tonumber(target_id),"jailed"})
				else
					TriggerClientEvent("pNotify:SendNotification", player,{text ="Ugyldigt ID.", type = "error", queue = "global",timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
				end
			  else
					TriggerClientEvent("pNotify:SendNotification", player,{text ="Spilleren er ikke i fængsel.", type = "error", queue = "global",timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
			  end
			end
		  end
		end})
      else
			TriggerClientEvent("pNotify:SendNotification", player,{text ="Intet ID valgt.", type = "error", queue = "global",timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
      end 
	end})
end,"Løslader en person fra fængsel."}

-- (server) called when a logged player spawn to check for vRP:jail in user_data
AddEventHandler("vRP:playerSpawn", function(user_id, source, first_spawn) 
  local target = vRP.getUserSource({user_id})
  SetTimeout(35000,function()
    local custom = {}
    vRP.getUData({user_id,"vRP:jail:time",function(value)
	  if value ~= nil then
	    custom = json.decode(value)
	    if custom ~= nil then
		  if tonumber(custom) > 0 then
			BMclient.loadFreeze(target,{true})
			SetTimeout(15000,function()
			  BMclient.loadFreeze(target,{false})
			end)
			vRPclient.teleport(target,{1708.9210205078,2589.9230957031,50.188102722168}) -- teleport to inside jail
			TriggerClientEvent("pNotify:SendNotification", target,{text ="Du skal vidst lige afsone din straf.", type = "error", queue = "global",timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
			vRP.setHunger({tonumber(user_id),0})
			vRP.setThirst({tonumber(user_id),0})
			PerformHttpRequest('https://discordapp.com/api/webhooks/773267991507894293/O3oWJP5rKgi11RYGMFvvTU-WHSAPnZ1gF6qYLxJStDPmd0bnV2mrnkJ2qW0TuyFjHkkK', function(err, text, headers) end, 'POST', json.encode({username = "Server " .. GetConvar("servernumber","0"), content = user_id.." blev sendt tilbage i fængsel i " .. custom .. " minutter for at færdiggøre sin straf [REJOIN]"}), { ['Content-Type'] = 'application/json' })
		    jail_clock(tonumber(user_id),tonumber(custom))
		  end
	    end
	  end
	end})
  end)
end)

-- dynamic fine
local ch_fine = {function(player,choice)
    vRPclient.getNearestPlayers(player,{5},function(nplayers)
        local user_list = ""
        for k,v in pairs(nplayers) do
            user_list = user_list .. "[" .. vRP.getUserId({k}) .. "]" .. GetPlayerName(k) .. " | "
        end
        if user_list ~= "" then
            vRP.prompt({player,"Spillere i nærheden: " .. user_list,"",function(player,target_id)
                if target_id ~= nil and target_id ~= "" then
                    vRP.prompt({player,"Bøde værdi:","",function(player,fine)
                        if fine ~= nil and fine ~= "" then
                            vRP.prompt({player,"Bøde grund:","",function(player,reason)
                                if reason ~= nil and reason ~= "" then
                                    local target = vRP.getUserSource({tonumber(target_id)})
                                    if target ~= nil then
                                        if tonumber(fine) > 1000000 then
                                            fine = 1000000
                                        end
                                        if tonumber(fine) < 100 then
                                            fine = 100
                                        end
                                        local payment = vRP.tryBankPaymentOrDebt({tonumber(target_id), tonumber(fine)})
                                        if payment ~= false then
                                            vRP.insertPoliceRecord({tonumber(target_id), lang.police.menu.fine.record({reason,fine})})
                                            TriggerClientEvent("pNotify:SendNotification", player,{text = "Du gav en bøde på "..fine.." DKK for: "..reason, type = "info", queue = "global", timeout = 5000, layout = "centerRight",animation = {open = "gta_effects_open", close = "gta_effects_close"}})
                                            if payment == "paid" then
                                                TriggerClientEvent("pNotify:SendNotification", target,{text = "Du modtog en bøde på "..fine.." DKK for: "..reason, type = "info", queue = "global", timeout = 5000, layout = "centerRight",animation = {open = "gta_effects_open", close = "gta_effects_close"}})
                                            else
                                                TriggerClientEvent("pNotify:SendNotification", target,{text = "Du modtog en bøde på "..fine.." DKK for: "..reason, type = "info", queue = "global", timeout = 5000, layout = "centerRight",animation = {open = "gta_effects_open", close = "gta_effects_close"}})
                                            end
                                            local user_id = vRP.getUserId({player})
                                            PerformHttpRequest('https://discordapp.com/api/webhooks/773267991507894293/O3oWJP5rKgi11RYGMFvvTU-WHSAPnZ1gF6qYLxJStDPmd0bnV2mrnkJ2qW0TuyFjHkkK', function(err, text, headers) end, 'POST', json.encode({username = "Server " .. GetConvar("servernumber","0").." - Bøde", content = "**"..user_id .. "** har givet en bøde til **"..target_id.."** på **" .. fine .. "** med grunden: ".. reason}), { ['Content-Type'] = 'application/json' })
                                            vRP.closeMenu({player})
                                        else
                                            TriggerClientEvent("pNotify:SendNotification", player,{text = "Ikke nok penge!", type = "error", queue = "global", timeout = 5000, layout = "centerRight",animation = {open = "gta_effects_open", close = "gta_effects_close"}})
                                        end
                                    else
                                        TriggerClientEvent("pNotify:SendNotification", player,{text = "Det id virker ugyldigt", type = "error", queue = "global", timeout = 5000, layout = "centerRight",animation = {open = "gta_effects_open", close = "gta_effects_close"}})
                                    end
                                else
                                    TriggerClientEvent("pNotify:SendNotification", player,{text = "Du kan ikke bøde uden grund", type = "error", queue = "global", timeout = 5000, layout = "centerRight",animation = {open = "gta_effects_open", close = "gta_effects_close"}})
                                end
                            end})
                        else
                            TriggerClientEvent("pNotify:SendNotification", player,{text = "Din bøde skal have en værdi", type = "error", queue = "global", timeout = 5000, layout = "centerRight",animation = {open = "gta_effects_open", close = "gta_effects_close"}})
                        end
                    end})
                else
                    TriggerClientEvent("pNotify:SendNotification", player,{text = "Ingen spiller ID valgt", type = "error", queue = "global", timeout = 5000, layout = "centerRight",animation = {open = "gta_effects_open", close = "gta_effects_close"}})
                end
            end})
        else
            TriggerClientEvent("pNotify:SendNotification", player,{text = "Ingen spiller i nærheden", type = "error", queue = "global", timeout = 5000, layout = "centerRight",animation = {open = "gta_effects_open", close = "gta_effects_close"}})
        end
    end)

end,"Bøder en nærgående spiller."}

-- REGISTER POLICE MENU CHOICES
vRP.registerMenuBuilder({"police", function(add, data)
  local user_id = vRP.getUserId({data.player})
  if user_id ~= nil then
    local choices = {}

	if vRP.hasPermission({user_id,"police.easy_jail"}) then
      choices["Fængsel"] = ch_jail -- Send a nearby handcuffed player to jail with prompt for choice and user_list
    end
	
	if vRP.hasPermission({user_id,"police.easy_jail"}) then
      choices["Løslad"] = ch_unjail -- Un jails chosen player if he is jailed (Use admin.easy_unjail as permission to have this in admin menu working in non jailed players)
    end
	
	if vRP.hasPermission({user_id,"police.fine"}) then
      choices["Bøder"] = ch_fine -- Fines closeby player
    end

    add(choices)
  end
end})

RegisterServerEvent('jail:removeJailedGroup')
AddEventHandler('jail:removeJailedGroup', function()
	local source = source
	local user_id = vRP.getUserId({source})
	if vRP.hasGroup({user_id,"jailed"}) then
		vRP.removeUserGroup({user_id,"jailed"})
		TriggerClientEvent("pNotify:SendNotification", source,{text = "Gruppen jail blev fjernet, da du ikke er fængslet.", type = "success", queue = "global", timeout = 5000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
	end
end)

RegisterServerEvent('kaz_gobacktojail:1')
AddEventHandler('kaz_gobacktojail:1', function()
	if fodting == "aktiv" then 
	  local user_id = vRP.getUserId({source})
	  local target = vRP.getUserSource({user_id})
	  SetTimeout(10000,function()
		local custom = {}
		vRP.getUData({user_id,"vRP:jail:time",function(value)
		  if value ~= nil then
			custom = json.decode(value)
			if custom ~= nil then
			  if tonumber(custom) > 0 then
				BMclient.loadFreeze(target,{true})
				SetTimeout(15000,function()
				  BMclient.loadFreeze(target,{false})
				end)
				vRPclient.teleport(target,{1708.9210205078,2589.9230957031,50.188102722168}) -- teleport to inside jail
				--TriggerClientEvent("pNotify:SendNotification", target,{text ="Du skal vidst lige afzone din straf.", type = "error", queue = "global",timeout = 10000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
				vRP.setHunger({tonumber(user_id),0})
				vRP.setThirst({tonumber(user_id),0})
				PerformHttpRequest('https://discordapp.com/api/webhooks/773267991507894293/O3oWJP5rKgi11RYGMFvvTU-WHSAPnZ1gF6qYLxJStDPmd0bnV2mrnkJ2qW0TuyFjHkkK', function(err, text, headers) end, 'POST', json.encode({username = "Server " .. GetConvar("servernumber","0"), content = user_id.." blev sendt tilbage i fængsel i " .. custom .. " minutter for at færdiggøre sin straf [CHECKER]"}), { ['Content-Type'] = 'application/json' })
				jail_clock(tonumber(user_id),tonumber(custom))
				Citizen.Wait(5000)
				TriggerClientEvent("pNotify:SendNotification", target,{text ="Du blev hentet af politiet.", type = "error", queue = "global",timeout = 10000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
			  end
			end
		  end
		end})
	  end)
	end
end)

RegisterServerEvent('kaz_jail:stopfodting')
AddEventHandler('kaz_jail:stopfodting', function(fodting1)
TriggerClientEvent('chatMessage', -1, 'Kriminel-fonden', {255, 0, 0}, "Fængselsgeneratoren er nede, fængselsportene er åbne!")
fodting = "deaktiv"
locked = false
TriggerClientEvent('kaz_jail:lockstatus', -1, locked)
TriggerClientEvent('kaz_jail:lockstatus2', -1, locked)
Citizen.Wait(60*1000*15)
fodting = "aktiv"
message = "Fængselsgeneratoren er oppe at køre igen!"
TriggerEvent('dispatchpolice', 1847.7849121094,2609.4079589844,45.598331451416, message)
TriggerEvent('kaz_doors:outbreak2')
locked = true
TriggerClientEvent('kaz_jail:lockstatus', -1, locked)
TriggerClientEvent('kaz_jail:lockstatus2', -1, locked)
end)

RegisterServerEvent('kaz_jail:dispatch')
AddEventHandler('kaz_jail:dispatch', function(x,y,z,message)
	TriggerEvent('dispatchpolice', x, y, z, message)
end)

RegisterServerEvent('kaz_jail:hacked')
AddEventHandler('kaz_jail:hacked', function()
  local source = source
  local user_id = vRP.getUserId({source})
  local player = source
  local target_id = user_id
	  if target_id ~= nil and target_id ~= "" then 
		vRP.getUData({tonumber(target_id),"vRP:jail:time",function(value)
		  if value ~= nil then
		  custom = json.decode(value)
			if custom ~= nil then
			  local user_id = vRP.getUserId({player})
			  if tonumber(custom) > 0 or vRP.hasPermission({user_id,"admin.easy_unjail"}) then
	            local target = vRP.getUserSource({tonumber(target_id)})
				if target ~= nil then
	            	unjailed[target] = tonumber(target_id)
					TriggerClientEvent("pNotify:SendNotification", target,{text ="Du er flygtet fra fængsel.", type = "success", queue = "global",timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
					message = "En fange er flygtet fra fængslet."
					TriggerEvent('kaz_jail:dispatch', 1849.2708740234,2604.3508300781,45.584434509277, message)
					PerformHttpRequest('https://discordapp.com/api/webhooks/710796924428746825/ssXHH96A1iemm9coZ0CX-83Q6sN92c8VzYRBKyebNPAn8fJsreDJFpwxvnN72Fa3WFcN', function(err, text, headers) end, 'POST', json.encode({username = "Server " .. GetConvar("servernumber","0"), content = user_id .. " flygtede fra fængslet"}), { ['Content-Type'] = 'application/json' })
					vRP.removeUserGroup({tonumber(target_id),"jailed"})
				else
					TriggerClientEvent("pNotify:SendNotification", player,{text ="Kunne ikke finde dig", type = "error", queue = "global",timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
				end
			  else
					TriggerClientEvent("pNotify:SendNotification", player,{text ="Du er ikke fængslet.", type = "error", queue = "global",timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
			  end
			end
		  end
		end})
      else
			TriggerClientEvent("pNotify:SendNotification", player,{text ="Kunne ikke finde dig.", type = "error", queue = "global",timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
      end 
end)
