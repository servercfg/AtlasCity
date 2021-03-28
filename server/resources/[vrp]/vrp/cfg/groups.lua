local cfg = {}

-- define each group with a set of permissions
-- _config property:
--- title (optional): group display name
--- gtype (optional): used to have only one group with the same gtype per player (example: a job gtype to only have one job)
--- onspawn (optional): function(player) (called when the player spawn with the group)
--- onjoin (optional): function(player) (called when the player join the group)
--- onleave (optional): function(player) (called when the player leave the group)
--- (you have direct access to vRP and vRPclient, the tunnel to client, in the config callbacks)

cfg.groups = {
  ["ledelse"] = {
    _config = {
		onjoin = function(player) 
			TriggerClientEvent("pNotify:SendNotification", player,{text = "Ledelse rank tildelt.", type = "success", queue = "global", timeout = 5000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
		end,
		onleave = function(player) 
			TriggerClientEvent("pNotify:SendNotification", player,{text = "Ledelse rank frataget.", type = "success", queue = "global", timeout = 5000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
		end,
		onspawn = function(player) end
	},
		"blacklisted.weapons",
		"blacklisted.vehicles",
		"player.group.add.staff",
		"player.group.remove.staff",
		"player.givemoney",
		"player.whitelist",
		"atlas.admin",
		"anticheese.bypass",
		"admin.bilforhandler",
        "player.unwhitelist",
		"player.noclip",
		"player.dmv",
		"player.giveitem",
		"player.custom",
		"player.ban",
		"vehicle.repair",
		"player.kick",
		"player.unban",
		"staff.seizable",
		"fire.start",
		"Anticheat.Bypass",
		"police.seize.items",
		"police.seize.weapons",
		"player.coords",
		"player.coordsnoheading",
		"admin.besked",
		"player.unlockvehicle",
		"player.repairvehicle",
		"player.deletevehicle",
		"staff.gun",
		"player.spawnvehicle",
		"admin.easy_unjail",
		"admin.spikes",
		"player.tptowaypoint",
		"player.tptome",
		"player.tpto",
		"player.tptocoords",
		"player.freeze",
		"staff.chat",
		"admin.tickets",
		"player.list",
		"admin.godmode",
		"admin.revive",
		"ledelse.fix",
		"staff.revive",
		"Mekaniker.dv",
		"staff.chattitle",
		"garderobe.adgang",
		"farm.access",
  },

    ["Admin"] = {
    _config = {
		onjoin = function(player) 
			TriggerClientEvent("pNotify:SendNotification", player,{text = "Admin rank tildelt.", type = "success", queue = "global", timeout = 5000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
		end,
		onleave = function(player) 
			TriggerClientEvent("pNotify:SendNotification", player,{text = "Admin rank frataget.", type = "success", queue = "global", timeout = 5000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
		end,
		onspawn = function(player) end
    },
		"player.deletevehicle",
		"player.ban",
        "player.unban",
		"player.group.add.staff",
		"player.group.remove.staff",
		"Anticheat.Bypass",
		"admin.besked",
		"player.coords",
		"admin.tickets",
		"player.whitelist",
		"player.custom",
		"anticheese.bypass",
		"player.unwhitelist",
		"staff.gun",
		"player.unlockvehicle",
		"admin.announce",
		"player.kick",
		"police.menu",
		"staff.seizable",
		"player.repairvehicle",
		"police.seize.weapons",
		"police.seize.items",
		"police.easy_cuff",
		"player.list",
		"player.tptome",
		"player.tptocoords",
		"player.tpto",
		"player.freeze",
		"staff.chat",
		"player.noclip",
		"admin.revive",
		"ledelse.fix",
		"staff.revive",
		"Mekaniker.dv",
		"staff.chattitle"
  },
  ["Moderator"] = {
    _config = {
		onjoin = function(player) 
			TriggerClientEvent("pNotify:SendNotification", player,{text = "Staff rank tildelt.", type = "success", queue = "global", timeout = 5000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
		end,
		onleave = function(player) 
			TriggerClientEvent("pNotify:SendNotification", player,{text = "Staff rank frataget.", type = "success", queue = "global", timeout = 5000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
		end,
		onspawn = function(player) end
    },
		"player.deletevehicle",
		"player.ban",
		"admin.besked",
		"player.coords",
		"admin.tickets",
		"player.ban",
		"staff.gun",
		"anticheese.bypass",
		"player.unlockvehicle",
		"admin.announce",
		"player.kick",
		"Anticheat.Bypass",
		"police.menu",
		"staff.seizable",
		"player.repairvehicle",
		"police.seize.weapons",
		"police.seize.items",
		"police.easy_cuff",
		"player.list",
		"player.tptome",
		"player.tptocoords",
		"player.tpto",
		"player.freeze",
		"staff.chat",
		"player.noclip",
		"admin.revive",
		"ledelse.fix",
		"staff.revive",
		"Mekaniker.dv",
		"staff.chattitle"
  },
  ["Supporter"] = {
    _config = {
		onjoin = function(player) 
			TriggerClientEvent("pNotify:SendNotification", player,{text = "Supporter rank tildelt.", type = "success", queue = "global", timeout = 5000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
		end,
		onleave = function(player) 
			TriggerClientEvent("pNotify:SendNotification", player,{text = "Supporter rank frataget.", type = "success", queue = "global", timeout = 5000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
		end,
		onspawn = function(player) end
    },
		"admin.tickets",
		"player.deletevehicle",
		"admin.besked",
		"admin.revive",
		"player.coords",
		"admin.announce",
		"player.kick",
		"Anticheat.Bypass",
		"anticheese.bypass",
		"player.list",
		"player.tptome",
		"player.tptocoords",
		"player.unlockvehicle",
		"player.tpto",
		"player.freeze",
		"staff.chat",
		"player.noclip",
		"staff.chattitle"
  },
    ["P-Supporter"] = {
    _config = {
		onjoin = function(player) 
			TriggerClientEvent("pNotify:SendNotification", player,{text = "Prøve Supporter rank tildelt.", type = "success", queue = "global", timeout = 5000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
		end,
		onleave = function(player) 
			TriggerClientEvent("pNotify:SendNotification", player,{text = "Prøve Supporter rank frataget.", type = "success", queue = "global", timeout = 5000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
		end,
		onspawn = function(player) end
    },
		"admin.tickets",
		"player.deletevehicle",
		"admin.besked",
		"admin.revive",
		"player.coords",
		"anticheese.bypass",
		"player.list",
		"player.tptome",
		"player.tptocoords",
		"player.tpto",
		"Anticheat.Bypass",
		"staff.chat",
		"player.noclip",
		"staff.chattitle"
  },
  ["jailed"] = {
	"admin.god"
},
["antonio"] = {
	"antonio.key"
},
["vin"] = {
	"vin.key"
},
["Jan"] = {
	"test.key",
	"diablos.key"
},
["MO"] = {
	"test123.key",
},
["Narko"] = {
	"diablos.key"
},
["Event Team"] = {
	"player.deletevehicle",
	"player.spawnvehicle"
},
    ["Whitelist"] = {
   "player.whitelist",
   "player.unwhitelist"
  },
  ["EMS"] = {
	"ems.whitelisted",
	},
	
	["Politi"] = {
	"cop.whitelisted",
	},
  -- the group user is auto added to all logged players
  ["user"] = {
    "player.phone",
    "player.calladmin",
    "player.coords",
    "police.askid",
	"police.store_weapons",
	"police.noway",
	"police.drag",
	"police.getoutveh",
	"police.putinveh",
    "user.askid",
    "police.seizable", -- can be seized
	--"user.firstaid",
	"player.player_menu",
	"player.check",
    "player.store_armor",
    "player.store_weapons",
    "player.fix_haircut",
    "player.loot",
	"player.store_money",
	"player.strip",
	"player.drag",
	"player.putoutveh",
	"player.putinveh",
	"garderobe.adgang"
  },
  ["vip"] = {
	_config = {
		onjoin = function(player) 
			TriggerClientEvent("pNotify:SendNotification", player,{text = "VIP rang tildelt.", type = "success", queue = "global", timeout = 5000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
		end,
		onleave = function(player) 
			TriggerClientEvent("pNotify:SendNotification", player,{text = "VIP rang frataget.", type = "success", queue = "global", timeout = 5000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
		end,
		onspawn = function(player) end
	},
	"hb.vip",
	"ramlov.vip"
},
["vip+"] = {
	_config = {
		onjoin = function(player) 
			TriggerClientEvent("pNotify:SendNotification", player,{text = "VIP+ rang tildelt.", type = "success", queue = "global", timeout = 5000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
		end,
		onleave = function(player) 
			TriggerClientEvent("pNotify:SendNotification", player,{text = "VIP+ rang frataget.", type = "success", queue = "global", timeout = 5000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
		end,
		onspawn = function(player) end
	},
	"hb.vip",
	"ramlov.vipplus"
},
["vip++"] = {
	_config = {
		onjoin = function(player) 
			TriggerClientEvent("pNotify:SendNotification", player,{text = "VIP++ rang tildelt.", type = "success", queue = "global", timeout = 5000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
		end,
		onleave = function(player) 
			TriggerClientEvent("pNotify:SendNotification", player,{text = "VIP++ rang frataget.", type = "success", queue = "global", timeout = 5000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
		end,
		onspawn = function(player) end
	},
	"hb.vip",
	"ramlov.vipplusplus"
},
["pussycat"] = {
	_config = {
		onjoin = function(player) 
			TriggerClientEvent("pNotify:SendNotification", player,{text = "Pussycat rang tildelt.", type = "success", queue = "global", timeout = 5000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
		end,
		onleave = function(player) 
			TriggerClientEvent("pNotify:SendNotification", player,{text = "Pussycat rang frataget.", type = "success", queue = "global", timeout = 5000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
		end,
		onspawn = function(player) end
	},
	"hb.vip",
	"pussycat.vip"
},

  ["EMS-Job"] = {
					_config = {
				gtype = "job",
				onjoin = function(player)
						TriggerClientEvent("pNotify:SendNotification", player,{text = "Du er nu EMS.", type = "success", queue = "global", timeout = 5000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
				end,
				onspawn = function(player) end,
				onleave = function(player) vRPclient.stopMission(player) end
		},
		"emergency.revive",
		"emergency.heal",
		"emergency.shop",
		"emergency.service",
		"emergency.cloakroom",
		"ems.loadshop",
		"emergency.vehicle",
		"emergency.market",
		"emergency2.market",
		"emergency.medic",
		"emergency.announce",
		"emergency.key",
		"emergency.menu",
		"emergency.putinveh",
		"emergency.getoutveh",
		"emergency.drag",
		"ems.paycheck",
		"ems.key",
		"radio.access",
		"-police.store_weapons",
		"emergency.paycheck",
		"doctor.cloakroom",
        "admin.deleteveh",
        "emergency.besked",
        "police.easy_cuff",
        "emergency.garage",
	"ems.whitelisted",
	"emergency.taser",
	"ems.loadshop"
},

["Falck Vagt"] = {
	_config = {
gtype = "job",
onjoin = function(player)
		TriggerClientEvent("pNotify:SendNotification", player,{text = "Du er nu Falck Vagt.", type = "success", queue = "global", timeout = 5000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
end,
onspawn = function(player) end,
onleave = function(player) vRPclient.stopMission(player) end
},
"ems.key",
"emsvagt.paycheck",
"falckvagt.garage",
"radio.access",
"tackle.pc",
},

  ["Politi-Job"] = {
				_config = {
				gtype = "job",
				onjoin = function(player)
						TriggerClientEvent("pNotify:SendNotification", player,{text = "Du er nu Politi.", type = "success", queue = "global", timeout = 5000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
				end,
				onspawn = function(player) end,
				onleave = function(player) vRPclient.stopMission(player) end
		},
	"cop.whitelisted",
	"police.noway",
	"ems.doors",
	"police.weapons",
	"police.menu",
	"tackle.pc",
	"ems.key",
	"police.heist",
		"police.carsearch",
		"panik.service",
		"police.cloakroom",
		"police.pc",
		"police.bodyarmor",
		"police.handcuff",
		"ramlovdv.admin",
		"police.putinveh",
		"police.getoutveh",
		"police.check",
		"robbery.police",
		"radio.access",
		"police.service",
		"police.wanted",
		"police.seize.weapons",
		"police.seize.items",
		"police.license",
		"police.easy_jail",
		"police.fine",
		"police.announce",
		"-police.store_weapons",
		"-police.seizable", -- negative permission, police can't seize itself, even if another group add the permission
		"police.vehicle",
		"police.weapons",
		"politi.paycheck",
		"police.drag",
		"police.robbery",
		"police.robbery1",
		"cop.keycard",
		"ems.keycard",
		"emergency.revive",
		"emergency.market",
		"police.menu_interaction",
        "politi.ledelse.doors",
        "politi.onduty",
        "admin.deleteveh",
        "bank.police",
        "police.easy_cuff",
        "police.easy_unjail",
        "police.jail",
        "police.store_weapons",
        "police.store_money",
        "holdup.police",
        "police.askid",
        "police.besked",
        "police.easy_fine",
        "police.garage",
        "policeheli.garage",
        "police.loadshop",
		"police.spikes",
		"radio.police",
},

["PET"] = {
	_config = {
	gtype = "job",
	onjoin = function(player)
			TriggerClientEvent("pNotify:SendNotification", player,{text = "Du er nu PET.", type = "success", queue = "global", timeout = 5000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
	end,
	onspawn = function(player) end,
	onleave = function(player) vRPclient.stopMission(player) end
},
"cop.whitelisted",
"police.noway",
"ems.doors",
"police.weapons",
"police.menu",
"tackle.pc",
"ems.key",
"police.carsearch",
"panik.service",
"police.cloakroom",
"police.pc",
"police.bodyarmor",
"police.handcuff",
"ramlovdv.admin",
"police.putinveh",
"police.getoutveh",
"pet.garage",
"police.check",
"robbery.police",
"pet.pc",
"radio.access",
"police.service",
"police.wanted",
"police.seize.weapons",
"police.seize.items",
"police.license",
"police.easy_jail",
"police.fine",
"police.announce",
"-police.store_weapons",
"-police.seizable", -- negative permission, police can't seize itself, even if another group add the permission
"police.vehicle",
"police.weapons",
"politi.paycheck",
"police.drag",
"cop.keycard",
"ems.keycard",
"emergency.revive",
"emergency.market",
"police.menu_interaction",
"politi.ledelse.doors",
"pet.keycard",
"admin.deleteveh",
"police.easy_cuff",
"police.easy_unjail",
"police.jail",
"police.store_weapons",
"police.store_money",
"police.askid",
"police.besked",
"police.easy_fine",
"police.garage",
"policeheli.garage",
"police.loadshop",
"police.spikes",
"radio.police",
},

["Journalist"] = {
	_config = {
		gtype = "job",
		onjoin = function(player) 
			TriggerClientEvent("pNotify:SendNotification", player,{text = "Du er nu Journalist.", type = "success", queue = "global", timeout = 5000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
		end,
		onspawn = function(player) end,
		onleave = function(player) vRPclient.stopMission(player) end
	},
	"journalist.announce",
	"journalist.service",
	"journalist.vehicle",
	"weazel.camera",
	"weazel.mic",
	"journalist.paycheck"
},
	["Mekaniker"] = {
		_config = {
		gtype = "job",
		onjoin = function(player)
			TriggerClientEvent("pNotify:SendNotification", player,{text = "Du er nu Mekaniker.", type = "success", queue = "global", timeout = 5000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
		end,
		onspawn = function(player) end,
		onleave = function(player) vRPclient.stopMission(player) end
		},
		"mekaniker.paycheck",
		"mekaniker.duty",
		"radio.access",
		"mechanic.whitelisted",
		"vehicle.repair",
		"mekaniker.adgang",
		"player.deletevehicle",
		"repair.vehicle",
		"vehicle.replace",
		"repair.service",
		"repair.loadshop",
		"repair.besked",
		"repair.menu"
	},
	["Autohjørnet"] = {
		_config = {
		gtype = "job",
		onjoin = function(player)
			TriggerClientEvent("pNotify:SendNotification", player,{text = "Du arbejder nu for Autohjørnet.", type = "success", queue = "global", timeout = 5000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
		end,
		onspawn = function(player) end,
		onleave = function(player) vRPclient.stopMission(player) end
		},
		"mekaniker.paycheck",
		"mekaniker.duty",
		"radio.access",
		"mechanic.whitelisted",
		"vehicle.repair",
		"mekaniker.adgang",
		"repair.vehicle",
		"player.deletevehicle",
		"vehicle.replace",
		"repair.service",
		"auto.garage",
		"repair.loadshop",
		"repair.besked",
		"repair.menu"
	},
	["Stripklub Arbejder"] = {
		_config = {
		gtype = "job",
		onjoin = function(player)
			TriggerClientEvent("pNotify:SendNotification", player,{text = "Du er nu Stripklub Arbejder.", type = "success", queue = "global", timeout = 5000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
		end,
		onspawn = function(player) end,
		onleave = function(player) vRPclient.stopMission(player) end
		},
		"strip.paycheck",
		"strip.keycard"
	},
	["Vagt"] = {
		_config = {
		gtype = "job",
		onjoin = function(player)
			TriggerClientEvent("pNotify:SendNotification", player,{text = "Du er nu Vagt for stripklubben.", type = "success", queue = "global", timeout = 5000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
		end,
		onspawn = function(player) end,
		onleave = function(player) vRPclient.stopMission(player) end
		},
		"tackle.pc",
		"vagt.paycheck",
		"strip.keycard"
	},
	["DJ"] = {
		_config = {
		gtype = "job",
		onjoin = function(player)
			TriggerClientEvent("pNotify:SendNotification", player,{text = "Du er nu DJ.", type = "success", queue = "global", timeout = 5000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
		end,
		onspawn = function(player) end,
		onleave = function(player) vRPclient.stopMission(player) end
		},
		"nojob.paycheck"
	},
		["Taxi Chauffør"] = {
		_config = {
		gtype = "job",
		onjoin = function(player)
			TriggerClientEvent("pNotify:SendNotification", player,{text = "Du er nu Taxi Chauffør.", type = "success", queue = "global", timeout = 5000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
		end,
		onspawn = function(player) end,
		onleave = function(player) vRPclient.stopMission(player) end
		},
		"taxi.service",
		"taxi.garage",
		"taxi.paycheck",
		"taxi.besked",
		"mission.taxi.passenger"
	},
	["Burgershot Medarbejder"] = {
		_config = {
		gtype = "job",
		onjoin = function(player)
			TriggerClientEvent("pNotify:SendNotification", player,{text = "Du er nu Burgershot Medarbejder.", type = "success", queue = "global", timeout = 5000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
		end,
		onspawn = function(player) end,
		onleave = function(player) vRPclient.stopMission(player) end
		},
		"burger.paycheck"
	},
	
	["Biltyv"] = {
		_config = {
			gtype = "job",
			onjoin = function(player) 
				TriggerClientEvent("pNotify:SendNotification", player,{text = "Du er nu Biltyv.", type = "success", queue = "global", timeout = 5000, layout = "centerLeft",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
			end,
			onspawn = function(player) end,
			onleave = function(player) vRPclient.stopMission(player) end
		},
		"biltyv.access",
		"arbejdsløs.paycheck",
		"money.launder",
		"player.loot",
	},

	["Våbenhandler"] = {
		_config = {
		gtype = "job",
		onjoin = function(player)
			TriggerClientEvent("pNotify:SendNotification", player,{text = "Du er nu Våbenhandler.", type = "success", queue = "global", timeout = 5000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
		end,
		onspawn = function(player) end,
		onleave = function(player) vRPclient.stopMission(player) end
		},
		"blacklisted.weapons",
		"farm.access",
		"weapons.dealer",
		"player.store_money",
		"våben.loadshop",
	},
		["Kriminel"] = {
		_config = {
	    gtype = "job",
		onjoin = function(player)
			TriggerClientEvent("pNotify:SendNotification", player,{text = "Du er nu Kriminel.", type = "success", queue = "global", timeout = 5000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
		end,
		onspawn = function(player) end,
		onleave = function(player) vRPclient.stopMission(player) end
		},
		"farm.access",
		"madsindbrud.adgang",
		"nojob.paycheck"
	},
		["Advokat"] = {
		_config = {
		gtype = "job",
		onjoin = function(player)
			TriggerClientEvent("pNotify:SendNotification", player,{text = "Du er nu Advokat.", type = "success", queue = "global", timeout = 5000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
		end,
		onspawn = function(player) end,
		onleave = function(player) vRPclient.stopMission(player) end
		},
		"advokat.paycheck",
		"retsag.key",
		"advokat.duty",
		"advokat.service",
	},
	["Dommer"] = {
		_config = {
		gtype = "job",
		onjoin = function(player)
			TriggerClientEvent("pNotify:SendNotification", player,{text = "Du er nu Dommer.", type = "success", queue = "global", timeout = 5000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
		end,
		onspawn = function(player) end,
		onleave = function(player) vRPclient.stopMission(player) end
		},
		"dommer.paycheck",
	},

	["Ejendomsmægler"] = {
		_config = {
		gtype = "job",
		onjoin = function(player)
			TriggerClientEvent("pNotify:SendNotification", player,{text = "Du er nu Ejendomsmægler.", type = "success", queue = "global", timeout = 5000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
		end,
		onspawn = function(player) end,
		onleave = function(player) vRPclient.stopMission(player) end
		},
		"ejendom.paycheck",
	},

		["Miner"] = {
				_config = {
				gtype = "job",
				onjoin = function(player)
			TriggerClientEvent("pNotify:SendNotification", player,{text = "Du er nu Miner.", type = "success", queue = "global", timeout = 5000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
		end,
		onspawn = function(player) end,
		onleave = function(player) vRPclient.stopMission(player) end
		},
		"miner.adgang",
		"miner.paycheck"
	},

	["Træhugger"] = {
		_config = {
		gtype = "job",
		onjoin = function(player)
			TriggerClientEvent("pNotify:SendNotification", player,{text = "Du er nu Træhugger.", type = "success", queue = "global", timeout = 5000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
		end,
		onspawn = function(player) end,
		onleave = function(player) vRPclient.stopMission(player) end
		},
		"skovhugger.tree",
		"miner.paycheck",
		"skovhugger.adgang"
	},
	["Skraldemand"] = {
		_config = {
		gtype = "job",
		onjoin = function(player)
			TriggerClientEvent("pNotify:SendNotification", player,{text = "Du er nu Skraldemand.", type = "success", queue = "global", timeout = 5000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
		end,
		onspawn = function(player) end,
		onleave = function(player) vRPclient.stopMission(player) end
		},
	    "skralde.vehicle",
	    "mission.skraldemand"
	},
	["Pizzabud"] = {
		_config = {
		gtype = "job",
		onjoin = function(player)
			TriggerClientEvent("pNotify:SendNotification", player,{text = "Du er nu Pizzabud.", type = "success", queue = "global", timeout = 5000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
		end,
		onspawn = function(player) end,
		onleave = function(player) vRPclient.stopMission(player) end
		},
		"delivery.vehicle",
		"delivery.paycheck",
		"delivery.pizza"
	},
	["Farmer"] = {
		_config = {
		gtype = "job",
		onjoin = function(player)
			TriggerClientEvent("pNotify:SendNotification", player,{text = "Du er nu Farmer.", type = "success", queue = "global", timeout = 5000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
		end,
		onspawn = function(player) end,
		onleave = function(player) vRPclient.stopMission(player) end
		},
		"farmer.farm",
	    "mission.farmer1",
	    "mission.farmer2"
	},
	["Lastbilchauffør"] = {
		_config = {
		gtype = "job",
		onjoin = function(player)
			TriggerClientEvent("pNotify:SendNotification", player,{text = "Du er nu Lastbilchauffør.", type = "success", queue = "global", timeout = 5000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
		end,
		onspawn = function(player) end,
		onleave = function(player) vRPclient.stopMission(player) end
		},
	    "delivery.trucker",
	    "trucker.vehicle",
		"trucker.paycheck"
	},
	["Diablos"] = {
		_config = {
		gtype = "job",
		onjoin = function(player)
			TriggerClientEvent("pNotify:SendNotification", player,{text = "Du er nu medlem af Diablos.", type = "success", queue = "global", timeout = 5000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
		end,
		onspawn = function(player) end,
		onleave = function(player) vRPclient.stopMission(player) end
		},
		"nojob.paycheck",
		"farm.access",
		"diablos.key",
		"bande.loadshop",
	},
	["Members Only"] = {
		_config = {
		gtype = "job",
		onjoin = function(player)
			TriggerClientEvent("pNotify:SendNotification", player,{text = "Du er nu medlem af Members Only.", type = "success", queue = "global", timeout = 5000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
		end,
		onspawn = function(player) end,
		onleave = function(player) vRPclient.stopMission(player) end
		},
	    "mo.key",
		"nojob.paycheck",
		"farm.access",
	},
	["Cartel"] = {
		_config = {
		gtype = "job",
		onjoin = function(player)
			TriggerClientEvent("pNotify:SendNotification", player,{text = "Du er nu medlem af Cartel.", type = "success", queue = "global", timeout = 5000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
		end,
		onspawn = function(player) end,
		onleave = function(player) vRPclient.stopMission(player) end
		},
	    "cartel.doors",
		"nojob.paycheck",
		"farm.access",
		"cartel.market",
		"bande.loadshop",
	},
	["The Lost"] = {
		_config = {
		gtype = "job",
		onjoin = function(player)
			TriggerClientEvent("pNotify:SendNotification", player,{text = "Du er nu medlem af The Lost.", type = "success", queue = "global", timeout = 5000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
		end,
		onspawn = function(player) end,
		onleave = function(player) vRPclient.stopMission(player) end
		},
	    "thelost.key",
		"nojob.paycheck",
		"farm.access",
	},

	["Ballas"] = {
		_config = {
		gtype = "job",
		onjoin = function(player)
			TriggerClientEvent("pNotify:SendNotification", player,{text = "Du er nu medlem af Ballas.", type = "success", queue = "global", timeout = 5000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
		end,
		onspawn = function(player) end,
		onleave = function(player) vRPclient.stopMission(player) end
		},
		"ballas.doors",
		"ballas.keycard",
		"nojob.paycheck",
		"farm.access",
		"bande.loadshop",
	},
	["Colombo"] = {
		_config = {
		gtype = "job",
		onjoin = function(player)
			TriggerClientEvent("pNotify:SendNotification", player,{text = "Du er nu medlem af Colombo Crime Family.", type = "success", queue = "global", timeout = 5000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
		end,
		onspawn = function(player) end,
		onleave = function(player) vRPclient.stopMission(player) end
		},
	    "colomb2o.keycard",
		"nojob.paycheck",
		"farm.access",
	},

	["Mafia"] = {
		_config = {
		gtype = "job",
		onjoin = function(player)
			TriggerClientEvent("pNotify:SendNotification", player,{text = "Du er nu medlem af Mafia.", type = "success", queue = "global", timeout = 5000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
		end,
		onspawn = function(player) end,
		onleave = function(player) vRPclient.stopMission(player) end
		},
	    "mafia.key",
		"nojob.paycheck",
		"farm.access",
	},
	["LTF"] = {
		_config = {
		gtype = "job",
		onjoin = function(player)
			TriggerClientEvent("pNotify:SendNotification", player,{text = "Du er nu medlem af LTF.", type = "success", queue = "global", timeout = 5000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
		end,
		onspawn = function(player) end,
		onleave = function(player) vRPclient.stopMission(player) end
		},
		"ltf.key",
		"nojob.paycheck",
		"farm.access",
	},
	["Vagos"] = {
		_config = {
		gtype = "job",
		onjoin = function(player)
			TriggerClientEvent("pNotify:SendNotification", player,{text = "Du er nu medlem af Vagos.", type = "success", queue = "global", timeout = 5000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
		end,
		onspawn = function(player) end,
		onleave = function(player) vRPclient.stopMission(player) end
		},
		"nojob.paycheck",
		"farm.access",
	},
	["Hells Angels"] = {
		_config = {
		gtype = "job",
		onjoin = function(player)
			TriggerClientEvent("pNotify:SendNotification", player,{text = "Du er nu medlem af Hells Angels.", type = "success", queue = "global", timeout = 5000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
		end,
		onspawn = function(player) end,
		onleave = function(player) vRPclient.stopMission(player) end
		},
	    "colombo.keycard",
		"nojob.paycheck",
		"farm.access",
	},
	["MS-13"] = {
		_config = {
		gtype = "job",
		onjoin = function(player)
			TriggerClientEvent("pNotify:SendNotification", player,{text = "Du er nu medlem af MS-13.", type = "success", queue = "global", timeout = 5000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
		end,
		onspawn = function(player) end,
		onleave = function(player) vRPclient.stopMission(player) end
		},
	    "mafia.key",
		"nojob.paycheck",
		"farm.access",
		"strip.keycard",
	},
	["Tordenskjold"] = {
		_config = {
		gtype = "job",
		onjoin = function(player)
			TriggerClientEvent("pNotify:SendNotification", player,{text = "Du er nu medlem af Tordenskjold.", type = "success", queue = "global", timeout = 5000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
		end,
		onspawn = function(player) end,
		onleave = function(player) vRPclient.stopMission(player) end
		},
		"kartel.key",
		"kartel.market",
		"nojob.paycheck",
		"farm.access",
	},
	["Bandidos"] = {
		_config = {
		gtype = "job",
		onjoin = function(player)
			TriggerClientEvent("pNotify:SendNotification", player,{text = "Du er nu medlem af Bandidos.", type = "success", queue = "global", timeout = 5000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
		end,
		onspawn = function(player) end,
		onleave = function(player) vRPclient.stopMission(player) end
		},
		"nojob.paycheck",
		"farm.access",
		"bande.loadshop",
	},
	["Black Army"] = {
		_config = {
		gtype = "job",
		onjoin = function(player)
			TriggerClientEvent("pNotify:SendNotification", player,{text = "Du er nu medlem af Black Army.", type = "success", queue = "global", timeout = 5000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
		end,
		onspawn = function(player) end,
		onleave = function(player) vRPclient.stopMission(player) end
		},
		"ba.paycheck",
		"farm.access",
		"bande.loadshop",
	},
	["Auto Genbrug"] = {
		_config = {
		gtype = "job",
		onjoin = function(player)
		    TriggerClientEvent("pNotify:SendNotification", player,{text = "Du arbejder nu for Auto Genbrug.", type = "success", queue = "global", timeout = 5000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
		end,
		onspawn = function(player) end,
		onleave = function(player) vRPclient.stopMission(player) end
	},
	"auto.paycheck",
	},
	["Bilforhandler"] = {
		_config = {
		gtype = "job",
		onjoin = function(player)
			TriggerClientEvent("pNotify:SendNotification", player,{text = "Du er nu en Bilforhandler.", type = "success", queue = "global", timeout = 5000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
		end,
		onspawn = function(player) end,
		onleave = function(player) vRPclient.stopMission(player) end
		},
		"bilforhandler.duty",
		"bilforhandler.doors",
		"bilforhandler.paycheck",
		"player.spawnvehicle",
		"player.deletevehicle",
		"admin.bilforhandler",
	},
	["Bar Arbejder"] = {
		_config = {
		gtype = "job",
		onjoin = function(player)
			TriggerClientEvent("pNotify:SendNotification", player,{text = "Du er nu Bar Arbejder.", type = "success", queue = "global", timeout = 5000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
		end,
		onspawn = function(player) end,
		onleave = function(player) vRPclient.stopMission(player) end
		},
		"nojob.paycheck",
		"farm.access",
		"stripklubben.doors"
	},
	["Arbejdsløs"] = {
		_config = {
		gtype = "job",
		onjoin = function(player)
			TriggerClientEvent("pNotify:SendNotification", player,{text = "Du er nu Arbejdsløs.", type = "success", queue = "global", timeout = 5000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
		end,
		onspawn = function(player) end,
		onleave = function(player) vRPclient.stopMission(player) end
		},
		"nojob.paycheck",
		"garderobe.adgang",
	}
}


-- groups are added dynamically using the API or the menu, but you can add group when an user join here
cfg.users = {
	[1] = { -- give superadmin and admin group to the first created user on the database
		"ledelse",
		"staff"
	}
}

-- group selectors
-- _config
--- x,y,z, blipid, blipcolor, permissions (optional)

cfg.selectors = {
	["Jobcenter"] = {
		_config = {x = -265.86267089844, y = -968.30444335938, z = 31.224395751953, blipid = 351, blipcolor = 3},
		"Taxi Chauffør",
		"Pizzabud",
		"Skraldemand",
		"Lastbilchauffør",
		"Træhugger",
		"Miner",
		"Journalist",
		"Kriminel",
		"Arbejdsløs"
	},
	["Politi Midtby"] = {
		_config = {x = 439.87124633789, y = -975.82958984375, z = 30.689332962036, blipid = 0, blipcolor = 0, permissions = {"cop.whitelisted"} },
		"Politi-Job",
		"Arbejdsløs"
	},
	["Politi DavisPD"] = {
		_config = {x = 356.97402954102, y = -1594.4321289063, z = 29.292049407959, blipid = 0, blipcolor = 0, permissions = {"cop.whitelisted"} },
		"Politi-Job",
		"Arbejdsløs"
	},
	["EMS"] = {
		_config = {x = 310.57275390625, y = -596.90789794922, z = 43.284061431885, blipid = 0, blipcolor = 0, permissions = {"ems.whitelisted"} },
		"EMS-Job",
		"Arbejdsløs"
	}
}

return cfg