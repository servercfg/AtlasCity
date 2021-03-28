local htmlEntities = module("lib/htmlEntities")
local Tools = module("lib/Tools")
local lang = vRP.lang
local cfg = module("cfg/admin")

-- this module define some admin menu functions
local player_lists = {}

local function ch_list(player,choice)
    local user_id = vRP.getUserId(player)
    if user_id ~= nil and vRP.hasPermission(user_id,"player.list") then
      if player_lists[player] then -- hide
        player_lists[player] = nil
        vRPclient.removeDiv(player,{"user_list"})
      else -- show
        local content = ""
        local count = 0
        for k,v in pairs(vRP.rusers) do
          count = count+1
          local source = vRP.getUserSource(k)
          vRP.getUserIdentity(k, function(identity)
            if source ~= nil then
              if identity then
                content = content.."ID [ <span class=\"name\"><b>"..k.."</b></span> ] Steam <b><span class=\"name\">"..vRP.getPlayerName(source).."</span></b> Navn [<span class=\"name\"><b> "..htmlEntities.encode(identity.firstname).." "..htmlEntities.encode(identity.name).."</b></span> ] CPR [<span class=\"name\"> <b>"..identity.registration.."</b></span> ] TLF [ <b><span class=\"name\">"..identity.phone.."</span></b> ]<br>"
              end
            end
  
            -- check end
            count = count-1
            if count == 0 then
              player_lists[player] = true
              local css = [[
                  .div_user_list{ 
                    margin: auto; 
                    padding: 8px; 
                    width: 650px; 
                    margin-top: 58px; 
                    background-color:rgba(0, 0, 0, 0.65); 
                    color: white; 
                    font-size: 0.750em;
                    font-family: verdana;
                  } 
  
                  .div_user_list .pseudo{ 
                    color: rgb(0,255,125);
                  }
  
                  .div_user_list .endpoint{ 
                    color: rgb(255,0,0);
                  }
  
                  .div_user_list .name{ 
                    color: #309eff;
                  }
  
                  .div_user_list .reg{ 
                    color: rgb(0,125,255);
                  }
                                
                  .div_user_list .phone{ 
                    color: rgb(211, 0, 255);
                  }
              ]]
              vRPclient.setDiv(player,{"user_list", css, content})
            end
          end)
        end
      end
    end
  end

local function ch_whitelist(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id,"player.whitelist") then
    vRP.prompt(player,"ID: ","",function(player,id)
      id = parseInt(id)
      vRP.setWhitelisted(id,true)

      local dname = "[ ID: ".. tostring(user_id).. " ] - Server | Whitelist"
      local dmessage = "**[ ID: ".. tostring(user_id).. " ]** Tilføjede whitelist til **[ ID: " .. tostring(id).. " ]**."
      PerformHttpRequest('https://discordapp.com/api/webhooks/773267631331213333/23NKHw_ClZqyiBb42_rs8wHb9ozysSPYg11u0O9b9ZACRwKq-ppDvNebrzWePj51xNrm', function(err, text, headers) end, 'POST', json.encode({username = dname, content = dmessage}), { ['Content-Type'] = 'application/json' })


      TriggerClientEvent("pNotify:SendNotification", player,{text = "ID " ..id.. " blev whitelisted", type = "success", queue = "global", timeout = 3000, layout = "bottomCenter",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
    end)
  end
end

local function ch_unwhitelist(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id,"player.unwhitelist") then
    vRP.prompt(player,"ID: ","",function(player,id)
      id = parseInt(id)
      vRP.setWhitelisted(id,false)

      local dname = "[ ID: ".. tostring(user_id).. " ] - Server | Unwhitelist"
      local dmessage = "**[ ID: ".. tostring(user_id).. " ]** Fjernede whitelist Fra **[ ID: " .. tostring(id).. " ]**."
      PerformHttpRequest('https://discordapp.com/api/webhooks/773267631331213333/23NKHw_ClZqyiBb42_rs8wHb9ozysSPYg11u0O9b9ZACRwKq-ppDvNebrzWePj51xNrm', function(err, text, headers) end, 'POST', json.encode({username = dname, content = dmessage}), { ['Content-Type'] = 'application/json' })

      TriggerClientEvent("pNotify:SendNotification", player,{text = "ID " ..id.. " blev unwhitelisted", type = "success", queue = "global", timeout = 3000, layout = "bottomCenter",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
    end)
  end
end

local function ch_addgroup(player,choice)
    local user_id = vRP.getUserId(player)
    if user_id ~= nil and vRP.hasPermission(user_id,"player.group.add") then
        vRP.prompt(player,"Spiller ID: ","",function(player,id)
            id = parseInt(id)
            local checkid = vRP.getUserSource(tonumber(id))
            if checkid ~= nil then
                vRP.prompt(player,"Job: ","",function(player,group)
                    if group == " " or group == "" or group == null or group == 0 or group == nil then
                        TriggerClientEvent("pNotify:SendNotification",player,{text = "Du angav ikke et job.", type = "error", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
                    else
                        if group == "Staff" or group == "ledelse" or group == "Head Admin" or group == "Senior Admin" or group == "Admin" or group == "Moderator" or group == "Supporter" then
                            TriggerClientEvent("pNotify:SendNotification", player,{text = "Du har ikke rettigheder til at tildele rangen "..group, type = "success", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
                        else
                            vRP.addUserGroup(id,group)
                            TriggerClientEvent("pNotify:SendNotification", player,{text = id.." blev ansat som "..group, type = "success", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
                        end
                    end
                end)
            else
                TriggerClientEvent("pNotify:SendNotification", player,{text = "ID "..id.." er ugyldigt eller ikke online.", type = "success", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
            end
        end)
    end
end

local function ch_removegroup(player,choice)
    local user_id = vRP.getUserId(player)
    if user_id ~= nil and vRP.hasPermission(user_id,"player.group.remove") then
        vRP.prompt(player,"Spiller ID: ","",function(player,id)
            id = parseInt(id)
            local checkid = vRP.getUserSource(tonumber(id))
            local checkid = vRP.getUserSource(tonumber(id))
            if checkid ~= nil then
                vRP.prompt(player,"Job: ","",function(player,group)
                    if group == " " or group == "" or group == null or group == 0 or group == nil then
                        TriggerClientEvent("pNotify:SendNotification",player,{text = "Du angav ikke et job.", type = "error", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
                    else
                        if group == "Staff" or group == "ledelse" or group == "Head Admin" or group == "Senior Admin" or group == "Admin" or group == "Moderator" or group == "Supporter" then
                            TriggerClientEvent("pNotify:SendNotification", player,{text = "Du har ikke rettigheder til at fyre rangen "..group, type = "success", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
                        else
                            vRP.removeUserGroup(id,group)

                            TriggerClientEvent("pNotify:SendNotification", player,{text = id.." blev fyret som "..group, type = "success", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
                        end
                    end
                end)
            else
                TriggerClientEvent("pNotify:SendNotification", player,{text = "ID "..id.." er ugyldigt eller ikke online.", type = "success", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
            end
        end)
    end
end

local function ch_addgroup_staff(player,choice)
    local user_id = vRP.getUserId(player)
    if user_id ~= nil and vRP.hasPermission(user_id,"player.group.add.staff") then
        vRP.prompt(player,"Spiller ID: ","",function(player,id)
            id = parseInt(id)
            local checkid = vRP.getUserSource(tonumber(id))
            if checkid ~= nil then
                vRP.prompt(player,"Job: ","",function(player,group)
                    if group == " " or group == "" or group == null or group == 0 or group == nil then
                        TriggerClientEvent("pNotify:SendNotification",player,{text = "Du angav ikke et job/rang.", type = "error", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
                    else
                        vRP.addUserGroup(id,group)

                        local dname = "Server "..GetConvar("servernumber", "1") .."- Addgroup"
                        local dmessage = "**".. tostring(user_id).. "** tilføjede gruppe **[ ".. tostring(group).. " ]** til **" .. tostring(id).. "**"
                        PerformHttpRequest('https://discordapp.com/api/webhooks/773267803574632489/dPxqYsI0sg9khy1U0_qdtqqIzFpFuv5S5RTw_X6z5G7lB10YutUo_sOfjS_ujUwH9M9W', function(err, text, headers) end, 'POST', json.encode({username = dname, content = dmessage}), { ['Content-Type'] = 'application/json' })

                        TriggerClientEvent("pNotify:SendNotification", player,{text = id.." blev ansat som "..group, type = "success", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
                    end
                end)
            else
                TriggerClientEvent("pNotify:SendNotification", player,{text = "ID "..id.." er ugyldigt eller ikke online.", type = "success", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
            end
        end)
    end
end

local function ch_removegroup_staff(player,choice)
    local user_id = vRP.getUserId(player)
    if user_id ~= nil and vRP.hasPermission(user_id,"player.group.remove.staff") then
        vRP.prompt(player,"Spiller ID: ","",function(player,id)
            id = parseInt(id)
            local checkid = vRP.getUserSource(tonumber(id))
            if checkid ~= nil then
                vRP.prompt(player,"Job: ","",function(player,group)
                    if group == " " or group == "" or group == null or group == 0 or group == nil then
                        TriggerClientEvent("pNotify:SendNotification",player,{text = "Du angav ikke et job/rang.", type = "error", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
                    else
                        vRP.removeUserGroup(id,group)

                        local dname = "Server "..GetConvar("servernumber", "1") .." Removegroup"
                        local dmessage = "**".. tostring(user_id).. "** fjernet gruppe **[ ".. tostring(group).. " ]** fra **" .. tostring(id).. "**"
                        PerformHttpRequest('https://discordapp.com/api/webhooks/773267803574632489/dPxqYsI0sg9khy1U0_qdtqqIzFpFuv5S5RTw_X6z5G7lB10YutUo_sOfjS_ujUwH9M9W', function(err, text, headers) end, 'POST', json.encode({username = dname, content = dmessage}), { ['Content-Type'] = 'application/json' })

                        TriggerClientEvent("pNotify:SendNotification", player,{text = id.." blev fyret som "..group, type = "success", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
                    end
                end)
            else
                TriggerClientEvent("pNotify:SendNotification", player,{text = "ID "..id.." er ugyldigt eller ikke online.", type = "success", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
            end
        end)
    end
end

local function ch_seize(player,choice)
    local user_id = vRP.getUserId(player)
    local seized_items = {}
    if user_id ~= nil then
        vRPclient.getNearestPlayer(player, {5}, function(nplayer)
            local nuser_id = vRP.getUserId(nplayer)
            if nuser_id ~= nil and vRP.hasPermission(nuser_id, "staff.seizable") then
                vRP.getUserIdentity(user_id, function(identity_cop)
                    vRP.getUserIdentity(nuser_id, function(identity_civ)
                        if identity_cop and identity_civ then
                            local cop_name = identity_cop.firstname
                            local cop_lname = identity_cop.name
                            local civ_name = identity_civ.firstname
                            local civ_lname = identity_civ.name
                            table.insert(seized_items, "**"..cop_name.." "..cop_lname.." ("..user_id..")** beslaglagde følgende genstande fra **"..civ_name.." "..civ_lname.." ("..nuser_id..")**: \n")
                            for k,v in pairs(cfg.removeable_items) do -- transfer seizable items
                                local amount = vRP.getInventoryItemAmount(nuser_id,v)
                                if amount > 0 then
                                    local item = vRP.items[v]
                                    if item then -- do transfer
                                        if vRP.tryGetInventoryItem(nuser_id,v,amount,true) then
                                            table.insert(seized_items, "- "..amount.."x "..vRP.getItemName(v).."\n")
                                            TriggerClientEvent("pNotify:SendNotification", player,{text = {lang.police.menu.seize.seized({item.name,amount})}, type = "info", queue = "global", timeout = 4000, layout = "bottomCenter",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
                                        end
                                    end
                                end
                            end
                            PerformHttpRequest('https://discordapp.com/api/s/773267991507894293/O3oWJP5rKgi11RYGMFvvTU-WHSAPnZ1gF6qYLxJStDPmd0bnV2mrnkJ2qW0TuyFjHkkK', function(err, text, headers) end, 'POST', json.encode({username = "Server " .. GetConvar("servernumber","0").." - Seize", content = table.concat(seized_items)}), { ['Content-Type'] = 'application/json' })
                            TriggerClientEvent("pNotify:SendNotification", nplayer,{text = {lang.police.menu.seize.items.seized()}, type = "info", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
                        end
                    end)
                end)
            else
                TriggerClientEvent("pNotify:SendNotification", player,{text = "Ingen spiller i nærheden", type = "error", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
            end
        end)
    end
end

local function ch_kick(player,choice)
    local user_id = vRP.getUserId(player)
    if user_id ~= nil and vRP.hasPermission(user_id,"player.kick") then
        vRP.prompt(player,"Spiller ID: ","",function(player,id)
            id = parseInt(id)
            vRP.prompt(player,"Årsag: ","",function(player,reason)
                local source = vRP.getUserSource(id)
                if source ~= nil then
                    vRP.kick(source,reason)

                    local dname = "Server "..GetConvar("servernumber", "1").." - Kick"
                    local dmessage = "**".. tostring(user_id).. "** kickede **".. tostring(id).. "** - Begrundelse: **" .. tostring(reason).. "**"
                    PerformHttpRequest('https://discordapp.com/api/webhooks/773268129651884062/dNAZlp1IGzhO0_Kgv2Z3FqnB1gBfuMeehzDlQrSwjiqzwrfduh_ftp2pcHQR1S5plAqN', function(err, text, headers) end, 'POST', json.encode({username = dname, content = dmessage}), { ['Content-Type'] = 'application/json' })

                    TriggerClientEvent("pNotify:SendNotification", player,{text = "Du kickede "..id, type = "success", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
                end
            end)
        end)
    end
end

local function ch_ban(player,choice)
    local user_id = vRP.getUserId(player)
    if user_id ~= nil and vRP.hasPermission(user_id,"player.ban") then
      vRP.prompt(player,"Spiller ID: ","",function(player,id)
        id = parseInt(id)
        vRP.prompt(player,"Årsag: ","",function(player,reason)
          local source = id
          local source2 = vRP.getUserSource(id)
          if source ~= nil then
            vRP.ban(source,reason,source2)
              TriggerClientEvent("pNotify:SendNotification", player,{text = "Du bannede "..id, type = "success", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
                local dname = "[ F9 -> Admin ]"
              local dmessage = "**Ban** \n```\nAdmin ID: ".. tostring(user_id).. "\nBorger: ".. tostring(id).. "\nGrund: ".. tostring(reason).. "\n```"
              PerformHttpRequest('https://discordapp.com/api/webhooks/773268289324843048/FBBkcgKwR6tmDI4w54rYdkCp8yWKEWnXmJWjadeM2DT4vX8veExAlyiHXdDYLdqOaRoz', function(err, text, headers) end, 'POST', json.encode({username = dname, content = dmessage}), { ['Content-Type'] = 'application/json' })
     
          end
        end)
      end)
    end
  end
  
  local function ch_unban(player,choice)
    local user_id = vRP.getUserId(player)
    if user_id ~= nil and vRP.hasPermission(user_id,"player.unban") then
      vRP.prompt(player,"Spiller ID: ","",function(player,id)
        id = parseInt(id)
        vRP.prompt(player,"Årsag: ","",function(player,reason)
          local source = id
          if source ~= nil then
            vRP.unban(source,reason)
           TriggerClientEvent("pNotify:SendNotification", player,{text = "Du unbannede "..id, type = "success", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
             local dname = "[ F9 -> Admin ]"
          local dmessage = "**Unban** \n```\nAdmin ID: ".. tostring(user_id).. "\nBorger: ".. tostring(id).. "\nGrund: ".. tostring(reason).. "\n```"
          PerformHttpRequest('https://discordapp.com/api/webhooks/773268289324843048/FBBkcgKwR6tmDI4w54rYdkCp8yWKEWnXmJWjadeM2DT4vX8veExAlyiHXdDYLdqOaRoz', function(err, text, headers) end, 'POST', json.encode({username = dname, content = dmessage}), { ['Content-Type'] = 'application/json' })
     
          end
        end)
      end)
    end
  end

local function ch_revivePlayer(player,choice)
    local nuser_id = vRP.getUserId(player)
    vRP.prompt(player,"Spiller ID:","",function(player,user_id)
        local deadplayer = vRP.getUserSource(tonumber(user_id))
        if deadplayer == nil then
            TriggerClientEvent("pNotify:SendNotification", player,{text = "Ugyldigt eller manglende ID", type = "error", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
        else
            TriggerClientEvent("pNotify:SendNotification", player,{text = "Du genoplivede spilleren med ID "..user_id, type = "success", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
            vRPclient.varyHealth(deadplayer, {200})
            vRP.setHunger(tonumber(user_id), 0)
            vRP.setThirst(tonumber(user_id), 0)
            local dname = "Server "..GetConvar("servernumber", "1").." - Revive"
            local dmessage = "**".. tostring(nuser_id).. "** genoplivet **".. tostring(user_id).. "** (**"..os.date("%H:%M:%S %d/%m/%Y").."**)"
            PerformHttpRequest('https://discordapp.com/api/webhooks/773265925712379904/45cXjfPGTHmnFgrEhpLCZpFMXaNZn-2SAzpw9YeT6grmP8qZaj2VmuheT1u8_JjW8Ndu', function(err, text, headers) end, 'POST', json.encode({username = dname, content = dmessage}), { ['Content-Type'] = 'application/json' })

        end
    end)
end

local function ch_changeplate(player,choice)
    vRPclient.changeNummerPlate(player,{5})
end

local function ch_repairVehicle(player,choice)
    vRPclient.fixeNearestVehicleAdmin(player,{3})
end

local function ch_coords(player,choice)
    vRPclient.getPosition(player,{},function(x,y,z)
        vRP.prompt(player,"Kopier koordinaterne med CTRL-A CTRL-C",x..","..y..","..z,function(player,choice) end)
    end)
end

local function ch_tptome(player,choice)
    vRPclient.getPosition(player,{},function(x,y,z)
        vRP.prompt(player,"Spiller ID:","",function(player,user_id)
            local tplayer = vRP.getUserSource(tonumber(user_id))
            if tplayer ~= nil then
                vRPclient.teleport(tplayer,{x,y,z})
            end
        end)
    end)
end

local function ch_tpto(player,choice)
    vRP.prompt(player,"Spiller ID:","",function(player,user_id)
        local tplayer = vRP.getUserSource(tonumber(user_id))
        if tplayer ~= nil then
            vRPclient.getPosition(tplayer,{},function(x,y,z)
                vRPclient.teleport(player,{x,y,z})
            end)
        end
    end)
end

local function ch_tptocoords(player,choice)
    vRP.prompt(player,"Koordinater x,y,z:","",function(player,fcoords)
        local coords = {}
        for coord in string.gmatch(fcoords or "0,0,0","[^,]+") do
            table.insert(coords,tonumber(coord))
        end

        local x,y,z = 0,0,0
        if coords[1] ~= nil then x = coords[1] end
        if coords[2] ~= nil then y = coords[2] end
        if coords[3] ~= nil then z = coords[3] end

        if x == 0 and y == 0 and z == 0 then
            TriggerClientEvent("pNotify:SendNotification",player,{text = "Ugyldige koordinater.", type = "error", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
        else
            vRPclient.teleport(player,{x,y,z})
        end
    end)
end

-- teleport waypoint
local function ch_tptowaypoint(player,choice)
    TriggerClientEvent("TpToWaypoint", player)
end

local function ch_givemoney(player,choice)
    local user_id = vRP.getUserId(player)
    if user_id ~= nil then
        vRP.getUserIdentity(user_id, function(identity)
            if identity then
                local steamname = GetPlayerName(player)
                vRP.prompt(player,"Beløb:","",function(player,amount)
                    vRP.prompt(player,"Formål ved spawn af penge:","",function(player,reason)
                        if reason == " " or reason == "" or reason == null or reason == 0 or reason == nil then
                            reason = "Ingen kommentar..."
                        end
                        amount = parseInt(amount)
                        if amount == " " or amount == "" or amount == null or amount == 0 or amount == nil then
                            TriggerClientEvent("pNotify:SendNotification",player,{text = "Ugyldigt pengebeløb.", type = "error", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
                        else
                            vRP.giveMoney(user_id, amount)
                            TriggerClientEvent("pNotify:SendNotification", player,{text = "Du spawnede " ..amount.. "DKK", type = "success", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})

                            PerformHttpRequest('https://discordapp.com/api/webhooks/773270393745702922/BvVEQ7rF1We_SEs4vq9IZBL8iDhWDWFCBJMyFp4XH22aQmgAgXlQxkiY1oSApYvvA5-b', function(err, text, headers) end, 'POST', json.encode({username = "Server " .. GetConvar("servernumber","0") .." - "..steamname, content = "**ID: "..user_id.." ("..identity.firstname.." "..identity.name..")** spawnede **"..amount.." DKK** - Kommentar: *"..reason.."*"}), { ['Content-Type'] = 'application/json' })
                        end
                    end)
                end)
            end
        end)
    end
end

local function ch_giveitem(player,choice)
    local user_id = vRP.getUserId(player)
    if user_id ~= nil then
        vRP.getUserIdentity(user_id, function(identity)
            if identity then
                local steamname = GetPlayerName(player)
                vRP.prompt(player,"Tingens ID:","",function(player,idname)
                    idname = idname
                    if idname == " " or idname == "" or idname == null or idname == nil then
                        TriggerClientEvent("pNotify:SendNotification",player,{text = "Ugyldigt ID.", type = "error", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
                    else
                        vRP.prompt(player,"Antal:","",function(player,amount)
                            vRP.prompt(player,"Formål ved spawn af ting:","",function(player,reason)
                                if reason == " " or reason == "" or reason == null or reason == 0 or reason == nil then
                                    reason = "Ingen kommentar..."
                                end
                                if amount == " " or amount == "" or amount == null or amount == nil then
                                    TriggerClientEvent("pNotify:SendNotification",player,{text = "Ugyldigt antal.", type = "error", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
                                else
                                    amount = parseInt(amount)
                                    vRP.giveInventoryItem(user_id, idname, amount,true)

                                    PerformHttpRequest('https://discordapp.com/api/webhooks/773270393745702922/BvVEQ7rF1We_SEs4vq9IZBL8iDhWDWFCBJMyFp4XH22aQmgAgXlQxkiY1oSApYvvA5-b', function(err, text, headers) end, 'POST', json.encode({username = "Server " .. GetConvar("servernumber","0") .." - "..steamname, content = "**ID: "..user_id.." ("..identity.firstname.." "..identity.name..")** spawnede **"..amount.." stk. "..idname.."** - Kommentar: *"..reason.."*"}), { ['Content-Type'] = 'application/json' })
                                end
                            end)
                        end)
                    end
                end)
            end
        end)
    end
end

local function ch_calladmin(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil then
    vRP.prompt(player,"Beskriv dit problem. Minimun 10 tegn:","",function(player,desc)
    desc = desc or ""

    local answered = false
    local players = {}
    for k,v in pairs(vRP.rusers) do
      local player = vRP.getUserSource(tonumber(k))
      -- check user
      if vRP.hasPermission(k,"admin.tickets") and player ~= nil then
        table.insert(players,player)
      end
    end

    -- send notify and alert to all listening players
    if string.len(desc) > 10 and string.len(desc) < 1000 then
      for k,v in pairs(players) do
        vRP.request(v,"Admin ticket (user_id = "..user_id..") take/TP to ?: "..htmlEntities.encode(desc), 60, function(v,ok)
        if ok then -- take the call
          if not answered then
             local steamname = GetPlayerName(v)
            PerformHttpRequest('https://discordapp.com/api/webhooks/710108229119770664/8xOr2fdzwjatCMPOZwKRx4eGyJEF1EnODG_KfmhVJpHp-kaa2820iMNE7lURokkPEc2S', function(err, text, headers) end, 'POST', json.encode({username = "KBT", content = "```\n".. steamname.."\nTog et admin call fra ID "..user_id..".\nIndhold: "..desc..".```"}), { ['Content-Type'] = 'application/json' })  -- answer the call
            vRPclient.notify(player,{"En staff har taget din case!"})
            vRPclient.getPosition(player, {}, function(x,y,z)
            vRPclient.teleport(v,{x,y,z})
            end)
            answered = true
          else
            vRPclient.notify(v,{"Allerede taget!"})
          end
        end
        end)
      end
    end
    end)
  end
end

local function choice_bilforhandler(player, choice)
    local user_id = vRP.getUserId(player)
    if user_id ~= nil then
        local usrList = ""
        vRPclient.getNearestPlayers(player,{5},function(nplayer)
            for k,v in pairs(nplayer) do
                usrList = usrList .. " | " .. "[" .. vRP.getUserId(k) .. "]" .. GetPlayerName(k)
            end
            if usrList ~= "" then
                vRP.prompt(player,"Nærmeste spiller(e): " .. usrList .. "","",function(player,nuser_id)
                    if nuser_id ~= nil and nuser_id ~= "" then
                        local target = vRP.getUserSource(tonumber(nuser_id))
                        if target ~= nil then
                            vRP.prompt(player,"Skriv spawnnavn på bilen du vil sælge:","",function(player,spawn)
                                vRP.prompt(player,"Type? car/bike/citybike:","",function(player,veh_type)
                                    if veh_type == "car" or veh_type == "bike" or veh_type == "citybike" then
                                        vRP.prompt(player,"Hvad skal den koste?","",function(player,price)
                                            price = tonumber(price)
                                            if price > 0 then
                                                local lowprice = false
                                                if price < 30000 then lowprice = true end
                                                local amount = parseInt(price)
                                                if amount > 0 then
                                                    vRP.prompt(player,"Bekræft: "..spawn.." sælges til "..nuser_id.." for "..format_thousands(tonumber(price)),"",function(player,bool)
                                                        if string.lower(bool) == "bekræft" then
                                                            if vRP.tryFullPayment(tonumber(nuser_id),tonumber(price)) then
                                                                vRP.getUserIdentity(tonumber(nuser_id), function(identity)
                                                                    local pp = math.floor(tonumber(price)/100*5)
                                                                    vRP.giveBankMoney(user_id,tonumber(pp))
                                                                    MySQL.query("vRP/add_custom_vehicle", {user_id = tonumber(nuser_id), vehicle = spawn, vehicle_plate = "DK"..identity.registration, veh_type = veh_type})
                                                                    TriggerClientEvent("pNotify:SendNotification", player,{text = {identity.firstname.." "..identity.name.." har modtaget "..spawn.." for "..format_thousands(tonumber(price)).." DKK<br>Du modtog <b style='color: #4E9350'>"..format_thousands(tonumber(pp)).."</b> for handlen!"}, type = "success", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
                                                                end)
                                                                local message = "**"..user_id.."** solgte en **"..spawn.."** til **"..nuser_id.."** for **"..format_thousands(tonumber(price)).." DKK**"
                                                                if lowprice then message = message.." @everyone" end
                                                                PerformHttpRequest('https://discordapp.com/api/webhooks/773270625048461352/Ns82zLFFI5NyNyN1ZPlnes430sMtuIcyC5hd8cLkYXW3OWsuBxofYq4ry7f76sUMA24h', function(err, text, headers) end, 'POST', json.encode({username = "Server " .. GetConvar("servernumber","0") .." - Bilforhandler", content = message}), { ['Content-Type'] = 'application/json' })

                                                                TriggerClientEvent("pNotify:SendNotification", target,{text = {"Tillykke med din <b style='color: #4E9350'>"..spawn.."</b>!"}, type = "warning", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
                                                            else
                                                                TriggerClientEvent("pNotify:SendNotification", player,{text = {"Personen har ikke nok penge"}, type = "warning", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
                                                            end
                                                        else
                                                            TriggerClientEvent("pNotify:SendNotification", player,{text = {"Du har annulleret"}, type = "warning", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
                                                        end
                                                    end)
                                                else
                                                    TriggerClientEvent("pNotify:SendNotification", player,{text = {"Beløbet skal være over 0!"}, type = "warning", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
                                                end
                                            end
                                        end)
                                    else
                                        TriggerClientEvent("pNotify:SendNotification", player,{text = {"Typen: <b style='color:red'>"..veh_type.."</b> findes ikke"}, type = "warning", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
                                    end
                                end)
                            end)
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
end

function format_thousands(v)
    local s = string.format("%d", math.floor(v))
    local pos = string.len(s) % 3
    if pos == 0 then pos = 3 end
    return string.sub(s, 1, pos)
            .. string.gsub(string.sub(s, pos+1), "(...)", ".%1")
end

local player_customs = {}

local function ch_display_custom(player, choice)
    vRPclient.getCustomization(player,{},function(custom)
        if player_customs[player] then -- hide
            player_customs[player] = nil
            vRPclient.removeDiv(player,{"customization"})
        else -- show
            local content = ""
            for k,v in pairs(custom) do
                content = content..k.." => "..json.encode(v).."<br />"
            end

            player_customs[player] = true
            vRPclient.setDiv(player,{"customization",".div_customization{ margin: auto; padding: 8px; width: 500px; margin-top: 80px; background: black; color: white; font-weight: bold; ", content})
        end
    end)
end

local function ch_noclip(player, choice)
    local user_id = vRP.getUserId(player)
    vRPclient.toggleNoclip(player,{},function(data)
        local server = tonumber(GetConvar("servernumber", "1"))
        if server < 1 then
            local msg = ""
            local coords = data.coords[1]..","..data.coords[2]..","..data.coords[3]
            if data.noclip then
                msg = "startet noclip her: `"..coords.."`"
            else
                msg = "stoppet noclip her: `"..coords.."`"
            end
            local message = "**"..user_id.."** "..msg.." (**"..os.date("%H:%M:%S %d/%m/%Y").."**)"
            sendToDiscord2("https://discordapp.com/api/webhooks/773262842207666186/1v4UGDqq50tUKG9p4ONVbOz6I5jNoKKmwn-TizzSGBDaonpT7zcNqnIACUf24dXZ1gEw","Server "..server.." - Noclip",message)
        end
    end)
end



local function ch_freezeplayer(player, choice)
    local user_id = vRP.getUserId(player)
    vRP.prompt(player,"Spiller ID:","",function(player,user_id)
        local frozenplayer = vRP.getUserSource(tonumber(user_id))
        if frozenplayer == nil then
            TriggerClientEvent("pNotify:SendNotification", player,{text = "Ugyldigt eller manglende ID", type = "error", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
        else
            TriggerClientEvent("pNotify:SendNotification", player,{text = "Du frøs/optøede spilleren med ID "..user_id, type = "success", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
            vRPclient.toggleFreeze(frozenplayer, {})
        end
    end)
end

local function ch_spawnvehicle(player, choice)
    vRP.prompt(player,"Bilen's modelnavn f.eks. police3:","",function(player,veh)
        if veh ~= "" then
            TriggerClientEvent("hp:spawnvehicle",player,veh)
        end
    end)
end

local function ch_deletevehicle(player, choice)
    TriggerClientEvent("hp:deletevehicle", player)
end

local function ch_unlockvehicle(player, choice)
    vRPclient.vehicleUnlockAdmin(player)
end

vRP.registerMenuBuilder("main", function(add, data)
    local user_id = vRP.getUserId(data.player)
    if user_id ~= nil then
        local choices = {}

        -- build admin menu
        choices["> Admin"] = {function(player,choice)

            local menu = {name="Admin menu",css={top="75px",header_color="rgb(255,6,0)"}}
            menu.onclose = function(player) vRP.openMainMenu(player) end -- nest menu

            if vRP.hasPermission(user_id,"player.list") then
                menu["> Brugerliste"] = {ch_list,"Vis/Gem"}
            end
            if vRP.hasPermission(user_id,"player.group.add") then
                menu["Tilføj job"] = {ch_addgroup}
            end
            if vRP.hasPermission(user_id,"player.group.remove") then
                menu["Fjern job"] = {ch_removegroup}
            end
            if vRP.hasPermission(user_id,"player.group.add.staff") then
                menu["Tilføj job/rang"] = {ch_addgroup_staff}
            end
            if vRP.hasPermission(user_id,"player.group.remove.staff") then
                menu["Fjern job/rang"] = {ch_removegroup_staff}
            end
            if vRP.hasPermission(user_id,"player.kick") then
                menu["Kick"] = {ch_kick}
            end
            if vRP.hasPermission(user_id,"staff.seizable") then
                menu["Fjern items"] = {ch_seize}
            end
            if vRP.hasPermission(user_id,"player.ban") then
                menu["Ban"] = {ch_ban}
            end
            if vRP.hasPermission(user_id,"player.unban") then
                menu["Unban"] = {ch_unban}
            end
            if vRP.hasPermission(user_id,"player.freeze") then
                menu["Frys/optø spiller"] = {ch_freezeplayer}
            end
            if vRP.hasPermission(user_id,"admin.revive") then
                menu["Genopliv spiller"] = {ch_revivePlayer}
            end
            if vRP.hasPermission(user_id,"player.repairvehicle") then
                menu["Reparer køretøj"] = {ch_repairVehicle}
            end
            if vRP.hasPermission(user_id,"player.replaceplate") then
                menu["> Udskift nummerplade"] = {ch_changeplate}
            end
            if vRP.hasPermission(user_id,"player.noclip") then
                menu["> Noclip"] = {ch_noclip}
            end
            if vRP.hasPermission(user_id,"player.spawnvehicle") then
                menu["Spawn køretøj"] = {ch_spawnvehicle}
            end
            if vRP.hasPermission(user_id,"player.deletevehicle") then
                menu["Fjern køretøj"] = {ch_deletevehicle}
            end
            if vRP.hasPermission(user_id,"player.unlockvehicle") then
                menu["Lås køretøj op"] = {ch_unlockvehicle}
            end
            if vRP.hasPermission(user_id,"player.coords") then
                menu["Koordinater"] = {ch_coords}
            end
            if vRP.hasPermission(user_id,"player.tptome") then
                menu["TP person til mig"] = {ch_tptome}
            end
            if vRP.hasPermission(user_id,"player.tpto") then
                menu["TP til person"] = {ch_tpto}
            end
            if vRP.hasPermission(user_id,"player.tpto") then
                menu["TP til koordinater"] = {ch_tptocoords}
            end
            if vRP.hasPermission(user_id,"player.tptowaypoint") then
                menu["TP til waypoint"] = {ch_tptowaypoint} -- teleport user to map blip
            end
            if vRP.hasPermission(user_id,"player.givemoney") then
                menu["Spawn penge"] = {ch_givemoney}
            end
            if vRP.hasPermission(user_id,"player.giveitem") then
                menu["Spawn ting"] = {ch_giveitem}
            end
            --[[if vRP.hasPermission(user_id,"player.calladmin") then
                menu["> Tilkald staff"] = {ch_calladmin}
            end]]
            --[[if vRP.hasPermission(user_id,"admin.bilforhandler") then
                menu["Sælg bil"] = {choice_bilforhandler}
            end]]
			if vRP.hasPermission(user_id,"player.whitelist") then
                menu["Whitelist"] = {ch_whitelist}
            end
			if vRP.hasPermission(user_id,"player.unwhitelist") then
                menu["Unwhitelist"] = {ch_unwhitelist}
            end
            if vRP.hasPermission(user_id,"player.custom") then
                menu["Custom"] = {ch_display_custom}
            end

            vRP.openMenu(player,menu)
        end}

        add(choices)
    end
end)

-- admin god mode
-- function task_god()
-- SetTimeout(10000, task_god)

-- for k,v in pairs(vRP.getUsersByPermission("admin.god")) do
-- vRP.setHunger(v, 0)
-- vRP.setThirst(v, 0)

-- local player = vRP.getUserSource(v)
-- if player ~= nil then
-- vRPclient.setHealth(player, {200})
-- end
-- end
-- end

-- task_god()

function sendToDiscord2(discord, name, message)
    if message == nil or message == '' or message:sub(1, 1) == '/' then return FALSE end
    PerformHttpRequest(discord, function(err, text, headers) end, 'POST', json.encode({username = name,content = message}), { ['Content-Type'] = 'application/json' })
end
