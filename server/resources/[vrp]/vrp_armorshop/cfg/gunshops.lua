
local cfg = {}
-- list of weapons for sale
-- for the native name, see https://wiki.fivem.net/wiki/Weapons (not all of them will work, look at client/player_state.lua for the real weapon list)
-- create groups like for the garage config
-- [native_weapon_name] = {display_name,body_price,ammo_price,description}
-- ammo_price can be < 1, total price will be rounded

-- _config: blipid, blipcolor, permissions (optional, only users with the permission will have access to the shop)

cfg.gunshop_types = {
    ["Våbenbutik"] = {
        _config = {blipid=110,blipcolor=1},
		["ARMOR"] = {"Skudsikker vest",50000,0,""},
        ["WEAPON_FLASHLIGHT"] = {"Lommelygte",5000,0,""},
        ["WEAPON_KNIFE"] = {"Kniv",12500,0,""},
        ["WEAPON_BAT"] = {"Baseballbat",7500,0,""},
        ["WEAPON_CROWBAR"] = {"Brækjern",5250,0,""},
        ["WEAPON_KNUCKLE"] = {"Knojern",10250,0,""},
        ["WEAPON_WRENCH"] = {"Svensknøgle",9750,0,""},
        ["WEAPON_SWITCHBLADE"] = {"Foldekniv",15250,0,""},
        ["WEAPON_GOLFCLUB"] = {"Golfkølle",7250,0,""},
        ["WEAPON_HAMMER"] = {"Hammer",3250,0,""}
	},

    ["Våbenhandler"] = {
        _config = {blipid=0,blipcolor=0, permissions = {"våben.loadshop"}},
		["WEAPON_SNSPISTOL"] = {"SNS Pistol",1500000,0,""},
        ["WEAPON_PISTOL"] = {"Pistol",2000000,0,""},
        ["WEAPON_HEAVYPISTOL"] = {"Heavy Pistol",2500000,0,""},
        ["WEAPON_PISTOL50"] = {"Deagle",3500000,0,""}
	},

	["EMS"] = {
        _config = {blipid=0,blipcolor=0, permissions = {"ems.loadshop"}},
		["ARMOR"] = {"Skudsikker vest",0,0,""},
        ["WEAPON_FLASHLIGHT"] = {"Lommelygte",0,0,""}
	},

	["PolitiStationen"] = {
		_config = {blipid=0,blipcolor=0, permissions = {"police.loadshop"}},
		["ARMOR"] = {"Skudsikker vest",0,0,""},
		["WEAPON_COMBATPISTOL"] = {"Tjenestepistol",0,0,""},
		["WEAPON_STUNGUN"] = {"Taser",0,0,""},
		["WEAPON_CARBINERIFLE"] = {"Carbine Riffel",0,0,""},
		["WEAPON_FLASHLIGHT"] = {"Lommelygte",0,0,""},
		["WEAPON_NIGHTSTICK"] = {"Politi stav", 0,0,""},
		["WEAPON_SMG"] = {"SMG",0,0,""},
		["WEAPON_FIREEXTINGUISHER"] = {"Brandslukker",0,0,""},
		["WEAPON_SNIPERRIFLE"] = {"Sniper",0,0,""}
	}
}
-- list of gunshops positions

cfg.gunshops = {
	--[[{"Våbenbutik", 1692.41, 3758.22, 34.7053,false},
	{"Våbenbutik", 252.696, -48.2487, 69.941,false},
	{"Våbenbutik", 844.299, -1033.26, 28.1949,false},
	{"Våbenbutik", -331.624, 6082.46, 31.4548,false},
	{"Våbenbutik", -664.147, -935.119, 21.8292,false},
	{"Våbenbutik", -1305.4624, -392.4640, 36.6957,false},
	{"Våbenbutik", -1119.4880,2697.0866,18.554,false},
	{"Våbenbutik", 2569.62, 294.453, 108.735,false},
	{"Våbenbutik", -3172.6037,1085.7481,20.8387,false},
	{"Våbenbutik", 21.70, -1107.41, 29.79,false},
	{"Våbenbutik", 810.15, -2156.88, 29.61,false},
	{"Våbenhandler", 457.8073425293,-1498.1424560547,28.188159942627,false},
	{"PolitiStationen", 459.21792602539,-979.71276855469,30.68957901001,true},
	{"PolitiStationen", -437.46026611328,5988.5776367188,31.616196060181,true},
	{"PolitiStationen", 1853.7529296875,3689.8930664063,34.186670684814,true},
	{"PolitiStationen", -1111.8388671875,-816.72729492188,-46.270099639893,true},
	{"EMS", 307.68814086914,-601.68664550781,43.283981323242,true},]]
}

return cfg