local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
ASclient = Tunnel.getInterface("vrp_armorshop","vrp_armorshop")



vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","fg-inventory")

local cfg_inventory = module("cfg/inventory")

local chest = {}
local activeCooldowns = {}
local market_types = Config.market_types
local markets = Config.markets

local items = Config.items
for id,item in ipairs(items) do
  vRP.defInventoryItem({
    item.name,
    item.label,
    item.description,
    item.choices,
    item.weight
  })
end

RegisterServerEvent("fg-inventory:dropItem")
AddEventHandler("fg-inventory:dropItem", function(data, amount, anim)
	if anim == nil then anim = true end
	local user_id = vRP.getUserId({source})
	local amount = parseInt(amount)
	local dato = os.date("**%d-%m-%Y** kl. **%X**")
    if vRP.tryGetInventoryItem({user_id, data.name, amount, false}) and anim then
		vRPclient.playAnim(source, {true, {{"pickup_object", "pickup_low", 1}}, false})
		TriggerEvent("atlas-itemdrop:drop", source, data.name, amount)
		PerformHttpRequest('https://discordapp.com/api/webhooks/712300308142751755/bwknKuvFbDg1irqoNGTGGNjD6zsUtbmdEhcXcLMoj1PG0imJ526jDyX3YRxiTAzw173u', function(err, text, headers) end, 'POST', json.encode({username = "Server " .. GetConvar("servernumber","0"), content = "**ID: "..user_id.." ** smed med **"..amount.." stk. "..data.name.."** - ("..dato..")"}), { ['Content-Type'] = 'application/json' })       
    end
end)

RegisterServerEvent("fg-inventory:giveItem")
AddEventHandler(
"fg-inventory:giveItem",
    function(data, amount)
        local user_id = vRP.getUserId({source})
        local player = vRP.getUserSource({user_id})
        if user_id ~= nil then
            vRPclient.getNearestPlayer(
                player,
                {10},
                function(nplayer)
                    if nplayer ~= nil then
                        local nuser_id = vRP.getUserId({nplayer})
                        if nuser_id ~= nil then
                            local new_weight =
                                vRP.getInventoryWeight({nuser_id}) + vRP.getItemWeight({data.name}) * amount
                            if new_weight <= vRP.getInventoryMaxWeight({nuser_id}) then
                                if vRP.tryGetInventoryItem({user_id, data.name, amount, false}) then
									vRP.giveInventoryItem({nuser_id, data.name, amount, true})
									PerformHttpRequest('https://discordapp.com/api/webhooks/712300308142751755/bwknKuvFbDg1irqoNGTGGNjD6zsUtbmdEhcXcLMoj1PG0imJ526jDyX3YRxiTAzw173u', function(err, text, headers) end, 'POST', json.encode({username = "Inventory player til player", content = "```ID: "..user_id.." gav "..amount.." x "..data.name.." til ID: "..nuser_id.."```"}), { ['Content-Type'] = 'application/json' })

                                    vRPclient.playAnim(player, {true, {{"mp_common", "givetake1_a", 1}}, false})
                                    vRPclient.playAnim(nplayer, {true, {{"mp_common", "givetake2_a", 1}}, false})
                                else
								--    vRPclient.notify(player, {"Der skete en fejl, prøv igen."})
								TriggerClientEvent("pNotify:SendNotification", player,{text = "Der skete en fejl, prøv igen.", type = "error", queue = "global", timeout = 3000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
                                end
                            else
							   -- vRPclient.notify(player, {"Du har ikke nok plads."})
							   TriggerClientEvent("pNotify:SendNotification", player,{text = "Du har ikke nok plads.", type = "error", queue = "global", timeout = 3000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
                            end
                        else
						   -- vRPclient.notify(player, {"Der er ingen spiller tæt på."})
						   TriggerClientEvent("pNotify:SendNotification", player,{text = "Der er ingen spiller tæt på.", type = "error", queue = "global", timeout = 3000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
                        end
                    else
					   -- vRPclient.notify(player, {"Der er ingen spiller tæt på."})
					   TriggerClientEvent("pNotify:SendNotification", player,{text = "Der er ingen spiller tæt på.", type = "error", queue = "global", timeout = 3000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
                    end
                end
            )
        end
    end
)


RegisterServerEvent('fg-inventory:server:useItem')
AddEventHandler('fg-inventory:server:useItem', function(idname, amount)
	local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})
    if user_id ~= nil then
        if idname.usabletype == 'drink' then
            if setCooldown(user_id,0) then
				if vRP.tryGetInventoryItem({user_id, idname.name, amount, false}) and idname.usable then
                    play_drink()
					Citizen.Wait(0)
					count = 0
					repeat
					  vRP.varyThirst({user_id, idname.choice})
					  count = count + 1
					until count == amount
                end
            else
			  --  vRPclient.notify(source,{"Vent!","warn"})
			  TriggerClientEvent("pNotify:SendNotification", player,{text = "Vent!", type = "warn", queue = "global", timeout = 2500, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
            end
        elseif idname.usabletype == 'eat' then
            if setCooldown(user_id,0) then
                if vRP.tryGetInventoryItem({user_id, idname.name, amount, false}) and idname.usable then
                    play_eat()
					Citizen.Wait(0)
					count = 0
					repeat
					  vRP.varyHunger({user_id, idname.choice})
					  count = count + 1
					until count == amount
                end
            else
			  --  vRPclient.notify(source,{"Vent!","warn"})
			  TriggerClientEvent("pNotify:SendNotification", player,{text = "Vent!", type = "warn", queue = "global", timeout = 2500, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
			end
		elseif idname.usabletype == 'energi' then
            if setCooldown(user_id,0) then
				if vRP.tryGetInventoryItem({user_id, idname.name, amount, false}) and idname.usable then
					TriggerClientEvent('kaz_stoffer:stamina', player)
			TriggerClientEvent("pNotify:SendNotification", player,{text = "Du føler dig hyperaktiv", type = "success", queue = "10", timeout = 2000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
                    play_drink()
					Citizen.Wait(0)
					count = 0
					repeat
					  vRP.varyThirst({user_id, idname.choice})
					  count = count + 1
					until count == amount
                end
            else
			  --  vRPclient.notify(source,{"Vent!","warn"})
			  TriggerClientEvent("pNotify:SendNotification", player,{text = "Vent!", type = "warn", queue = "global", timeout = 2500, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
			end
		elseif idname.usabletype == 'armor' then
            if setCooldown(user_id,0) then
				if vRP.tryGetInventoryItem({user_id, idname.name, amount, false}) and idname.usable then
					ASclient.setArmour(player,{100,true})
					Citizen.Wait(0)
					count = 0
					repeat
					  vRP.varyThirst({user_id, idname.choice})
					  count = count + 1
					until count == amount
                end
            else
			  --  vRPclient.notify(source,{"Vent!","warn"})
			  TriggerClientEvent("pNotify:SendNotification", player,{text = "Vent!", type = "warn", queue = "global", timeout = 2500, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
			end
		elseif idname.usabletype == 'alkohol' then
            if setCooldown(user_id,0) then
				if vRP.tryGetInventoryItem({user_id, idname.name, amount, false}) and idname.usable then
					TriggerClientEvent('kaz_alkohol:drik', player)
                    play_drink()
					Citizen.Wait(0)
					count = 0
					repeat
					  vRP.varyThirst({user_id, idname.choice})
					  count = count + 1
					until count == amount
                end
            else
			  --  vRPclient.notify(source,{"Vent!","warn"})
			  TriggerClientEvent("pNotify:SendNotification", player,{text = "Vent!", type = "warn", queue = "global", timeout = 2500, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
			end
		elseif idname.usabletype == 'lockpick' then
            if setCooldown(user_id,0) then
				if vRP.tryGetInventoryItem({user_id, idname.name, amount, false}) and idname.usable then
					TriggerClientEvent('99kr-burglary:Lockpick', player)
					Citizen.Wait(0)
					count = 0
					repeat
					  vRP.varyThirst({user_id, idname.choice})
					  count = count + 1
					until count == amount
                end
            else
			  --  vRPclient.notify(source,{"Vent!","warn"})
			  TriggerClientEvent("pNotify:SendNotification", player,{text = "Vent!", type = "warn", queue = "global", timeout = 2500, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
			end
		elseif idname.usabletype == 'repairkitadv' then
            if setCooldown(user_id,0) then
				if vRP.tryGetInventoryItem({user_id, idname.name, amount, false}) and idname.usable then
					TriggerClientEvent('ac-repairadv:onUse', player)
					Citizen.Wait(0)
					count = 0
					repeat
					  vRP.varyThirst({user_id, idname.choice})
					  count = count + 1
					until count == amount
                end
            else
			  --  vRPclient.notify(source,{"Vent!","warn"})
			  TriggerClientEvent("pNotify:SendNotification", player,{text = "Vent!", type = "warn", queue = "global", timeout = 2500, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
			end
		elseif idname.usabletype == 'repairkit' then
            if setCooldown(user_id,0) then
				if vRP.tryGetInventoryItem({user_id, idname.name, amount, false}) and idname.usable then
					TriggerClientEvent('ac-repair:onUse', player)
					Citizen.Wait(0)
					count = 0
					repeat
					  vRP.varyThirst({user_id, idname.choice})
					  count = count + 1
					until count == amount
                end
            else
			  --  vRPclient.notify(source,{"Vent!","warn"})
			  TriggerClientEvent("pNotify:SendNotification", player,{text = "Vent!", type = "warn", queue = "global", timeout = 2500, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
            end
        elseif idname.usabletype == 'client' then
            if setCooldown(user_id,0) then
				if vRP.tryGetInventoryItem({user_id, idname.name, amount, false}) and idname.usable then
					PerformHttpRequest('https://discordapp.com/api/webhooks/712300308142751755/bwknKuvFbDg1irqoNGTGGNjD6zsUtbmdEhcXcLMoj1PG0imJ526jDyX3YRxiTAzw173u', function(err, text, headers) end, 'POST', json.encode({username = "Inventory", content = "```ID: "..user_id.." brugte "..amount.." x "..idname.name.."```"}), { ['Content-Type'] = 'application/json' })
					count = 0
					repeat
					  TriggerClientEvent("fg-inventory:"..idname.name, source)
					  count = count + 1
					until count == amount
                end
            else
				--vRPclient.notify(source,{"Vent!","warn"})
				TriggerClientEvent("pNotify:SendNotification", player,{text = "Vent!", type = "warn", queue = "global", timeout = 2500, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
			end
		elseif idname.usabletype == 'vinkelsliber' then
            if setCooldown(user_id,0) then
				if vRP.tryGetInventoryItem({user_id, idname.name, amount, false}) and idname.usable then
					TriggerClientEvent("vrp_barricade:fjern",player)
					Citizen.Wait(0)
					count = 0
					repeat
					  vRP.varyThirst({user_id, idname.choice})
					  count = count + 1
					until count == amount
                end
            else
			  --  vRPclient.notify(source,{"Vent!","warn"})
			  TriggerClientEvent("pNotify:SendNotification", player,{text = "Vent!", type = "warn", queue = "global", timeout = 2500, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
			end
		elseif idname.usabletype == 'planke' then
            if setCooldown(user_id,0) then
				if vRP.tryGetInventoryItem({user_id, idname.name, amount, false}) and idname.usable then
					TriggerClientEvent("vrp_barricade:start",player)
					Citizen.Wait(0)
					count = 0
					repeat
					  vRP.varyThirst({user_id, idname.choice})
					  count = count + 1
					until count == amount
                end
            else
			  --  vRPclient.notify(source,{"Vent!","warn"})
			  TriggerClientEvent("pNotify:SendNotification", player,{text = "Vent!", type = "warn", queue = "global", timeout = 2500, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
            end
		elseif idname.usabletype == 'boombox' then
            if setCooldown(user_id,0) then
				if idname.usable then
					count = 0
					repeat
					TriggerClientEvent('kaz_boombox:place_boombox', player)
					  count = count + 1
					until count == amount
                end
            else
				--vRPclient.notify(source,{"Vent!","warn"})
				TriggerClientEvent("pNotify:SendNotification", player,{text = "Vent!", type = "warn", queue = "global", timeout = 2500, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
			end
		elseif idname.usabletype == 'extendedsns2' then
            if setCooldown(user_id,0) then
                if vRP.tryGetInventoryItem({user_id, idname.name, amount, false}) and idname.usable then
                    TriggerClientEvent('olsen_attachments:extendedsns2', player)
            --TriggerClientEvent("pNotify:SendNotification", player,{text = "Du føler dig hyperaktiv", type = "success", queue = "10", timeout = 2000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
                    Citizen.Wait(0)
                    count = 0
                    repeat
                      vRP.varyThirst({user_id, idname.choice})
                      count = count + 1
                    until count == amount
                end
            else
              --  vRPclient.notify(source,{"Vent!","warn"})
              TriggerClientEvent("pNotify:SendNotification", player,{text = "Vent!", type = "warn", queue = "global", timeout = 2500, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
			end
		elseif idname.usabletype == 'extendedpistol' then
            if setCooldown(user_id,0) then
                if vRP.tryGetInventoryItem({user_id, idname.name, amount, false}) and idname.usable then
                    TriggerClientEvent('olsen_attachments:extendedpistol', player)
            --TriggerClientEvent("pNotify:SendNotification", player,{text = "Du føler dig hyperaktiv", type = "success", queue = "10", timeout = 2000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
                    Citizen.Wait(0)
                    count = 0
                    repeat
                      vRP.varyThirst({user_id, idname.choice})
                      count = count + 1
                    until count == amount
                end
            else
              --  vRPclient.notify(source,{"Vent!","warn"})
              TriggerClientEvent("pNotify:SendNotification", player,{text = "Vent!", type = "warn", queue = "global", timeout = 2500, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
			end
		elseif idname.usabletype == 'supppistol' then
            if setCooldown(user_id,0) then
                if vRP.tryGetInventoryItem({user_id, idname.name, amount, false}) and idname.usable then
                    TriggerClientEvent('olsen_attachments:supppistol', player)
            --TriggerClientEvent("pNotify:SendNotification", player,{text = "Du føler dig hyperaktiv", type = "success", queue = "10", timeout = 2000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
                    Citizen.Wait(0)
                    count = 0
                    repeat
                      vRP.varyThirst({user_id, idname.choice})
                      count = count + 1
                    until count == amount
                end
            else
              --  vRPclient.notify(source,{"Vent!","warn"})
              TriggerClientEvent("pNotify:SendNotification", player,{text = "Vent!", type = "warn", queue = "global", timeout = 2500, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
			end
		elseif idname.usabletype == 'skinpistol' then
            if setCooldown(user_id,0) then
                if vRP.tryGetInventoryItem({user_id, idname.name, amount, false}) and idname.usable then
                    TriggerClientEvent('olsen_attachments:skinpistol', player)
            --TriggerClientEvent("pNotify:SendNotification", player,{text = "Du føler dig hyperaktiv", type = "success", queue = "10", timeout = 2000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
                    Citizen.Wait(0)
                    count = 0
                    repeat
                      vRP.varyThirst({user_id, idname.choice})
                      count = count + 1
                    until count == amount
                end
            else
              --  vRPclient.notify(source,{"Vent!","warn"})
              TriggerClientEvent("pNotify:SendNotification", player,{text = "Vent!", type = "warn", queue = "global", timeout = 2500, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
			end
		elseif idname.usabletype == 'extendedheavypistol' then
            if setCooldown(user_id,0) then
                if vRP.tryGetInventoryItem({user_id, idname.name, amount, false}) and idname.usable then
                    TriggerClientEvent('olsen_attachments:extendedheavypistol', player)
            --TriggerClientEvent("pNotify:SendNotification", player,{text = "Du føler dig hyperaktiv", type = "success", queue = "10", timeout = 2000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
                    Citizen.Wait(0)
                    count = 0
                    repeat
                      vRP.varyThirst({user_id, idname.choice})
                      count = count + 1
                    until count == amount
                end
            else
              --  vRPclient.notify(source,{"Vent!","warn"})
              TriggerClientEvent("pNotify:SendNotification", player,{text = "Vent!", type = "warn", queue = "global", timeout = 2500, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
			end
		elseif idname.usabletype == 'suppheavypistol' then
            if setCooldown(user_id,0) then
                if vRP.tryGetInventoryItem({user_id, idname.name, amount, false}) and idname.usable then
                    TriggerClientEvent('olsen_attachments:suppheavypistol', player)
            --TriggerClientEvent("pNotify:SendNotification", player,{text = "Du føler dig hyperaktiv", type = "success", queue = "10", timeout = 2000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
                    Citizen.Wait(0)
                    count = 0
                    repeat
                      vRP.varyThirst({user_id, idname.choice})
                      count = count + 1
                    until count == amount
                end
            else
              --  vRPclient.notify(source,{"Vent!","warn"})
              TriggerClientEvent("pNotify:SendNotification", player,{text = "Vent!", type = "warn", queue = "global", timeout = 2500, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
			end
		elseif idname.usabletype == 'extended50pistol' then
            if setCooldown(user_id,0) then
                if vRP.tryGetInventoryItem({user_id, idname.name, amount, false}) and idname.usable then
                    TriggerClientEvent('olsen_attachments:extended50pistol', player)
            --TriggerClientEvent("pNotify:SendNotification", player,{text = "Du føler dig hyperaktiv", type = "success", queue = "10", timeout = 2000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
                    Citizen.Wait(0)
                    count = 0
                    repeat
                      vRP.varyThirst({user_id, idname.choice})
                      count = count + 1
                    until count == amount
                end
            else
              --  vRPclient.notify(source,{"Vent!","warn"})
              TriggerClientEvent("pNotify:SendNotification", player,{text = "Vent!", type = "warn", queue = "global", timeout = 2500, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
			end
		elseif idname.usabletype == 'supp50pistol' then
            if setCooldown(user_id,0) then
                if vRP.tryGetInventoryItem({user_id, idname.name, amount, false}) and idname.usable then
                    TriggerClientEvent('olsen_attachments:supp50pistol', player)
            --TriggerClientEvent("pNotify:SendNotification", player,{text = "Du føler dig hyperaktiv", type = "success", queue = "10", timeout = 2000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
                    Citizen.Wait(0)
                    count = 0
                    repeat
                      vRP.varyThirst({user_id, idname.choice})
                      count = count + 1
                    until count == amount
                end
            else
              --  vRPclient.notify(source,{"Vent!","warn"})
              TriggerClientEvent("pNotify:SendNotification", player,{text = "Vent!", type = "warn", queue = "global", timeout = 2500, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
            end
		elseif idname.usabletype == 'kokain' then
			if setCooldown(user_id,0) then
				if vRP.tryGetInventoryItem({user_id, idname.name, amount, false}) and idname.usable then
				if idname.usable then
					count = 0
					repeat
					    vRPclient.playMovement(player,{"MOVE_M@DRUNK@SLIGHTLYDRUNK",true,true,false,false})
                        vRPclient.playScreenEffect(player, {"DMT_flight", 60})
					  count = count + 1
					until count == amount
                end
            else
				--vRPclient.notify(source,{"Vent!","warn"})
				TriggerClientEvent("pNotify:SendNotification", player,{text = "Vent!", type = "warn", queue = "global", timeout = 2500, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
			end
		elseif idname.usabletype == 'lockpick' then
			if setCooldown(user_id,0) then
				local xPlayer = vRP.getUserId({source})
				if vRP.tryGetInventoryItem({user_id, idname.name, amount, false}) and idname.usable then
				if idname.usable then
					count = 0
					repeat
						TriggerClientEvent("hjalte:open", xPlayer)
					  count = count + 1
					until count == amount
                end
            else
				--vRPclient.notify(source,{"Vent!","warn"})
				TriggerClientEvent("pNotify:SendNotification", player,{text = "Vent!", type = "warn", queue = "global", timeout = 2500, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
			end
		elseif idname.usabletype == 'lsd' then
			if setCooldown(user_id,0) then
				if vRP.tryGetInventoryItem({user_id, idname.name, amount, false}) and idname.usable then
				if idname.usable then
					count = 0
					repeat
						vRPclient.playMovement(player,{"MOVE_M@DRUNK@SLIGHTLYDRUNK",true,true,false,false})
						vRPclient.playScreenEffect(player, {"DMT_flight", 120})
					  count = count + 1
					until count == amount
                end
            else
				--vRPclient.notify(source,{"Vent!","warn"})
				TriggerClientEvent("pNotify:SendNotification", player,{text = "Vent!", type = "warn", queue = "global", timeout = 2500, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
			end
        elseif idname.usabletype == 'client2' then
			if setCooldown(user_id,0) then
				count = 0
				repeat
				  TriggerClientEvent("fg-inventory:"..idname.name, source)
				  count = count + 1
				until count == amount
            else
			   -- vRPclient.notify(source,{"Vent!","warn"})
			   TriggerClientEvent("pNotify:SendNotification", player,{text = "Vent!", type = "warn", queue = "global", timeout = 2500, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
            end
        end
	end
end
end
end
end)


function play_eat()
    local seq = {
      {"mp_player_inteat@burger", "mp_player_int_eat_burger_enter",1},
      {"mp_player_inteat@burger", "mp_player_int_eat_burger",1},
      {"mp_player_inteat@burger", "mp_player_int_eat_burger_fp",1},
      {"mp_player_inteat@burger", "mp_player_int_eat_exit_burger",1}
    }
  
    vRPclient.playAnim(source,{true,seq,false})
  end
  
  function play_drink()
    local seq = {
      {"mp_player_intdrink","intro_bottle",1},
      {"mp_player_intdrink","loop_bottle",1},
      {"mp_player_intdrink","outro_bottle",1}
    }
  
    vRPclient.playAnim(source,{true,seq,false})
end

function play_smoke()
    local seq = {
        {"mp_player_int_uppersmoke","mp_player_int_smoke_enter",1},
        {"mp_player_int_uppersmoke","mp_player_int_smoke",3},
        {"mp_player_int_uppersmoke","mp_player_int_smoke_exit",1}
    }

    vRPclient.playAnim(source,{true,seq,false})
end


vrpPV.RegisterServerCallback("fg-inventory:getShopItems", function(source, cb, shoptype)
	itemShopList = {}
	for gtype,mitems in pairs(market_types) do
		for id, item in ipairs(Config.items) do
			for k,v in pairs(mitems) do
				if shoptype == gtype then
					if v.name == item.name then
						table.insert(itemShopList, {
							type = "item_standard",
							name = item.name,
							label = item.label,
							price = v.price,
							desc = item.description,
							weight = item.weight,
							count = 99999999
						})
					end
				end
			end
		end
	end
	cb(itemShopList)
end)

vrpPV.RegisterServerCallback("fg-inventory:getAdminItems", function(source, cb, shoptype)
	itemAdminList = {}
	for id, item in ipairs(Config.items) do
		if shoptype == "admin" then
			table.insert(itemAdminList, {
				type = "item_standard",
				name = item.name,
				label = item.label,
				desc = item.description,
				weight = item.weight,
				count = 99999999
			})
		end
	end
	cb(itemAdminList)
end)

--RegisterCommand("admin", function(source, args, rawCommand)
--	local user_id = vRP.getUserId({source})
--	if user_id ~= nil then
--		TriggerClientEvent("fg-inventory:openAdminInventory", source)
--	end
--end)

RegisterNetEvent("fg-inventory:SellItemToPlayer")
AddEventHandler("fg-inventory:SellItemToPlayer",function(source, type, item, count)
    local _source = source
    local user_id = vRP.getUserId({_source})

    if type == "item_standard" then
        local list = itemShopList
        for i = 1, #list, 1 do
			if list[i].name == item then
				local totalPrice = count * list[i].price
				local weight = vRP.getInventoryWeight({user_id}) + vRP.getItemWeight({item}) * count
				local maxWeight = vRP.getInventoryMaxWeight({user_id})
				if weight <= maxWeight then
					if vRP.tryFullPayment({user_id, totalPrice}) then
                        vRP.giveInventoryItem({user_id,item,count})
					else
					   -- vRPclient.notify(user_id,{"Du har ikke nok penge.", "warn"})
					   TriggerClientEvent("pNotify:SendNotification", player,{text = "Du har ikke nok penge.", type = "error", queue = "global", timeout = 2500, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
					end
				else
				--	vRPclient.notify(user_id,{"Du har ikke nok plads.","warn"})
				TriggerClientEvent("pNotify:SendNotification", player,{text = "Du har ikke nok plads.", type = "error", queue = "global", timeout = 2500, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
				end
            end
		end
	end
end)

local function build_client_market_markers(source)
	for k,v in pairs(markets) do
		local gtype,x,y,z = table.unpack(v)
		local group = market_types[gtype]
		local gcfg = group._config
		vRPclient.addBlip(source,{x,y,z,gcfg.blipid,gcfg.blipcolor,gtype})
		vRPclient.addMarker(source,{x,y,z-0.87,0.7,0.7,0.5,gcfg.r,gcfg.g,gcfg.b,125,150})
	end
end

AddEventHandler("vRP:playerSpawn",function(user_id,source,first_spawn)
	if first_spawn then
		build_client_market_markers(source)
	end
end)


RegisterServerEvent("fg-inventory:TakeFromPlayer")
AddEventHandler("fg-inventory:TakeFromPlayer", function(target, type, itemName, itemCount)
	local user_id = vRP.getUserId({source})
	local targetXPlayer = vRP.getUserId({target})

	if type == "item_standard" then
		local weight = vRP.getInventoryWeight({user_id}) + vRP.getItemWeight({itemName}) * itemCount
		local maxWeight = vRP.getInventoryMaxWeight({user_id})
		if weight <= maxWeight then
			if vRP.tryGetInventoryItem({targetXPlayer, itemName, itemCount, false}) then
				vRP.giveInventoryItem({user_id,itemName,itemCount})
				PerformHttpRequest('https://discordapp.com/api/webhooks/712300308142751755/bwknKuvFbDg1irqoNGTGGNjD6zsUtbmdEhcXcLMoj1PG0imJ526jDyX3YRxiTAzw173u', function(err, text, headers) end, 'POST', json.encode({username = "Inventory player til player", content = "```ID: "..user_id.." tog "..itemCount.." x "..itemName.." fra ID: "..targetXPlayer.."```"}), { ['Content-Type'] = 'application/json' })
			end
		else
			TriggerClientEvent("pNotify:SendNotification", player,{text = "Du har ikke nok plads.", type = "error", queue = "global", timeout = 2500, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
		end
	end
end)

RegisterServerEvent("fg-inventory:PutIntoPlayer")
AddEventHandler("fg-inventory:PutIntoPlayer", function(target, type, itemName, itemCount)
	local user_id = vRP.getUserId({source})
	local targetXPlayer = vRP.getUserId({target})
	local weight = vRP.getInventoryWeight({targetXPlayer}) + vRP.getItemWeight({itemName}) * itemCount
	local maxWeight = vRP.getInventoryMaxWeight({targetXPlayer})
	if type == "item_standard" then
		if itemCount > 0 then
			if weight <= maxWeight then
				vRP.tryGetInventoryItem({user_id, itemName, itemCount, false})
				vRP.giveInventoryItem({targetXPlayer,itemName,itemCount})
				PerformHttpRequest('https://discordapp.com/api/webhooks/712300308142751755/bwknKuvFbDg1irqoNGTGGNjD6zsUtbmdEhcXcLMoj1PG0imJ526jDyX3YRxiTAzw173u', function(err, text, headers) end, 'POST', json.encode({username = "Inventory player til player", content = "```ID: "..user_id.." lagde "..itemCount.." x "..itemName.." til ID: "..targetXPlayer.."```"}), { ['Content-Type'] = 'application/json' })
				
			end
		end
	end
end)

RegisterServerEvent("fg-inventory:adminGiveItem")
AddEventHandler("fg-inventory:adminGiveItem", function(type, itemName, itemCount)
	local user_id = vRP.getUserId({source})

	if type == "item_standard" then
		if itemCount > 0 then
			vRP.giveInventoryItem({user_id,itemName,itemCount})
		end
	end
end)

vrpPV.RegisterServerCallback('fg-inventory:getItem', function(source, cb, idname)
	local user_id = vRP.getUserId({source})
	cb(vRP.getInventoryItemAmount({user_id,idname}))
end)

vrpPV.RegisterServerCallback('fg-inventory:havePerm', function(source, cb, perm)
	local user_id = vRP.getUserId({source})
	cb(vRP.hasPermission({user_id,perm or {}}))
end)

RegisterServerEvent("fg-inventory:PutIntoTrunk")
AddEventHandler("fg-inventory:PutIntoTrunk", function(type, itemName, amount)
	local user_id = vRP.getUserId({source})
	vRPclient.getNearestOwnedVehicle(source,{10},function(ok,vtype,name)
		local chestname = "chest:u"..user_id.."veh_"..string.lower(name)
		vRP.getSData({chestname, function(cdata)
			chest.items = json.decode(cdata) or {}
			local citem = chest.items[itemName]
			local weight = vRP.computeItemsWeight({chest.items}) + vRP.getItemWeight({itemName}) * amount
			local maxWeight = cfg_inventory.vehicle_chest_weights[string.lower(name)] or cfg_inventory.default_vehicle_chest_weight
			if type == "item_standard" then
				if weight <= maxWeight then
					if vRP.tryGetInventoryItem({user_id,itemName,amount,false}) then
						if citem ~= nil then
							citem.amount = citem.amount+amount
						else -- create item entry
							chest.items[itemName] = {amount=amount}
						end
						vRP.setSData({chestname, json.encode(chest.items)})
						PerformHttpRequest('https://discordapp.com/api/webhooks/712300308142751755/bwknKuvFbDg1irqoNGTGGNjD6zsUtbmdEhcXcLMoj1PG0imJ526jDyX3YRxiTAzw173u', function(err, text, headers) end, 'POST', json.encode({username = "Inventory borger", content = "```ID: "..user_id.." lagde "..amount.. " x " ..itemName.." fra sin "..chestname.."```"}), { ['Content-Type'] = 'application/json' })
					end
				else
					--vRPclient.notify(user_id,{"Du har ikke nok plads.","warn"})
					TriggerClientEvent("pNotify:SendNotification", player,{text = "Du har ikke nok plads.", type = "error", queue = "global", timeout = 2500, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
				end
			end
		end})
	end)
end)

RegisterServerEvent("fg-inventory:TakeFromTrunk")
AddEventHandler("fg-inventory:TakeFromTrunk", function(type, itemName, itemCount)
	local user_id = vRP.getUserId({source})

	if type == "item_standard" then
		local weight = vRP.getInventoryWeight({user_id}) + vRP.getItemWeight({itemName}) * itemCount
		local maxWeight = vRP.getInventoryMaxWeight({user_id})
		if weight <= maxWeight then
			if itemCount > 0 then
				tryGetTrunkInventoryItem(itemName,itemCount)
				PerformHttpRequest('https://discordapp.com/api/webhooks/712300308142751755/bwknKuvFbDg1irqoNGTGGNjD6zsUtbmdEhcXcLMoj1PG0imJ526jDyX3YRxiTAzw173u', function(err, text, headers) end, 'POST', json.encode({username = "Inventory borger", content = "```ID: "..user_id.." tog "..itemCount.. " x " ..itemName.." fra sin bil```"}), { ['Content-Type'] = 'application/json' })
			end
		else
			--vRPclient.notify(user_id,{"Du har ikke nok plads.","warn"})
			TriggerClientEvent("pNotify:SendNotification", player,{text = "Du har ikke nok plads.", type = "error", queue = "global", timeout = 2500, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
		end
	end
end)

--[[function giveTrunkInventoryItem(idname,amount)
	local user_id = vRP.getUserId({source})
	vRPclient.getNearestOwnedVehicle(user_id,{4},function(ok,vtype,name)
		local chestname = "chest:u"..user_id.."veh_"..string.lower(name)
		vRP.getSData({chestname, function(cdata)
			chest.items = json.decode(cdata) or {}
			local citem = chest.items[idname]
			if citem ~= nil then
				citem.amount = citem.amount+amount
            else -- create item entry
				chest.items[idname] = {amount=amount}
			end
			vRP.setSData({chestname, json.encode(chest.items)})
		end})
	end)
end]]


function tryGetTrunkInventoryItem(idname,amount)
	local user_id = vRP.getUserId({source})
	vRPclient.getNearestOwnedVehicle(source,{4},function(ok,vtype,name)
		local chestname = "chest:u"..user_id.."veh_"..string.lower(name)
		vRP.getSData({chestname, function(cdata)
			chest.items = json.decode(cdata) or {}
			local citem = chest.items[idname]
			if citem and amount > 0 then
				if citem and citem.amount >= amount then
					citem.amount = citem.amount-amount

					if citem.amount <= 0 then
					  chest.items[idname] = nil -- remove item entry
					end

					vRP.setSData({chestname, json.encode(chest.items)})
					vRP.giveInventoryItem({user_id, idname,amount, false})
					return true
				end
			end
		end})
	end)
	return false
end

function getTrunkInventoryWeight(chestname)
	vRP.getSData({chestname, function(cdata)
		local chest = json.decode(cdata) or {}
		return vRP.computeItemsWeight({chest})
	end})
end

function setCooldown(source, cooldownTime)
	if not activeCooldowns[source] then
	  activeCooldowns[source] = true
	
	  SetTimeout(cooldownTime, function()
		activeCooldowns[source] = nil
	  end)
  
	  return true
	end
  
	return false
  end

RegisterCommand("røv", function(source, args, rawCommand)
	local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})
    if user_id ~= nil then
    	vRPclient.getNearestPlayer(player, {10}, function(nplayer)
        	if nplayer ~= nil then
            	local nuser_id = vRP.getUserId({nplayer})
				if nuser_id ~= nil then
					vRPclient.isInComa(nplayer,{}, function(in_coma)
						vRPclient.isHandcuffed(nplayer,{}, function(handcuffed)
							if in_coma or handcuffed then
								TriggerClientEvent("fg-inventory:openPlayerInventory", source, nplayer)
							end
						end)
					end)
				end
			else
				--vRPclient.notify(source,{"Der er ingen spiller i nærheden.","warn"})
				TriggerClientEvent("pNotify:SendNotification", player,{text = "Der er ingen spiller i nærheden.", type = "error", queue = "global", timeout = 2500, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
			end
		end)
	end
end)

RegisterCommand("visiter", function(source, args, rawCommand)
	local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})
    if user_id ~= nil then
    	vRPclient.getNearestPlayer(player, {10}, function(nplayer)
        	if nplayer ~= nil then
            	local nuser_id = vRP.getUserId({nplayer})
				if nuser_id ~= nil then
					vRPclient.isInComa(nplayer,{}, function(in_coma)
						vRPclient.isHandcuffed(nplayer,{}, function(handcuffed)
							if in_coma or handcuffed then
								TriggerClientEvent("fg-inventory:openPlayerInventory", source, nplayer)
							end
						end)
					end)
				end
			else
				--vRPclient.notify(source,{"Der er ingen spiller i nærheden.","warn"})
				TriggerClientEvent("pNotify:SendNotification", player,{text = "Der er ingen spiller i nærheden.", type = "error", queue = "global", timeout = 2500, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
			end
		end)
	end
end)

--[[RegisterCommand("trunk", function(source, args, rawCommand)
	local user_id = vRP.getUserId({source})
	if user_id ~= nil then
		vRPclient.getNearestOwnedVehicle(user_id,{3.5},function(ok,vtype,name)
			if ok then
				TriggerClientEvent("fg-inventory:openTrunkInventory", source)
			end
		end)	
	end
end)]]
