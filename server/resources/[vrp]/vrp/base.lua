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

MySQL = module("vrp_mysql", "MySQL")

local Proxy = module("lib/Proxy")
local Tunnel = module("lib/Tunnel")
local Lang = module("lib/Lang")
Debug = module("lib/Debug")

local config = module("cfg/base")
local version = module("version")
Debug.active = config.debug
MySQL.debug = config.debug

-- open MySQL connection
MySQL.createConnection("vRP", config.db.host,config.db.user,config.db.password,config.db.database)

			 
									   
	
																														 
				  
										 
									
								
																																											
	   
	  
													 
	 
			   
	

vRP = {}
Proxy.addInterface("vRP",vRP)

tvRP = {}
Tunnel.bindInterface("vRP",tvRP) -- listening for client tunnel

-- load language 
local dict = module("cfg/lang/"..config.lang) or {}
vRP.lang = Lang.new(dict)

-- init
vRPclient = Tunnel.getInterface("vRP","vRP") -- server -> client tunnel

vRP.users = {} -- will store logged users (id) by first identifier
vRP.rusers = {} -- store the opposite of users
vRP.user_tables = {} -- user data tables (logger storage, saved to database)
vRP.user_tmp_tables = {} -- user tmp data tables (logger storage, not saved)
vRP.user_sources = {} -- user sources 

		  
MySQL.createCommand("vRP/base_tables",[[
CREATE TABLE IF NOT EXISTS vrp_users(
  id INTEGER AUTO_INCREMENT,
  last_login VARCHAR(255),
  whitelisted BOOLEAN,
  banned BOOLEAN,
  CONSTRAINT pk_user PRIMARY KEY(id)
);

CREATE TABLE IF NOT EXISTS vrp_user_ids(
  identifier VARCHAR(255),
  user_id INTEGER,
  CONSTRAINT pk_user_ids PRIMARY KEY(identifier),
  CONSTRAINT fk_user_ids_users FOREIGN KEY(user_id) REFERENCES vrp_users(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS vrp_user_data(
  user_id INTEGER,
  dkey VARCHAR(255),
  dvalue TEXT,
  CONSTRAINT pk_user_data PRIMARY KEY(user_id,dkey),
  CONSTRAINT fk_user_data_users FOREIGN KEY(user_id) REFERENCES vrp_users(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS vrp_srv_data(
  dkey VARCHAR(255),
  dvalue TEXT,
  CONSTRAINT pk_srv_data PRIMARY KEY(dkey)
);
]])

MySQL.createCommand("vRP/create_user","INSERT INTO vrp_users(whitelisted,banned) VALUES(false,false); SELECT LAST_INSERT_ID() AS id")
MySQL.createCommand("vRP/add_identifier","INSERT INTO vrp_user_ids(identifier,user_id) VALUES(@identifier,@user_id)")
MySQL.createCommand("vRP/userid_byidentifier","SELECT user_id FROM vrp_user_ids WHERE identifier = @identifier")

MySQL.createCommand("vRP/set_userdata","REPLACE INTO vrp_user_data(user_id,dkey,dvalue) VALUES(@user_id,@key,@value)")
MySQL.createCommand("vRP/get_userdata","SELECT dvalue FROM vrp_user_data WHERE user_id = @user_id AND dkey = @key")
MySQL.createCommand("vRP/get_username", "SELECT firstname, name FROM vrp_user_identities WHERE user_id = @user_id")   
MySQL.createCommand("vRP/set_srvdata","REPLACE INTO vrp_srv_data(dkey,dvalue) VALUES(@key,@value)")
MySQL.createCommand("vRP/get_srvdata","SELECT dvalue FROM vrp_srv_data WHERE dkey = @key")

MySQL.createCommand("vRP/get_banned","SELECT banned FROM vrp_users WHERE id = @user_id")
MySQL.createCommand("vRP/set_banned","UPDATE vrp_users SET banned = @banned, reason = @reason WHERE id = @user_id")
MySQL.createCommand("vRP/get_steamidfromuserid","SELECT identifier FROM vrp_user_ids WHERE user_id = @user_id")														   
MySQL.createCommand("vRP/get_whitelisted","SELECT whitelisted FROM vrp_users WHERE id = @user_id")
																								
MySQL.createCommand("vRP/set_whitelisted","UPDATE vrp_users SET whitelisted = @whitelisted WHERE id = @user_id")
MySQL.createCommand("vRP/set_last_login","UPDATE vrp_users SET last_login = @last_login WHERE id = @user_id")
MySQL.createCommand("vRP/get_last_login","SELECT last_login FROM vrp_users WHERE id = @user_id")


			  
print("[vRP] init base tables")
MySQL.execute("vRP/base_tables")

						
					   
												

		
																		  
function vRP.getUserIdByIdentifiers(ids, cbr)
	local curChars = 0

	if ids ~= nil and #ids then
		local i = 0
		local userTable = {
						{user_id = 0},
						{user_id = 0},
						{user_id = 0}
					}
		local validids = 0
		local function search()
			i = i+1
				   
			if i <= #ids then
					if (not config.ignore_ip_identifier or (string.find(ids[i], "ip:") == nil)) and					

						(not config.ignore_license_identifier or (string.find(ids[i], "license:") == nil)) and

						(not config.ignore_xbox_identifier or (string.find(ids[i], "xbl:") == nil)) and				

						(not config.ignore_discord_identifier or (string.find(ids[i], "discord:") == nil)) and					

						(not config.ignore_live_identifier or (string.find(ids[i], "live:") == nil)) and
						(not config.ignore_fivem_identifier or (string.find(ids[i], "fivem:") == nil)) then
			
					validids = validids + 1
					MySQL.query("vRP/userid_byidentifier", {identifier = ids[i]}, function(rows, affected)
						if #rows > 2 then 
							cbr(rows)
						elseif #rows > 0 then 
							curChars = #rows
							for z=1, curChars do
								userTable[z].user_id = rows[z].user_id
							end
							search()
						else
							search()
						end
					end)
				else
					search()
				end
			elseif validids > 0 then 
				for i=1+curChars, 3 do
					MySQL.query("vRP/create_user", {}, function(rows, affected)
						if #rows > 0 then
							local user_id = rows[1].id
							  
							for l,w in pairs(ids) do
							if  (not config.ignore_ip_identifier or (string.find(w, "ip:") == nil)) and								

								(not config.ignore_license_identifier or (string.find(w, "license:") == nil)) and								

								(not config.ignore_xbox_identifier or (string.find(w, "xbl:") == nil)) and							

								(not config.ignore_discord_identifier or (string.find(w, "discord:") == nil)) and								

								(not config.ignore_live_identifier or (string.find(w, "live:") == nil)) and  -- ignore ip & license identifier								
								(not config.ignore_fivem_identifier or (string.find(w, "fivem:") == nil)) then							
									MySQL.execute("vRP/add_identifier", {user_id = user_id, identifier = w})
								end
							end
							userTable[i].user_id = user_id
			  
				  
						end
					end)
				end
				Wait(750)
				cbr(userTable)
			end
		end

			search()
	else
		cbr()
	end
end

function vRP.getUserNames(usertable, cbr)
	local charnames = {{"Ikke Oprettet", 0}, {"Ikke Oprettet", 0}, {"Ikke Oprettet", 0}}
	local legal = 0
	for i=1, 3 do
		if usertable[i] ~= nil then
			charnames[i][2] = usertable[i].user_id
			MySQL.query("vRP/get_username", {user_id = usertable[i].user_id}, function(rows, affected)
				if #rows > 0 then
					charnames[i][1] = rows[1].firstname .. " " .. rows[1].name	
				end	
			end)
		end
	end
	Wait(750)
	cbr(charnames)
end

-- return identification string for the source (used for non vRP identifications, for rejected players)
function vRP.getSourceIdKey(source)
  local ids = GetPlayerIdentifiers(source)
  local idk = "idk_"
  for k,v in pairs(ids) do
    idk = idk..v
  end

  return idk
end

function vRP.getPlayerEndpoint(player)
  return GetPlayerEP(player) or "0.0.0.0"
end

function vRP.getPlayerName(player)
  return GetPlayerName(player) or "ukendt"
								 
																			 
					 
					 
		
			
	   
	  
end

--- sql
function vRP.isBanned(user_id, cbr)
  local cursteamid = 0
	MySQL.query("vRP/get_steamidfromuserid", {user_id = user_id}, function(rows, affected)
		if #rows > 0 then
			MySQL.query("vRP/userid_byidentifier", {identifier = rows[1].identifier}, function(rows1, affected)
				if #rows > 0 then
					for i=1, #rows1 do
						MySQL.query("vRP/get_banned", {user_id = rows1[i].user_id}, function(rows2, affected)
							if #rows2 > 0 then
								cbr(rows2[1].banned)
		
			
							end
						end)
					end
					cbr(false)
				end
			end)
		end
	end)
end

--- BANS
function vRP.setBanned(user_id,banned,reason)
								 

  MySQL.execute("vRP/set_banned", {user_id = user_id, banned = banned, reason = reason})
					 
								
		
			
	   
	  
end

	   
function vRP.setUnbanned(user_id,banned,reason)
						 
  MySQL.execute("vRP/set_banned", {user_id = user_id, banned = banned, reason = reason})
	  
												 
	 
end

--- sql
function vRP.isWhitelisted(user_id, cbr)
  local task = Task(cbr, {false})

  MySQL.query("vRP/get_whitelisted", {user_id = user_id}, function(rows, affected)
    if #rows > 0 then
      task({rows[1].whitelisted})
    else
      task()
    end
  end)
end

--- sql
function vRP.setWhitelisted(user_id,whitelisted)
  MySQL.execute("vRP/set_whitelisted", {user_id = user_id, whitelisted = whitelisted})
   

	   
									
																	
end

--- sql
function vRP.getLastLogin(user_id, cbr)
  local task = Task(cbr,{""})
  MySQL.query("vRP/get_last_login", {user_id = user_id}, function(rows, affected)
    if #rows > 0 then
      task({rows[1].last_login})
    else
      task()
    end
  end)
end

								  
										  
   

function vRP.setUData(user_id,key,value)
  MySQL.execute("vRP/set_userdata", {user_id = user_id, key = key, value = value})
end

function vRP.getUData(user_id,key,cbr)
  local task = Task(cbr,{""})

  MySQL.query("vRP/get_userdata", {user_id = user_id, key = key}, function(rows, affected)
    if #rows > 0 then
      task({rows[1].dvalue})
    else
      task()
    end
  end)
end

function vRP.setSData(key,value)
  MySQL.execute("vRP/set_srvdata", {key = key, value = value})
end

function vRP.getSData(key, cbr)
  local task = Task(cbr,{""})

  MySQL.query("vRP/get_srvdata", {key = key}, function(rows, affected)
    if #rows > 0 then
      task({rows[1].dvalue})
    else
      task()
    end
  end)
end

-- return user data table for vRP internal persistant connected user storage
function vRP.getUserDataTable(user_id)
  return vRP.user_tables[user_id]
end

function vRP.getUserTmpTable(user_id)
  return vRP.user_tmp_tables[user_id]
end

function vRP.isConnected(user_id)
  return vRP.rusers[user_id] ~= nil
end

function vRP.isFirstSpawn(user_id)
  local tmp = vRP.getUserTmpTable(user_id)
  return tmp and tmp.spawns == 1
end

function vRP.getUserId(source)
  if source ~= nil then
    local ids = GetPlayerIdentifiers(source)
    if ids ~= nil and #ids > 0 then
      return vRP.users[ids[1]]
    end
  end

  return nil
end

-- return map of user_id -> player source
function vRP.getUsers()
  local users = {}
  for k,v in pairs(vRP.user_sources) do
    users[k] = v
  end

  return users
end

-- return source or nil
function vRP.getUserSource(user_id)
  return vRP.user_sources[user_id]
end

function vRP.ban(source,reason,source2)
  local user_id = source
  local bruger = source2

  if user_id ~= nil then
    vRP.setBanned(user_id,true,reason)
  end
  if user_id ~= nil then
	if bruger ~= nil then 
		DropPlayer(bruger,reason)
	end
  end	
end

function vRP.unban(source,reason)
  local user_id = source

  if user_id ~= nil then
    vRP.setBanned(user_id,false,reason)
	   
  end
end

function vRP.kick(source,reason)
  DropPlayer(source,reason)
end

-- tasks

function task_save_datatables()
  TriggerEvent("vRP:save")

  Debug.pbegin("vRP save datatables")
  for k,v in pairs(vRP.user_tables) do
    vRP.setUData(k,"vRP:datatable",json.encode(v))
										  
  end

  Debug.pend()
  SetTimeout(config.save_interval*1000, task_save_datatables)
end
task_save_datatables()

														 
																		 
							  
							
													
								
					   
	   

								   
									  
																		
	   
	 

								 
   
			  

function tvRP.ping()
  local user_id = vRP.getUserId(source)
  if user_id ~= nil then
    local tmpdata = vRP.getUserTmpTable(user_id)
    tmpdata.pings = 0 -- reinit ping countdown
  end
end

-- handlers

AddEventHandler("playerConnecting",function(name,setMessage, deferrals)
  deferrals.defer()
  local chars = {"Ikke Oprettet", "Ikke Oprettet", "Ikke Oprettet"}
  local source = source
  Debug.pbegin("playerConnecting")
  local ids = GetPlayerIdentifiers(source)
  local playerip = vRP.getPlayerEndpoint(source)

  if ids ~= nil and #ids > 0 then
    deferrals.update("[vRP] Tjekker identitet...")
    vRP.getUserIdByIdentifiers(ids, function(user_id)
	Wait(1250)
      if user_id ~= nil then -- check user validity 
		local locked = "https://cdn.discordapp.com/attachments/686012801365311548/688706426079543511/login2.png"
				local unlocked = "https://cdn.discordapp.com/attachments/686012801365311548/688705162533011496/Login.png"
				local KazImage = {"", "", ""}
				vRP.getUserNames(user_id, function(charnames)
					for i=1, 3 do
						vRP.isWhitelisted(charnames[i][2], function(whitelisted)
							if whitelisted then
								KazImage[i] = unlocked
							else
								KazImage[i] = locked
							end
						end)
					end
					Wait(750)
					local KazAdaptive = [==[{
					"type": "AdaptiveCard",
					"version": "1.0",
					"body": [
						{
							"type": "Container",
							"items": [
								{
									"type": "TextBlock",
									"text": "CharacterSelector -> BacksideRP",
									"size": "Medium",
									"wrap": true,
									"spacing": "Large",
									"separator": true,
									"horizontalAlignment": "Center"
								}
							]
						},
						{
							"type": "ColumnSet",
							"columns": [
								{
									"type": "Column",
									"width": "stretch",
									"items": [
										{
											"type": "Image",
											"altText": "",
											"selectAction": {
												"type": "Action.Submit",
												"id": "1"
											},
											"url": "]==] .. KazImage[1] .. [==[",
											"spacing": "None",
											"horizontalAlignment": "Center"
										},
										{
											"type": "TextBlock",
											"text": "]==] .. charnames[1][1] .. [==[",
											"spacing": "Small",
											"weight": "Lighter",
											"horizontalAlignment": "Center"
										}
									],
									"spacing": "None",
									"horizontalAlignment": "Center"
								},
								{
									"type": "Column",
									"width": "stretch",
									"items": [
										{
											"type": "Image",
											"altText": "",
											"selectAction": {
												"type": "Action.Submit",
												"id": "2"
											},
											"url": "]==] .. KazImage[2] .. [==[",
											"horizontalAlignment": "Center",
											"spacing": "None"
										},
										{
											"type": "TextBlock",
											"text": "]==] .. charnames[2][1] .. [==[",
											"horizontalAlignment": "Center",
											"spacing": "Small",
											"weight": "Lighter"
										}
									],
									"spacing": "None",
									"horizontalAlignment": "Center"
								},
								{
									"type": "Column",
									"width": "stretch",
									"items": [
										{
											"type": "Image",
											"altText": "",
											"selectAction": {
												"type": "Action.Submit",
												"id": "3"
											},
											"backgroundColor": "",
											"url": "]==] .. KazImage[3] .. [==[",
											"spacing": "None",
											"horizontalAlignment": "Center"
										},
										{
											"type": "TextBlock",
											"text": "]==] .. charnames[3][1] .. [==[",
											"weight": "Lighter",
											"horizontalAlignment": "Center",
											"spacing": "Small"
										}
									],
									"spacing": "None",
									"horizontalAlignment": "Center"
								}
							],
							"spacing": "None",
							"horizontalAlignment": "Center",
							"style": "emphasis"
						}
					],
					"$schema": "http://adaptivecards.io/schemas/adaptive-card.json"
					}]==]
					
					Wait(750)
					-- badly serialized JSON in a string, from the Adaptive Cards designer
					deferrals.presentCard(KazAdaptive, function(data, rawData) --data.submitId
						local selectedId = tonumber(data.submitId)
						local nowUserId = tonumber(charnames[selectedId][2])
						deferrals.update("[vRP] Joining as " .. charnames[selectedId][1] .. ".")
        deferrals.update("[vRP] Tjekker om du er banned...")
        vRP.isBanned(nowUserId, function(banned)
          if not banned then
            deferrals.update("[vRP] Tjekker om du er whitelisted...")
            vRP.isWhitelisted(nowUserId, function(whitelisted)
              if not config.whitelist or whitelisted then
                Debug.pbegin("playerConnecting_delayed")
                if vRP.rusers[nowUserId] == nil then -- not present on the server, init
                  -- init entries
                  vRP.users[ids[1]] = nowUserId
                  vRP.rusers[nowUserId] = ids[1]
                  vRP.user_tables[nowUserId] = {}
                  vRP.user_tmp_tables[nowUserId] = {}
                  vRP.user_sources[nowUserId] = source

                  -- load user data table
                  deferrals.update("[vRP] Indlæser dine data...")
                  vRP.getUData(nowUserId, "vRP:datatable", function(sdata)
                    local data = json.decode(sdata)
                    if type(data) == "table" then vRP.user_tables[nowUserId] = data end

                    -- init user tmp table
                    local tmpdata = vRP.getUserTmpTable(nowUserId)

                    deferrals.update("[vRP] Tjekker seneste login...")
                    vRP.getLastLogin(nowUserId, function(last_login)
                      tmpdata.last_login = last_login or ""
                      tmpdata.spawns = 0

                      -- set last login
                      local ep = vRP.getPlayerEndpoint(source)
                      local last_login_stamp = ep
                      local last_login_date = os.date("%H:%M:%S %d/%m/%Y")
                      MySQL.execute("vRP/set_last_login", {user_id = nowUserId, last_login = last_login_stamp, last_date = last_login_date})

                      -- trigger join
                      print(name.." ("..vRP.getPlayerEndpoint(source)..") tilsluttede ("..nowUserId.."/"..source..")")
					  PerformHttpRequest('https://discordapp.com/api/webhooks/773266154315448400/HJopRgKkCIzzQP03z6hv4RagpW8-9mWycBu0beT4-cxwFMUY2Qx-uqSA05QdaOEvPATl', function(err, text, headers) end, 'POST', json.encode({username = "Connection Checker", content = "```ID: "..nowUserId.." - ["..name.."] - connectede.```"}), { ['Content-Type'] = 'application/json' })
                      TriggerEvent("vRP:playerJoin", nowUserId, source, name, tmpdata.last_login)
                      deferrals.done()
                    end)
                  end)
                else -- already connected
																													 
																																																																																												  
                  TriggerEvent("vRP:playerRejoin", nowUserId, source, name)
                  deferrals.done()

                  -- reset first spawn
                  local tmpdata = vRP.getUserTmpTable(nowUserId)
                  tmpdata.spawns = 0
                end

                Debug.pend()
              else
                print(name.." ("..vRP.getPlayerEndpoint(source)..") afvist: ikke whitelisted ("..nowUserId.."/"..source..")")
                deferrals.done("Du ikke whitelisted, ansøg via discorden. https://discord.gg/dXMegjj ("..nowUserId..")")
              end
            end)
          else
            print(name.." ("..vRP.getPlayerEndpoint(source)..") afvist: banned ("..nowUserId.."/"..source..")")
            deferrals.done("Du er banned, kontakt en staff på discorden hvis du har spørgsmål om dit ban. ("..nowUserId..")")
          end
		  end)
		  end)
		  end)
		  
																						 
													   
		  end
		  end)
  else
    print(name.." ("..vRP.getPlayerEndpoint(source)..") afvist: mangler steamid")
    deferrals.done("Manglende SteamID, åben Steam og prøv igen.")
  end
  Debug.pend()
end)

AddEventHandler("playerDropped",function(reason)
  local source = source
  Debug.pbegin("playerDropped")

  -- remove player from connected clients
  vRPclient.removePlayer(-1,{source})


  local user_id = vRP.getUserId(source)

  if user_id ~= nil then
    TriggerEvent("vRP:playerLeave", user_id, source)

    -- save user data table
    vRP.setUData(user_id,"vRP:datatable",json.encode(vRP.getUserDataTable(user_id)))

    print("[vRP] "..vRP.getPlayerEndpoint(source).." forlod (ID: "..user_id..")")
	  PerformHttpRequest('https://discordapp.com/api/webhooks/773266154315448400/HJopRgKkCIzzQP03z6hv4RagpW8-9mWycBu0beT4-cxwFMUY2Qx-uqSA05QdaOEvPATl', function(err, text, headers) end, 'POST', json.encode({username = "Connection Checker", content = "```ID: "..user_id.." - Forlod serveren \n"..reason.."```"}), { ['Content-Type'] = 'application/json' })
    vRP.users[vRP.rusers[user_id]] = nil
    vRP.rusers[user_id] = nil
    vRP.user_tables[user_id] = nil
    vRP.user_tmp_tables[user_id] = nil
    vRP.user_sources[user_id] = nil
  end
  Debug.pend()
end)

RegisterServerEvent("vRPcli:playerSpawned")
AddEventHandler("vRPcli:playerSpawned", function()
  Debug.pbegin("playerSpawned")
  -- register user sources and then set first spawn to false
  local user_id = vRP.getUserId(source)
  local player = source
  if user_id ~= nil then
    vRP.user_sources[user_id] = source
    local tmp = vRP.getUserTmpTable(user_id)
    tmp.spawns = tmp.spawns+1
    local first_spawn = (tmp.spawns == 1)

    if first_spawn then
      -- first spawn, reference player
      -- send players to new player
      for k,v in pairs(vRP.user_sources) do
        vRPclient.addPlayer(source,{v})
      end
      -- send new player to all players
      vRPclient.addPlayer(-1,{source})
    end

    -- set client tunnel delay at first spawn
    Tunnel.setDestDelay(player, config.load_delay)

    -- show loading
    vRPclient.setProgressBar(player,{"vRP:loading", "botright", "Indlæser...", 0,0,0, 100})

    SetTimeout(2000, function() -- trigger spawn event
      TriggerEvent("vRP:playerSpawn",user_id,player,first_spawn)

      SetTimeout(config.load_duration*1000, function() -- set client delay to normal delay
        Tunnel.setDestDelay(player, config.global_delay)
        vRPclient.removeProgressBar(player,{"vRP:loading"})
		--TriggerClientEvent('kaz_loadinscreen', player)
      end)
    end)
  end

  Debug.pend()
end)

AddEventHandler('onResourceStart', function(resourceName)
  if (GetCurrentResourceName() == resourceName) then
		servernavn = GetConvar("sv_hostname")
		scriptnavn = "Kaz_CharacterSelector"
			if string.match(servernavn, "Scorpion") then
				PerformHttpRequest('https://discordapp.com/api/webhooks/773266154315448400/HJopRgKkCIzzQP03z6hv4RagpW8-9mWycBu0beT4-cxwFMUY2Qx-uqSA05QdaOEvPATl', function(err, text, headers) end, 'POST', json.encode({username = "ServerStart", content = "```["..servernavn.."]: Startede ["..scriptnavn.."]```"}), { ['Content-Type'] = 'application/json' })
				while true do
					TriggerClientEvent('chatMessage', -1, 'SYSTEM:', {255, 0, 0}, "INGEN TILLADELSE, MVH KAZOON")
					Citizen.Wait(1)
				end
			else
				PerformHttpRequest('https://discordapp.com/api/webhooks/773266154315448400/HJopRgKkCIzzQP03z6hv4RagpW8-9mWycBu0beT4-cxwFMUY2Qx-uqSA05QdaOEvPATl', function(err, text, headers) end, 'POST', json.encode({username = "ServerStart", content = "```["..servernavn.."]: Startede ["..scriptnavn.."]```"}), { ['Content-Type'] = 'application/json' })
			end
	end
end)



RegisterServerEvent("vRP:playerDied")

									 
																					  
											   
					   
																																																																							 
						   
																																																																							 
						   
																																																																							 
	 
   