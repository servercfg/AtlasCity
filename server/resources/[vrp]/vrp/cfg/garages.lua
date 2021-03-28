
local cfg = {}
-- define garage types with their associated vehicles
-- (vehicle list: https://wiki.fivem.net/wiki/Vehicles)

-- each garage type is an associated list of veh_name/veh_definition
-- they need a _config property to define the blip and the vehicle type for the garage (each vtype allow one vehicle to be spawned at a time, the default vtype is "default")
-- this is used to let the player spawn a boat AND a car at the same time for example, and only despawn it in the correct garage
-- _config: vtype, blipid, blipcolor, permissions (optional, only users with the permission will have access to the shop)

cfg.rent_factor = 10 -- 10% of the original price if a rent
cfg.sell_factor = 0 -- sell for 75% of the original price

cfg.garage_types = {

	["Taxa"] = {
		_config = {vtype="default", blipid=198, blipcolor=5, permissions = {"taxi.garage"}},
		["taxi"] = {"Taxa", 0, ""}
	},

	["Politi Båd Garage"] = {
		_config = {vtype="boat", permissions = {"police.garage"}},
		["predator"] = {"Politi Båd", 0, ""}
	},

	["Både"] = {
		_config = {vtype="boat",blipid=427,blipcolor=4},
		["seashark"] = {"Jetski",50000, ""},
		["jetmax"] = {"Jetmax",350000, ""},
		["suntrap"] = {"Suntrap",500000, ""},
	},

	["Helikopter Politiet"] = {
		_config = {vtype="helicopter", permissions = {"police.garage"}},
		["polmav"] = {"Politi Helikopter",0,""}
	},

	["Helikopter EMS"] = {
		_config = {vtype="helicopter",blipid=0,blicolor=0, permissions = {"emergency.garage"}},
		["supervolito"] = {"EMS Helikopter",0,""}
	},

	["Politi Garage"] = {
		_config = {vtype="default", permissions = {"police.garage"}},
		["pmcv"] = {"Hakuchou MC", 0, ""},
		["polthrust"] = {"Thruster MC", 0, ""},
		["policeb2"] = {"Offroad MC", 0, ""},
		["coracle"] = {"Oracle [Civil]", 0, ""},
		["cgranger"] = {"Granger [Civil]", 0, ""},
		["cdrafter"] = {"Drafter [Civil]", 0, ""},
		["cballer"] = {"Baller [Civil]", 0, ""},
		["pschafter2"] = {"Schafter", 0, ""},
		["pballer2"] = {"Baller", 0, ""},
		["pbus"] = {"Fængsels Bus", 0, ""},
		["iballer2"] = {"Baller [Indsatsleder]", 0, ""},
		["ischafter2"] = {"Schafter [Indsatsleder]", 0, ""},
		["fibp62"] = {"Vapid Scout", 0, ""},
		["fibp63"] = {"Vapid Scout (Blå)", 0, ""},
		["raidenp"] = {"Raiden", 0, ""},
		["BB2018U"] = {"Buffalo [Civil]", 0, ""},
		["KSRS2018U"] = {"Sultan [Civil]", 0, ""},
		["bcpd6"] = {"Sentinel", 0, ""},
		["bcpd10"] = {"Felon", 0, ""},
	},

	["PET Garage"] = {
		_config = {vtype="default", permissions = {"pet.garage"}},
		["coracle"] = {"Oracle [Civil]", 0, ""},
		["cgranger"] = {"Granger [Civil]", 0, ""},
		["cdrafter"] = {"Drafter [Civil]", 0, ""},
		["cballer"] = {"Baller [Civil]", 0, ""},
		["BB2018U"] = {"Buffalo [Civil]", 0, ""},
		["KSRS2018U"] = {"Sultan [Civil]", 0, ""},
	},

	["EMS Bil"] = {
		_config = {vtype="default", permissions = {"emergency.garage"}},
		["lsambulance"] = {"Ambulance", 0, ""},
		["ambulance22"] = {"Vapid Speedo", 0, ""},
		["ambulance3"] = {"Specialambulance", 0, ""},
		["ems"] = {"Vapid Interceptor", 0, ""},
		["bcpd10a"] = {"Sentinel", 0, ""},
		["lballer2"] = {"Baller", 0, ""},
	},

	["Værksted"] = {
		_config = {vtype="default",blipid=402,blipcolor=4, permissions = {"repair.loadshop"}},
		["flatbed3"] = {"Flatbed", 0, ""},
		["towtruck2"] = {"Tow Truck 2", 0, ""},
		["towtruck"] = {"Tow Truck", 0, ""}
	},

	["Minebilen"] = {
		_config = {vtype="default",blipid=318,blipcolor=4, permissions = {"skralde.vehicle"}},
		["tiptruck"] = {"Minebilen", 0,""},
	},

	["Skraldevogn"] = {
		_config = {vtype="default",blipid=318,blipcolor=4, permissions = {"skralde.vehicle"}},
		["trash"] = {"Skraldevogn", 0,""},
	},

	["Lastbil garage"] = {
		_config = {vtype="default",blipid=477,blipcolor=4,permissions={"trucker.vehicle"}},
		["phantom"] = {"Phantom",0, ""},
		["packer"] = {"Packer",0, ""}
	},

	["Pizza Job"] = {
		_config = {vtype="default",blipid=56,blipcolor=17,permissions={"delivery.vehicle"}},
		["faggio2"] = {"Scooter",0, ""}
	},

	["Falck Vagt"] = {
		_config = {vtype="default", permissions = {"falckvagt.garage"}},
		["falckvagt"] = {"Vagt Bil",0, ""}
	}

}

-- {garage_type,x,y,z}
cfg.garages = {
	{"Politi Båd Garage",-738.80834960938,-2788.3461914063,-0.62692016363144},
	{"Politi Båd Garage",650.94604492188,-1845.4201660156,8.0595712661743},
	{"Politi Båd Garage",-792.35516357422,-1500.3491210938,-0.47498399019241},
	{"Politi Båd Garage",-689.23419189453,6177.9765625,-0.45267567038536},
	--[[{"Politi Garage", 449.77325439453,-1018.7691040039,28.513710021973},
	{"Politi Garage", 1863.0129394531,3704.1630859375,33.439643859863},
	{"Politi Garage", -452.27276611328,5994.9067382813,31.340549468994},
	{"Politi Garage", -991.66143798828,-2983.0874023438,13.945066452026},
	{"Politi Garage", 348.24728393555,-1635.2542724609,23.784440994263},
	{"Politi Garage", 1057.4593505859,-3198.3024902344,5.9029655456543},
	{"PET Garage", -3.1561324596405,-709.93054199219,32.338104248047},
	{"Helikopter Politiet",449.51892089844,-987.99310302734,43.691665649414},
	{"Helikopter Politiet",-475.13912963867,5988.3642578125,31.336708068848},
	{"Helikopter Politiet",1866.1794433594,3648.2150878906,35.77840423584},
	{"Helikopter Politiet",-1145.9259033203,-2864.4560546875,13.946004867554}, 
	{"Helikopter Politiet",363.2087097168,-1598.0445556641,36.948680877686}, 
	{"Helikopter EMS",-252.35554504395,6319.0590820313,39.659595489502},  
	{"Helikopter EMS",351.30996704102,-588.32525634766,74.165664672852}, 
	{"Helikopter EMS",1849.9605712891,3638.923828125,35.77840423584}, 
	{"Helikopter EMS",-475.13912963867,5988.3642578125,31.336708068848},
	{"Helikopter EMS",-1145.9259033203,-2864.4560546875,13.946004867554}, 
    {"EMS Bil",1842.958984375,3706.4206542969,33.601928710938},
	{"EMS Bil",-262.59860229492,6338.517578125,32.329288482666},
	{"EMS Bil",326.12588500977,-549.32189941406,28.743782043457},
	{"EMS Bil",-991.66143798828,-2983.0874023438,13.945066452026},
	{"Værksted",-182.30268859863,-1289.5889892578,31.295980453491},
	{"Værksted",1773.6405029297,3344.4948730469,40.905914306641},]]
	{"Både",-2013.9351806641,-1041.3424072266,-0.4406553208828},
	{"Både",-785.62957763672,-1498.5974121094,-0.086649641394615},
	{"Både",1571.1760253906,3845.3767089844,30.856819152832},
	{"Både",-1806.4201660156,-988.86822509766,0.074662901461124},
	{"Både",3845.25390625,4445.0776367188,-0.017860990017653},
	--{"Taxa", 897.17816162109,-152.6538848877,76.558364868164},
	--{"Minebilen", 496.79681396484,-1970.5522460938,24.905403137207},
	--{"Skraldevogn", 1540.0747070313,-2093.2795410156,77.100486755371},
	--{"Lastbil garage",160.06260681152,6407.921875,31.162828445435},
	--{"Pizza Job", 412.62152099609,107.33561706543,100.92472076416},
	--{"Falck Vagt", 343.9196472168,-556.44708251953,28.743444442749},
}

return cfg
