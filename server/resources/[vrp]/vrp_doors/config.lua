local cfg = {}

cfg.doors = {
    --Hospitalet
    [1] = {locked = false, key = "key_ems", permission="ems.key", name = "Midtby Hospital",hash=-434783486,coords={303.4296875,-581.71002197266,43.283985137939}, pairs = 2},
    [2] = {locked = false, key = "key_ems", permission="ems.key", name = "Midtby Hospital",hash=-1700911976,coords={304.49063110352,-582.02996826172,43.283885955811}, pairs = 1},
    [3] = {locked = true, key = "key_ems", permission="ems.key", name = "Midtby Hospital",hash=854291622,coords={303.67324829102,-597.21862792969,43.284027099609}},
    [4] = {locked = true, key = "key_ems", permission="ems.key", name = "Midtby Hospital",hash=854291622,coords={308.43585205078,-597.42718505859,43.284027099609}},
    [5] = {locked = true, key = "key_ems", permission="ems.key", name = "Midtby Hospital",hash=854291622,coords={313.17636108398,-596.12017822266,43.284023284912}},
    [6] = {locked = true, key = "key_ems", permission="ems.key", name = "Midtby Hospital",hash=-434783486,coords={327.853515625,-593.40747070313,43.284030914307}, pairs = 7},
    [7] = {locked = true, key = "key_ems", permission="ems.key", name = "Midtby Hospital",hash=-1700911976,coords={327.58322143555,-594.50018310547,43.283905029297}, pairs = 6},
    [8] = {locked = true, key = "key_ems", permission="ems.key", name = "Midtby Hospital",hash=-434783486,coords={324.95208740234,-589.53344726563,43.283981323242}, pairs = 9},
    [9] = {locked = true, key = "key_ems", permission="ems.key", name = "Midtby Hospital",hash=-1700911976,coords={326.01397705078,-589.84918212891,43.283893585205}, pairs = 8},
    [10] = {locked = true, key = "key_ems", permission="ems.key", name = "Midtby Hospital",hash=854291622,coords={304.21951293945,-571.92895507813,43.284030914307}},
    [11] = {locked = true, key = "key_ems", permission="ems.key", name = "Midtby Hospital",hash=854291622,coords={307.83029174805,-569.81500244141,43.284027099609}},
    [12] = {locked = true, key = "key_ems", permission="ems.key", name = "Midtby Hospital",hash=-434783486,coords={312.76507568359,-571.68157958984,43.284027099609}, pairs = 13},
    [13] = {locked = true, key = "key_ems", permission="ems.key", name = "Midtby Hospital",hash=-1700911976,coords={313.70886230469,-571.97253417969,43.28394317627}, pairs = 12},
    [14] = {locked = true, key = "key_ems", permission="ems.key", name = "Midtby Hospital",hash=-434783486,coords={318.45733642578,-573.67120361328,43.283985137939}, pairs = 15},
    [15] = {locked = true, key = "key_ems", permission="ems.key", name = "Midtby Hospital",hash=-1700911976,coords={319.65469360352,-574.10369873047,43.283790588379}, pairs = 14},
    [16] = {locked = false, key = "key_ems", permission="ems.key", name = "Midtby Hospital",hash=-434783486,coords={317.8645324707,-579.00628662109,43.283981323242}, pairs = 17},
    [17] = {locked = false, key = "key_ems", permission="ems.key", name = "Midtby Hospital",hash=-1700911976,coords={316.58233642578,-578.62408447266,43.283805847168}, pairs = 16},
    [18] = {locked = true, key = "key_ems", permission="ems.key", name = "Midtby Hospital",hash=-434783486,coords={323.92651367188,-575.63067626953,43.283981323242}, pairs = 19},
    [19] = {locked = true, key = "key_ems", permission="ems.key", name = "Midtby Hospital",hash=-1700911976,coords={325.07723999023,-576.19866943359,43.283798217773}, pairs = 18}, 
    [20] = {locked = true, key = "key_ems", permission="ems.key", name = "Midtby Hospital",hash=-434783486,coords={326.26870727539,-578.63500976563,43.283985137939}, pairs = 21},
    [21] = {locked = true, key = "key_ems", permission="ems.key", name = "Midtby Hospital",hash=-1700911976,coords={325.85556030273,-579.86480712891,43.283790588379}, pairs = 20}, 
    [22] = {locked = true, key = "key_ems", permission="ems.key", name = "Midtby Hospital",hash=854291622,coords={336.83505249023,-580.42071533203,43.283981323242}},
    [23] = {locked = true, key = "key_ems", permission="ems.key", name = "Midtby Hospital",hash=854291622,coords={341.43133544922,-582.04272460938,43.283981323242}},
    [24] = {locked = true, key = "key_ems", permission="ems.key", name = "Midtby Hospital",hash=854291622,coords={339.58447265625,-587.12145996094,43.283981323242}},
    [25] = {locked = true, key = "key_ems", permission="ems.key", name = "Midtby Hospital",hash=854291622,coords={337.55917358398,-592.7333984375,43.283988952637}},
    [26] = {locked = true, key = "key_ems", permission="ems.key", name = "Midtby Hospital",hash=854291622,coords={347.51733398438,-584.30877685547,43.283988952637}}, 
    [27] = {locked = true, key = "key_ems", permission="ems.key", name = "Midtby Hospital",hash=-434783486,coords={349.11386108398,-586.92059326172,43.283988952637}, pairs = 28},
    [28] = {locked = true, key = "key_ems", permission="ems.key", name = "Midtby Hospital",hash=-1700911976,coords={348.53439331055,-588.14978027344,43.283855438232}, pairs = 27},
    [29] = {locked = true, key = "key_ems", permission="ems.key", name = "Midtby Hospital",hash=854291622,coords={346.9641418457,-592.83551025391,43.28401184082}},
    [30] = {locked = true, key = "key_ems", permission="ems.key", name = "Midtby Hospital",hash=854291622,coords={345.63702392578,-596.65826416016,43.28401184082}},
    [31] = {locked = true, key = "key_ems", permission="ems.key", name = "Midtby Hospital",hash=854291622,coords={350.61248779297,-598.6162109375,43.28401184082}},
    [32] = {locked = true, key = "key_ems", permission="ems.key", name = "Midtby Hospital",hash=854291622,coords={351.95944213867,-594.89111328125,43.28401184082}},
    [33] = {locked = true, key = "key_ems", permission="ems.key", name = "Midtby Hospital",hash=854291622,coords={355.73513793945,-584.08813476563,43.28401184082}},
    [34] = {locked = true, key = "key_ems", permission="ems.key", name = "Midtby Hospital",hash=854291622,coords={357.3948059082,-580.39916992188,43.28401184082}},
    [35] = {locked = true, key = "key_ems", permission="ems.key", name = "Midtby Hospital",hash=854291622,coords={361.17303466797,-589.19293212891,43.284030914307}},
    [36] = {locked = true, key = "key_ems", permission="ems.key", name = "Midtby Hospital",hash=854291622,coords={359.40896606445,-594.07403564453,43.284027099609}},
    --Paleto Hospital 
    [37] = {locked = true, key = "key_ems", permission="ems.key", name = "Paleto Hospital",hash=613848716,coords={-243.46711730957,6324.37109375,32.426132202148}},
    [38] = {locked = true, key = "key_ems", permission="ems.key", name = "Paleto Hospital",hash=613848716,coords={-244.31634521484,6325.1235351563,32.426776885986}},
    [39] = {locked = true, key = "key_ems", permission="ems.key", name = "Paleto Hospital",hash=613848716,coords={-248.56239318848,6329.4077148438,32.426414489746}},
    [40] = {locked = true, key = "key_ems", permission="ems.key", name = "Paleto Hospital",hash=613848716,coords={-249.52731323242,6330.2705078125,32.426975250244}},
    [41] = {locked = true, key = "key_ems", permission="ems.key", name = "Paleto Hospital",hash=613848716,coords={-249.23112487793,6332.2890625,32.426136016846}},
    [42] = {locked = true, key = "key_ems", permission="ems.key", name = "Paleto Hospital",hash=613848716,coords={-248.38391113281,6333.1782226563,32.426429748535}},
    [43] = {locked = true, key = "key_ems", permission="ems.key", name = "Paleto Hospital",hash=-770740285,coords={-251.90225219727,6329.6743164063,32.427173614502}},
    [44] = {locked = true, key = "key_ems", permission="ems.key", name = "Paleto Hospital",hash=-770740285,coords={-252.71714782715,6328.9370117188,32.427188873291}},
    [45] = {locked = true, key = "key_ems", permission="ems.key", name = "Paleto Hospital",hash=-770740285,coords={-251.59478759766,6322.8530273438,32.427188873291}},
    [46] = {locked = true, key = "key_ems", permission="ems.key", name = "Paleto Hospital",hash=-770740285,coords={-250.71264648438,6322.0849609375,32.427188873291}},
    [47] = {locked = true, key = "key_ems", permission="ems.key", name = "Paleto Hospital",hash=1415151278,coords={-251.24731445313,6319.4111328125,32.427188873291}},
    [48] = {locked = true, key = "key_ems", permission="ems.key", name = "Paleto Hospital",hash=1415151278,coords={-252.26467895508,6318.513671875,32.427188873291}},
    [49] = {locked = true, key = "key_ems", permission="ems.key", name = "Paleto Hospital",hash=-770740285,coords={-254.86154174805,6321.6772460938,32.427188873291}},
    [50] = {locked = true, key = "key_ems", permission="ems.key", name = "Paleto Hospital",hash=-770740285,coords={-254.11401367188,6322.4619140625,32.427188873291}},
    [51] = {locked = true, key = "key_ems", permission="ems.key", name = "Paleto Hospital",hash=-770740285,coords={-256.91879272461,6313.8666992188,32.427219390869}},
    [52] = {locked = true, key = "key_ems", permission="ems.key", name = "Paleto Hospital",hash=613848716,coords={-262.14559936523,6310.6953125,32.427207946777}, pairs = 172},
    [172] = {locked = true, key = "key_ems", permission="ems.key", name = "Paleto Hospital",hash=613848716,coords={-263.10305786133,6311.5786132813,32.430000305176}, pairs = 52},
    --Michaels hus
    [53] = { locked = true, key = "5", permission="colombo.keycard", name = "5", hash =  "v_ilev_mm_doorm_r", coords={ -816.34075927734, 178.02558898926,72.227691650391}, pairs = 54},
    [54] = { locked = true, key = "5", permission="colombo.keycard", name = "5", hash =  "v_ilev_mm_doorm_l", coords={ -816.58001708984, 178.50416564941,72.227813720703}, pairs = 53},     
    [55] = { locked = true, key = "5", permission="colombo.keycard", name = "5", hash =  "v_ilev_mm_door", coords={ -807.15789794922, 185.71429443359,72.484481811523}},
    [57] = { locked = true, key = "5", permission="colombo.keycard", name = "5", hash =  "prop_bh1_48_backdoor_l", coords={-796.09320068359, 177.35055541992,72.835258483887}, pairs = 56},   
    [56] = { locked = true, key = "5", permission="colombo.keycard", name = "5", hash =  "prop_bh1_48_backdoor_l", coords={-793.64440917969, 181.22857666016,72.83528137207}, pairs = 57},
    [58] = { locked = true, key = "5", permission="colombo.keycard", name = "5", hash =  "prop_bh1_48_backdoor_r", coords={ -795.15954589844, 177.74322509766,72.835266113281}, pairs = 59},    
    [59] = { locked = true, key = "5", permission="colombo.keycard", name = "5", hash =  "prop_bh1_48_backdoor_r", coords={ -793.95068359375, 182.0545501709,72.835350036621}, pairs = 58},
    [60] = { locked = true, key = "5", permission="colombo.keycard", name = "5", hash =  -2125423493, coords={ -843.4931, 155.8496,66.8763}},
    --Denice's hus
    [61] = { locked = true, key = "6", permission="antonio.key", name = "6", hash =  520341586, coords={ -14.1750, -1440.6750, 31.1015}},
    --Franklins hus
    [62] = { locked = true, key = "7", permission="ltf.key", name = "7", hash =  308207762, coords={ 8.1706, 538.9403, 176.0281}},           
    --BeachHouse
    [63] = { locked = true, key = "17", permission="", name = "17", hash =  -607040053, coords={ -1149.8902, -1521.6926, 10.6280}},
    --Retssalen   
    [64] = { locked = true, key = "3", permission="", name = "3", hash =  34120519,  coords={ 227.5726, -416.0190,-118.4651}},
    -- La Blanca
    [65] = { locked = true, key = "14", permission="mafia.key", name = "14", hash =  "v_ilev_ra_door4l", coords={ 1395.920, 1142.904,114.700}, pairs = 66}, -- front left
    [66] = { locked = true, key = "14", permission="mafia.key", name = "14", hash =  "v_ilev_ra_door4r", coords={ 1395.919, 1140.704,114.790}, pairs = 65}, -- front right
    [67] = { locked = true, key = "14", permission="mafia.key", name = "14", hash =  "v_ilev_ra_door1_r", coords={1398.289,1128.314,114.4836}},
    [68] = { locked = true, key = "14", permission="mafia.key", name = "14", hash =  "v_ilev_ra_door1_l", coords={1400.489,1128.314,114.4836}},
    [69] = { locked = true, key = "14", permission="mafia.key", name = "14", hash =  "v_ilev_ra_door1_r", coords={1400.488,1128.314,114.4836}},
    [70] = { locked = true, key = "14", permission="mafia.key", name = "14", hash =  "v_ilev_ra_door1_l", coords={1402.688,1128.314,114.4836}},
    [71] = { locked = true, key = "14", permission="mafia.key", name = "14", hash =  "v_ilev_ra_door1_r", coords={1409.292,1150.654,114.4869}},
    [72] = { locked = true, key = "14", permission="mafia.key", name = "14", hash =  "v_ilev_ra_door1_l", coords={1409.292,1148.454,114.4869}},
    [73] = { locked = true, key = "14", permission="mafia.key", name = "14", hash =  "v_ilev_ra_door1_r", coords={1409.292,1148.454,114.4869}},
    [74] = { locked = true, key = "14", permission="mafia.key", name = "14", hash =  "v_ilev_ra_door1_l", coords={1409.292,1146.254,114.4869}},
    [75] = { locked = true, key = "14", permission="mafia.key", name = "14", hash =  "v_ilev_ra_door1_r", coords={1409.292,1146.254,114.4869}},
    [76] = { locked = true, key = "14", permission="mafia.key", name = "14", hash =  "v_ilev_ra_door1_l", coords={1409.292,1144.054,114.4869}},
    [271] = { locked = true, key = "14", permission="mafia.key", name = "14", hash =  -1032171637, coords={1391.002,1131.556,114.3337}},
    [272] = { locked = true, key = "14", permission="mafia.key", name = "14", hash =  -52575179, coords={1391.178,1132.736,114.3337}},
    [273] = { locked = true, key = "14", permission="mafia.key", name = "14", hash =  -1032171637, coords={1390.941,1162.923,114.3725}},
    [274] = { locked = true, key = "14", permission="mafia.key", name = "14", hash =  -52575179, coords={1390.862,1161.666,114.3725}},
    [275] = { locked = true, key = "14", permission="mafia.key", name = "14", hash =  -1032171637, coords={1408.125,1160.659,114.3342}},
    [276] = { locked = true, key = "14", permission="mafia.key", name = "14", hash =  -52575179, coords={1408.275,1159.444,114.3342}},
    [277] = { locked = true, key = "14", permission="mafia.key", name = "14", hash =  -1032171637, coords={1408.165,1165.342,114.3342}},
    [278] = { locked = true, key = "14", permission="mafia.key", name = "14", hash =  -52575179, coords={1408.253,1164.133,114.3342}},
    --PET kontor
    [77] = { locked = true, key = "15", permission="pet.keycard", name = "15", hash =  "v_ilev_fib_door2", coords={ 121.21444702148, -757.10894775391,242.15208435059}}, -- front left
    [78] = { locked = true, key = "15", permission="pet.keycard", name = "15", hash =  "v_ilev_fib_door2", coords={ 127.42668151855, -763.98931884766,242.15208435059}}, -- front right
    [79] = { locked = true, key = "15", permission="pet.keycard", name = "15", hash =  "v_ilev_fib_door2", coords={ 119.02278900146, -734.02886962891,242.15196228027}}, -- front right
    --SALGSSTEDER 
    --[80] = { locked = true, key = "", permission="sellroom.whitelisted", name = "Købmanden", hash =  "v_ilev_epsstoredoor", coords={ 242.5555, 360.6089,105.8533}},      
    --FÆNGSEL
    [81] = { locked = true, key = "1", permission="cop.keycard", name = "1", hash =  741314661, coords={ 1845.0246582031, 2608.3833007813,45.588790893555}, range = 10},
    [82] = { locked = true, key = "1", permission="cop.keycard", name = "1", hash =  741314661, coords={ 1818.4844970703, 2608.4245605469,45.594127655029}, range = 10},
    --KAZOONS HÅNDVÆRKERFIRMA  
    [83] = { locked = true, key = "21", permission="strip.keycard", name = "21", hash =  "v_ilev_roc_door2", coords={ 99.571685791016, -1293.2911376953,29.268753051758}},
    [84] = { locked = true, key = "21", permission="strip.keycard", name = "21", hash =  "prop_magenta_door", coords={ 95.564407348633, -1285.1196289063,29.278381347656}},
    --HELLS ANGELS
    --[85] = { locked = true, key = "22", permission="", name = "22", hash =  "v_ilev_tort_door", coords={ 134.4093170166, -2203.4624023438,7.3598127365112}},      
    --EKSTRA TIL KÆLDERHOSPITAL        
    [86] = { locked = true, key = "2", permission="ems.keycard", name = "2", hash =  "v_ilev_cor_firedoor", coords={ 251.61546325684, -1365.6739501953,24.537788391113}, pairs = 87},
    [87] = { locked = true, key = "2", permission="ems.keycard", name = "2", hash =  "v_ilev_cor_firedoor", coords={ 252.44039916992, -1366.3625488281,24.537811279297}, pairs = 86},
    --SonsOfAnarchy
    [88] = { locked = true, key = "8", permission="", name = "8", hash =  "prop_facgate_01", coords={ 957.348, -138.583, 73.562}, range = 10},
    --FightClubThingy
    --[89] = { locked = true, key = "8", permission="", name = "8", hash =  "prop_fnclink_02gate6_r", coords={ 964.043, -188.9519,73.48999}},
    --EKSTRA TIL PD SANDY (KAZOON)
    [90] = { locked = true, key = "1", permission="cop.keycard", name = "1", hash =  "v_ilev_ph_cellgate", coords={ 1848.3480224609, 3681.1394042969,34.286602020264}},
    [91] = { locked = true, key = "1", permission="cop.keycard", name = "1", hash =  "v_ilev_ph_cellgate", coords={ 1846.0610351563, 3684.9367675781,34.286643981934}},
	--NIGHTCLUB
	[92] = { locked = true, key = "9", permission="kartel.key", name = "Natklub", hash =  "ba_prop_door_club_glass", coords={ -1621.751953125,-3015.9489746094,-75.205078125}},
	[93] = { locked = true, key = "9", permission="kartel.key", name = "Natklub", hash =  "ba_prop_door_club_glam_generic", coords={ -1621.3787841797,-3019.1606445313,-75.205078125}},
	[94] = { locked = true, key = "9", permission="kartel.key", name = "Natklub", hash =  "ba_prop_door_club_generic_vip", coords={ -1607.4812011719,-3006.1018066406,-75.205146789551}},
	[95] = { locked = true, key = "9", permission="kartel.key", name = "Natklub", hash =  "ba_prop_door_club_edgy_generic", coords={ -1583.4389648438,-3005.720703125,-76.004959106445}},
	--EKSTRA TIL STRIPKLUBBEN v_ilev_door_orangesolid
	[96] = { locked = true, key = "21", permission="strip.keycard", name = "21", hash =  "v_ilev_door_orangesolid", coords={ 113.65085601807, -1296.8083496094,29.268762588501}},
	--Tequila
    [97] = { locked = true, key = "10", permission="diablos.key", name = "10", hash =  "v_ilev_roc_door3", coords={ -568.20495605469,281.09652709961,82.976066589355}}, -- Garderobe
    [98] = { locked = true, key = "10", permission="diablos.key", name = "10", hash =  "v_ilev_roc_door4", coords={ -562.00219726563,293.64669799805,87.627990722656}}, -- Bagdør
    [99] = { locked = true, key = "10", permission="diablos.key", name = "10", hash =  "v_ilev_roc_door2", coords={ -569.76776123047,293.07702636719,79.176704406738}}, -- Under
	--PD LSCUSTOMS		
	[100] = { locked = true, key = "1", permission="cop.keycard", name = "1", hash =  "prop_com_gar_door_01", coords={ 452.34289550781,-1001.1693115234,25.709547042847}, range = 5},
	[101] = { locked = true, key = "1", permission="cop.keycard", name = "1", hash =  "prop_com_gar_door_01", coords={ 447.41268920898,-1001.1377563477,25.709869384766}, range = 5},
	-- Fænglet
	[102] = { locked = true, key = "1", permission="cop.keycard", name = "1", hash =  "v_ilev_gtdoor", coords={ 1658.584,2397.722,45.71526}},
	[103] = { locked = true, key = "1", permission="cop.keycard", name = "1", hash =  "v_ilev_gtdoor", coords={ 1759.62,2412.837,45.71166}},
	[104] = { locked = true, key = "1", permission="cop.keycard", name = "1", hash =  "v_ilev_gtdoor", coords={ 1821.17,2476.265,45.68915}},
	[105] = { locked = true, key = "1", permission="cop.keycard", name = "1", hash =  "v_ilev_gtdoor", coords={ 1820.77,2620.77,45.95126}},
	[106] = { locked = true, key = "1", permission="cop.keycard", name = "1", hash =  "v_ilev_gtdoor", coords={ 1845.79,2698.621,45.95531}},
	[107] = { locked = true, key = "1", permission="cop.keycard", name = "1", hash =  "v_ilev_gtdoor", coords={ 1773.108,2759.7,45.88673}},
	[108] = { locked = true, key = "1", permission="cop.keycard", name = "1", hash =  "v_ilev_gtdoor", coords={ 1651.161,2755.436,45.87868}},
	[109] = { locked = true, key = "1", permission="cop.keycard", name = "1", hash =  "v_ilev_gtdoor", coords={ 1572.662,2679.191,45.72976}},
	[110] = { locked = true, key = "1", permission="cop.keycard", name = "1", hash =  "v_ilev_gtdoor", coords={ 1537.811,2585.995,45.68915}},
	[111] = { locked = true, key = "1", permission="cop.keycard", name = "1", hash =  "v_ilev_gtdoor", coords={ 1543.241,2471.294,45.71201}},
	--Trevors trailor
    --[112] = { locked = true, key = "11", permission="", name = "Trevors Trailor", hash =  "v_ilev_trevtraildr", coords={ 1973.4393310547,3815.7998046875,33.510219573975}},
    -- The Lost
    [113] = {locked = true, key = "key_thelost", permission="thelost.key", name = "The Lost",hash=190770132,coords={981.75329589844,-102.53480529785,74.845123291016}},
	--Sandymek
    [114] = { locked = true, key = "16", permission="", name = "Sandymek", hash =  "prop_fnclink_03gate2", coords={ 1759.4360351563,3312.7041015625,41.118431091309}, range = 10},
    --Bilforhandler
    --[115] = {locked = false, key = "key_bilforhandler", permission="bilforhandler.doors", name = "Bilforhandler",hash=2059227086,coords={-38.636848449707,-1108.3608398438,26.468864440918}, pairs = 116},
    --[116] = {locked = false, key = "key_bilforhandler", permission="bilforhandler.doors", name = "Bilforhandler",hash=1417577297,coords={-37.818347930908,-1108.7191162109,26.468883514404}, pairs = 116},
    --[117] = {locked = false, key = "key_bilforhandler", permission="bilforhandler.doors", name = "Bilforhandler",hash=-2051651622,coords={-34.122013092041,-1108.2292480469,26.422351837158}},
    --[118] = {locked = false, key = "key_bilforhandler", permission="bilforhandler.doors", name = "Bilforhandler",hash=-2051651622,coords={-31.903076171875,-1102.4223632813,26.422357559204}},
    --[119] = {locked = false, key = "key_bilforhandler", permission="bilforhandler.doors", name = "Bilforhandler",hash=2059227086,coords={-60.018104553223,-1093.4749755859,26.67373085022}, pairs = 120},
    --[120] = {locked = false, key = "key_bilforhandler", permission="bilforhandler.doors", name = "Bilforhandler",hash=1417577297,coords={-60.425937652588,-1094.2043457031,26.673414230347}, pairs = 119},
    --Fitness
    --[121] = { locked = true, key = "23", permission="", name = "Fitness", hash =  "v_ilev_gc_door01", coords={-45.93007,-1290.667,29.67249}},
    --Satudarah
    [122] = { locked = true, key = "10", permission="diablos.key", name = "10", hash =  "v_ilev_roc_door4", coords={-565.1712,276.6259,83.28626}},
    --Sandy PD
    [123] = {locked = true, key = "key_lspd", permission="cop.keycard", name = "Politistation", hash = 1557126584, coords={1842.78125,3690.9018554688,34.286655426025}},
    [124] = {locked = true, key = "key_lspd", permission="cop.keycard", name = "Politistation", hash = 1557126584, coords={1848.6605224609,3690.7421875,34.286640167236}},
    [125] = {locked = true, key = "key_lspd", permission="cop.keycard", name = "Politistation", hash = 1557126584, coords={1851.2239990234,3693.9606933594,34.286640167236}},
    [126] = {locked = true, key = "key_lspd", permission="cop.keycard", name = "Politistation", hash = 1557126584, coords={1854.1685791016,3693.97265625,34.286647796631}},
    [127] = {locked = true, key = "key_lspd", permission="cop.keycard", name = "Politistation", hash = 1557126584, coords={1856.5999755859,3689.8645019531,34.286659240723}},
    [128] = {locked = true, key = "key_lspd", permission="cop.keycard", name = "Politistation", hash = 1557126584, coords={1850.8371582031,3682.7854003906,34.286643981934}},
    [129] = {locked = true, key = "key_lspd", permission="cop.keycard", name = "Politistation", hash = 1557126584, coords={1845.5241699219,3688.9594726563,34.286609649658}},
    [130] = {locked = false, key = "key_lspd", permission="cop.keycard", name = "Politistation", hash=-1765048490,coords={1855.0665283203,3683.5229492188,34.266490936279}},
    --Paleto PD
    [131] = {locked = true, key = "key_lspd", permission="cop.keycard", name = "Politistation",hash=2271212864,coords={-450.33877563477,6015.9897460938,31.716361999512}},
    [132] = {locked = true, key = "key_lspd", permission="cop.keycard", name = "Politistation",hash=2271212864,coords={-450.33877563477,6015.9897460938,31.716361999512}},
    [133] = {locked = true, key = "key_lspd", permission="cop.keycard", name = "Politistation",hash=3775898501,coords={-453.78839111328,6011.3051757813,31.716331481934}},
    [134] = {locked = true, key = "key_lspd", permission="cop.keycard", name = "Politistation",hash=452874391,coords={-451.48696899414,6006.58984375,31.840093612671}},
    [135] = {locked = true, key = "key_lspd", permission="cop.keycard", name = "Politistation",hash=3613901090,coords={-449.07745361328,6008.0834960938,31.716337203979}},
    [136] = {locked = true, key = "key_lspd", permission="cop.keycard", name = "Politistation",hash=245182344,coords={-448.2126159668,6007.1684570313,31.716354370117}},
    [137] = {locked = true, key = "key_lspd", permission="cop.keycard", name = "Politistation",hash=964838196,coords={-441.4548034668,6012.2744140625,31.71635055542}},
    [138] = {locked = true, key = "key_lspd", permission="cop.keycard", name = "Politistation",hash=964838196,coords={-442.34408569336,6011.3979492188,31.71635055542}},
    [139] = {locked = true, key = "key_lspd", permission="cop.keycard", name = "Politistation",hash=3342610948,coords={-438.13052368164,6007.8037109375,31.716327667236}},
    [140] = {locked = true, key = "key_lspd", permission="cop.keycard", name = "Politistation",hash=3342610948,coords={-441.5553894043,6004.5219726563,31.716331481934}},
    [141] = {locked = true, key = "key_lspd", permission="cop.keycard", name = "Politistation",hash=452874391,coords={-446.76275634766,6001.8974609375,31.716184616089}},
    [142] = {locked = true, key = "key_lspd", permission="cop.keycard", name = "Politistation",hash=3283274690,coords={-437.13568115234,5992.3920898438,31.716176986694}},
    [143] = {locked = true, key = "key_lspd", permission="cop.keycard", name = "Politistation",hash=3138946425,coords={-440.83819580078,5989.44921875,31.716176986694}},
    [144] = {locked = true, key = "key_lspd", permission="cop.keycard", name = "Politistation",hash=631614199,coords={-432.73403930664,5992.7749023438,31.716173171997}},
    [145] = {locked = true, key = "key_lspd", permission="cop.keycard", name = "Politistation",hash=631614199,coords={-428.56289672852,5997.140625,31.716175079346}},
    [146] = {locked = true, key = "key_lspd", permission="cop.keycard", name = "Politistation",hash=631614199,coords={-431.58096313477,6000.2651367188,31.716171264648}},
    [147] = {locked = false, key = "key_lspd", permission="cop.keycard", name = "Politistation",hash=2793810241,coords={-444.01232910156,6016.5668945313,31.716339111328}},
    [148] = {locked = false, key = "key_lspd", permission="cop.keycard", name = "Politistation",hash=2793810241,coords={-443.05529785156,6015.6323242188,31.716341018677}},
    --Main PD
    [149] = {locked = false, key = "1", permission="cop.keycard", name = "Politistation", hash = 320433149, coords={434.6516418457,-982.50048828125,30.709634780884}, pairs = 150},
    [150] = {locked = false, key = "1", permission="cop.keycard", name = "Politistation", hash = -1215222675, coords={434.67895507813,-981.35205078125,30.713493347168}, pairs = 149},
    [151] = {locked = true, key = "1", permission="cop.keycard", name = "Politistation", hash = -1320876379, coords={447.27914428711,-979.90002441406,30.68932723999}},
    [152] = {locked = true, key = "1", permission="cop.keycard", name = "Politistation", hash = -1033001619, coords={453.0849609375,-982.537109375,30.689332962036}},
    [153] = {locked = true, key = "1", permission="cop.keycard", name = "Politistation", hash = 1557126584, coords={450.0634765625,-986.43286132813,30.689321517944}},
    [154] = {locked = true, key = "1", permission="cop.keycard", name = "Politistation", hash = 507213820, coords={463.32470703125,-1011.3848266602,32.710483551025}},
    [155] = {locked = true, key = "1", permission="cop.keycard", name = "Politistation", hash = -340230128, coords={464.39154052734,-984.01379394531,43.691715240479}},
    [156] = {locked = true, key = "1", permission="cop.keycard", name = "Politistation", hash = 185711165, coords={445.24172973633,-989.53607177734,30.68931388855}, pairs = 157},
    [157] = {locked = true, key = "1", permission="cop.keycard", name = "Politistation", hash = 185711165, coords={444.10348510742,-989.52789306641,30.68931388855}, pairs = 156},
    [158] = {locked = true, key = "1", permission="cop.keycard", name = "Politistation", hash = -1033001619, coords={445.38522338867,-998.92639160156,30.724504470825}, pairs = 159},
    [159] = {locked = true, key = "1", permission="cop.keycard", name = "Politistation", hash = -1033001619, coords={446.51062011719,-998.94049072266,30.724235534668}, pairs = 158},
    [160] = {locked = true, key = "1", permission="cop.keycard", name = "Politistation", hash = -131296141, coords={443.36318969727,-988.33306884766,26.674173355103}},
    [161] = {locked = true, key = "1", permission="cop.keycard", name = "Politistation", hash = -131296141, coords={441.90350341797,-985.91284179688,26.674167633057}},
    [162] = {locked = true, key = "1", permission="cop.keycard", name = "Politistation", hash = -543497392, coords={439.13513183594,-979.59594726563,26.668563842773}},
    [163] = {locked = true, key = "1", permission="cop.keycard", name = "Politistation", hash = -543497392, coords={465.51336669922,-989.41290283203,24.914688110352}, pairs = 164},
    [164] = {locked = true, key = "1", permission="cop.keycard", name = "Politistation", hash = -543497392, coords={465.5954284668,-990.62152099609,24.914693832397}, pairs = 163},
    [165] = {locked = true, key = "1", permission="cop.keycard", name = "Politistation", hash = 631614199, coords={463.84606933594,-992.66772460938,24.914703369141}},
    [166] = {locked = true, key = "1", permission="cop.keycard", name = "Politistation", hash = 631614199, coords={461.77255249023,-993.75866699219,24.914703369141}},
    [167] = {locked = true, key = "1", permission="cop.keycard", name = "Politistation", hash = 631614199, coords={461.77200317383,-998.34558105469,24.914703369141}},
    [168] = {locked = true, key = "1", permission="cop.keycard", name = "Politistation", hash = 631614199, coords={461.79940795898,-1001.9838256836,24.914703369141}},
    [169] = {locked = true, key = "1", permission="cop.keycard", name = "Politistation", hash = -1033001619, coords={467.89120483398,-996.43688964844,24.914703369141}},
    [170] = {locked = true, key = "1", permission="cop.keycard", name = "Politistation", hash = -1033001619, coords={472.16897583008,-996.40832519531,24.914703369141}},
    [171] = {locked = true, key = "1", permission="cop.keycard", name = "Politistation", hash = -1033001619, coords={476.50173950195,-996.40673828125,24.914703369141}},
    [172] = {locked = true, key = "1", permission="cop.keycard", name = "Politistation", hash = -1033001619, coords={480.70343017578,-996.40051269531,24.914703369141}},
    [173] = {locked = true, key = "1", permission="cop.keycard", name = "Politistation", hash = -1033001619, coords={480.70428466797,-1003.5158691406,24.914703369141}},
    [174] = {locked = true, key = "1", permission="cop.keycard", name = "Politistation", hash = -1033001619, coords={476.35052490234,-1003.6340332031,24.914703369141}},
    [175] = {locked = true, key = "1", permission="cop.keycard", name = "Politistation", hash = -1033001619, coords={472.15084838867,-1003.5540161133,24.914703369141}},
    [176] = {locked = true, key = "1", permission="cop.keycard", name = "Politistation", hash = -1033001619, coords={467.77703857422,-1003.6379394531,24.914703369141}},
    [177] = {locked = true, key = "1", permission="cop.keycard", name = "Politistation", hash = -1033001619, coords={464.18988037109,-1003.6285400391,24.914703369141}},
    [179] = {locked = true, key = "1", permission="cop.keycard", name = "Politistation", hash = -2023754432, coords={467.9992980957,-1014.5133666992,26.386335372925}, pairs = 180},
    [180] = {locked = true, key = "1", permission="cop.keycard", name = "Politistation", hash = -2023754432, coords={469.25390625,-1014.5598754883,26.386335372925}, pairs = 179},
    [181] = {locked = true, key = "1", permission="cop.keycard", name = "Politistation", hash = 1557126584, coords={434.67895507813,-981.35205078125,30.713493347168}},
    [182] = {locked = true, key = "1", permission="cop.keycard", name = "Politistation", hash = 1557126584, coords={434.67895507813,-981.35205078125,30.713493347168}},
    [183] = {locked = true, key = "1", permission="cop.keycard", name = "Politistation", hash = 1557126584, coords={434.67895507813,-981.35205078125,30.713493347168}},
    [184] = {locked = true, key = "1", permission="cop.keycard", name = "Politistation", hash = 1557126584, coords={434.67895507813,-981.35205078125,30.713493347168}},
    [185] = {locked = true, key = "1", permission="cop.keycard", name = "Politistation", hash = 1557126584, coords={434.67895507813,-981.35205078125,30.713493347168}},
    [186] = {locked = true, key = "1", permission="cop.keycard", name = "Politistation", hash = 1557126584, coords={434.67895507813,-981.35205078125,30.713493347168}},
    [187] = {locked = true, key = "1", permission="cop.keycard", name = "Politistation", hash = 1557126584, coords={434.67895507813,-981.35205078125,30.713493347168}},
    [188] = {locked = true, key = "1", permission="cop.keycard", name = "Politistation", hash=-1603817716, coords={488.91033935547,-1017.6137695313,28.212596893311}, range = 10.0},
    [189] = {locked = true, key = "1", permission="cop.keycard", name = "Politistation", hash = -131296141, coords={471.36383056641,-985.49243164063,24.914703369141}},
    [190] = {locked = true, key = "1", permission="cop.keycard", name = "Politistation", hash = 91564889, coords={475.58505249023,-985.91558837891,24.914712905884}},
    [191] = {locked = true, key = "1", permission="cop.keycard", name = "Politistation", hash = -131296141, coords={468.31127929688,-977.86163330078,24.914714813232}},
    [192] = {locked = true, key = "1", permission="cop.keycard", name = "Politistation", hash = -131296141, coords={463.54534912109,-981.3388671875,24.914710998535}},

    -- Vingården
    [194] = {locked = true, key = "1", permission="vin.key", name = "Vingården", hash = 1077118233, coords={-1885.8975830078,2050.7529296875,141.00622558594}, pairs = 195},
    [195] = {locked = true, key = "1", permission="vin.key", name = "Vingården", hash = 1077118233, coords={-1886.8514404297,2051.0080566406,141.00804138184}, pairs = 194},

    [196] = {locked = true, key = "1", permission="vin.key", name = "Vingården", hash = 1077118233, coords={-1888.5533447266,2051.7673339844,140.98490905762}, pairs = 197},
    [197] = {locked = true, key = "1", permission="vin.key", name = "Vingården", hash = 1077118233, coords={-1889.5187988281,2052.0698242188,141.00233459473}, pairs = 196},

    [198] = {locked = true, key = "1", permission="vin.key", name = "Vingården", hash = 1843224684, coords={-1908.2839355469,2072.3801269531,140.40589904785}, pairs = 199},
    [199] = {locked = true, key = "1", permission="vin.key", name = "Vingården", hash = 1843224684, coords={-1908.9871826172,2073.0625,140.40838623047}, pairs = 198},

    [200] = {locked = true, key = "1", permission="vin.key", name = "Vingården", hash = 1843224684, coords={-1910.7393798828,2074.5576171875,140.40838623047}, pairs = 201},
    [201] = {locked = true, key = "1", permission="vin.key", name = "Vingården", hash = 1843224684, coords={-1911.4526367188,2075.068359375,140.40689086914}, pairs = 200},

    [202] = {locked = true, key = "1", permission="vin.key", name = "Vingården", hash = 1843224684, coords={-1911.3372802734,2079.2565917969,140.40005493164}, pairs = 203},
    [203] = {locked = true, key = "1", permission="vin.key", name = "Vingården", hash = 1843224684, coords={-1910.5648193359,2080.1352539063,140.39819335938}, pairs = 202},

    [204] = {locked = true, key = "1", permission="vin.key", name = "Vingården", hash = 1843224684, coords={-1906.9936523438,2084.3637695313,140.40669250488}, pairs = 205},
    [205] = {locked = true, key = "1", permission="vin.key", name = "Vingården", hash = 1843224684, coords={-1906.4110107422,2085.0349121094,140.40469360352}, pairs = 204},

    [206] = {locked = true, key = "1", permission="vin.key", name = "Vingården", hash = 1843224684, coords={-1902.4128417969,2086.0551757813,140.40715026855}, pairs = 207},
    [207] = {locked = true, key = "1", permission="vin.key", name = "Vingården", hash = 1843224684, coords={-1901.5764160156,2085.3688964844,140.40591430664}, pairs = 206},
    [208] = {locked = true, key = "1", permission="vin.key", name = "Vingården", hash = 1843224684, coords={-1899.9066162109,2083.9438476563,140.40757751465}, pairs = 209},
    [209] = {locked = true, key = "1", permission="vin.key", name = "Vingården", hash = 1843224684, coords={-1899.0891113281,2083.3054199219,140.40565490723}, pairs = 208},

    [210] = {locked = true, key = "1", permission="vin.key", name = "Vingården", hash = 1077118233, coords={-1894.1380615234,2075.4169921875,141.00804138184}, pairs = 211},
    [211] = {locked = true, key = "1", permission="vin.key", name = "Vingården", hash = 1077118233, coords={-1893.4384765625,2074.7570800781,141.00791931152}, pairs = 210},

    [212] = {locked = true, key = "1", permission="vin.key", name = "Vingården", hash = 1077118233, coords={-1886.66796875,2073.9753417969,140.99752807617}, pairs = 213},
    [213] = {locked = true, key = "1", permission="vin.key", name = "Vingården", hash = 1077118233, coords={-1885.6881103516,2073.6328125,140.99862670898}, pairs = 212},

    [214] = {locked = true, key = "1", permission="vin.key", name = "Vingården", hash = 1077118233, coords={-1875.046875,2069.7290039063,140.9973449707}, pairs = 215},
    [215] = {locked = true, key = "1", permission="vin.key", name = "Vingården", hash = 1077118233, coords={-1874.0932617188,2069.4135742188,140.99752807617}, pairs = 214},

    [216] = {locked = true, key = "1", permission="vin.key", name = "Vingården", hash = 1077118233, coords={-1860.0556640625,2054.1599121094,141.00964355469}, pairs = 217},
    [217] = {locked = true, key = "1", permission="vin.key", name = "Vingården", hash = 1077118233, coords={-1860.9320068359,2054.1594238281,141.00956726074}, pairs = 216},

    [218] = {locked = true, key = "1", permission="vin.key", name = "Vingården", hash = 988364535, coords={-1864.213,2061.265,141.1456}, pairs = 219},
    [219] = {locked = true, key = "1", permission="vin.key", name = "Vingården", hash = -1141522158, coords={-1864.2,2059.899,141.1452}, pairs = 218},

    [220] = {locked = true, key = "1", permission="vin.key", name = "Vingården", hash = 534758478, coords={-1878.8939208984,2057.2827148438,140.98399353027}},

    [221] = {locked = true, key = "1", permission="vin.key", name = "Vingården", hash = 534758478, coords={-1883.9638671875,2060.2392578125,145.57373046875}, pairs = 222},
    [222] = {locked = true, key = "1", permission="vin.key", name = "Vingården", hash = 534758478, coords={-1884.9044189453,2060.5881347656,145.57369995117}, pairs = 221},

    [223] = {locked = true, key = "1", permission="vin.key", name = "Vingården", hash = 534758478, coords={-1883.291015625,2065.0915527344,145.57379150391}, pairs = 224},
    [224] = {locked = true, key = "1", permission="vin.key", name = "Vingården", hash = 534758478, coords={-1882.2983398438,2064.7941894531,145.57379150391}, pairs = 223},

    [225] = {locked = true, key = "1", permission="vin.key", name = "Vingården", hash = 534758478, coords={-1876.7563476563,2067.1511230469,145.5738067627}},

    [226] = {locked = true, key = "1", permission="vin.key", name = "Vingården", hash = 534758478, coords={-1881.0568847656,2060.984375,145.57386779785}, pairs = 227},
    [227] = {locked = true, key = "1", permission="vin.key", name = "Vingården", hash = 534758478, coords={-1880.6743164063,2062.0378417969,145.57386779785}, pairs = 226},

    [228] = {locked = true, key = "1", permission="vin.key", name = "Vingården", hash = 534758478, coords={-1886.2399902344,2064.1064453125,145.57386779785}, pairs = 229},
    [229] = {locked = true, key = "1", permission="vin.key", name = "Vingården", hash = 534758478, coords={-1886.5274658203,2063.0966796875,145.57386779785}, pairs = 228},

    [230] = {locked = true, key = "1", permission="vin.key", name = "Vingården", hash = 534758478, coords={-1893.0827636719,2069.9636230469,144.86250305176}, pairs = 231},
    [231] = {locked = true, key = "1", permission="vin.key", name = "Vingården", hash = 534758478, coords={-1893.8028564453,2068.9672851563,144.86251831055}, pairs = 230},
    --Davis PD
    [232] = {locked = true, key = "1", permission="cop.keycard", name = "Politistation", hash = -1501157055, coords={361.74743652344,-1584.6025390625,29.292060852051}, pairs = 233},
    [233] = {locked = true, key = "1", permission="cop.keycard", name = "Politistation", hash = -1501157055, coords={361.08294677734,-1585.5581054688,29.292060852051}, pairs = 232},

    [234] = {locked = true, key = "1", permission="cop.keycard", name = "Politistation", hash = -1320876379, coords={365.7682800293,-1588.6330566406,29.292036056519}},

    [235] = {locked = true, key = "1", permission="cop.keycard", name = "Politistation", hash = -1320876379, coords={374.75247192383,-1603.7873535156,29.292060852051}},

    [236] = {locked = true, key = "1", permission="cop.keycard", name = "Politistation", hash = 749848321, coords={379.04428100586,-1601.8068847656,36.955760955811}},

    [237] = {locked = true, key = "1", permission="cop.keycard", name = "Politistation", hash = -1320876379, coords={368.41259765625,-1596.1463623047,29.292053222656}},

    [238] = {locked = true, key = "1", permission="cop.keycard", name = "Politistation", hash = 749848321, coords={371.78134155273,-1600.5275878906,29.292053222656}},

    [239] = {locked = true, key = "1", permission="cop.keycard", name = "Politistation", hash = -1501157055, coords={369.51293945313,-1606.8927001953,29.292060852051}, pairs = 240},
    [240] = {locked = true, key = "1", permission="cop.keycard", name = "Politistation", hash = -1501157055, coords={368.67947387695,-1607.7856445313,29.292055130005}, pairs = 239},

    [241] = {locked = true, key = "1", permission="cop.keycard", name = "Politistation", hash = 631614199, coords={366.06500244141,-1608.8586425781,29.292064666748}},

    [242] = {locked = true, key = "1", permission="cop.keycard", name = "Politistation", hash = 631614199, coords={363.74169921875,-1606.8975830078,29.292051315308}},

    [243] = {locked = true, key = "1", permission="cop.keycard", name = "Politistation", hash = 631614199, coords={354.83111572266,-1599.3579101563,29.292051315308}},

    [244] = {locked = true, key = "1", permission="cop.keycard", name = "Politistation", hash = 631614199, coords={352.44500732422,-1597.4670410156,29.292053222656}},

    [245] = {locked = true, key = "1", permission="cop.keycard", name = "Politistation", hash = 631614199, coords={349.48300170898,-1601.0701904297,29.292060852051}},

    [246] = {locked = true, key = "1", permission="cop.keycard", name = "Politistation", hash = 631614199, coords={351.80987548828,-1603.0684814453,29.29203414917}},

    [247] = {locked = true, key = "1", permission="cop.keycard", name = "Politistation", hash = 631614199, coords={360.72906494141,-1610.5576171875,29.292049407959}},

    [248] = {locked = true, key = "1", permission="cop.keycard", name = "Politistation", hash = 631614199, coords={363.14306640625,-1612.4954833984,29.292049407959}},

    [249] = {locked = true, key = "1", permission="cop.keycard", name = "Politistation", hash = -1156020871, coords={392.54110717773,-1635.4429931641,29.292055130005}},
  -- grove st
    [250] = {locked = true, key = "1", permission="ballas.keycard", name = "Ballas", hash = -43433986, coords={68.71639251709,-1912.9899902344,21.591156005859}, range = 25.0},
    [251] = {locked = true, key = "1", permission="ballas.keycard", name = "Ballas", hash = 1817008884, coords={77.286170959473,-1902.6317138672,21.620752334595}},
    [252] = {locked = true, key = "1", permission="ballas.keycard", name = "Ballas", hash = 1817008884, coords={58.34566116333,-1914.8933105469,21.608196258545}},
    [253] = {locked = true, key = "1", permission="ballas.keycard", name = "Ballas", hash = 23523831, coords={114.32030487061,-1961.6224365234,21.333339691162}},
    [254] = {locked = true, key = "1", permission="ballas.keycard", name = "Ballas", hash = -1912632538, coords={113.1429977417,-1973.8548583984,21.326919555664}},
    [255] = {locked = true, key = "1", permission="ballas.keycard", name = "Ballas", hash = 989957872, coords={117.7869644165,-1974.0141601563,21.337631225586}, pairs = 256},
    [256] = {locked = true, key = "1", permission="ballas.keycard", name = "Ballas", hash = -204046185, coords={118.37073516846,-1973.7775878906,21.340200424194}, pairs = 255},
    [257] = {locked = true, key = "1", permission="ballas.keycard", name = "Ballas", hash = -1730259609, coords={111.10291290283,-1978.7169189453,20.962619781494}},
    [258] = {locked = true, key = "1", permission="ballas.keycard", name = "Ballas", hash = 1947176169, coords={107.22588348389,-1976.0483398438,20.961685180664}, pairs = 259},
    [259] = {locked = true, key = "1", permission="ballas.keycard", name = "Ballas", hash = 1184805384, coords={108.30417633057,-1975.5340576172,20.95908164978}, pairs = 258},
    [260] = {locked = true, key = "1", permission="ballas.keycard", name = "Ballas", hash = 1122314606, coords={105.27279663086,-1976.8905029297,20.968454360962}},
    [261] = {locked = true, key = "1", permission="ballas.keycard", name = "Ballas", hash = -167783606, coords={91.655387878418,-1981.8012695313,20.457874298096}, pairs = 262},
    [262] = {locked = true, key = "1", permission="ballas.keycard", name = "Ballas", hash = 1805008497, coords={92.629699707031,-1982.8067626953,20.467237472534}, pairs = 261},
    [263] = {locked = true, key = "1", permission="ballas.keycard", name = "Ballas", hash = -167783606, coords={94.394241333008,-1984.6101074219,20.44033241272}, pairs = 264},
    [264] = {locked = true, key = "1", permission="ballas.keycard", name = "Ballas", hash = 1805008497, coords={95.2880859375,-1985.6953125,20.429574966431}, pairs = 263},
}	
return cfg
