
vRP = Proxy.getInterface("vRP")
vRPg = Proxy.getInterface("vRP_garages")

function deleteVehiclePedIsIn()
	local v = GetVehiclePedIsIn(GetPlayerPed(-1),false)
	SetVehicleHasBeenOwnedByPlayer(v,false)
	SetEntityAsMissionEntity(v, false, true) -- set not as mission entity
	SetVehicleAsNoLongerNeeded(Citizen.PointerValueIntInitialized(v))
	DeleteEntity(v)
end

local vehshop = {
	opened = false,
	title = "Bilforhandler",
	currentmenu = "Bilforhandler",
	lastmenu = nil,
	currentpos = nil,
	selectedbutton = 0,
	marker = { r = 0, g = 155, b = 255, a = 200, type = 1 },
	menu = {
		x = 0.2,
		y = 0.08,
        width = 0.2,
        height = 0.03,
        buttons = 10,
        from = 1,
        to = 10,
        scale = 0.4,
        font = 1,
		["Bilforhandler"] = {
			title = "Bilforhandler",
			name = "Bilforhandler",
			buttons = {
				{name = "Biler", description = ""},
				{name = "Motorcykler", description = ""},
				{name = "Cykler", description = ""},
			}
		},
		["Biler"] = {
			title = "Biler",
			name = "Biler",
			buttons = {
				{name = "Coupeer", description = ''},
				{name = "Kompakte", description = ''},
				{name = "Muskelbiler", description = ''},
				{name = "Offroad", description = ''},
				{name = "Sedaner", description = ''},
				{name = "Sportsklassikere", description = ''},
				{name = "Sportsvogne", description = ''},
				{name = "Superbiler", description = ''},
				{name = "SUV", description = ''},
				{name = "Varevogne", description = ''},
			}
		},
		["Kompakte"] = {
			title = "Kompakte",
			name = "Kompakte",
			buttons = {
				{name = "Blista", costs = 50000, description = {}, model = "blista"},
				{name = "Brioso R/A", costs = 75000, description = {}, model = "brioso"},
				{name = "Dilettante", costs = 50000, description = {}, model = "dilettante"},
				{name = "Futo", costs = 112500, description = {}, model = "futo"},
				{name = "Issi", costs = 60000, description = {}, model = "issi2"},
				{name = "Prairie", costs = 75000, description = {}, model = "prairie"},
				{name = "Rhapsody", costs = 50000, description = {}, model = "rhapsody"},
				{name = "Emperor", costs = 40000, description = {}, model = "emperor"},
				{name = "Issi Classic", costs = 40000, description = {}, model = "issi3"},
				{name = "Panto", costs = 60000, description = {}, model = "panto"},
				{name = "Issi 7", costs = 500000, description = {}, model = "issi7"},
				{name = "Club", costs = 70000, description = {}, model = "club"},
			}
		},
		["Coupeer"] = {
			title = "Coupeer",
			name = "Coupeer",
			buttons = {
  				{name = "Cognoscenti Cabrio", costs = 750000, description = {}, model = "cogcabrio"},
				{name = "F620", costs = 775000, description = {}, model = "f620"},
				{name = "Felon GT", costs = 650000, description = {}, model = "felon2"},
				{name = "Jackal", costs = 650000, description = {}, model = "jackal"},
				{name = "Oracle", costs = 450000, description = {}, model = "oracle"},
				{name = "Oracle XS", costs = 500000, description = {}, model = "oracle2"},
				{name = "Sentinel", costs = 435000, description = {}, model = "sentinel"},
				{name = "Sentinel XS", costs = 430000, description = {}, model = "sentinel2"},
				{name = "Übermacht Sentinel Classic", costs = 1250000, description = {}, model = "sentinel3"},
				{name = "Windsor", costs = 1400000, description = {}, model = "windsor"},
				{name = "Windsor Drop", costs = 1300000, description = {}, model = "windsor2"},
				{name = "Zion", costs = 600000, description = {}, model = "zion"},
				{name = "FlashGT", costs = 450000, description = {}, model = "flashgt"},
				{name = "Zion Cabrio", costs = 620000, description = {}, model = "zion2"},
				{name = "Specter", costs = 1300000, description = {}, model = "specter"},
				{name = "Specter CTM", costs = 1400000, description = {}, model = "specter2"},
				{name = "Monroe", costs = 575000, description = {}, model = "monroe"},
				{name = "Ubermacht Zion", costs = 415000, description = {}, model = "zion3"},
				{name = "Nebula", costs = 300000, description = {}, model = "nebula"},
				{name = "Albany Manana", costs = 300000, description = {}, model = "manana2"},
			}
		},
		["Sportsvogne"] = {
			title = "Sportsvogne",
			name = "Sportsvogne",
			buttons = {
				{name = "Banshee", costs = 675000, description = {}, model = "banshee"},
				{name = "Buffalo", costs = 620000, description = {}, model = "buffalo"},
				{name = "Buffalo S", costs = 650000, description = {}, model = "buffalo2"},
				{name = "Carbonizzare", costs = 1200000, description = {}, model = "carbonizzare"},
				{name = "Coquette", costs = 900000, description = {}, model = "coquette"},
				{name = "Furore GT", costs = 850000, description = {}, model = "furoregt"},
				{name = "Fusilade", costs = 675000, description = {}, model = "fusilade"},
				{name = "Hijak Ruston", costs = 650000, description = {}, model = "ruston"},
				{name = "Jester", costs = 3700000, description = {}, model = "jester"},
				{name = "Kuruma", costs = 1500000, description = {}, model = "kuruma"},
				{name = "Lynx", costs = 1440000, description = {}, model = "lynx"},
				{name = "Massacro", costs = 3200000, description = {}, model = "massacro"},
				{name = "Omnis", costs = 1000000, description = {}, model = "omnis"},
				{name = "Penumbra", costs = 650000, description = {}, model = "penumbra"},
				{name = "Schafter V12", costs = 1350000, description = {}, model = "schafter3"},
				{name = "Sultan", costs = 700000, description = {}, model = "sultan"},
				{name = "Sultan RS", costs = 2200000, description = {}, model = "sultanrs"},
				{name = "Feltzer 2", costs = 1500000, description = {}, model = "feltzer2"},
				{name = "Surano", costs = 600000, description = {}, model = "surano"},
				{name = "Tropos", costs = 1350000, description = {}, model = "tropos"},
				{name = "Verkierer", costs = 500000, description = {}, model = "verlierer2"},	
				{name = "Neon", costs = 1900000, description = {}, model = "neon"},	
				{name = "Comet SR", costs = 3500000, description = {}, model = "comet5"},	
				{name = "Comet Custom", costs = 2500000, description = {}, model = "comet3"},	
				{name = "Bestia GTS", costs = 2000000, description = {}, model = "bestiagts"},	
				{name = "Jester(Racecar)", costs = 3000000, description = {}, model = "jester2"},
				{name = "Jester3", costs = 825000, description = {}, model = "jester3"},	
				{name = "Massacro(Racecar)", costs = 2900000, description = {}, model = "massacro2"},	
				{name = "Rapid GT", costs = 2700000, description = {}, model = "rapidgt"},	
				{name = "Rapid GT Convert", costs = 3000000, description = {}, model = "rapidgt2"},	
				{name = "Schlagen GT", costs = 3000000, description = {}, model = "schlagen"},	
				{name = "Pariah", costs = 2100000, description = {}, model = "pariah"},	
				{name = "Khamelion", costs = 1700000, description = {}, model = "khamelion"},	
				{name = "Raptor", costs = 1000000, description = {}, model = "raptor"},	
				{name = "Dominator GTX", costs = 3000000, description = {}, model = "dominator3"},	
				{name = "Elegy", costs = 1800000, description = {}, model = "elegy"},
				{name = "Elegy Turbo", costs = 2400000, description = {}, model = "elegy2"},	
				{name = "Dewbauchee Exemplar", costs = 500000, description = {}, model = "exemplar"},
				{name = "Dewbauchee Seven-70", costs = 600000, description = {}, model = "seven70"},
				{name = "Benefactor Schwartzer", costs = 400000, description = {}, model = "schwarzer"},	
				{name = "Weeny Issi", costs = 3500000, description = {}, model = "issi7"},
				{name = "Jugular", costs = 5500000, description = {}, model = "jugular"},				
			}
		},
		["Sportsklassikere"] = {
			title = "Sportsklassikere",
			name = "Sportsklassikere",
			buttons = {
				{name = "Casco", costs = 700000, description = {}, model = "casco"},
				{name = "Coquette Classic", costs = 900000, description = {}, model = "coquette2"},
				{name = "Pigalle", costs = 400000, description = {}, model = "pigalle"},
				{name = "Stinger", costs = 800000, description = {}, model = "stinger"},
				{name = "Stinger GT", costs = 900000, description = {}, model = "stingergt"},
				{name = "Stirling GT", costs = 710000, description = {}, model = "feltzer3"},
				{name = "Z-Type", costs = 1000000, description = {}, model = "ztype"},
				{name = "Btype 3", costs = 1100000, description = {}, model = "btype3"},		
				{name = "Retinue", costs = 350000, description = {}, model = "retinue"},
				{name = "Torero", costs = 900000, description = {}, model = "torero"},
				{name = "Cheetah Classic", costs = 950000, description = {}, model = "cheetah2"},
				{name = "Hermes", costs = 600000, description = {}, model = "hermes"},
				{name = "Rapid GT Classic", costs = 550000, description = {}, model = "rapidgt3"},
				{name = "Michelli GT-", costs = 160000, description = {}, model = "michelli"},
				{name = "Fagaloa", costs = 200000, description = {}, model = "fagaloa"},
				{name = "Karin 190z", costs = 400000, description = {}, model = "z190"},
				{name = "Peyote Gasser", costs = 650000, description = {}, model = "peyote2"},
				{name = "Sultan Classic", costs = 1200000, description = {}, model = "sultan2"},
				{name = "Glendale Custom", costs = 1000000, description = {}, model = "glendale2"},
				{name = "Vapid Peyote", costs = 750000, description = {}, model = "peyote3"},
			}
		},
		["Superbiler"] = {
			title = "Superbiler",
			name = "Superbiler",
			buttons = {
			{name = "Tyrant", costs = 6250000, description = {}, model = "tyrant"},
			{name = "Osiris", costs = 4500000, description = {}, model = "osiris"},
			{name = "Taipan", costs = 5450000, description = {}, model = "taipan"},
			{name = "Zentorno", costs = 7500000, description = {}, model = "zentorno"},
			{name = "Vacca", costs = 5500000, description = {}, model = "vacca"},
			{name = "Tempesta", costs = 7200000, description = {}, model = "tempesta"},
			{name = "Reaper", costs = 6750000, description = {}, model = "reaper"},
			{name = "Entity XF", costs = 6500000, description = {}, model = "entityxf"},
			{name = "Grotti Itali", costs = 12500000, description = {}, model = "italigto"},
			{name = "Übermacht SC1", costs = 3100000, description = {}, model = "sc1"},
			{name = "Krieger", costs = 8500000, description = {}, model = "krieger"},
			{name = "Neo", costs = 9000000, description = {}, model = "neo"},
			{name = "Paragon", costs = 8500000, description = {}, model = "paragon"},
			{name = "Zorrusso", costs = 5000000, description = {}, model = "zorrusso"},
			{name = "Emerus", costs = 11000000, description = {}, model = "emerus"},
			{name = "Locust", costs = 6000000, description = {}, model = "locust"},
			{name = "Thrax", costs = 10000000, description = {}, model = "thrax"},
			{name = "Penetrator", costs = 3000000, description = {}, model = "penetrator"},
			{name = "Cyclone", costs = 7500000, description = {}, model = "cyclone"},
			{name = "Vagner", costs = 5250000, description = {}, model = "vagner"},
			{name = "Voltic", costs = 3750000, description = {}, model = "voltic"},
			{name = "Turismor", costs = 6500000, description = {}, model = "turismor"},
			{name = "Tyrus", costs = 5500000, description = {}, model = "tyrus"},
			{name = "Itali GTB", costs = 6250000, description = {}, model = "italigtb"},
			{name = "X80 Proto", costs = 6000000, description = {}, model = "prototipo"},
			{name = "Pfister 811", costs = 5500000, description = {}, model = "pfister811"},
			{name = "Cheetah", costs = 7750000, description = {}, model = "cheetah"},
			{name = "T20", costs = 8200000, description = {}, model = "t20"},
			{name = "Emperor ETR1", costs = 4750000, description = {}, model = "sheava"},
			{name = "Nero Custom", costs = 6000000, description = {}, model = "nero2"},
			{name = "Vapid FMJ", costs = 7000000, description = {}, model = "fmj"},
			{name = "GP1", costs = 5500000, description = {}, model = "gp1"},
			{name = "Coquette D10", costs = 6000000, description = {}, model = "coquette4"},
			{name = "Tigon", costs = 3000000, description = {}, model = "tigon"},
		}
		},
		["Muskelbiler"] = {
			title = "Muskelvogne",
			name = "Muskelvogne",
			buttons = {
				{name = "Blade", costs = 325000, description = {}, model = "blade"},
				{name = "Buccaneer", costs = 250000, description = {}, model = "buccaneer"},
				{name = "Chino", costs = 225000, description = {}, model = "chino"},
				{name = "Coquette BlackFin", costs = 695000, description = {}, model = "coquette3"},
				{name = "Dominator", costs = 625000, description = {}, model = "dominator"},
				{name = "Dukes", costs = 575000, description = {}, model = "dukes"},
				{name = "Faction", costs = 545000, description = {}, model = "faction"},
				{name = "Ruiner", costs = 375000, description = {}, model = "ruiner"},
				{name = "Voodoo", costs = 325000, description = {}, model = "voodoo"},
				{name = "Hotknife", costs = 610000, description = {}, model = "hotknife"},
				{name = "Ratloader V2", costs = 345000, description = {}, model = "ratloader2"},
				{name = "Impaler", costs = 475000, description = {}, model = "impaler"},
				{name = "Deviant", costs = 600000, description = {}, model = "deviant"},
				{name = "Slamvan", costs = 395000, description = {}, model = "slamvan"},
				{name = "Nightshade", costs = 475000, description = {}, model = "nightshade"},
				{name = "Picador", costs = 400000, description = {}, model = "picador"},
				{name = "Tampa", costs = 660000, description = {}, model = "tampa"},
				{name = "Ellie", costs = 610000, description = {}, model = "ellie"},
				{name = "Virgo", costs = 150000, description = {}, model = "virgo"},
				{name = "Vapid Clique", costs = 625000, description = {}, model = "clique"},
				{name = "Bravado Gauntlet", costs = 500000, description = {}, model = "gauntlet"},
				{name = "Imponte Phoenix", costs = 510000, description = {}, model = "phoenix"},
				{name = "Declasse Tulip", costs = 510000, description = {}, model = "tulip"},
				{name = "Sabre Turbo", costs = 625000, description = {}, model = "sabregt"},
				{name = "Gauntlet Classic", costs = 575000, description = {}, model = "gauntlet3"},
				{name = "Gauntlet Hellfire", costs = 2250000, description = {}, model = "gauntlet4"},
				{name = "Gauntlet Classic 2", costs = 2000000, description = {}, model = "gauntlet5"},
				{name = "Beater Dukes", costs = 2000000, description = {}, model = "dukes3"},
			}
		},
		["Offroad"] = {
			title = "Offroad",
			name = "offroad",
			buttons = {
				{name = "Bifta", costs = 75000, description = {}, model = "bifta"},
				{name = "Brawler", costs = 725000, description = {}, model = "brawler"},
				{name = "Dubsta 6x6", costs = 475000, description = {}, model = "dubsta3"},
				{name = "Dune Buggy", costs = 150000, description = {}, model = "dune"},
				{name = "Rebel", costs = 220000, description = {}, model = "rebel2"},
				{name = "Rodhi 2", costs = 85000, description = {}, model = "bodhi2"},
				{name = "Kamacho", costs = 315000, description = {}, model = "kamacho"},
				{name = "Riata", costs = 325000, description = {}, model = "riata"},
				{name = "Streiter", costs = 225000, description = {}, model = "streiter"},
				{name = "Blazer", costs = 10000, description = {}, model = "blazer"},
				{name = "Bravado Rumpo Custom", costs = 235000, description = {}, model = "rumpo3"},
				{name = "Canis Mesa", costs = 300000, description = {}, model = "mesa"},
				{name = "Rebel", costs = 275000, description = {}, model = "rebel"},
				{name = "Kalahari", costs = 125000, description = {}, model = "kalahari"},
				{name = "Yosemite Rancher", costs = 500000, description = {}, model = "yosemite3"},
			}
		},
		["SUV"] = {
			title = "SUV",
			name = "SUV",
			buttons = {
				{name = "Baller", costs = 735000, description = {}, model = "baller"},
				{name = "Cavalcade", costs = 330000, description = {}, model = "cavalcade"},
				{name = "Granger", costs = 665000, description = {}, model = "granger"},
				{name = "Huntley S", costs = 465000, description = {}, model = "huntley"},
				{name = "Landstalker", costs = 83000, description = {}, model = "landstalker"},
				{name = "Radius", costs = 62000, description = {}, model = "radi"},
				{name = "Rocoto", costs = 780000, description = {}, model = "rocoto"},
				{name = "Seminole", costs = 165000, description = {}, model = "seminole"},
				{name = "XLS", costs = 465000, description = {}, model = "xls"},
				{name = "Dubsta", costs = 750000, description = {}, model = "dubsta"},
				{name = "Benefactor Dubsta", costs = 1250000, description = {}, model = "dubsta2"},
				{name = "FQ2", costs = 1000000, description = {}, model = "fq2"},
				{name = "Patriot SUV", costs = 2000000, description = {}, model = "patriot2"},
				{name = "Baller V3", costs = 1600000, description = {}, model = "baller3"},
				{name = "Toros", costs = 3200000, description = {}, model = "toros"},
				{name = "Vapid Contender", costs = 200000, description = {}, model = "contender"},
				{name = "Patriot", costs = 1500000, description = {}, model = "patriot"},
				{name = "Novak", costs = 450000, description = {}, model = "novak"},
				{name = "Hellion", costs = 550000, description = {}, model = "hellion"},
				{name = "Caracara 4x4", costs = 350000, description = {}, model = "caracara2"},
				{name = "Landstalker XL", costs = 2000000, description = {}, model = "landstalker2"},
				{name = "Seminole Frontier", costs = 400000, description = {}, model = "seminole2"},
			}
		},
		["Varevogne"] = {
			title = "Varevogne",
			name = "Varevogne",
			buttons = {
				{name = "Bison", costs = 130000, description = {}, model = "bison"},
				{name = "Bobcat XL", costs = 123000, description = {}, model = "bobcatxl"},
				{name = "Journey", costs = 150000, description = {}, model = "journey"},
				{name = "Minivan", costs = 300000, description = {}, model = "minivan"},
				{name = "Rustvogn", costs = 800000, description = {}, model = "romero"},
				{name = "Paradise", costs = 250000, description = {}, model = "paradise"},
				{name = "Camper", costs = 345000, description = {}, model = "camper"},
				{name = "Rumpo", costs = 130000, description = {}, model = "rumpo"},
				{name = "Surfer", costs = 110000, description = {}, model = "surfer"},
				{name = "Youga", costs = 160000, description = {}, model = "youga"},
				{name = "MoonBeam", costs = 500000, description = {}, model = "moonbeam2"},
				{name = "Youga Classic 4x4", costs = 300000, description = {}, model = "youga3"},
			}
		},
		["Sedaner"] = {
			title = "Sedaner",
			name = "Sedaner",
			buttons = {
				{name = "Asea", costs = 225000, description = {}, model = "asea"},
				{name = "Asterope", costs = 257000, description = {}, model = "asterope"},
				{name = "Ingot", costs = 85000, description = {}, model = "ingot"},
				{name = "Intruder", costs = 250000, description = {}, model = "intruder"},
				{name = "Premier", costs = 210000, description = {}, model = "premier"},
				{name = "Primo", costs = 235000, description = {}, model = "primo"},
				{name = "Primo Custom", costs = 275000, description = {}, model = "primo2"},
				{name = "Regina", costs = 175000, description = {}, model = "regina"},
				{name = "Schafter", costs = 625000, description = {}, model = "schafter2"},
				{name = "Stanier", costs = 100000, description = {}, model = "stanier"},
				{name = "Stratum", costs = 100000, description = {}, model = "stratum"},
				{name = "Stretch", costs = 750000, description = {}, model = "stretch"},
				{name = "Super Diamond", costs = 670000, description = {}, model = "superd"},
				{name = "Surge", costs = 240000, description = {}, model = "surge"},
				{name = "Cheburek", costs = 165000, description = {}, model = "cheburek"},
				{name = "Tailgater", costs = 410000, description = {}, model = "tailgater"},
				{name = "Warrener", costs = 175000, description = {}, model = "warrener"},
				{name = "Washington", costs = 225000, description = {}, model = "washington"},
				{name = "Raiden", costs = 675000, description = {}, model = "raiden"},
				{name = "Cognoscenti", costs = 650000, description = {}, model = "cognoscenti"},
				{name = "Cognoscenti 55", costs = 7000000, description = {}, model = "cog55"},
				{name = "Glendale", costs = 195000, description = {}, model = "glendale"},
				{name = "Weeny Dynasty", costs = 250000, description = {}, model = "dynasty"},
				{name = "Drafter", costs = 680000, description = {}, model = "drafter"},
			}
		},
		["Motorcykler"] = {
			title = "Motorcykler",
			name = "Motorcykler",
			buttons = {
				{name = "Akuma", costs = 90000, description = {}, model = "akuma"},
				{name = "Bagger", costs = 250000, description = {}, model = "bagger"},
				{name = "Bati 801", costs = 120000, description = {}, model = "bati"},
				{name = "Bati 801RR", costs = 120000, description = {}, model = "bati2"},
				{name = "BF400", costs = 300000, description = {}, model = "bf400"},
				{name = "Carbon RS", costs = 180000, description = {}, model = "carbonrs"},
				{name = "Cliffhanger", costs = 325000, description = {}, model = "cliffhanger"},
				{name = "Double T", costs = 800000, description = {}, model = "double"},
				{name = "Faggio", costs = 13000, description = {}, model = "faggio2"},
				{name = "Gargoyle", costs = 220000, description = {}, model = "gargoyle"},
				{name = "Hakuchou", costs = 650000, description = {}, model = "hakuchou"},
				{name = "Hexer", costs = 120000, description = {}, model = "hexer"},
				{name = "Innovation", costs = 190000, description = {}, model = "innovation"},
				{name = "Nemesis", costs = 120000, description = {}, model = "nemesis"},
				{name = "PCJ-600", costs = 90000, description = {}, model = "pcj"},
				{name = "Ruffian", costs = 210000, description = {}, model = "ruffian"},
				{name = "Sanchez", costs = 80000, description = {}, model = "sanchez"},
				{name = "Thrust", costs = 323000, description = {}, model = "thrust"},
				{name = "Vader", costs = 200000, description = {}, model = "vader"},
				{name = "Vindicator", costs = 600000, description = {}, model = "vindicator"},
				{name = "Nightblade", costs = 400000, description = {}, model = "nightblade"},
				{name = "ZombieChopper", costs = 385000, description = {}, model = "zombieb"},
				{name = "Avarus", costs = 400000, description = {}, model = "avarus"},
				{name = "Sanctus", costs = 2000000, description = {}, model = "sanctus"},
				{name = "Vortex", costs = 800000, description = {}, model = "vortex"},
				{name = "Diabolus Custom", costs = 300000, description = {}, model = "diablous2"},
				{name = "Lectro", costs = 175000, description = {}, model = "lectro"},
				{name = "Defiler", costs = 200000, description = {}, model = "defiler"},
				{name = "Daemon", costs = 225500, description = {}, model = "daemon"},
				{name = "Enduro", costs = 160000, description = {}, model = "enduro"},
				{name = "Pegassi", costs = 350000, description = {}, model = "esskey"},
				{name = "FCR 1000 Custom", costs = 200000, description = {}, model = "fcr2"},
				{name = "FCR 1000", costs = 180000, description = {}, model = "fcr"},
				{name = "Manchez", costs = 150000, description = {}, model = "manchez"},
				{name = "Sovereign", costs = 275000, description = {}, model = "sovereign"},
				{name = "Ruffian", costs = 150000, description = {}, model = "ruffian"},
				{name = "PCJ 600", costs = 120000, description = {}, model = "pcj"},
				{name = "Vader", costs = 125000, description = {}, model = "vader"},
			}
		},
		["Cykler"] = {
			title = "Cykler",
			name = "Cykler",
			buttons = {
				{name = "BMX", costs = 2000, description = {}, model = "bmx"},
				{name = "Cruiser", costs = 5000, description = {}, model = "cruiser"},
				{name = "Fixter", costs = 5000, description = {}, model = "fixter"},
				{name = "Scorcher", costs = 9000, description = {}, model = "scorcher"},
				{name = "Tribike 1", costs = 14500, description = {}, model = "tribike"},
				{name = "Tribike 2", costs = 14500, description = {}, model = "tribike2"},
				{name = "Tribike 3", costs = 14500, description = {}, model = "tribike3"},
			}
		}
	}
}
local fakecar = {model = '', car = nil}
local vehshop_locations = {
	{entering = {-57.476829528809,-1096.8350830078,26.422332763672}, inside = {-45.110725402832,-1097.2772216797,26.422332763672,116.60857391357}, outside = {-16.410259246826,-1100.7811279297,26.676038742065}},
}

local vehshop_blips ={}
local inrangeofvehshop = false
local currentlocation = nil
local boughtcar = false

function vehSR_drawTxt(text,font,centre,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextProportional(0)
	SetTextScale(scale, scale)
	SetTextColour(r, g, b, a)
	SetTextDropShadow(0, 0, 0, 0,255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(centre)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x , y)
end

function vehSR_IsPlayerInRangeOfVehshop()
	return inrangeofvehshop
end

local firstspawn = 0
AddEventHandler('playerSpawned', function(spawn)
	if firstspawn == 0 then
		vehSR_ShowVehshopText(true)
		firstspawn = 1
	end
end)

function vehSR_ShowVehshopText(bool)
	if bool and #vehshop_blips == 0 then
		for station,pos in pairs(vehshop_locations) do
			local loc = pos
			pos = pos.entering
			table.insert(vehshop_blips, {blip = blip, pos = loc})
		end
		Citizen.CreateThread(function()
			while #vehshop_blips > 0 do
				Citizen.Wait(0)
				local inrange = false
				for i,b in ipairs(vehshop_blips) do
					if GetDistanceBetweenCoords(b.pos.entering[1],b.pos.entering[2],b.pos.entering[3],GetEntityCoords(vehSR_LocalPed())) < 10 then
						--DrawMarker(27, b.pos.entering[1],b.pos.entering[2],b.pos.entering[3] -0.95,0,0,0,0,0,Rotation,1.501,1.5001,0.5001,255,0,0,200,0,0,0,true)
						DrawMarker(21, b.pos.entering[1],b.pos.entering[2],b.pos.entering[3] -0.25, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 0, 151, 255, 100, false, true, 2, true, false, false, false)
					end
					if vehshop.opened == false and IsPedInAnyVehicle(vehSR_LocalPed(), true) == false and GetDistanceBetweenCoords(b.pos.entering[1],b.pos.entering[2],b.pos.entering[3],GetEntityCoords(vehSR_LocalPed())) < 1 then
						DrawText3Ds(b.pos.entering[1],b.pos.entering[2],b.pos.entering[3], "Tryk ~c~[~b~E~c~] ~w~for at gennemse køretøjer", 3.0, 7)
						currentlocation = b
						inrange = true
					end
				end
				inrangeofvehshop = inrange
			end
		end)
	elseif bool == false and #vehshop_blips > 0 then
		vehshop_blips = {}
	end
end

function vehSR_f(n)
	return n + 0.0001
end

function vehSR_LocalPed()
	return GetPlayerPed(-1)
end

function vehSR_try(f, catch_f)
	local status, exception = pcall(f)
	if not status then
		catch_f(exception)
	end
end
function vehSR_firstToUpper(str)
    return (str:gsub("^%l", string.upper))
end
--local veh = nil
function vehSR_OpenCreator()
	boughtcar = false
	local ped = vehSR_LocalPed()
	local pos = currentlocation.pos.inside
	FreezeEntityPosition(ped,true)
	SetEntityVisible(ped,false)
	SetEntityCoords(ped,pos[1],pos[2],pos[3])
	SetEntityHeading(ped,pos[4])
	vehshop.currentmenu = "Bilforhandler"
	vehshop.opened = true
	vehshop.selectedbutton = 0
end
local vehicle_price = 0
function vehSR_CloseCreator(vehicle,veh_type)
	Citizen.CreateThread(function()
		local ped = vehSR_LocalPed()
		if not boughtcar then
			local pos = currentlocation.pos.entering
			SetEntityCoords(ped,pos[1],pos[2],pos[3])
			FreezeEntityPosition(ped,false)
			SetEntityVisible(ped,true)
		else
			deleteVehiclePedIsIn()
			vRP.teleport({-16.410259246826,-1100.7811279297,26.676038742065})
			vRPg.spawnBoughtVehicle({veh_type, vehicle})
			SetEntityVisible(ped,true)
			FreezeEntityPosition(ped,false)
		end
		vehshop.opened = false
		vehshop.menu.from = 1
		vehshop.menu.to = 10
	end)
end

function vehSR_drawMenuButton(button,x,y,selected)
	local menu = vehshop.menu
	SetTextFont(6)
	SetTextProportional(0)
	SetTextScale(menu.scale, menu.scale)
	if selected then
		SetTextColour(0, 0, 0, 255)
	else
		SetTextColour(255, 255, 255, 255)
	end
	SetTextCentre(0)
	SetTextEntry("STRING")
	AddTextComponentString(button.name)
	if selected then
		DrawRect(x,y,menu.width,menu.height,255,255,255,255)
	else
		DrawRect(x,y,menu.width,menu.height,0,0,0,150)
	end
	DrawText(x - menu.width/2 + 0.005, y - menu.height/2 + 0.0008)
end

function vehSR_drawMenuTitle(txt,x,y)
local menu = vehshop.menu
	SetTextFont(2)
	SetTextProportional(0)
	SetTextScale(0.5, 0.5)
	SetTextColour(255, 255, 255, 255)
	SetTextEntry("STRING")
	AddTextComponentString(txt)
	DrawRect(x,y,menu.width,menu.height,0,0,0,150)
	DrawText(x - menu.width/2 + 0.005, y - menu.height/2 + 0.0008)
end
function vehSR_tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end
function vehSR_Notify(text)
SetNotificationTextEntry('STRING')
AddTextComponentString(text)
DrawNotification(false, false)
end

function vehSR_drawMenuRight(txt,x,y,selected)
	local menu = vehshop.menu
	SetTextFont(2)
	SetTextProportional(0)
	SetTextScale(0.4, 0.4)
	if selected then
		SetTextColour(0, 0, 0, 255)
	else
		SetTextColour(255, 255, 255, 255)
	end
	SetTextCentre(0)
	SetTextEntry("STRING")
	AddTextComponentString(txt)
	DrawText(x + menu.width/2 - 0.04, y - menu.height/2 + 0.0008)
end
local backlock = false
Citizen.CreateThread(function()
	local last_dir
	while true do
		Citizen.Wait(0)
		if IsControlJustPressed(1,51) and vehSR_IsPlayerInRangeOfVehshop() then
			if vehshop.opened then
				vehSR_CloseCreator("","")
			else
				vehSR_OpenCreator()
			end
		end
		if vehshop.opened then
			local ped = vehSR_LocalPed()
			local menu = vehshop.menu[vehshop.currentmenu]
			vehSR_drawTxt(vehshop.title,1,1,vehshop.menu.x,vehshop.menu.y,1.0, 255,255,255,255)
			vehSR_drawMenuTitle(menu.title, vehshop.menu.x,vehshop.menu.y + 0.08)
			vehSR_drawTxt(vehshop.selectedbutton.."/"..vehSR_tablelength(menu.buttons),0,0,vehshop.menu.x + vehshop.menu.width/2 - 0.0385,vehshop.menu.y + 0.067,0.4, 255,255,255,255)
			local y = vehshop.menu.y + 0.12
			buttoncount = vehSR_tablelength(menu.buttons)
			local selected = false

			for i,button in pairs(menu.buttons) do
				if i >= vehshop.menu.from and i <= vehshop.menu.to then

					if i == vehshop.selectedbutton then
						selected = true
					else
						selected = false
					end
					vehSR_drawMenuButton(button,vehshop.menu.x,y,selected)
					if button.costs ~= nil then
							vehSR_drawMenuRight(button.costs.." DKK",0.174,y,selected)
						if vehshop.currentmenu == "Tilbuds biler" or vehshop.currentmenu == "Tilbuds motorcykler" or vehshop.currentmenu == "Kompakte" or vehshop.currentmenu == "Coupeer" or vehshop.currentmenu == "Sedaner" or vehshop.currentmenu == "Sportsvogne" or vehshop.currentmenu == "Sportsklassikere" or vehshop.currentmenu == "Superbiler" or vehshop.currentmenu == "Muskelbiler" or vehshop.currentmenu == "Offroad" or vehshop.currentmenu == "SUV" or vehshop.currentmenu == "Varevogne" or vehshop.currentmenu == "industrial" or vehshop.currentmenu == "cycles" or vehshop.currentmenu == "Motorcykler" or vehshop.currentmenu == "Cykler" then
						else
							vehSR_drawMenuButton(button,vehshop.menu.x,y,selected)
						end
					end
					y = y + 0.04
						if vehshop.currentmenu == "Tilbuds biler" or vehshop.currentmenu == "Tilbuds motorcykler" or vehshop.currentmenu == "Kompakte" or vehshop.currentmenu == "Coupeer" or vehshop.currentmenu == "Sedaner" or vehshop.currentmenu == "Sportsvogne" or vehshop.currentmenu == "Sportsklassikere" or vehshop.currentmenu == "Superbiler" or vehshop.currentmenu == "Muskelbiler" or vehshop.currentmenu == "Offroad" or vehshop.currentmenu == "SUV" or vehshop.currentmenu == "Varevogne" or vehshop.currentmenu == "industrial" or vehshop.currentmenu == "cycles" or vehshop.currentmenu == "Motorcykler" or vehshop.currentmenu == "Cykler" then
						 if selected then
							if fakecar.model ~= button.model then
								if DoesEntityExist(fakecar.car) then
									DeleteEntity(fakecar.car)
								end
								local pos = currentlocation.pos.inside
								local hash = GetHashKey(button.model)
								RequestModel(hash)
								local timer = 0
								while not HasModelLoaded(hash) and timer < 255 do
									Citizen.Wait(1)
									vehSR_drawTxt("Indlæser...",0,1,0.5,0.5,1.5,255,255-timer,255-timer,255)
									RequestModel(hash)
									timer = timer + 1
								end
								if timer < 255 then
									local veh = CreateVehicle(hash,pos[1],pos[2],pos[3],pos[4],false,false)
									while not DoesEntityExist(veh) do
										Citizen.Wait(1)
										vehSR_drawTxt("Indlæser...",0,1,0.5,0.5,1.5,255,255-timer,255-timer,255)
									end
									FreezeEntityPosition(veh,true)
									SetEntityInvincible(veh,true)
									SetVehicleDoorsLocked(veh,4)
									TaskWarpPedIntoVehicle(vehSR_LocalPed(),veh,-1)
									for i = 0,24 do
										SetVehicleModKit(veh,0)
										RemoveVehicleMod(veh,i)
									end
									fakecar = { model = button.model, car = veh}
								else
									timer = 0
									while timer < 25 do
										Citizen.Wait(1)
										vehSR_drawTxt("Indlæsning mislykkedes...",0,1,0.5,0.5,1.5,255,0,0,255)
										timer = timer + 1
									end
									if last_dir then
										if vehshop.selectedbutton < buttoncount then
											vehshop.selectedbutton = vehshop.selectedbutton +1
											if buttoncount > 10 and vehshop.selectedbutton > vehshop.menu.to then
												vehshop.menu.to = vehshop.menu.to + 1
												vehshop.menu.from = vehshop.menu.from + 1
											end
										else
											last_dir = false
											vehshop.selectedbutton = vehshop.selectedbutton -1
											if buttoncount > 10 and vehshop.selectedbutton < vehshop.menu.from then
												vehshop.menu.from = vehshop.menu.from -1
												vehshop.menu.to = vehshop.menu.to - 1
											end
										end
									else
										if vehshop.selectedbutton > 1 then
											vehshop.selectedbutton = vehshop.selectedbutton -1
											if buttoncount > 10 and vehshop.selectedbutton < vehshop.menu.from then
												vehshop.menu.from = vehshop.menu.from -1
												vehshop.menu.to = vehshop.menu.to - 1
											end
										else
											last_dir = true
											vehshop.selectedbutton = vehshop.selectedbutton +1
											if buttoncount > 10 and vehshop.selectedbutton > vehshop.menu.to then
												vehshop.menu.to = vehshop.menu.to + 1
												vehshop.menu.from = vehshop.menu.from + 1
											end
										end
									end
								end
							end
						end
					end
					if selected and IsControlJustPressed(1,201) then
						vehSR_ButtonSelected(button)
					end
				end
			end
			if IsControlJustPressed(1,202) then
				vehSR_Back()
			end
			if IsControlJustReleased(1,202) then
				backlock = false
			end
			if IsControlJustPressed(1,188) then
				last_dir = false
				if vehshop.selectedbutton > 1 then
					vehshop.selectedbutton = vehshop.selectedbutton -1
					if buttoncount > 10 and vehshop.selectedbutton < vehshop.menu.from then
						vehshop.menu.from = vehshop.menu.from -1
						vehshop.menu.to = vehshop.menu.to - 1
					end
				end
			end
			if IsControlJustPressed(1,187)then
				last_dir = true
				if vehshop.selectedbutton < buttoncount then
					vehshop.selectedbutton = vehshop.selectedbutton +1
					if buttoncount > 10 and vehshop.selectedbutton > vehshop.menu.to then
						vehshop.menu.to = vehshop.menu.to + 1
						vehshop.menu.from = vehshop.menu.from + 1
					end
				end
			end
		end

	end
end)


function vehSR_round(num, idp)
  if idp and idp>0 then
    local mult = 10^idp
    return math.floor(num * mult + 0.5) / mult
  end
  return math.floor(num + 0.5)
end
function vehSR_ButtonSelected(button)
	local ped = GetPlayerPed(-1)
	local this = vehshop.currentmenu
	local btn = button.name
	if this == "Bilforhandler" then
		if btn == "Biler" then
			vehSR_OpenMenu('Biler')
		elseif btn == "Motorcykler" then
			vehSR_OpenMenu('Motorcykler')
		elseif btn == "Cykler" then
			vehSR_OpenMenu('Cykler')
		elseif btn == "Tilbuds biler" then
			vehSR_OpenMenu('Tilbuds biler')
		elseif btn == "Tilbuds motorcykler" then
			vehSR_OpenMenu('Tilbuds motorcykler')
		end
	elseif this == "Biler" then
		if btn == "Sportsvogne" then
			vehSR_OpenMenu('Sportsvogne')
		elseif btn == "Sedaner" then
			vehSR_OpenMenu('Sedaner')
		elseif btn == "Kompakte" then
			vehSR_OpenMenu('Kompakte')
		elseif btn == "Coupeer" then
			vehSR_OpenMenu('Coupeer')
		elseif btn == "Sportsklassikere" then
			vehSR_OpenMenu("Sportsklassikere")
		elseif btn == "Superbiler" then
			vehSR_OpenMenu('Superbiler')
		elseif btn == "Muskelbiler" then
			vehSR_OpenMenu('Muskelbiler')
		elseif btn == "Offroad" then
			vehSR_OpenMenu('Offroad')
		elseif btn == "SUV" then
			vehSR_OpenMenu('SUV')
		elseif btn == "Varevogne" then
			vehSR_OpenMenu('Varevogne')
		end
	elseif this == "Tilbuds biler" or this == "Kompakte" or this == "Coupeer" or this == "Sedaner" or this == "Sportsvogne" or this == "Sportsklassikere" or this == "Superbiler" or this == "Muskelbiler" or this == "Offroad" or this == "SUV" or this == "Varevogne" or this == "industrial" then
		TriggerServerEvent('veh_SR:CheckMoneyForVeh',button.model,button.name,button.costs,"car")
    elseif this == "Motorcykler" or this == "Tilbuds motorcykler" then
		TriggerServerEvent('veh_SR:CheckMoneyForVeh',button.model,button.name,button.costs,"bike")
    elseif this == "Cykler" then
		TriggerServerEvent('veh_SR:CheckMoneyForVeh',button.model,button.name,button.costs,"citybike")
	end
end

RegisterNetEvent('veh_SR:CloseMenu')
AddEventHandler('veh_SR:CloseMenu', function(vehicle, veh_type)
	boughtcar = true
	vehSR_CloseCreator(vehicle,veh_type)
end)

function vehSR_OpenMenu(menu)
	fakecar = {model = '', car = nil}
	vehshop.lastmenu = vehshop.currentmenu
	if menu == "Biler" then
		vehshop.lastmenu = "Bilforhandler"
	elseif menu == "Motorcykler"  then
		vehshop.lastmenu = "Bilforhandler"
	elseif menu == 'Cykler' then
		vehshop.lastmenu = "Bilforhandler"
	elseif menu == "Tilbuds biler"  then
		vehshop.lastmenu = "Bilforhandler"
	elseif menu == "Tilbuds motorcykler" then
		vehshop.lastmenu = "Bilforhandler"
	end
	vehshop.menu.from = 1
	vehshop.menu.to = 10
	vehshop.selectedbutton = 0
	vehshop.currentmenu = menu
end

function vehSR_Back()
	if backlock then
		return
	end
	backlock = true
	if vehshop.currentmenu == "Bilforhandler" then
		vehSR_CloseCreator("","")
	elseif vehshop.currentmenu == "Tilbuds biler" or vehshop.currentmenu == "Kompakte" or vehshop.currentmenu == "Coupeer" or vehshop.currentmenu == "Sedaner" or vehshop.currentmenu == "Sportsvogne" or vehshop.currentmenu == "Sportsklassikere" or vehshop.currentmenu == "Superbiler" or vehshop.currentmenu == "Muskelbiler" or vehshop.currentmenu == "Offroad" or vehshop.currentmenu == "SUV" or vehshop.currentmenu == "Varevogne" or vehshop.currentmenu == "industrial" or vehshop.currentmenu == "cycles" or vehshop.currentmenu == "Motorcykler" or vehshop.currentmenu == "Tilbuds motorcykler" or vehshop.currentmenu == "Cykler" then
		if DoesEntityExist(fakecar.car) then
			DeleteEntity(fakecar.car)
		end
		fakecar = {model = '', car = nil}
		vehSR_OpenMenu(vehshop.lastmenu)
	else
		vehSR_OpenMenu(vehshop.lastmenu)
	end

end

function vehSR_stringstarts(String,Start)
   return string.sub(String,1,string.len(Start))==Start
end

function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end