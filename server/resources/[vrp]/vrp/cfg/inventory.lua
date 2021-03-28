local cfg = {}

cfg.inventory_weight_per_strength = 10 -- weight for an user inventory per strength level (no unit, but thinking in "kg" is a good norm)

-- default chest weight for vehicle trunks
cfg.default_vehicle_chest_weight = 100

-- define vehicle chest weight by model in lower case
cfg.vehicle_chest_weights = {
-- lastbiler
	["tiptruck"] = 250,
	["rumpo2"] = 150,
	["minivan"] = 150,
	["moonbeam2"] = 150,
	["speedo4"] = 150,
	["surfer"] = 150,
	["bf400"] = 5,
	["akuma"] = 5,
	["sanchez"] = 5,
	["bati"] = 5,
	["dubsta2"] = 80,
	["granger"] = 100,
	["yosemite"] = 100,
	["bobcatxl"] = 100,
	["journey"] = 450,
	["camper"] = 400,
	["bison"] = 100,
	["burrito4"] = 150,
	["burrito"] = 150,
	["youga"] = 150,
	["paradise"] = 150,
	["bmx"] = 0,
	["cruiser"] = 0,
	["fixter"] = 0,
	["scorcher"] = 0,
	["tribike"] = 0,
	["tribike2"] = 0,
	["tribike3"] = 0,
	["gargoyle"] = 2,
	["dubsta3"] = 200,
	["rumpo"] = 300,
	["mule3"] = 300,
	["mule4"] = 1000,
	["sandking"] = 125,
	["rumpo3"] = 200,
	["contender"] = 100,
	["double"] = 5,
	["rebla"] = 150,
	["everon"] = 250,
	["landstalker2"] = 250,
}

return cfg
