-- define items, see the Inventory API on github

local cfg = {}
-- see the manual to understand how to create parametric items
-- idname = {name or genfunc, description or genfunc, genfunc choices or nil, weight or genfunc}
-- a good practice is to create your own item pack file instead of adding items here
cfg.items = {
	--[[
	["kniv"] = {"Køkken kniv", "En normal køkken kniv købt i bilka.", nil, 0.01}, -- no choices
	["syre"] = {"Syre", "Ulovligt! Bruges til at fremstille LSD", nil, 0.10}, -- no choices
	["lsd"] = {"LSD", "Ulovligt! Kan sælges.", nil, 0.25}, -- no choices
	["guldmalm"] = {"Guldmalm", "Bruges til fremstilling af guld.", nil, 1.00}, -- minearbejder
	["guldbar"] = {"Guldbar", "Kan sælges videre for penge.", nil, 0.50}, -- minearbejder
	["alumalm"] = {"AluMalm", "Bruges til fremstilling af Aluminium.", nil, 1.00}, -- minearbejder
	["alubar"] = {"Aluminium Bar", "Kan sælges videre for penge.", nil, 0.50}, -- minearbejder
	["tree"] = {"Træstamme", "Stammerne skal hugges op, før de kan bruges til noget.", nil,25.00}, -- træhugger
	["planks"] = {"Planke", "Skal sælges til de byggepladser som efterspørger dem.", nil,5.00}, -- træhugger
	["kokainblade"] = {"Kokainblad", "Bruges til fremstilling af kokain.", nil, 0.10}, -- civil
	["jointpapir"] = {"JointPapir", "Til at lave joints.", nil, 0.01}, -- civil
	["virus"] = {"HackingTaske", "Indenholder bærbar og chip-kort.", nil , 1},
	["svejser"] = {"Skære Brænder", "Bruges til bankrøverier", nil , 1},
	["pose"] = {"Pose", "Kan sættes over hovedet.", nil , 0.05},
	["falsknummerplade"] = {"Falsk nummerplade", "Passer til udlejningsbiler.", nil , 1.00},
	["forlovelsesring"] = {"Forlovelsesring", "Fordi du elsker personen.", nil , 1.00},
	["vielsesring"] = {"Vielsesring", "Når det er gjort officielt.", nil , 1.00},
	["virksomhed"] = {"Advokatbrev", "Underskrevet. - Til at oprette virksomhed.", nil , 1.00},
	["kemikalier"] = {"Kemikalier (Meth)", "Kemikalier til Meth.", nil , 0.10},
	["meth"] = {"Meth", "Meth.", nil , 0.25},
	["kemikalier2"] = {"Kemikalier (Amf)", "Kemikalier til Amf", nil , 0.10},
	["firstlogin"] = {"Dåbsattest", "Bruges til at skifte navn", nil , 0.10},
	["skunkfro"] = {"Skunkfrø", "Kan plantes.", nil , 0.10},
    ["skunk2"] = {"Skunk 1g", "Skal pakkes.", nil , 0.01},
    ["skunk1000"] = {"Skunkplante", "Skal tørres.", nil , 5.00},
    ["klump10"] = {"Pose med skunk (10g)", "Sælges eller åbnes.", nil , 0.10},
	["ristet"] = {"Ristet smøg", "Bruges til Joints.", nil , 0.10},

	--Nicki
	["nicki_juvel"] = {"Juvel", "Juvel, sælg den og få Sorte Penge.", nil , 0.10},
	["nicki_virus"] = {"Virus", "Virus, bruges til at røve Hæveautomat.", nil , 0.10},

	["aluminium"] = {"Aluminium oxide", "Kan laves til aluminium bar", nil, 0.25}, -- no choices
	["aluminiumbar"] = {"Aluminium bar", "Kan sælges for profit", nil, 0.40}, -- no choices

	["steel"] = {"Stål", "Kan laves til rustfri stål", nil, 0.30}, -- no choices
	["stainless"] = {"Rustfri stål", "Kan sælges for profit", nil, 0.50}, -- no choices
	["chromium"] = {"Chromium", "Skal bruges til rustfri stål", nil, 0.05}, -- no choices
	["nickel"] = {"Nickel", "Skal bruges til rustfri stål", nil, 0.05}, -- no choices

	--Biltyveri
	["lockpicking_kit"] = {"Skruetrækker", "Bruges til at åbne biler med sammen med et dirkesæt.", nil, 0.01},
	["falsknummerplade"] = {"Falsk nummerplade", "Passer til udlejningsbiler.", nil , 1.00},

	["sulfur"] = {"Svovl", "Bliver brugt til gummi", nil, 0.10}, -- no choices

	["bank_Penge"] = {"Penge Fra Banken", "DKK.", nil, 0}, -- no choices
	["iphone"] = {"iPhone X", "Bruges til at sende beskeder mm", nil, 0.2},
	["samsung"] = {"Samsung Galaxy S9", "Bruges til at sende beskeder mm", nil, 0.2},
	["oneplus"] = {"OnePlus 6T", "Bruges til at sende beskeder mm", nil, 0.2},
	["træ"] = {"Træ", "Bruges til at laves om til planker", nil, 3},
	["planke"] = {"Planker", "Kan sælges i byen", nil, 1.5},
	["rod"] = {"Mekaniker Rod", "", nil, 0.50}, -- no choices
	["vindruer"] = {"Vindruer", "Kan sælges", nil , 0.01},
	["pakke"] = {"Pakke", "Skal afleveres til kunder", nil , 3.0},
	["brev"] = {"Brev", "Skal afleveres til kunder", nil , 0.5},
	["lægerapport"] = {"Læge Journal", "Bliver krævet afleveret til andet hospital", nil , 0.2},
	["medicin"] = {"Medicin", "Bliver krævet afleveret til andet hospital", nil , 1},
	["dive"] = {"Dykker Udstyr", "Bruges til at dykke med", nil , 1},

	--Amfetamin produktion
	["amf"] = {"Amfetamin", "Amfetamin.", nil, 0.50},
	
	--Keys
	["key_hvidvask"] = {"Nøgle - Slagteriet","Nøgler til slagteriet", nil, 0.01},
	["key_soa"] = {"Nøgle - SOA","Nøgle til klubhuset", nil, 0.01},
	["key_soa_salg"] = {"Nøgle - SOA Salg","Nøgle til salg", nil, 0.01},
	["key_stripklub"] = {"Nøgle - Stripklubben","Nøgler til stripklubben", nil, 0.01},
	["key_yacht"] = {"Nøgle - Yacht","Nøgler til yachten", nil, 0.01},
	["key_ca"] = {"Nøgle - Mekaniker","Nøgler Porten", nil, 0.01},
	["key_advokat"] = {"Nøgle - Advokat","Nøgler til advokatkontor", nil, 0.01},
	["key_realestate"] = {"Nøgle - Ejendomsmægler","Nøgler til ejendomsmægler kontor", nil, 0.01},
	["key_lifeinvader"] = {"Nøgle - Lifeinvader","Nøgler til lifeinvader", nil, 0.01},
	["key_cartel"] = {"Nøgle - Cartel","Nøgler til Cartellets hus", nil, 0.00},
	["key_bilforhandler"] = {"Nøgle - Bilforhandler","Nøgler til Bilforhandleren", nil, 0.01},
	["key_grove3"] = {"Nøgle - Grove street 3","Nøgler til Grove 3", nil, 0.01},
	["key_grove2"] = {"Nøgle - Grove street 2","Nøgler til Grove 2", nil, 0.01},
	["key_grove"] = {"Nøgle - Grove street 2","Nøgler til Grove 2", nil, 0.01},
	["key_ltf3"] = {"Nøgle - LTF3","Nøgler til LTF 3", nil, 0.01},
	["key_lost"] = {"Nøgle - Lost MC","Nøgler til Tequila-la", nil, 0.01},
	["key_bolig1"] = {"Nøgle - Bolig 1","Nøgler til bolig 1", nil, 0.01},
	["key_bolig7"] = {"Nøgle - Bolig 7","Nøgler til bolig 7", nil, 0.01},
	["key_bolig13"] = {"Nøgle - Bolig 13","Nøgler til bolig 13", nil, 0.01},
	["key_bolig10"] = {"Nøgle - Bolig 10","Nøgler til bolig 10", nil, 0.01},
	["key_ejendom2"] = {"Nøgle - Ejendom 2","Nøgler til ejendom 2", nil, 0.01},
	["key_ejendom3"] = {"Nøgle - Ejendom 3","Nøgler til ejendom 3", nil, 0.01},

	-- nøgler
	["1"] = {"💳 Politi nøglekort", "Nøgle Nummer 1", nil, 0.01}, -- PD
	["2"] = {"💳 Hospital nøglekort", "Nøgle Nummer 2", nil, 0.01}, -- Hospital
	["3"] = {"💳 Retssal nøglekort", "Nøgle Nummer 3", nil,0.01}, -- nøgle til retssalen
	["4"] = {"🔑 4", "Nøgle Nummer 4", nil, 0.01}, -- Skummel Lejlighed
	["5"] = {"🔑 5", "Nøgle Nummer 5", nil, 0.01}, -- Michaels Hus
	["6"] = {"🔑 6", "Nøgle Nummer 6", nil, 0.01}, -- Denices Hus
	["7"] = {"🔑 7", "Nøgle Nummer 7", nil, 0.01}, -- Franklins hus
	["8"] = {"🔑 8", "Nøgle Nummer 8", nil, 0.01}, -- Rockerborgen
	["9"] = {"🔑 9", "Nøgle Nummer 9", nil, 0.01}, -- Natklub
	["10"] = {"🔑 10", "Nøgle Nummer 10", nil, 0.01}, -- Floyds Lejlighed
	["11"] = {"🔑 11", "Nøgle Nummer 11", nil, 0.01}, -- Trevors Trailer
	["12"] = {"🔑 12", "Nøgle Nummer 12", nil, 0.01}, -- HomeBase Autoservice
	["13"] = {"🔑 13", "Nøgle Nummer 13", nil, 0.01}, -- Homebases Ejendomskontor
	["14"] = {"🔑 14", "Nøgle Nummer 14", nil, 0.01}, -- La Blanca
	["15"] = {"🔑 15", "Nøgle Nummer 15", nil, 0.01}, -- Advokat kontor
	["16"] = {"🔑 16", "Nøgle Nummer 16", nil, 0.01}, -- Bilforhandler
	["17"] = {"🔑 17", "Nøgle Nummer 17", nil, 0.01}, -- BeachHouse
	["18"] = {"🔑 18", "Nøgle Nummer 18", nil, 0.01}, -- Anonymous
	["19"] = {"🔑 19", "Nøgle Nummer 19", nil, 0.01}, -- Skunksalg
	["20"] = {"🔑 20", "Nøgle Nummer 20", nil, 0.01}, -- KokainSalg
	["21"] = {"🔑 21", "Nøgle Nummer 21", nil, 0.01}, -- KazoonsHåndværkerFirma
	["22"] = {"🔑 22", "Nøgle Nummer 22", nil, 0.01}, -- Ha Klubhus


  -- Våben
	["wbody|WEAPON_VINTAGEPISTOL"] = {"Fartmåler", "", nil, 0.01},
	["wammo|WEAPON_VINTAGEPISTOL"] = {"Fartmåler ammo", "", nil, 0.01},
	["wbody|WEAPON_PISTOL"] = {"Håndpistol", "", nil, 0.01},
	["wammo|WEAPON_PISTOL"] = {"Håndpistol ammo", "", nil, 0.01},
	["wbody|WEAPON_PISTOL_MK2"] = {"Håndpistol Mk2", "", nil, 0.01},
	["wammo|WEAPON_PISTOL_MK2"] = {"Håndpistol Mk2 ammo", "", nil, 0.01},
	["wbody|WEAPON_MARKSMANPISTOL"] = {"Marksmanpistol", "", nil, 0.01},
	["wammo|WEAPON_MARKSMANPISTOL"] = {"Marksmanpistol ammo", "", nil, 0.01},
	["wbody|WEAPON_SNSPISTOL"] = {"SNS Pistol", "", nil, 0.01},
	["wammo|WEAPON_SNSPISTOL"] = {"SNS Pistol ammo", "", nil, 0.01},
	["wbody|WEAPON_REVOLVER"] = {"Smith&Wesson", "", nil, 0.01},
	["wammo|WEAPON_REVOLVER"] = {"Smith&Wesson ammo", "", nil, 0.01},
	["wbody|WEAPON_HEAVYPISTOL"] = {"Heavypistol", "", nil, 0.01},
	["wammo|WEAPON_HEAVYPISTOL"] = {"Heavypistol ammo", "", nil, 0.01},
	["wbody|WEAPON_MACHINEPISTOL"] = {"Maskinpistol", "", nil, 0.01},
	["wammo|WEAPON_MACHINEPISTOL"] = {"Maskinpistol ammo", "", nil, 0.01},
	["wbody|WEAPON_PISTOL50"] = {".50 Desert Eagle", "", nil, 0.01},
	["wammo|WEAPON_PISTOL50"] = {".50 Desert Eagle ammo", "", nil, 0.01},
	["wbody|WEAPON_MOLOTOV"] = {"Molotov", "", nil, 0.01},
	["wammo|WEAPON_MOLOTOV"] = {"Molotov brændstof", "", nil, 0.01},
	["wbody|WEAPON_PUMPSHOTGUN"] = {"Pumpshotgun", "", nil, 0.01},
	["wammo|WEAPON_PUMPSHOTGUN"] = {"Pumpshotgun shells", "", nil, 0.01},
	["wbody|WEAPON_ASSAULTSHOTGUN"] = {"Kampshotgun", "", nil, 0.01},
	["wammo|WEAPON_ASSAULTSHOTGUN"] = {"Kampshotgun shells", "", nil, 0.01},
	["wbody|WEAPON_SAWNOFFSHOTGUN"] = {"Afskåret shotgun", "", nil, 0.01},
	["wammo|WEAPON_SAWNOFFSHOTGUN"] = {"Afskåret shotgun shells", "", nil, 0.01},
	["wbody|WEAPON_ASSAULTRIFLE"] = {"Kamprifle", "", nil, 0.01},
	["wammo|WEAPON_ASSAULTRIFLE"] = {"Kamprifle ammo", "", nil, 0.01},
	["wbody|WEAPON_CARBINERIFLE"] = {"Karbinriffel", "", nil, 0.01},
	["wammo|WEAPON_CARBINERIFLE"] = {"Karbinriffel ammo", "", nil, 0.01},
	["wbody|WEAPON_HEAVYSNIPER"] = {"Snigskytte riffel", "", nil, 0.01},
	["wammo|WEAPON_HEAVYSNIPER"] = {"Snigskytte riffel ammo", "", nil, 0.01},
	["wbody|WEAPON_SNIPERRIFLE"] = {"Jagtriffel", "", nil, 0.01},
	["wammo|WEAPON_SNIPERRIFLE"] = {"Jagtriffel ammo", "", nil, 0.01},
	["wbody|WEAPON_GUSENBERG"] = {"Tommygun", "", nil, 0.01},
	["wammo|WEAPON_GUSENBERG"] = {"Tommygun drum-mag", "", nil, 0.01},
	["wbody|WEAPON_STUNGUN"] = {"Strømpistol", "", nil, 0.01},
	["wbody|WEAPON_COMBATPISTOL"] = {"Tjenestepistol", "", nil, 0.01},
	["wammo|WEAPON_COMBATPISTOL"] = {"Tjenestepistol ammo", "", nil, 0.01},
	["wbody|WEAPON_COMBATPDW"] = {"Kamp PDW", "", nil, 0.01},
	["wammo|WEAPON_COMBATPDW"] = {"Kamp PDW ammo", "", nil, 0.01},
	["wbody|WEAPON_CARBINERIFLE_MK2"] = {"Karbinriffel Mk2", "", nil, 0.01},
	["wammo|WEAPON_CARBINERIFLE_MK2"] = {"Karbinriffel Mk2 ammo", "", nil, 0.01},
	["wbody|WEAPON_HEAVYSNIPER_MK2"] = {"Barrett M82 .50cal", "", nil, 0.01},
	["wammo|WEAPON_HEAVYSNIPER_MK2"] = {"Barrett M82 .50cal ammo", "", nil, 0.01},
	["wbody|WEAPON_SMG"] = {"SMG", "", nil, 0.01},
	["wammo|WEAPON_SMG"] = {"SMG ammo", "", nil, 0.01},
	["wbody|WEAPON_MINISMG"] = {"MiniSMG", "", nil, 0.01},
	["wammo|WEAPON_MINISMG"] = {"MiniSMG ammo", "", nil, 0.01},
	["wbody|WEAPON_MICROSMG"] = {"MicroSMG", "", nil, 0.01},
	["wammo|WEAPON_MICROSMG"] = {"MicroSMG ammo", "", nil, 0.01},
	["wbody|WEAPON_BATTLEAXE"] = {"Kampøkse", "", nil, 0.01},
	["wbody|WEAPON_BALL"] = {"Baseballbold", "", nil, 0.01},
	["wbody|WEAPON_GOLFCLUB"] = {"Golfkølle", "", nil, 0.01},
	["wbody|WEAPON_KNIFE"] = {"Kniv", "", nil, 0.01},
	["wbody|WEAPON_BAT"] = {"Baseball bat", "", nil, 0.01},
	["wbody|WEAPON_POOLCUE"] = {"Poolkø", "", nil, 0.01},
	["wbody|WEAPON_MACHETE"] = {"Machete", "", nil, 0.01},
	["wbody|WEAPON_CROWBAR"] = {"Brækjern", "", nil, 0.01},
	["wbody|WEAPON_SWITCHBLADE"] = {"Foldekniv", "", nil, 0.01},
	["wbody|WEAPON_KNUCKLE"] = {"Knojern", "", nil, 0.01},
	["wbody|WEAPON_WRENCH"] = {"Svensknøgle", "", nil, 0.01},
	["wbody|WEAPON_HAMMER"] = {"Hammer", "", nil, 0.01},
	
	---- STRIPS/POSER ---------
	["strips"] = {"Strips", "", nil, 0.01},
	["pose"] = {"Pose", "", nil, 0.01},
	
	---- Items ----
	["paraply"] = {"Paraply", "", nil, 0.01},
	["unicorn"] = {"Unicorn", "", nil, 0.01},
	["stok"] = {"Stok", "", nil, 0.01},
	["kuffert"] = {"Kuffert", "", nil, 0.01},
	["box"] = {"Box", "", nil, 0.01},

	---- Burger Shot ----
	["burger"] = {"Burger", "", nil, 0.01}]]

  }

-- load more items function
local function load_item_pack(name)
  local items = module("cfg/item/"..name)
  if items then
    for k,v in pairs(items) do
      cfg.items[k] = v
    end
  else
    print("[vRP] item pack ["..name.."] not found")
  end
end

-- PACKS
load_item_pack("ting")
load_item_pack("required")
load_item_pack("jobs")
load_item_pack("food")
load_item_pack("drugs")

return cfg
