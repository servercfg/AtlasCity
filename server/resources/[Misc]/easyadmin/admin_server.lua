local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "olsen_easyadmin")

------------------------------------
------------------------------------
---- DONT TOUCH ANY OF THIS IF YOU DON'T KNOW WHAT YOU ARE DOING
---- THESE ARE **NOT** CONFIG VALUES, USE THE CONVARS IF YOU WANT TO CHANGE SOMETHING
------------------------------------
------------------------------------
-- THIS IS OBSOLETE NOW, PLEASE USE THE WIKI TO ADD ADMINS
admins = {}
-- THIS IS OBSOLETE NOW, PLEASE USE THE WIKI TO ADD ADMINS
-- Muted Players Table
MutedPlayers = {} 
-- cached players, for offline banning
CachedPlayers = {}
OnlineAdmins = {}
ChatReminders = {}


Citizen.CreateThread(function()
	while true do 
		Wait(20000)
		for i, player in pairs(CachedPlayers) do 
			if player.droppedTime and (os.time() > player.droppedTime+600) then
				CachedPlayers[i]=nil
			end
		end
	end
end)


-- Chat Reminder Code
function sendRandomReminder()
	reminderTime = GetConvarInt("ea_chatReminderTime", 0)
	if reminderTime ~= 0 and #ChatReminders > 0 then
		local reminder = ChatReminders[ math.random( #ChatReminders ) ] -- select random reminder from table
		local adminNames = ""
		local t = {}
		for i,_ in pairs(OnlineAdmins) do
			table.insert(t, getName(i))
		end
		for i,n in ipairs(t) do 
			if i == 1 then
				adminNames = n
			elseif i == #t then
				adminNames = adminNames.." "..n
			else
				adminNames = adminNames.." "..n..","
			end
		end
		t=nil

		if adminNames == "" then adminNames = "@admins" end -- if no admins are online just print @admins
		reminder = string.gsub(reminder, "@admins", adminNames)

		reminder = string.gsub(reminder, "@bancount", #blacklist)

		reminder = string.gsub(reminder, "@time", os.date("%X", os.time()))
		reminder = string.gsub(reminder, "@date", os.date("%x", os.time()))
		TriggerClientEvent("chat:addMessage", -1, { args = { "EasyAdmin", reminder } })
	end
end

Citizen.CreateThread(function()
	--Wait(10000)
	reminderTime = GetConvarInt("ea_chatReminderTime", 0)
	if reminderTime ~= 0 then
		while true do 
			Wait(reminderTime*60000)
			sendRandomReminder()
		end
	else
		while true do
			Wait(20000)
			sendRandomReminder() -- check for changes in the convar
		end
	end
end)

AddEventHandler('playerDropped', function (reason)
	if CachedPlayers[source] then
		CachedPlayers[source].droppedTime = os.time()
	end
	if OnlineAdmins[source] then
		OnlineAdmins[source] = nil
	end
end)

AddEventHandler("EasyAdmin:amiadmin", function()
	if not CachedPlayers[source] then
		CachedPlayers[source] = {id = source, name = GetPlayerName(source), identifiers = GetPlayerIdentifiers(source), immune = DoesPlayerHavePermission(source,"easyadmin.immune")}
	end
end)

RegisterServerEvent("EasyAdmin:GetPlayerList")
AddEventHandler("EasyAdmin:GetPlayerList", function()
	if IsPlayerAdmin(source) then
		local l = {}
		local players = GetPlayers()
		for i, player in pairs(players) do
			if CachedPlayers[player] then
				table.insert(l, CachedPlayers[player])
			end
		end
		TriggerClientEvent("EasyAdmin:GetPlayerList", source, l) 
	end
end)


RegisterServerEvent("EasyAdmin:GetInfinityPlayerList")
AddEventHandler("EasyAdmin:GetInfinityPlayerList", function()
	if IsPlayerAdmin(source) then
		local l = {}
		local players = GetPlayers()

		for i, player in pairs(players) do
			local player = tonumber(player)
			for i, cached in pairs(CachedPlayers) do
				if (cached.id == player) then
					table.insert(l, CachedPlayers[i])
				end
			end
		end
		TriggerClientEvent("EasyAdmin:GetInfinityPlayerList", source, l) 
	end
end)


RegisterServerEvent("EasyAdmin:requestCachedPlayers")
AddEventHandler('EasyAdmin:requestCachedPlayers', function(playerId)
	local src = source
	if DoesPlayerHavePermission(source,"easyadmin.ban") then
		TriggerClientEvent("EasyAdmin:fillCachedPlayers", src, CachedPlayers)
		PrintDebugMessage("Cached Players requested by "..getName(src,true))
	end
end)

function GetOnlineAdmins()
	return OnlineAdmins
end

function IsPlayerAdmin(pid)
	return OnlineAdmins[pid]
end


function DoesPlayerHavePermission(player, object)
	local haspermission = false
	if (player == 0 or player == "") then
		return true
	end-- Console. It's assumed this will be an admin with access. If not, why the fuck are they giving random people access?
	
	if IsPlayerAceAllowed(player,object) then -- check if the player has access to this permission
		haspermission = true
	else
		haspermission = false
	end
	
	if not haspermission then -- if not, check if they are admin using the legacy method.
		local numIds = GetPlayerIdentifiers(player)
		for i,admin in pairs(admins) do
			for i,theId in pairs(numIds) do
				if admin == theId then
					haspermission = true
				end
			end
		end
	end
	return haspermission
end

AnonymousAdmins = {}
Citizen.CreateThread(function()
	local strfile = LoadResourceFile(GetCurrentResourceName(), "language/"..GetConvar("ea_LanguageName", "en")..".json")
	if strfile then
		strings = json.decode(strfile)[1]
	else
		strings = {language=GetConvar("ea_LanguageName", "en")}
	end
	
	
	moderationNotification = GetConvar("ea_moderationNotification", "false")
	if GetConvar("ea_enableDebugging", "false") == "true" then
		enableDebugging = true
		PrintDebugMessage("^1Debug Messages Enabled, Anonymous Admins may not be anonymous!")
	else
		enableDebugging = false
	end
	minimumMatchingIdentifiers = GetConvarInt("ea_minIdentifierMatches", 2)
	
	RegisterServerEvent('EasyAdmin:amiadmin')
	AddEventHandler('EasyAdmin:amiadmin', function()
		
		local identifiers = GetPlayerIdentifiers(source)
		for perm,val in pairs(permissions) do
			local thisPerm = DoesPlayerHavePermission(source,"easyadmin."..perm)
			if perm == "screenshot" and not screenshots then
				thisPerm = false
			end
			--if (perm == "teleport" or perm == "spectate") and infinity then
			--if (perm == "spectate") and infinity then
			--	thisPerm = false
			--end 
			if thisPerm == true then
				OnlineAdmins[source] = true 
			end
			TriggerClientEvent("EasyAdmin:adminresponse", source, perm,thisPerm)
			PrintDebugMessage("Processed Perm "..perm.." for "..getName(source)..", result: "..tostring(thisPerm))
		end

		
		-- give player the right settings to work with
		TriggerClientEvent("EasyAdmin:SetSetting", source, "button",GetConvarInt("ea_MenuButton", 289) )
		if GetConvar("ea_alwaysShowButtons", "false") == "true" then
			TriggerClientEvent("EasyAdmin:SetSetting", source, "forceShowGUIButtons", true)
		else
			TriggerClientEvent("EasyAdmin:SetSetting", source, "forceShowGUIButtons", false)
		end
		
		TriggerClientEvent("EasyAdmin:SetLanguage", source, strings)
		
	end)
	
	RegisterServerEvent("EasyAdmin:requestSpectate")
	AddEventHandler('EasyAdmin:requestSpectate', function(playerId)
		if DoesPlayerHavePermission(source,"easyadmin.spectate") then
			PrintDebugMessage("Player "..getName(source,true).." Requested Spectate to "..getName(playerId,true))
			SendWebhookMessage(moderationNotification,string.format(GetLocalisedText('spectatedplayer'), getName(source), getName(playerId)))
			local tgtCoords = GetEntityCoords(GetPlayerPed(playerId))
			local source = source
            local user_id = vRP.getUserId({source})
			TriggerClientEvent("EasyAdmin:requestSpectate", source, playerId, tgtCoords)
			PerformHttpRequest('https://discordapp.com/api/webhooks/773265925712379904/45cXjfPGTHmnFgrEhpLCZpFMXaNZn-2SAzpw9YeT6grmP8qZaj2VmuheT1u8_JjW8Ndu', function(err, text, headers) end, 'POST', json.encode({username = "Staff Logs", content = "**ID: "..user_id.." ** spectatede til en"}), { ['Content-Type'] = 'application/json' })
		end
	end)
	
	RegisterServerEvent("EasyAdmin:TeleportPlayerToCoords")
	AddEventHandler('EasyAdmin:TeleportPlayerToCoords', function(playerId,px,py,pz)
		if DoesPlayerHavePermission(source,"easyadmin.teleport.player") then
			PrintDebugMessage("Player "..getName(source,true).." requsted teleport to "..px..", "..py..", "..pz)
			local source = source
            local user_id = vRP.getUserId({source})
			TriggerClientEvent("EasyAdmin:TeleportRequest", playerId, px,py,pz)
			PerformHttpRequest('https://discordapp.com/api/webhooks/773265925712379904/45cXjfPGTHmnFgrEhpLCZpFMXaNZn-2SAzpw9YeT6grmP8qZaj2VmuheT1u8_JjW8Ndu', function(err, text, headers) end, 'POST', json.encode({username = "Staff Logs", content = "**ID: "..user_id.." ** teleportede en til sig selv"}), { ['Content-Type'] = 'application/json' })
		end
	end)

	RegisterServerEvent("EasyAdmin:TeleportAdminToPlayer")
	AddEventHandler("EasyAdmin:TeleportAdminToPlayer", function(id)
		if GetPlayerName(id) and DoesPlayerHavePermission(source, "easyadmin.teleport") then
			local source = source
			local user_id = vRP.getUserId({source})
			local tgtPlayer = id
			local tgtPed = GetPlayerPed(tgtPlayer)
			local tgtCoords = GetEntityCoords(tgtPed)
			SendWebhookMessage(moderationNotification,string.format(GetLocalisedText("teleportedtoplayer"), getName(source), getName(id)))
			TriggerClientEvent('EasyAdmin:TeleportRequest', source, tgtCoords.x, tgtCoords.y, tgtCoords.z)
			PerformHttpRequest('https://discordapp.com/api/webhooks/773265925712379904/45cXjfPGTHmnFgrEhpLCZpFMXaNZn-2SAzpw9YeT6grmP8qZaj2VmuheT1u8_JjW8Ndu', function(err, text, headers) end, 'POST', json.encode({username = "Staff Logs", content = "**ID: "..user_id.." ** teleporterede til en"}), { ['Content-Type'] = 'application/json' })
		else
			print('EASYADMIN FAILED TO TELEPORT'..source..' TO ID: '..id)
		end
	end)
	
	RegisterServerEvent("EasyAdmin:SlapPlayer")
	AddEventHandler('EasyAdmin:SlapPlayer', function(playerId,slapAmount)
		if DoesPlayerHavePermission(source,"easyadmin.slap") then
			PrintDebugMessage("Player "..getName(source,true).." slapped "..getName(playerId,true).." for "..slapAmount.." HP")
			SendWebhookMessage(moderationNotification,string.format(GetLocalisedText("adminslappedplayer"), getName(source), getName(playerId), slapAmount))
			TriggerClientEvent("EasyAdmin:SlapPlayer", playerId, slapAmount)
		end
	end)
	
	RegisterServerEvent("EasyAdmin:FreezePlayer")
	AddEventHandler('EasyAdmin:FreezePlayer', function(playerId,toggle)
		if DoesPlayerHavePermission(source,"easyadmin.freeze") then
			if toggle then
				SendWebhookMessage(moderationNotification,string.format(GetLocalisedText("adminfrozeplayer"), getName(source), getName(playerId)))
				PrintDebugMessage("Player "..getName(source,true).." froze "..getName(playerId,true))
			else
				SendWebhookMessage(moderationNotification,string.format(GetLocalisedText("adminunfrozeplayer"), getName(source), getName(playerId)))
				PrintDebugMessage("Player "..getName(source,true).." unfroze "..getName(playerId,true))
			end
			TriggerClientEvent("EasyAdmin:FreezePlayer", playerId, toggle)
		end
	end)
	
	RegisterServerEvent("EasyAdmin:TookScreenshot")
	
	RegisterServerEvent("EasyAdmin:TakeScreenshot")
	AddEventHandler('EasyAdmin:TakeScreenshot', function(playerId)
		if scrinprogress then
			TriggerClientEvent("chat:addMessage", source, { args = { "EasyAdmin", GetLocalisedText("screenshotinprogress") } })
			return
		end
		scrinprogress = true
		local src=source
		local playerId = playerId

		if DoesPlayerHavePermission(source,"easyadmin.screenshot") then
			thistemporaryevent = AddEventHandler("EasyAdmin:TookScreenshot", function(result)
				res = tostring(result)
				if (moderationNotification == GetConvar("ea_screenshoturl", 'https://wew.wtf/upload.php')) then
					res = ""
				end
				SendWebhookMessage(moderationNotification, string.format(GetLocalisedText("admintookscreenshot"), getName(src), getName(playerId), res))
				TriggerClientEvent('chat:addMessage', src, { template = '<img src="{0}" style="max-width: 400px;" />', args = { res } })
				TriggerClientEvent("chat:addMessage", src, { args = { "EasyAdmin", string.format(GetLocalisedText("screenshotlink"), res) } })
				PrintDebugMessage("Screenshot for Player "..getName(playerId,true).." done, "..res.." requsted by"..getName(src,true))
				scrinprogress = false
				RemoveEventHandler(thistemporaryevent)
			end)
			
			TriggerClientEvent("EasyAdmin:CaptureScreenshot", playerId)
			local timeoutwait = 0
			repeat
				timeoutwait=timeoutwait+1
				Wait(5000)
				if timeoutwait == 5 then
					RemoveEventHandler(thistemporaryevent)
					scrinprogress = false -- cancel screenshot, seems like it failed
					TriggerClientEvent("chat:addMessage", src, { args = { "EasyAdmin", "Screenshot Failed!" } })
				end
			until not scrinprogress
		end
	end)
	
	RegisterServerEvent("EasyAdmin:unbanPlayer")
	AddEventHandler('EasyAdmin:unbanPlayer', function(banId)
		local thisBan = nil
		if DoesPlayerHavePermission(source,"easyadmin.unban") then
			for i,ban in ipairs(blacklist) do 
				if ban.banid == banId then
					thisBan = ban
					break
				end
			end
			UnbanId(banId)
			PrintDebugMessage("Player "..getName(source,true).." unbanned "..banId)
			SendWebhookMessage(moderationNotification,string.format(GetLocalisedText("adminunbannedplayer"), getName(source), banId, thisBan.reason))
			SaveResourceFile(GetCurrentResourceName(), "banlist.json", json.encode(blacklist, {indent = true}), -1)
		end
	end)

	RegisterServerEvent("EasyAdmin:mutePlayer")
	AddEventHandler('EasyAdmin:mutePlayer', function(playerId)
		local src = source
		if DoesPlayerHavePermission(src,"easyadmin.mute") then
			if not MutedPlayers[playerId] then 
				MutedPlayers[playerId] = true
				TriggerClientEvent("chat:addMessage", src, { args = { "EasyAdmin", getName(playerId) .. " " .. GetLocalisedText("playermuted") } })
				PrintDebugMessage("Player "..getName(source,true).." muted "..getName(playerId,true))
			else 
				MutedPlayers[playerId] = nil
				TriggerClientEvent("chat:addMessage", src, { args = { "EasyAdmin", getName(playerId) .. " " .. GetLocalisedText("playerunmuted") } })
				PrintDebugMessage("Player "..getName(source,true).." unmuted "..getName(playerId,true))
			end
		end
	end)

	RegisterServerEvent("EasyAdmin:SetAnonymous")
	AddEventHandler('EasyAdmin:SetAnonymous', function(playerId)
		if DoesPlayerHavePermission(source,"easyadmin.anon") then
			if AnonymousAdmins[source] then
				AnonymousAdmins[source] = nil
				PrintDebugMessage("Player "..getName(source,true).." un-anoned himself")
			else
				AnonymousAdmins[source] = true
				PrintDebugMessage("Player "..getName(source,true).." anoned himself")
			end
		end
	end)

	
	blacklist = {}
	

	function GetFreshBanId()
		if blacklist[#blacklist] then 
			return blacklist[#blacklist].banid+1
		else
			return 1
		end
	end
	function updateAdmins(addItem)
		admins = {}
		local content = LoadResourceFile(GetCurrentResourceName(), "admins.txt")
		if not content then
			return -- instead of re-creating the file, just quit, we dont need to continue anyway.
		end
		Citizen.Trace("^1EasyAdmin: WARNING!!!!^7\n")
		Citizen.Trace("^1EasyAdmin: WARNING!!!!^7\n")
		Citizen.Trace("^3The following SteamIDs are added to your admins.txt file, this method is **OUTDATED** and **DOES NOT WORK**^7\n")
		Citizen.Trace("Add these admins using ACE:\n")
		for index,value in ipairs(mysplit(content, "\n")) do
			Citizen.Trace(value.."\n")
		end
		Citizen.Trace("^1EasyAdmin: WARNING!!!!^7\n")
		Citizen.Trace("^1EasyAdmin: WARNING!!!!^7\n")
	end
	
	--[[
		Very basic function that turns "source" into a useable player name.
	]]
	function getName(src,anonymousdisabled)
		if (src == 0 or src == "") then
			return "Console"
		else
			if AnonymousAdmins[src] and not anonymousdisabled then
				return GetLocalisedText("anonymous")
			elseif CachedPlayers[src] and CachedPlayers[src].name then
				return CachedPlayers[src].name
			elseif (GetPlayerName(src)) then
				return GetPlayerName(src)
			else
				return "Unknown - " .. src
			end
		end
	end
	
	function updateBan(id,newData)
		if id and newData and newData.identifiers and newData.banid and newData.reason and newData.expire then 
			blacklist[id] = newData
			SaveResourceFile(GetCurrentResourceName(), "banlist.json", json.encode(blacklist, {indent = true}), -1)
			if GetConvar("ea_custombanlist", "false") == "true" then 
				TriggerEvent("ea_data:updateBan", newData)
			end
		end
	end


	function updateBlacklist(data,remove)
		-- life is pain, if you think this code sucks, SUCK MY DICK and make it better
		local change=false --mark if file was changed to save up on disk writes.
		if GetConvar("ea_custombanlist", "false") == "true" then 
			
			if data and not remove then
				table.insert(blacklist, data)
				TriggerEvent("ea_data:addBan", data)
				
			elseif data and remove then
				for i,theBan in ipairs(blacklist) do
					if theBan.banid == data.banid then
						table.remove(blacklist,i)
						PrintDebugMessage("removed ban as per custombanlist remove")
						TriggerEvent("ea_data:removeBan", theBan)
						break
					end
				end
			elseif not data then
				TriggerEvent('ea_data:retrieveBanlist', function(banlist)
					blacklist = banlist
					PrintDebugMessage("updated banlist custom banlist")
					for i,theBan in ipairs(blacklist) do
						if theBan.expire < os.time() then
							table.remove(blacklist,i)
							PrintDebugMessage("removing old ban custom banlist")
							TriggerEvent("ea_data:removeBan", theBan)
						end
					end
				end)
			end
			return
		end
		
		local content = LoadResourceFile(GetCurrentResourceName(), "banlist.json")
		if not content then
			SaveResourceFile(GetCurrentResourceName(), "banlist.json", json.encode({}), -1)
			content = json.encode({})
		end
		blacklist = json.decode(content)
		
				
		local txtcontent = LoadResourceFile(GetCurrentResourceName(), "banlist.txt") -- compat
		if not txtcontent then txtcontent = "" end
		if string.len(txtcontent) > 5 then
			for index,value in ipairs(mysplit(txtcontent, "\n")) do
				curstring = "" -- make a new string
				for i = 1, #value do -- loop trough every character of "value" to determine if it's part of the identifier or reason
					if string.sub(value,i,i) == ";" then break end -- end the loop if we reached the "reason" part
					curstring = curstring..string.sub(value,i,i) -- add our current letter to our string
				end
				local reason = string.match(value, "^.*%;(.*)" ) or GetLocalisedText("nongiven") -- get the reason from the string or use "none given" if it's nil
				local reason = string.gsub(reason,"\r","")
				table.insert(blacklist, {identifier = curstring, reason = reason, expire = 10444633200 }) -- we need an expire time here, anything will do, lets make it christmas!
			end
			SaveResourceFile(GetCurrentResourceName(), "banlist.txt", "", 0) -- overwrite banlist with emptyness, we dont even need this file, but sadly we cant delete it :(
			SaveResourceFile(GetCurrentResourceName(), "banlist.json", json.encode(blacklist, {indent = true}), -1)
		end
		

		PrintDebugMessage("updated banlist")
		if not blacklist then
			print("^1-^2-^3-^4-^5-^6-^8-^9-^1-^2-^3-^4-^5-^6-^8-^9-^1-^2-^3-^3!^1FATAL ERROR^3!^3-^2-^1-^9-^8-^6-^5-^4-^3-^2-^1-^9-^8-^6-^5-^4-^3-^2-^7\n")
			print("EasyAdmin: ^1Failed^7 to load Banlist!\n")
			print("EasyAdmin: Please check your banlist file for errors, ^1Bans *will not* work!^7\n")
			print("^1-^2-^3-^4-^5-^6-^8-^9-^1-^2-^3-^4-^5-^6-^8-^9-^1-^2-^3-^3!^1FATAL ERROR^3!^3-^2-^1-^9-^8-^6-^5-^4-^3-^2-^1-^9-^8-^6-^5-^4-^3-^2-^7\n")
		end
		
		if blacklist[1] and (blacklist[1].identifier or blacklist[1].steam or blacklist[1].discord) then -- more compat
			Citizen.Trace("Upgrading Banlist...\n")
			for i,ban in ipairs(blacklist) do
				if not ban.identifiers then
					ban.identifiers = {}
					change=true
				end
				if ban.identifier then
					table.insert(ban.identifiers, ban.identifier)
					ban.identifier = nil
					change=true
				end
				if ban.steam then
					table.insert(ban.identifiers, ban.steam)
					ban.steam = nil
					change=true
				end
				if ban.discord and ban.discord ~= "" then
					table.insert(ban.identifiers, ban.discord)
					ban.discord = nil
					change=true
				end
			end
			Citizen.Trace("Banlist Upgraded! No Further Action is necesarry.\n")
		end

		
		if data and not remove then
			table.insert(blacklist, data)
			change=true
		elseif not data then
			for i,theBan in ipairs(blacklist) do
				theBan.id = nil
				if not theBan.banid then
					if i==1 then 
						theBan.banid = 1
					else
						theBan.banid = blacklist[i].banid or i
					end
					change=true
				end
				if not theBan.expire then 
					table.remove(blacklist,i)
					change=true
				elseif not theBan.identifiers then -- make sure 1 identifier is given, otherwise its a broken ban
					table.remove(blacklist,i)
					change=true
				elseif not theBan.identifiers[1] then 
					table.remove(blacklist,i)
					change=true
				elseif theBan.expire < os.time() then
					table.remove(blacklist,i)
					PrintDebugMessage("removing old ban no custom banlist")
					change=true
				elseif theBan.expire == 1924300800 then
					blacklist[i].expire = 10444633200
					change=true
				end
			end
		end
		if data and remove then
			for i,theBan in ipairs(blacklist) do
				if data.banid == theBan.banid then
					table.remove(blacklist,i)
					PrintDebugMessage("removing ban as ordered by remove param")
					change=true
					break
				end
			end
		end
		if change then
			SaveResourceFile(GetCurrentResourceName(), "banlist.json", json.encode(blacklist, {indent = true}), -1)
		end
	end



	
	function IsIdentifierBanned(theIndentifier)
		local identifierfound = false
		for index,value in ipairs(blacklist) do
			for i,identifier in ipairs(value.identifiers) do
				if theIndentifier == identifier then
					identifierfound = true
				end
			end
		end
		return identifierfound
	end

	AddEventHandler("EasyAdmin:GetVersion", function(cb)
		local verFile = LoadResourceFile(GetCurrentResourceName(), "version.json")
		local verContent = json.decode(verFile)
		print(verContent.fivem.version)
		cb(verContent.fivem.version)
	end)
	
	function BanIdentifier(identifier,reason)
		updateBlacklist( {identifiers = {identifier} , banner = "Unknown", reason = reason, expire = 10444633200} )
	end
	
	function BanIdentifiers(identifier,reason)
		updateBlacklist( {identifiers = identifier , banner = "Unknown", reason = reason, expire = 10444633200} )
	end
	
	function UnbanIdentifier(identifier)
		if banid then 
			if blacklist[banid] then 
				table.remove(blacklist,banid)
			end
		elseif identifier then
			for i,ban in ipairs(blacklist) do
				for index,id in ipairs(ban.identifiers) do
					if identifier == id then
						table.remove(blacklist,i)
						PrintDebugMessage("removed ban as per unbanidentifier func")
						return
					end 
				end
			end
		end
	end

	function UnbanId(id)
		for i,ban in ipairs(blacklist) do 
			if ban.banid == id then
				table.remove(blacklist,i)
				if GetConvar("ea_custombanlist", "false") == "true" then 
					TriggerEvent("ea_data:removeBan", ban)
				end
			end
		end
	end
	
	AddEventHandler('playerConnecting', function(playerName, setKickReason)
		local numIds = GetPlayerIdentifiers(source)
		local matchingIdentifiers = 0
		if not blacklist then
			print("^1-^2-^3-^4-^5-^6-^8-^9-^1-^2-^3-^4-^5-^6-^8-^9-^1-^2-^3-^3!^1FATAL ERROR^3!^3-^2-^1-^9-^8-^6-^5-^4-^3-^2-^1-^9-^8-^6-^5-^4-^3-^2-^7\n")
			print("EasyAdmin: ^1Failed^7 to load Banlist!\n")
			print("EasyAdmin: Please check this error soon, ^1Bans *will not* work!^7\n")
			print("^1-^2-^3-^4-^5-^6-^8-^9-^1-^2-^3-^4-^5-^6-^8-^9-^1-^2-^3-^3!^1FATAL ERROR^3!^3-^2-^1-^9-^8-^6-^5-^4-^3-^2-^1-^9-^8-^6-^5-^4-^3-^2-^7\n")
		 	return
		end
		for bi,blacklisted in ipairs(blacklist) do
			for i,theId in ipairs(numIds) do
				for ci,identifier in ipairs(blacklisted.identifiers) do
					if identifier == theId then
						matchingIdentifiers = matchingIdentifiers+1
						PrintDebugMessage("IDENTIFIER MATCH! "..identifier.." Required: "..matchingIdentifiers.."/"..minimumMatchingIdentifiers)
						if matchingIdentifiers >= minimumMatchingIdentifiers then
							setKickReason(string.format( GetLocalisedText("bannedjoin"), blacklist[bi].reason, os.date('%d/%m/%Y 	%H:%M:%S', blacklist[bi].expire )))
							PrintDebugMessage("EasyAdmin: Connection of "..GetPlayerName(source).." Declined, Banned for "..blacklist[bi].reason.." \n")
							CancelEvent()
							return
						end
					end
				end
			end
		end
	end)


	AddEventHandler('chatMessage', function(Source, Name, Msg)
		if MutedPlayers[Source] then
			CancelEvent()
			TriggerClientEvent("chat:addMessage", Source, { args = { "EasyAdmin", GetLocalisedText("playermute") } })
		end
	end)
	
	
	---------------------------------- USEFUL
	
	function SendWebhookMessage(webhook,message)
		moderationNotification = GetConvar("ea_moderationNotification", "false")
		if webhook ~= "false" then
			PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
		end
	end
	
	function mysplit(inputstr, sep)
		if sep == nil then
			sep = "%s"
		end
		local t={} ; i=1
		for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
			t[i] = str
			i = i + 1
		end
		return t
	end
	
	
	local verFile = LoadResourceFile(GetCurrentResourceName(), "version.json")
	local verContent = json.decode(verFile)
	local curVersion = (verContent.fivem.version or verContent.version)
	local updatePath = "/Blumlaut/EasyAdmin"
	local resourceName = "EasyAdmin ("..GetCurrentResourceName()..")"
	function checkVersion(err,response, headers)
		if err == 200 then
			local data = json.decode(response)
			if curVersion ~= data.fivem.version and tonumber(curVersion) < tonumber(data.fivem.version) then
				print("\n--------------------------------------------------------------------------")
				print("\n"..resourceName.." is outdated.\nNewest Version: "..data.fivem.version.."\nYour Version: "..curVersion.."\nPlease update it from https://github.com"..updatePath.."")
				print("\nUpdate Changelog:\n"..data.changelog)
				print("\n--------------------------------------------------------------------------")
			elseif tonumber(curVersion) > tonumber(data.version) then
				print("Your version of "..resourceName.." seems to be higher than the current version.")
			else
				print(resourceName.." is up to date!")
			end
		else
			print("EasyAdmin Version Check failed!")
		end
		if GetResourceState("screenshot-basic") == "missing" then 
			--print("\nEasyAdmin: screenshot-basic is not installed on this Server, screenshots unavailable")
		else
			StartResource("screenshot-basic")
			screenshots = true
		end
		local onesync = GetConvar("onesync", "off")
		if (onesync ~= "off" and onesync ~= "legacy") then 
			infinity = true
		end
		
		SetTimeout(3600000, checkVersionHTTPRequest)
	end
	
	function checkVersionHTTPRequest()
		PerformHttpRequest("https://raw.githubusercontent.com/"..updatePath.."/master/version.json", checkVersion, "GET")
	end
	
	function loopUpdateBlacklist()
		updateBlacklist()
		SetTimeout(300000, loopUpdateBlacklist)
	end


	
	---------------------------------- END USEFUL
	loopUpdateBlacklist()
	updateAdmins()
	checkVersionHTTPRequest()
end)
