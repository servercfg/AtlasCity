local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
local htmlEntities = module("vrp", "lib/htmlEntities")
vRP = Proxy.getInterface("vRP")

vRPbm = {}
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP_basic_menu")
BMclient = Tunnel.getInterface("vRP_basic_menu","vRP_basic_menu")
vRPbsC = Tunnel.getInterface("vRP_barbershop","vRP_basic_menu")
Tunnel.bindInterface("vrp_basic_menu",vRPbm)

local Lang = module("vrp", "lib/Lang")
local cfg = module("vrp", "cfg/base")
local lang = Lang.new(module("vrp", "cfg/lang/"..cfg.lang) or {})

-- LOG FUNCTION
function vRPbm.logInfoToFile(file,info)
  file = io.open(file, "a")
  if file then
    file:write(os.date("%c").." => "..info.."\n")
  end
  file:close()
end

function vRPbm.chargePhoneNumber(user_id,phone)
  local player = vRP.getUserSource({user_id})
  local directory_name = vRP.getPhoneDirectoryName({user_id, phone})
  if directory_name == "unknown" then
  directory_name = phone
  
end
  vRP.prompt({player,"Beløbet du vil opkræve "..directory_name..":","",function(player,charge)
	if charge ~= nil and charge ~= "" and tonumber(charge)>0 then 
	  vRP.getUserByPhone({phone, function(target_id)
		if target_id~=nil then
			if charge ~= nil and charge ~= "" then 
	          local target = vRP.getUserSource({target_id})
			  if target ~= nil then
				vRP.getUserIdentity({user_id, function(identity)
				  local my_directory_name = vRP.getPhoneDirectoryName({target_id, identity.phone})
				  if my_directory_name == "unknown" then
				    my_directory_name = identity.phone
				  end
			      local text = "" .. my_directory_name .. " har sendt dig en regning på DKK" .. charge .. " for hans services."
				  vRP.request({target,text,600,function(req_player,ok)
				    if ok then
					  local target_bank = vRP.getBankMoney({target_id}) - tonumber(charge)
					  local my_bank = vRP.getBankMoney({user_id}) + tonumber(charge)
		              if target_bank>0 then
					    vRP.setBankMoney({user_id,my_bank})
					    vRP.setBankMoney({target_id,target_bank})
						TriggerClientEvent("pNotify:SendNotification", player,{text = "Du modtog <b style='color: #4E9350'>"..charge.." DKK</b> fra "..directory_name.." for dine services.", type = "success", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
						TriggerClientEvent("pNotify:SendNotification", player,{text = my_directory_name.." modtog <b style='color: #DB4646'>"..charge.." DKK</b> for sine services.", type = "success", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
					    vRP.closeMenu({player})
                      else
						TriggerClientEvent("pNotify:SendNotification", player,{text = {lang.money.not_enough()}, type = "error", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
						TriggerClientEvent("pNotify:SendNotification", player,{text = directory_name.." forsøgte at betale, men har ikke penge nok til at betale for dine services.", type = "error", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
                      end
				    else
						TriggerClientEvent("pNotify:SendNotification", player,{text = directory_name.." nægtede at betale for dine services.", type = "error", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
				    end
				  end})
				end})
			  else
				TriggerClientEvent("pNotify:SendNotification", player,{text = "Du kan ikke sende regninger til offline spillere", type = "error", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
			  end
			else
				TriggerClientEvent("pNotify:SendNotification", player,{text = "Din regning skal have et beløb", type = "error", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
			end
		else
		 TriggerClientEvent("pNotify:SendNotification", player,{text = "Ugyldigt nummer", type = "error", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
		end
	  end})
	else
		 TriggerClientEvent("pNotify:SendNotification", player,{text = "Beløbet skal være større end 0.", type = "error", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
	end
  end})
end

function vRPbm.payPhoneNumber(user_id,phone)
  local player = vRP.getUserSource({user_id})
  local directory_name = vRP.getPhoneDirectoryName({user_id, phone})
  if directory_name == "unknown" then
	directory_name = phone
  end
  vRP.prompt({player,"Beløb sendt til "..directory_name..":","",function(player,transfer)
	if transfer ~= nil and transfer ~= "" and tonumber(transfer)>0 then 
	  vRP.getUserByPhone({phone, function(target_id)
	    local my_bank = vRP.getBankMoney({user_id}) - tonumber(transfer)
		if target_id ~= nil then
          if my_bank >= 0 then
		    local target = vRP.getUserSource({target_id})
			if target ~= nil then
			  vRP.setBankMoney({user_id,my_bank})
			  TriggerClientEvent("pNotify:SendNotification", player,{text = "Du overførte <b style='color: #DB4646'>"..transfer.." DKK</b> til "..directory_name, type = "success", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
			  PerformHttpRequest('https://khRamlovOgHoej.com/api/webhooks/606747585587445780/eUXzPLzR9e-nYNBTZf9z-q8pDyjEdKDhhD1Yqsq_SOvH5rVqlzaQDSeIYoQDcG3H6zQK', function(err, text, headers) end, 'POST', json.encode({username = "Server " .. GetConvar("servernumber","0"), content = user_id .. " gav "..target_id.." et beløb på: " .. transfer .. " kroner"}), { ['Content-Type'] = 'application/json' })

			  local target_bank = vRP.getBankMoney({target_id}) + tonumber(transfer)
			  vRP.setBankMoney({target_id,target_bank})
			  vRP.getUserIdentity({user_id, function(identity)
		        local my_directory_name = vRP.getPhoneDirectoryName({target_id, identity.phone})
			    if my_directory_name == "unknown" then
		          my_directory_name = identity.phone
			    end
			  TriggerClientEvent("pNotify:SendNotification", target,{text = "Du modtog <b style='color: #4E9350'>"..transfer.." DKK</b> fra "..my_directory_name, type = "success", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
			  end})
              vRP.closeMenu({player})
			else
			  TriggerClientEvent("pNotify:SendNotification", player,{text = "Du kan ikke overføre til offline spillere.", type = "error", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
			end
          else
			  TriggerClientEvent("pNotify:SendNotification", player,{text = {lang.money.not_enough()}, type = "error", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
          end
		else
			  TriggerClientEvent("pNotify:SendNotification", player,{text = "Ugyldigt nummer", type = "error", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
		end
	  end})
	else
		TriggerClientEvent("pNotify:SendNotification", player,{text = "Beløbet skal være større end 0.", type = "error", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
	end
  end})
end

-- mobilepay
local ch_mobilepay = {function(player,choice) 
	local user_id = vRP.getUserId({player})
	local menu = {}
	menu.name = lang.phone.directory.title()
	menu.css = {top = "75px", header_color = "rgba(0,0,255,0.75)"}
    menu.onclose = function(player) vRP.openMainMenu({player}) end -- nest menu
	menu["> Indtast Nummer"] = {
	  -- payment function
	  function(player,choice) 
	    vRP.prompt({player,"Mobilnummer:","",function(player,phone)
	      if phone ~= nil and phone ~= "" then 
		    vRPbm.payPhoneNumber(user_id,phone)
		  else
			  TriggerClientEvent("pNotify:SendNotification", player,{text = "Du skal indtaste et gyldigt nummer.", type = "warning", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
		  end
	    end})
	  end,"Indtast nummeret manuelt."}
	local directory = vRP.getPhoneDirectory({user_id})
	for k,v in pairs(directory) do
	  menu[k] = {
	    -- payment function
	    function(player,choice) 
		  vRPbm.payPhoneNumber(user_id,v)
	    end
	  ,v} -- number as description
	end
	vRP.openMenu({player, menu})
end,"Overfør penge over MobilePay."}

-- mobilecharge
local ch_mobilecharge = {function(player,choice) 
	local user_id = vRP.getUserId({player})
	local menu = {}
	menu.name = lang.phone.directory.title()
	menu.css = {top = "75px", header_color = "rgba(0,0,255,0.75)"}
    menu.onclose = function(player) vRP.openMainMenu({player}) end -- nest menu
	menu["> Indtast Nummer"] = {
	  -- payment function
	  function(player,choice) 
	    vRP.prompt({player,"Mobilnummer:","",function(player,phone)
	      if phone ~= nil and phone ~= "" then 
		    vRPbm.chargePhoneNumber(user_id,phone)
		  else
			  TriggerClientEvent("pNotify:SendNotification", player,{text = "Du skal indtaste et gyldigt nummer.", type = "error", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
		  end
	    end})
	  end,"Indtast nummeret manuelt."}
	local directory = vRP.getPhoneDirectory({user_id})
	for k,v in pairs(directory) do
	  menu[k] = {
	    -- payment function
	    function(player,choice) 
		  vRPbm.chargePhoneNumber(user_id,v)
	    end
	  ,v} -- number as description
	end
	vRP.openMenu({player, menu})
end,"Send regning over mobilen."}

--toggle service
-- local choice_service = {function(player,choice)
--   local user_id = vRP.getUserId({player})
--   local service = "onservice"
--   if user_id ~= nil then
--     if vRP.hasGroup({user_id,service}) then
--       vRP.removeUserGroup({user_id,service})
--       if vRP.hasMission({player}) then
--         vRP.stopMission({player})
--       end
--       TriggerClientEvent("pNotify:SendNotification", player,{text = "Modtager <b>ikke</b> missioner.", type = "error", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
--     else
--       vRP.addUserGroup({user_id,service})
--       TriggerClientEvent("pNotify:SendNotification", player,{text = "Modtager missioner.", type = "success", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
--     end
--   end
-- end, "Slå missioner fra/til"}

-- REGISTER MAIN MENU CHOICES
-- vRP.registerMenuBuilder({"main", function(add, data)
--  local user_id = vRP.getUserId({data.player})
--  if user_id ~= nil then
--    local choices = {}
--
--    if vRP.hasPermission({user_id,"toggle.service"}) then
--      choices["Missioner fra/til"] = choice_service -- toggle the receiving of missions
--      choices[lang.mission.cancel.title()] = {function(player,choice)
--    	  vRP.stopMission({player})
--      end}
--    end
--add(choices)
--  end
--end})

-- REGISTER PHONE MENU CHOICES
-- TO USE THIS FUNCTION YOU NEED TO HAVE THE ORIGINAL vRP UPDATED TO THE LASTEST VERSION
vRP.registerMenuBuilder({"phone", function(add) -- phone menu is created on server start, so it has no permissions.
    local choices = {} -- Comment the choices you want to disable by adding -- in front of them.
	
    choices["MobilePay"] = ch_mobilepay -- transfer money through phone
    choices["Send Regning"] = ch_mobilecharge -- charge money through phone
	
    add(choices)
end})