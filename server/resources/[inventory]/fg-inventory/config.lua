Config = {}

Config.OpenControl = 166 -- Key for opening inventory.

Config.items = {
  -- ITEMS --
    {name = 'lockpick', 	    label = 'Dirkesæt', 	    description = 'God til at bryde ind i ting.. eller bygninger.',   type = "lockpick",     choices = 0,	    weight = 0.50},
    {name = 'kikkert', 	    label = 'Kikkert', 	    description = 'Kikkert.',        choices = 0,	    weight = 0.50},
    {name = 'falsknummerplade', 	    label = 'Falsk Nummerplade', 	    description = 'Passer til udlejningsbiler.',        choices = 0,	    weight = 0.50},
    {name = 'nicki_virus', 	    label = 'Virus (ATM)', 	    description = 'Virus til ATMer.',        choices = 0,	    weight = 0.10},
    {name = 'nicki_juvel', 	    label = 'Juvel', 	    description = 'Juveller.',        choices = 0,	    weight = 0.10},
    {name = 'iphone', 	      label = 'iPhone', 	      description = 'Den velkendte og overpricede mobil kendt som en iPhone.', 				choices = 0,	    weight = 0.50},
    {name = 'samsung', 	      label = 'Samsung', 	      description = 'En Samsung mobil af ukendt årgang. God til at tage billeder.', 	choices = 0,	    weight = 0.50},
    {name = 'oneplus', 	      label = 'OnePlus', 	      description = 'Et ukendt mærke, men den fungerer fint og holder strøm godt.', 	choices = 0,	    weight = 0.50},
    {name = 'radio', 	      label = 'Radio', 	      description = 'Kommunikations enhed', 		choices = 0,	    weight = 0.50},
    --{name = 'cigaret',      label = 'Cigaret', 	      description = 'Til den trængende, eller bare til festrygeren (yeah right).', type = "cigaret", 		  choices = 0,	    weight = 0.02},
    {name = 'dirty_money',      label = 'Kontanter', 	    description = 'De lugter lidt, så de skal nok vaskes inden de kan bruges.', 	  choices = 0,	    weight = 0.00},
    {name = 'cleaning',       label = 'Rengøringsklud', description = 'Bruges til at rengøre og finpusse biler til original stand.',  	  choices = 0,	    weight = 0.10},
    {name = 'repairkit',      label = 'Bilværktøj', 	  description = 'Et simpelt værktøj som dog kan fikse selv avanceret skader.',   type = "repairkit",	  choices = 10,	    weight = 1.00},
    {name = 'tyre',      label = 'Reserve Dæk', 	  description = 'Reserve Dæk', 	  choices = 0,	    weight = 5.00},
    {name = 'medkit',      label = 'Medkit', 	  description = 'Medkit.', 	  choices = 0,	    weight = 1.00},
    {name = "boombox",        label = "Boombox",        description = "En transportabel musikafspiller som giver gode 90'er vibes.",  type = "boombox",   choices = 0,      weight = 2.50},
    --{name = 'cigaretpakke',       label = 'Cigaretpakke', description = '', type = "cigaretpakke", 	  choices = 0,	    weight = 0.10},
    {name = 'aluore',      label = 'Aluminium Ore', 	  description = 'Aluminium Ore.', 	  choices = 0,	    weight = 0.10},
    {name = 'alu',      label = 'Aluminium', 	  description = 'Aluminium.', 	  choices = 0,	    weight = 0.10},
    {name = 'firstlogin',      label = 'Dåbsattest', 	  description = 'Dåbsattest.', 	  choices = 0,	    weight = 0.10},

    {name = 'methlab',      label = 'Methlab', 	  description = 'Bruges til at lave meth.', 	  choices = 0,    weight = 0.10},
    {name = 'acetone',      label = 'Acetone', 	  description = 'Acetone.', 	  choices = 0,     weight = 0.10},
    {name = 'lithium',      label = 'Lithium', 	  description = 'Lithium.', 	  choices = 0,	   weight = 0.10},
    
    --{name = 'skruetraekker',      label = 'Skruetraekker', 	  description = 'Skruetraekker til indbrud.', 	  choices = 0,	    weight = 0.10},
    {name = 'rejsekuffert',      label = 'Rejsekuffert', 	  description = 'Rejsekuffert.', 	  choices = 0,	    weight = 0.10},

    {name = 'id_card_f',      label = 'Nøglekort', 	  description = 'Nøglekort til Fleeca Bank.', 	  choices = 0,     weight = 0.10},
    {name = 'secure_card',      label = 'Sikkerhedskort', 	  description = 'Sikkerhedskort.', 	  choices = 0,	   weight = 0.10},

    {name = "repairkitadv",               label = "Advanced Repairkit",                        description = "Værktøjskasse til at fikse ødelagte køretøjet",                    type = "repairkitadv",        choices = 10,        weight = 0.50},
    {name = 'vinkelsliber',      label = 'Vinkelsliber', 	  description = 'Vinkelsliber.', 	type = "vinkelsliber",  choices = 0,     weight = 0.10},
    {name = 'planke',      label = 'Planke', 	  description = 'Planke.', type = "planke",	  choices = 0,	   weight = 0.10},

    {name = 'fisk1',      label = 'Torsk', 	  description = 'Torsk.', 	  choices = 0,	   weight = 0.10},
    {name = 'fisk2',      label = 'Laks', 	  description = 'Laks.', 	  choices = 0,	   weight = 0.10},
    {name = 'fisk3',      label = 'Sild', 	  description = 'Sild.', 	  choices = 0,	   weight = 0.10},
    {name = 'fisk4',      label = 'Ørred', 	  description = 'Ørred.', 	  choices = 0,	   weight = 0.10},
    {name = 'fisk5',      label = 'Makrel', 	  description = 'Makrel.', 	  choices = 0,	   weight = 0.10},
    {name = 'fisk6',      label = 'Aborre', 	  description = 'Aborre.', 	  choices = 0,	   weight = 0.10},

    -- Attachments
    {name = 'extendedsns2',      label = 'Extended Clip (SNS)', 	  description = 'Extended Clip (SNS).', 	  choices = 0,	type = "extendedsns2",     weight = 0.10},
    {name = 'extendedpistol',      label = 'Extended Clip (Pistol)', 	  description = 'Extended Clip (Pistol).', 	  choices = 0,	type = "extendedpistol",     weight = 0.10},
    {name = 'supppistol',      label = 'Suppressor (Pistol)', 	  description = 'Suppressor (Pistol).', 	  choices = 0,	type = "supppistol",     weight = 0.10},
    {name = 'skinpistol',      label = 'Skin (Pistol)', 	  description = 'Skin (Pistol).', 	  choices = 0,	type = "skinpistol",     weight = 0.10},
    {name = 'extendedheavypistol',      label = 'Extended Clip (Heavy Pistol)', 	  description = 'Extended Clip (Heavy Pistol).', 	  choices = 0,	type = "extendedheavypistol",     weight = 0.10},
    {name = 'suppheavypistol',      label = 'Suppressor (Heavy Pistol)', 	  description = 'Suppressor (Heavy Pistol).', 	  choices = 0,	type = "suppheavypistol",     weight = 0.10},
    {name = 'extended50pistol',      label = 'Extended Clip (Deagle)', 	  description = 'Extended Clip (Deagle).', 	  choices = 0,	type = "extended50pistol",     weight = 0.10},
    {name = 'supp50pistol',      label = 'Suppressor (Deagle)', 	  description = 'Suppressor (Deagle).', 	  choices = 0,	type = "supp50pistol",     weight = 0.10},

    -- Nummerplade
    {name = 'screwdriver', 	      label = 'Skruetrækker', 	      description = 'Skruetrækker til at skrue nummerplader af med.',			choices = 0,	    weight = 0.50},
    {name = 'nummerplade', 	      label = 'Nummerplade', 	      description = 'Nummerplade.', 	choices = 0,	    weight = 0.50},

    --BANK ROBBERY
    {name = 'thermal_charge', 	    label = 'Thermal Charge', 	    description = '',        choices = 0,	    weight = 0.10},
    {name = 'laptop_h', 	    label = 'Laptop', 	    description = '',        choices = 0,	    weight = 0.10},
    {name = 'id_card', 	    label = 'ID Kort', 	    description = '',        choices = 0,	    weight = 0.10},
    {name = 'dia_box', 	    label = 'Diamant Box', 	    description = '',        choices = 0,	    weight = 0.10},
    {name = 'gold_bar', 	    label = 'Guld bar', 	    description = '',        choices = 0,	    weight = 0.10},

  -- BEREDSKABET --
    {name = 'bandage',        label = 'Bandage',        description = 'En bandage er lidt ligesom et lille disney plaster på såret.', 	type = "client",    choices = 0,	weight = 0.10},
    {name = 'panodil',        label = 'Panodil', 	      description = 'Et simpelt værktøj som dog kan fikse selv avanceret skader.', 	  type = "client",    choices = 0,	weight = 0.05},
    {name = 'fentanyl',       label = 'Fentanyl', 	    description = 'Fentanyl er stærkt vanedannende men giver en god følelse.',   	  type = "client",    choices = 0,	weight = 0.15},

  -- DRIKKE --
    {name = "water",        label = "Vand",             description = "En iskold lækker kildevand som smager af absolut intet.",        type = "drink",     choices = -15,    weight = 0.10},
    {name = "cola",         label = "Cola",             description = "Pas på med ikke at købe for mange - ellers ender du som Anders.",type = "drink",     choices = -25,    weight = 0.15},
    {name = "beer",         label = "Øl",               description = "Wubulaba Øl med 4,6 procent mjød. God erstatning for corona.",   type = "drink",     choices = -10,    weight = 0.15},
    {name = "vodka",        label = "Vodka",            description = "Russisk drik af mærket cyka - 42 procent ren alkohol.",          type = "alkohol",     choices =  10,    weight = 0.50},
    {name = "whiskey",      label = "Whiskey",          description = "En Jack Daniels har aldrig skadet - 57 procent. alkohol",        type = "alkohol",     choices =  10,    weight = 0.50},
    {name = "redgull",      label = "Redbull",          description = "Om den giver vinger eller ej må du finde ud af.",                type = "energi",     choices = -25,    weight = 0.20},

  -- MAD --
    {name = "apple",        label = "Æble",             description = "Et æble om dagen holder doktoren væk - eller noget i den dur.",  type = "eat",       choices = -10,    weight = 0.05},
    {name = "bread",        label = "Brød",             description = "Næsten lige så godt som mors hjemmebag - men kun næsten.",       type = "eat",       choices = -15,    weight = 0.10},  
    {name = "taco",        label = "Taco",             description = "En klassiker fra Mexico.",       type = "eat",       choices = -25,    weight = 0.10},  
    {name = "tacopack",        label = "Taco Pose",             description = "En pose med en taco.",       choices = 0,    weight = 0.10},  
    {name = "sandwich",     label = "Sandwich",         description = "En lækker frisklavet kyllinge sandwich med karrydressing.",      type = "eat",       choices = -25,    weight = 0.15},
    {name = "hamburger",    label = "Hamburger",        description = "En uimodståelig fristelse af saftig bøf og lækker bacon.",       type = "eat",       choices = -35,    weight = 0.20},
    {name = "frites",    label = "Pomfritter",        description = "Pomfritter.",       type = "eat",       choices = -15,    weight = 0.20},
    {name = "nuggets",    label = "Nuggets",        description = "Nuggets.",       type = "eat",       choices = -25,    weight = 0.20},
    {name = "kebab",        label = "Kebab",            description = "Kebab er guds gave til menneskeheden og sådan er det.",          type = "eat",       choices = -30,    weight = 0.20},
    {name = "cornybig",     label = "Cornybig",         description = "En lille lækker snack (ikke din kæreste) til farten.",           type = "eat",       choices = -15,    weight = 0.10},

  -- HASH PROCESS --
    {name = 'skunk1000',			label = 'Skunk (1g)',			description = 'En marijuana blad som bruges til at lave klumper af hash.',					  choices = 0,	  weight = 0.01},
    {name = 'skunk2',			label = 'Skunkplante',			description = 'En klump hash som kan laves om til en joint eller mursten.',					  choices = 0,	  weight = 0.5},
    {name = 'klump10',			label = 'Skunk Pose (10g)',		description = 'Hvem elsker ikke wholesale? Det er formålet med denne "mursten".',		  choices = 0,	  weight = 0.10},
    {name = 'skunkfro',			label = 'Skunk Frø',		description = 'Du bruger denne til at skabe lækre planter som kan sælges for skejs',	choices = 0,	  weight = 0.001},
    {name = 'joint', 	        label = 'Joint', 	        description = 'En joint kan sælges på gaden eller blive forarbejdet endnu mere.',     type = "client",    choices = 0,	  weight = 0.001},

  -- CHENS RESTAURANT I MIDTBY --
    {name = "spicynudler",   label = "Spicy Nudler",        description = "Eventuelt spørg om ekstra 'vuff vuff' og Chen bliver glad.",     type = "eat",     choices = -99,    weight = 0.50},
    {name = "sweetnudler",   label = "Søde Nudler",         description = "Nudler som har fået en ordentlig omgang sweet n sour sauce.",    type = "eat",     choices = -99,    weight = 0.50},
    {name = "normalnudler",  label = "Normal Nudler",       description = "Normale nudler.. som er meget normale, og smager normalt.",      type = "eat",     choices = -99,    weight = 0.50},
    {name = "nudlerkarry",   label = "Nudler med Karry",    description = "Stegte nudler vendt i karry direkte importeret fra indien.",     type = "eat",     choices = -99,    weight = 0.50},
    {name = "nudlerrejer",   label = "Nudler med Rejer",    description = "En omgang lækker nudler med alt godt fra byens hav.",            type = "eat",     choices = -99,    weight = 0.50},
    {name = "nudlerkanguru", label = "Nudler med Kænguru",  description = "Lækre stegte nudler med 100 procent australsk babykænguru.",     type = "eat",     choices = -99,    weight = 0.50},
    {name = "sushi",         label = "Sushi",               description = "Lækker sushi maki, nigiri og ruller med økologisk fisk.",        type = "eat",     choices = -99,    weight = 0.50},

  -- ALKOHOLISKE DRIKKE --
    {name = "rodvin",        label = "Rødvin",              description = "Rødvin er lavet af italienske vindruer.. det er alt jeg ved.",            type = "alkohol",       choices = -10,    weight = 0.20},
    {name = "hvidvin",       label = "Hvidvin",             description = "Hvidvin siges at være god til kylling.. måske også andet?",              type = "alkohol",       choices = -10,    weight = 0.20},  
    {name = "ginhass",       label = "Gin Hass",            description = "En rigtig lækker drink som en ved navn Therese godt kan lide.",          type = "alkohol",       choices = -25,    weight = 0.20},
    {name = "tequila",       label = "Tequila Sunrise",     description = "En kvinde ved navn Meredith kan rigtig godt lide denne drink.",          type = "alkohol",       choices = -10,    weight = 0.20},
    {name = "daiquiri",      label = "Strawberry Daiquiri", description = "Kebab er guds gave til menneskeheden og sådan er det.",                  type = "alkohol",       choices = -25,    weight = 0.20},
    {name = "mojito",        label = "Mexicansk Mojito",    description = "En lille lækker snack (ikke din kæreste) til farten.",                   type = "alkohol",       choices = -25,    weight = 0.20}, 
    {name = "moet",          label = "Moet Champagne",      description = "Hvis man kunne sammenligne en iPhone og champagne er dette resultatet.", type = "alkohol",       choices = -20,    weight = 0.20}, 
    {name = "romogcola",     label = "Rom og Cola",         description = "En lille lækker snack (ikke din kæreste) til farten.",                   type = "alkohol",       choices = -30,    weight = 0.20},

  -- Kokain --
  {name = 'kokainblade', 	  label = 'Kokainblade', 	  description = 'Kokainblade',       choices = 0,	  weight = 0.10},
  {name = 'kokain',		  label = 'Kokain',		  description = 'Kokain',    type = "kokain",      choices = 0,	  weight = 0.25},  


  -- METH --
    {name = 'kemikalier', 	  label = 'Kemikalier (Meth)', 	  description = 'Kemikalier til Meth',       choices = 0,	  weight = 0.10},
    {name = 'meth',		  label = 'Meth',		  description = 'Meth',         choices = 0,	  weight = 0.25},  

     -- AMF --
     {name = 'kemikalier2', 	  label = 'Kemikalier (AMF)', 	  description = 'Kemikalier til Amfetamin',       choices = 0,	  weight = 0.10},
     {name = 'amf',		  label = 'Amfetamin',		  description = 'Amfetamin',         choices = 0,	  weight = 0.25},  

  -- LSD --
    {name = 'syre', 	      label = 'syre', 	      description = 'Syre til LSD',    choices = 0,	  weight = 0.10},
    {name = 'lsd',		        label = 'LSD',		        description = 'LSD er mindre farligt end MDMA og er derfor også lidt billigere.',   type = "lsd",     choices = 0,	  weight = 0.25},  

    -- MISC --
    {name = 'guldmalm', 	    label = 'Guldmalm', 	      description = 'Guldmalm',        choices = 0,	  weight = 0.50},
    {name = 'guldbar', 	    label = 'Guldbar', 	      description = 'Den er skide tung men gør også din pengepung tung hvis solgt.',        choices = 0,	  weight = 1.00},
    {name = 'strips', 	      label = 'Strips', 	      description = 'Bruges til cable-management, og absolut ikke til at kidnappe folk',    choices = 0,	  weight = 0.05},
    {name = 'pose', 	        label = 'Pose', 	        description = 'En pose som du kan opbevare ting i, eller smide over hovedet på folk.',choices = 0,	  weight = 0.10},

    -- MINING --
    {name = 'kul', 	          label = 'Kul', 	          description = 'Enten noget du selv har hakket - eller har du fået den af julemanden?', choices = 0,	  weight = 0.002},
    {name = 'solvklump', 	    label = 'Sølvklump', 	    description = 'En lille klump sølv som i sig selv ikke er særlig meget værd.. endnu.', choices = 0,	  weight = 0.002},
    {name = 'solvbar', 	      label = 'Sølvbar', 	      description = 'Denne bar er skide tung men gør også din pengepung tung hvis solgt.',   choices = 0,	  weight = 0.005},
    {name = 'grus', 	        label = 'Gravgrus', 	    description = 'Kan sælges til byggepladser eller du kan dumpe det i naboens have.',    choices = 0,	  weight = 0.002},

    -- VINTING --
    {name = 'flaske', 	      label = 'Tom flaske', 	  description = 'En tom flaske som du kan bruge til at fylde lækkerrier (såsom vin) i.',        choices = 0,	  weight = 0.002},
    {name = 'vin', 	          label = 'Vinflaske', 	    description = 'En utrolig lækker og økologisk vin (findes det?) som du nok selv har lavet.',  choices = 0,	  weight = 0.002},
    {name = 'vindrue', 	      label = 'Vindrue', 	      description = 'En lille lækkerbisken som kan spises eller laves om til lækker vin.',          choices = 0,	  weight = 0.002},

      -- MISC TING
    {name = 'WEAPON_FIREEXTINGUISHER',		label = 'Brandslukker',	    description = '',		choices = 0,	weight = 2.00},
    --{name = 'WEAPON_FIREWORK',				  label = 'Fyrværkeri',       description = '',		choices = 0,	weight = 1.00},
    {name = 'WEAPON_PETROLCAN',				    label = 'Benzindunk',		    description = '',		choices = 0,	weight = 1.00},

	  -- HÅNDVÅBEN
    {name = 'WEAPON_KNIFE',		    		    label = 'Kniv',				      description = '',  type = "client",     choices = 0,  weight = 1.00},
    {name = 'WEAPON_DAGGER',		    		    label = 'Dagger',				      description = '',  type = "client",     choices = 0,  weight = 1.00},
    {name = 'WEAPON_SWITCHBLADE',			    label = 'Foldekniv',		    description = '',  type = "client",     choices = 0,  weight = 0.75},
    {name = 'WEAPON_HATCHET',				      label = 'Økse',			        description = '',  type = "client",     choices = 0,  weight = 2.50},
    {name = 'WEAPON_MACHETE',				      label = 'Machete',			    description = '',  type = "client",     choices = 0,  weight = 1.50},
	  {name = 'WEAPON_BAT',					        label = 'Bat',		          description = '',  type = "client",     choices = 0,  weight = 1.00},
    {name = 'WEAPON_CROWBAR',				      label = 'Brækjern',			    description = '',  type = "client",     choices = 0,  weight = 1.00},
    {name = 'WEAPON_GOLFCLUB',	    	    label = 'Golfkølle',		    description = '',  type = "client",     choices = 0,  weight = 1.00},
	  {name = 'WEAPON_WRENCH',				      label = 'Svensknøgle',		  description = '',  type = "client",     choices = 0,  weight = 0.50},
    {name = 'WEAPON_HAMMER',				      label = 'Hammer',			      description = '',  type = "client",     choices = 0,  weight = 0.50},

      -- RARE VÅBEN
    {name = 'WEAPON_KNUCKLE',				      label = 'Knojern',		      description = '',   type = "client",    choices = 0,  weight = 0.25},
    {name = 'WEAPON_PISTOL',				      label = 'Håndpistol',	      description = '',  type = "client",     choices = 0,  weight = 1.00},
    {name = 'WEAPON_SNSPISTOL',				      label = 'SNS Pistol',	      description = '',  type = "client",     choices = 0,  weight = 1.05},
    {name = 'WEAPON_HEAVYPISTOL',				      label = 'Heavy Pistol',	      description = '',  type = "client",     choices = 0,  weight = 1.10},
    {name = 'WEAPON_PISTOL50',				      label = 'Deagle',	      description = '',   type = "client",    choices = 0,  weight = 1.15},
    {name = 'WEAPON_MINISMG',			    label = 'Mini SMG',		  description = '',   type = "client",  choices = 0,  weight = 5.00},

      -- POLITIET
      {name = 'WEAPON_ARMOR',        label = 'Skudsikkervest',             description = '', type = "armor",    choices = 0,  weight = 0.25},
    {name = 'WEAPON_FLASHLIGHT',			    label = 'Lommelygte',		    description = '', type = "client",      choices = 0,  weight = 0.25},
    {name = 'WEAPON_NIGHTSTICK',			    label = 'Knippel',		      description = '',  type = "client",     choices = 0,  weight = 1.00},
    {name = 'WEAPON_STUNGUN',				      label = 'Strømpistol',		  description = '', type = "client",      choices = 0,  weight = 0.50},
    {name = 'WEAPON_COMBATPISTOL',		    label = 'USP Compact',	    description = '',  type = "client",     choices = 0,  weight = 1.00},
    {name = 'WEAPON_SMG',					        label = 'MP5',				      description = '',  type = "client",     choices = 0,  weight = 2.50},
    {name = 'WEAPON_HEAVYSNIPER',			    label = 'Præcisionsriffel',	description = '',   type = "client",    choices = 0,  weight = 7.50},
    {name = 'WEAPON_CARBINERIFLE',  label = 'Riffel',	      description = '',  type = "client",     choices = 0,  weight = 5.00},

      -- VÅBEN AMMO
    {name = 'PISTOL_AMMO',        label = 'Pistolskud',             description = '', type = "client",    choices = 0,  weight = 0.05},
    {name = 'RIFLE_AMMO',         label = 'Riffelskud',             description = '', type = "client",    choices = 0,  weight = 0.10},
    {name = 'SMG_AMMO',           label = 'SMG Skud',               description = '', type = "client",    choices = 0,  weight = 0.05},
    {name = 'SNIPER_AMMO',        label = '50. Cal Skud',           description = '', type = "client",    choices = 0,  weight = 0.20},
    {name = 'LMG_AMMO',           label = 'LMG Skud',               description = '', type = "client",    choices = 0,  weight = 0.15},
    {name = 'SHOTGUN_AMMO',       label = 'Shotgun Skud',           description = '', type = "client",    choices = 0,  weight = 0.10},
}

Config.market_types = {
  ['Supermarked'] = {
    _config = {blipid = 59, blipcolor = 69},
    {name = 'bread',                        price = 15},
    {name = 'water',                        price = 10},
    {name = 'cigaret',                    price = 10},
    {name = 'sandwich',                     price = 25},
    {name = 'hamburger',                    price = 40},
    {name = 'apple',                        price = 10},
    {name = 'kikkert',                        price = 550},
    {name = 'strips',                        price = 100},
    {name = 'pose',                        price = 100},
    {name = 'whiskey',                      price = 80},
    {name = 'beer',                         price = 25},
    {name = 'vodka',                        price = 69},
    {name = 'skunkfro',                        price = 20},
    {name = 'cola',                         price = 18},
    {name = 'redgull',                      price = 20},
    {name = 'kebab',                        price = 35},
    {name = 'taco',                        price = 35},
    {name = 'spicynudler',                   price = 14},
    {name = 'sweetnudler',                   price = 16},
    {name = 'normalnudler',                  price = 18},
    {name = 'nudlerkarry',                   price = 15},
    {name = 'nudlerrejer',                   price = 10},
    {name = 'nudlerkanguru',                 price = 20},
    {name = 'sushi',                         price = 80},
},
['Burger Shot'] = {
  _config = {blipid = 106, blipcolor = 60},
  {name = 'hamburger',                    price = 40},
  {name = 'frites',                    price = 15},
  {name = 'nuggets',                    price = 25},
  {name = 'cola',                         price = 18},
},
["EMSudstyr"] = {
  _config = {blipcolor = 2, perm = "emergency.key"},
    {name = 'bandage',                       price = 0},
    {name = 'medkit',                       price = 0},
    {name = 'radio',                      price = 0},
    {name = 'panodil',                      price = 0},
    {name = 'WEAPON_FLASHLIGHT',                      price = 0},
    {name = 'WEAPON_ARMOR',                      price = 0},
},
['Mekaniker'] = {
  _config = {blipcolor = 2, perm = "repair.loadshop"},
    {name = 'tyre',                      price = 500},
    {name = 'kebab',                      price = 20},
    {name = 'redgull',                      price = 25},
    {name = 'repairkit',                     price = 1000},
    {name = 'repairkitadv',                     price = 1000},
    {name = 'screwdriver',                     price = 1000},
},
['Vendingdrikke'] = {
  _config = {blipcolor = 2},
    {name = 'water',                        price = 20},
    {name = 'cola',                         price = 18},
    {name = 'redgull',                      price = 20},
},
['Vendingmad'] = {
  _config = {blipcolor = 2},
    {name = 'sandwich',                     price = 25},
    {name = 'apple',                        price = 10},
    {name = 'cornybig',                     price = 20},
},
['EMSgratis'] = {
  _config = {blipcolor = 2, perm = "emergency.market"},
    {name = 'sandwich',                     price = 0},
    {name = 'apple',                        price = 0},
    {name = 'water',                        price = 0},
    {name = 'cola',                         price = 0},
},
['POLgratis'] = {
  _config = {blipcolor = 2, perm = "police.pc"},
    {name = 'sandwich',                     price = 0},
    {name = 'apple',                        price = 0},
    {name = 'water',                        price = 0},
    {name = 'kebab',                      price = 20},
    {name = 'cola',                         price = 0},
    {name = 'radio',                      price = 0},
    {name = 'medkit',                      price = 0},
},
['Politiudstyr'] = {
  _config = {blipcolor = 2, perm = "police.pc"},
    {name = "WEAPON_FLASHLIGHT",            price = 0},
    {name = "WEAPON_NIGHTSTICK",            price = 0},
    {name = "WEAPON_STUNGUN",               price = 0},
    {name = "WEAPON_COMBATPISTOL",          price = 0},
    {name = "WEAPON_SMG",                   price = 0},
    {name = "WEAPON_ARMOR",           price = 0},
    {name = "WEAPON_FIREEXTINGUISHER",           price = 0},
    {name = "WEAPON_SNIPERRIFLE",           price = 0},
    {name = "WEAPON_CARBINERIFLE",           price = 0},
},
['Våbenhandler'] = {
  _config = {blipcolor = 2, perm = "våben.loadshop"},
    {name = "WEAPON_SNSPISTOL",            price = 1000000},
    {name = "WEAPON_HEAVYPISTOL",            price = 2500000},
    {name = "WEAPON_PISTOL",               price = 1500000},
    {name = "WEAPON_PISTOL50",          price = 3000000},
    {name = "WEAPON_MINISMG",          price = 4000000},
    {name = "PISTOL_AMMO",          price = 2000},
    {name = "SMG_AMMO",          price = 2500},
},
['Sorte Marked'] = {
  _config = {blipcolor= 2},
  {name = "WEAPON_DAGGER",                 price = 15000},
  {name = "WEAPON_MACHETE",                 price = 20000},
  {name = "WEAPON_HATCHET",               price = 25000},
  {name = "lockpick",                   price = 2500},
  {name = "nicki_virus",               price = 2500},
  {name = "id_card_f",               price = 10000}
},
['Meth Marked'] = {
  _config = {blipcolor= 2},
  {name = "methlab",                 price = 20000},
  {name = "acetone",                 price = 1000},
  {name = "lithium",               price = 2500},
},
['Sikkerhedskort Marked'] = {
  _config = {blipcolor= 2},
  {name = "secure_card",                 price = 300},
},
['Jem & Fix'] = {
    _config = {blipid= 110, blipcolor= 1},
    {name = "WEAPON_ARMOR",                 price = 25000},
    {name = "WEAPON_KNIFE",                 price = 5000},
    {name = "WEAPON_SWITCHBLADE",           price = 3500},
    {name = "WEAPON_BAT",                   price = 2500},
    {name = "WEAPON_CROWBAR",               price = 1000},
    {name = "WEAPON_GOLFCLUB",              price = 2500},
    {name = "WEAPON_WRENCH",                price = 1000},
    {name = "WEAPON_HAMMER",                price = 500},
    {name = "WEAPON_FLASHLIGHT",            price = 500},
    {name = "WEAPON_KNUCKLE",            price = 750},
    {name = "planke",            price = 1500},
    {name = "vinkelsliber",            price = 1500},
},
['Stripklubben'] = {
  _config = {blipcolor = 2},
  {name = 'rodvin',                        price = 25},
  {name = 'hvidvin',                       price = 25},
  {name = 'ginhass',                       price = 50},
  {name = 'tequila',                       price = 55},
  {name = 'daiquiri',                      price = 60},
  {name = 'mojito',                        price = 45},
  {name = 'moet',                          price = 125},
  {name = 'romogcola',                     price = 50},
},
['Mobilbutik'] = {
  _config = {blipid = 459, blipcolor = 77},
  {name = "iphone",                       price = 9125},
  {name = "samsung",                      price = 6600},
  {name = "oneplus",                      price = 4250},
  {name = "radio",                        price = 500},
  }
}


-- list of markets {type,x,y,z}

Config.markets = {    
    {"Supermarked", -47.522762298584, -1756.85717773438, 29.421010971069}, -- 24/7: davis ave. og grove st.
    {"Supermarked", 25.7454013824463, -1345.26232910156, 29.497020721435}, -- 24/7: innocence blvd. og elgin ave.
    {"Supermarked", 1135.57678222656, -981.78125, 46.415798187255}, -- kiosk: el rancho blvd. og vespucci blvd.
    {"Supermarked", 1163.53820800781, -323.541320800781, 69.205055236816}, -- 24/7: west mirror drive
    {"Supermarked", 374.26095581055, 327.88385009766, 103.56636810303}, -- 24/7: clinton ave.
    {"Supermarked", 2555.35766601563, 382.16845703125, 108.62294769287}, -- 24/7: polomino fwy.
    {"Supermarked", 2676.76733398438, 3281.57788085938, 55.241123199462}, -- 24/7: senora fwy.
    {"Supermarked", 1960.50793457031, 3741.84008789063, 32.343738555908}, -- 24/7: 0and ave. og alhambra dr.
    {"Supermarked", 1393.23828125, 3605.171875, 34.980930328369}, -- kiosk: algonquin blvd.
    {"Supermarked", 1166.18151855469, 2709.35327148438, 38.157714843750}, -- kiosk: route 68
    {"Supermarked", 547.987609863281, 2669.7568359375, 42.156513214111}, -- 24/7: route 68
    {"Supermarked", 1698.30737304688, 4924.37939453125, 42.063674926757}, -- 24/7: grapeseed main st.
    {"Supermarked", 1729.54443359375, 6415.76513671875, 35.037220001220}, -- 24/7: senora fwy.
    {"Supermarked", -3243.9013671875, 1001.40405273438, 12.830705642700}, -- 24/7: barbareno fwy.
    {"Supermarked", -2967.8818359375, 390.78662109375, 15.043314933776}, -- kiosk: great ocean hwy.
    {"Supermarked", -3041.17456054688, 585.166198730469, 7.9089336395263}, -- 24/7: ineseno road
    {"Supermarked", -1820.55725097656, 792.770568847656, 138.11325073242}, -- 24/7: banham canyon dr. og nortch rockford dr.
    {"Supermarked", -1486.76574707031, -379.553985595703, 40.163387298584}, -- kiosk: properity st.
    {"Supermarked", -1223.18127441406, -907.385681152344, 12.326346397399}, -- kiosk: san andreas ave.
    {"Supermarked", -707.408996582031, -913.681701660156, 19.215585708618}, -- 24/7: polomino ave. og ginger st. 

    {"EMSudstyr", 311.93841552734,-597.59197998047,43.283996582031}, -- PILLBOX HOSPITAL
    {"EMSudstyr", 1831.0646972656,3678.1252441406,34.27490234375}, -- SANDY HOSPITAL

    {"Politiudstyr", 1841.9409179688,3688.9069824219,34.286602020264}, -- POLITI ARMORY SANDY
    {"Politiudstyr", 459.21792602539,-979.71276855469,30.68957901001}, -- POLITI MISSION ROW

    {"Vendingdrikke", 308.68795776367,-585.2529296875,43.284004211426}, -- PILLBOX HOSPITAL LOBBY
    {"Vendingdrikke", -1100.3675537109,-823.64538574219,19.001447677612}, -- VESPUCCI STATION LOBBY
    {"Vendingdrikke", 1769.9323730469,3323.599609375,41.447914123535}, -- SANDY MEKANIKER
    {"Vendingdrikke", 436.2780456543,-986.73040771484,30.689653396606}, -- POLITISTATION MIDTBY
    {"Vendingdrikke", 429.84677124023,-1078.9565429688,30.031633377075}, -- ADVOKATKONTORET
    {"Vendingdrikke", 890.87786865234,-158.40010070801,76.94278717041}, -- TAXI KONTORET
    {"Vendingdrikke", 1790.0281982422,2589.7907714844,45.717193603516}, -- FÆNGSLET INDE LOBBY
    {"Vendingdrikke", 1842.6157226563,2569.7756347656,45.891937255859}, -- FÆNGSLET YDRE LOBBY
    {"Vendingdrikke", 720.74139404297,-799.96203613281,16.474296569824}, -- NEDE VED EL ORIGINALS

    {"Vendingmad", 310.69815063477,-586.00341796875,43.284004211426}, -- PILLBOX HOSPITAL LOBBY
    {"Vendingmad", 1770.7193603516,3322.4399414063,41.448925018311}, -- SANDY MEKANIKER

    {"EMSgratis", 306.41616821289,-601.53442382813,43.283996582031}, -- PILLBOX HOSPITAL
    {"EMSgratis", 1845.2142333984,3679.7919921875,34.274890899658}, -- SANDY HOSPITAL
    {"POLgratis", 449.54730224609,-987.83996582031,26.674102783203}, -- MISSION ROW PD
    {"POLgratis", 381.66815185547,-1610.6778564453,29.292051315308}, -- MISSION ROW PD
    

    
    {"Jem & Fix", 1693.59375,3760.1452636719,34.70531463623}, -- SANDY MIDTBY
    {"Jem & Fix", 252.19242858887,-50.177494049072,69.941062927246}, -- TÆT PÅ KØRESKOLEN
    {"Jem & Fix", 842.16882324219,-1033.7299804688,28.194843292236}, -- HØJRE FRA MIDTBY PD
    {"Jem & Fix", -330.2204284668,6084.0200195313,31.454765319824}, -- OPPE I PALETO BAY
    {"Jem & Fix", -661.98754882813,-935.10211181641,21.829216003418}, -- TÆT PÅ VESPUCCI PD
    {"Jem & Fix", -1305.7849121094,-394.48388671875,36.695762634277}, -- MIDTBY TOP VENSTRE
    {"Jem & Fix", -1117.6987304688,2698.64453125,18.554130554199}, -- TÆT PÅ MILITÆRBASEN
    {"Jem & Fix", 2567.6203613281,294.0827331543,108.73484802246}, -- HELT UDE TIL HØJRE MIDTE
    {"Jem & Fix", -3171.7954101563,1087.9256591797,20.838731765747}, -- HELT UDE TIL VENSTRE MIDTE
    {"Jem & Fix", 22.101684570313,-1107.3146972656,29.797027587891}, -- NEDENUNDER MIDTBY GARAGE
    {"Jem & Fix", 809.9931640625,-2157.4206542969,29.619012832642}, -- NEDE TÆT PÅ HAVNEN

    {"Mobilbutik", -656.98876953125,-857.27966308594,24.490018844604}, -- MOBIL BUTIK RIGT KVARTER
    {"Mobilbutik", 591.32824707031,2744.0380859375,42.042156219482}, -- Sandy
    {"Mobilbutik", -406.84094238281,6062.7177734375,31.500108718872}, -- Paleto

    {"Stripklubben", 127.15741729736,-1284.2979736328,29.280485153198},

    {"Sorte Marked", -1108.083984375,-1643.4897460938,4.6405267715454},
    {"Meth Marked", -2175.2124023438,4294.2978515625,49.056190490723},
    {"Sikkerhedskort Marked", 915.68225097656,-1702.9000244141,51.258495330811},

    {"Burger Shot", -1193.6016845703,-892.486328125,13.995156288147},

    {"Våbenhandler",513.45837402344,-2320.486328125,5.9985680580139},

    {"Mekaniker", 1776.6403808594,3322.8234863281,41.449893951416}, -- SANDY MEKANIKER
    {"Mekaniker", 548.9287109375,-188.73881530762,54.481346130371}, -- AUTO EXOTIC BYEN
    {"Mekaniker", 1153.9372558594,-780.86273193359,57.598705291748}
}