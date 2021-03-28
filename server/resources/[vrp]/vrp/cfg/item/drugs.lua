local items = {}

local function play_drink(player)
	local seq = {
		{"mp_player_intdrink","intro_bottle",1},
		{"mp_player_intdrink","loop_bottle",1},
		{"mp_player_intdrink","outro_bottle",1}
	}

	vRPclient.playAnim(player,{true,seq,false})
end

local pills_choices = {}
pills_choices["> Indtag"] = {function(player,choice)
	local user_id = vRP.getUserId(player)
	if user_id ~= nil then
		if vRP.tryGetInventoryItem(user_id,"pills",1) then
			vRPclient.varyHealth(player,{20})
			vRPclient.notify(player,{"~g~ Indtager piller"})
			play_drink(player)
			vRP.closeMenu(player)
		end
	end
end}

local function play_smoke(player)
	local seq2 = {
		{"mp_player_int_uppersmoke","mp_player_int_smoke_enter",1},
		{"mp_player_int_uppersmoke","mp_player_int_smoke",1},
		{"mp_player_int_uppersmoke","mp_player_int_smoke",1},
		{"mp_player_int_uppersmoke","mp_player_int_smoke_exit",1}
	}

	vRPclient.playAnim(player,{true,seq2,false})
end

local smoke_choices = {}
smoke_choices["> Ryg"] = {function(player,choice)
	local user_id = vRP.getUserId(player)
	if user_id ~= nil then
		if vRP.tryGetInventoryItem(user_id,"joint",1) then
			vRP.varyHunger(user_id,(20))
			vRPclient.notify(player,{"~g~ Ryger joint"})
			vRPclient.playMovement(player,{"MOVE_M@DRUNK@SLIGHTLYDRUNK",true,true,false,false})
			vRPclient.playScreenEffect(player, {"DMT_flight", 60})

			play_smoke(player)
			vRP.closeMenu(player)
		end
	end
end}

local function play_smell(player)
	local seq3 = {
		{"mp_player_intdrink","intro_bottle",1},
		{"mp_player_intdrink","loop_bottle",1},
		{"mp_player_intdrink","outro_bottle",1}
	}

	vRPclient.playAnim(player,{true,seq3,false})
end

local alkohol = {}
alkohol["> Drik"] = {function(player,choice)
	local user_id = vRP.getUserId(player)
	if user_id ~= nil then
			TriggerClientEvent('kaz_alkohol:drik', player)
			play_drink(player)
			vRP.closeMenu(player)
	end
end}

local boombox = {}
boombox["> Brug"] = {function(player,choice)
local user_id = vRP.getUserId(player)
	if user_id ~= nil then
			TriggerClientEvent('kaz_boombox:place_boombox', player)
		vRP.closeMenu(player)
	end
end}

local smell_choices = {}
smell_choices["> Snif"] = {function(player,choice)
	local user_id = vRP.getUserId(player)
	if user_id ~= nil then
		if vRP.tryGetInventoryItem(user_id,"kokain",1) then
			vRP.varyThirst(user_id,(20))
			vRPclient.notify(player,{"~g~ Snif kokain"})
			vRPclient.playMovement(player,{"MOVE_M@DRUNK@SLIGHTLYDRUNK",true,true,false,false})
			vRPclient.playScreenEffect(player, {"DMT_flight", 60})
			play_smell(player)
			vRP.closeMenu(player)
		end
	end
end}

local function play_lsd(player)
	local seq4 = {
		{"mp_player_intdrink","intro_bottle",1},
		{"mp_player_intdrink","loop_bottle",1},
		{"mp_player_intdrink","outro_bottle",1}
	}

	vRPclient.playAnim(player,{true,seq4,false})
end

local lsd_choices = {}
lsd_choices["> Tag"] = {function(player,choice)
	local user_id = vRP.getUserId(player)
	if user_id ~= nil then
		if vRP.tryGetInventoryItem(user_id,"lsd",1) then
			vRP.varyThirst(user_id,(20))
			vRPclient.notify(player,{"~g~ Tag lsd"})
			vRPclient.playMovement(player,{"MOVE_M@DRUNK@SLIGHTLYDRUNK",true,true,false,false})
			vRPclient.playScreenEffect(player, {"DMT_flight", 120})
			play_lsd(player)
			vRP.closeMenu(player)
		end
	end
end}

local energidrik = {}
energidrik["> Drik"] = {function(player,choice)
	local user_id = vRP.getUserId(player)
	if user_id ~= nil then
		if vRP.tryGetInventoryItem(user_id,"redgull",1,false) then
			vRP.varyThirst(user_id,(-30))
			TriggerClientEvent('kaz_stoffer:stamina', player)
			TriggerClientEvent("pNotify:SendNotification", player,{text = "Du føler dig hyperaktiv", type = "success", queue = "10", timeout = 2000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
			play_drink(player)
			vRP.closeMenu(player)
		end
	end
end}

local skunk_udpak = {}
skunk_udpak["> Udpak"] = {function(player,choice)
	local user_id = vRP.getUserId(player)
	if user_id ~= nil then
		if vRP.tryGetInventoryItem(user_id,"klump10",1) then
			vRP.giveInventoryItem(user_id, "skunkklump", 10,true)
			vRP.closeMenu(player)
		end
	end
end}

local joint_making = {}
joint_making["> Lav Joint"] = {function(player,choice)
	local user_id = vRP.getUserId(player)
	if user_id ~= nil then
		if vRP.tryGetInventoryItem(user_id,"ristet",1) and vRP.tryGetInventoryItem(user_id,"jointpapir",1) and vRP.tryGetInventoryItem(user_id,"skunkklump",1) then
			vRP.giveInventoryItem(user_id, "joint", 1,true)
			vRP.closeMenu(player)
		end
	end
end}

local smoke2_choices = {}
smoke2_choices["> Ryg"] = {function(player,choice)
	local user_id = vRP.getUserId(player)
	if user_id ~= nil then
		if vRP.tryGetInventoryItem(user_id,"cigaret",1) then
			vRP.varyHunger(user_id,(20))
			TriggerClientEvent("pNotify:SetQueueMax", player, 9, 2)
			TriggerClientEvent("pNotify:SendNotification", player,{text = "Ryger en Smøg", type = "success", queue = "9", timeout = 2000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
			TriggerClientEvent('kaz_stoffer:ryg2', player) 
			vRP.closeMenu(player)
		end
	end
end}

local smoke3_choices = {}
smoke3_choices["> Rist"] = {function(player,choice)
	local user_id = vRP.getUserId(player)
	if user_id ~= nil then
		if vRP.tryGetInventoryItem(user_id,"cigaret",1) then
			vRP.giveInventoryItem(user_id, "ristet", 1,true)
			vRP.closeMenu(player)
		end
	end
end}

items["cigaret"] = {"Cigaret","En vanedannende cigaret",function(args) return smoke2_choices end,0.01}
items["pills"] = {"Smertestillende","En Smertestillende pille",function(args) return pills_choices end,0.1}
items["joint"] = {"Joint","En dejlig ryger",function(args) return smoke_choices end,0.10}
items["kokain"] = {"Kokain","Lidt kokain",function(args) return smell_choices end,0.25}
items["lsd"] = {"LSD","Lidt lsd",function(args) return lsd_choices end,0.01}
items["lighter"] = {"Lighter","Bruges til at riste smøger",function(args) return smoke3_choices end,0.01}

items["redgull"] = {"Redbull","Energi drik",function(args) return energidrik end,0.10}
items["boombox"] = {"BoomBox","En styk musikafspiller!",function(args) return boombox end,10.00}
items["ol"] = {"Øl","En kold øl",function(args) return alkohol end,0.10}
items["margarita"] = {"Margarita","Time to party",function(args) return alkohol end,0.10}
items["white"] = {"White Russian","Time to party",function(args) return alkohol end,0.10}
items["pina"] = {"Pina Colada","Time to party",function(args) return alkohol end,0.10}
items["mojito"] = {"Mojito","Time to party",function(args) return alkohol end,0.10}
items["strawberry"] = {"Strawberry Daiquiri","Time to party",function(args) return alkohol end,0.10}
items["teqshot"] = {"Tequila shot","Time to party",function(args) return alkohol end,0.10}
items["whisky"] = {"Whisky & cola","Time to party",function(args) return alkohol end,0.10}
items["vin"] = {"Rød Vin","Time to party",function(args) return alkohol end,0.10}
items["jackd"] = {"Jack D","Time to party",function(args) return alkohol end,0.10}
items["moet"] = {"Möet","Time to party",function(args) return alkohol end,0.10}
items["belvedere"] = {"Belvedere","Time to party",function(args) return alkohol end,0.10}
items["klump10"] = {"Pose med skunk (10g)","Sælges eller åbnes.",function(args) return skunk_udpak end,0.10}
items["skunkklump"] = {"Klump af 1g Skunk","Bruges til joints.",function(args) return joint_making end,0.10}
items["joint"] = {"Joint","1g mixed.", function(args) return smoke_choices end,0.10}
items["romogcola"] = {"Rom og Cola","Time to party",function(args) return alkohol end,0.10}
items["ginogtonic"] = {"Gin og Tonic","Time to party",function(args) return alkohol end,0.10}
items["tequilla"] = {"Tequilla Sunrise","Time to party",function(args) return alkohol end,0.10}
items["sexbeach"] = {"Sex on the beach","Time to party",function(args) return alkohol end,0.10}
items["gin"] = {"Gin","Time to party",function(args) return alkohol end,0.10}
items["vodkajuice"] = {"Vodka Juice","Time to party",function(args) return alkohol end,0.10}
items["kinder"] = {"Kinderæg Shot","Time to party",function(args) return alkohol end,0.10}

return items