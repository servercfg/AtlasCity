Config = {}

Config.AntiSpamCooldown = 3
Config.DriverPed = 988062523
Config.Color = {0,180,249}
Config.BlipColor = 39

Config.Garages = {
    -------------- Example --------------
    -- {
    --     name = "Example Garage", <----------------------------------------------------------- Display name in the menu
    --     permissions = "needed.permission", <------------------------------------------------- Needed permission to access the garage
    --     showBlip = true, <------------------------------------------------------------------- Show the blip true / false
    --     blipID = 198, <---------------------------------------------------------------------- Blip ID (https://wiki.gtanet.work/index.php?title=Blips)
    --     despawn_at_open_menu_coords = true, <------------------------------------------------ Hide the despawn circle and use the garage location as despawn location
    --     open_menu_location = {908.99322509766,-175.82164001465,75.4}, <---------------------- Location for access the garage
    --     vehicle_spawn_location = {915.61669921875,-163.56176757813,74.637138366699}, <------- Vehicle spawn location
    --     vehicle_despawn_location = {}, <----------------------------------------------------- Vehicle despawn location (Disable despawn_at_open_menu_coords if you wanna use this)
    --     vehicles = {
    --         {
    --             displayname = "Taxa",
    --             model = "taxi",
    --             permissions = "taxi.service",
    --             vtype = "car"
    --         },
    --         {
    --             displayname = "Taxa",
    --             model = "taxi",
    --             permissions = "taxi.service",
    --             vtype = "car"
    --         }
    --     }
    -- },
    {
        name = "Politi Garage - Paleto", 
        permissions = "police.service",
        showBlip = false,
        blipID = 357, 
        despawn_at_open_menu_coords = false,
        open_menu_location = {-460.19097900391,6014.7622070313,32.490112304688},
        vehicle_spawn_location = {-482.56994628906,6024.822265625,31.340534210205,219.71},
        vehicle_despawn_location = {-458.06924438477,6043.9770507813,31.3405418396},
        vehicles = {
            {
                displayname = "Schafter (Uniformeret)",
                model = "pschafter2",
                permissions = "police.service",
                vtype = "car",
                billed = "https://cdn.discordapp.com/attachments/470558175721160706/757660186751271083/Schafter.jpg"
            },
            {
                displayname = "Baller (Uniformeret)",
                model = "pballer2",
                permissions = "police.service",
                vtype = "car",
                billed = "https://cdn.discordapp.com/attachments/470558175721160706/757640719249965066/Baller.jpg"
            },
            {
                displayname = "Raiden (Uniformeret)",
                model = "raidenp",
                permissions = "police.service",
                vtype = "car",
                billed = "https://cdn.discordapp.com/attachments/470558175721160706/757659893053390858/Raiden.jpg"
            },
            {
                displayname = "Sentinel (Uniformeret)",
                model = "bcpd6",
                permissions = "police.service",
                vtype = "car",
                billed = "https://cdn.discordapp.com/attachments/470558175721160706/757660712654078043/Sentinel.jpg"
            },
            {
                displayname = "Felon (Uniformeret)",
                model = "bcpd10",
                permissions = "police.service",
                vtype = "car",
                billed = "https://cdn.discordapp.com/attachments/470558175721160706/757657855678611556/Felon.jpg"
            },
            {
                displayname = "Vapid Scout (Uniformeret)",
                model = "fibp62",
                permissions = "police.service",
                vtype = "car",
                billed = "https://cdn.discordapp.com/attachments/470558175721160706/757662735684337917/Vapid_Scout.jpg"
            },
            {
                displayname = "Vapid Scout (Blå)",
                model = "fibp63",
                permissions = "police.service",
                vtype = "car",
                billed = "https://cdn.discordapp.com/attachments/470558175721160706/757663014676856873/Vapid_Scout_Bla.jpg"
            },
            {
                displayname = "Drafter (Civil)",
                model = "cdrafter",
                permissions = "police.service",
                vtype = "car",
                billed = "https://cdn.discordapp.com/attachments/470558175721160706/757657471723765872/Drafter_Civil.jpg"
            },
            {
                displayname = "Oracle (Civil)",
                model = "coracle",
                permissions = "police.service",
                vtype = "car",
                billed = "https://cdn.discordapp.com/attachments/470558175721160706/757659509098283199/Oracle_Civil.jpg"
            },
            {
                displayname = "Granger (Civil)",
                model = "cgranger",
                permissions = "police.service",
                vtype = "car",
                billed = "https://cdn.discordapp.com/attachments/470558175721160706/757659254499836144/Granger_Civil.jpg"
            },
            {
                displayname = "Baller (Civil)",
                model = "cballer",
                permissions = "police.service",
                vtype = "car",
                billed = "https://cdn.discordapp.com/attachments/470558175721160706/757641711353725080/Baller_Civil.jpg"
            },
            {
                displayname = "Buffalo (Civil)",
                model = "BB2018U",
                permissions = "police.service",
                vtype = "car",
                billed = "https://cdn.discordapp.com/attachments/470558175721160706/757657011600228372/Buffalo_Civil.jpg"
            },
            {
                displayname = "Sultan (Civil)",
                model = "KSRS2018U",
                permissions = "police.service",
                vtype = "car",
                billed = "https://cdn.discordapp.com/attachments/470558175721160706/757661003524866179/Sultan_Civil.jpg"
            },
            {
                displayname = "Baller (Indsatsleder)",
                model = "iballer2",
                permissions = "police.service",
                vtype = "car",
                billed = "https://cdn.discordapp.com/attachments/470558175721160706/757641415995162684/Baller_Indsatsleder.jpg"
            },
            {
                displayname = "Schafter (Indsatsleder)",
                model = "ischafter2",
                permissions = "police.service",
                vtype = "car",
                billed = "https://cdn.discordapp.com/attachments/470558175721160706/757660471812816988/Schafter_Indsatsleder.jpg"
            },
            {
                displayname = "Hakuchou (Motorcykel)",
                model = "pmcv",
                permissions = "police.service",
                vtype = "bike",
                billed = "https://cdn.discordapp.com/attachments/470558175721160706/757662286188904548/Hakuchou_MC.jpg"
            },
            {
                displayname = "Thruster (Motorcykel)",
                model = "polthrust",
                permissions = "police.service",
                vtype = "bike",
                billed = "https://cdn.discordapp.com/attachments/470558175721160706/757661989530108037/Thruster_MC.jpg"
            },
            {
                displayname = "Offroad (Motorcykel)",
                model = "policeb2",
                permissions = "police.service",
                vtype = "bike",
                billed = "https://cdn.discordapp.com/attachments/470558175721160706/757661519734505572/Offroad_MC.jpg"
            },
            {
                displayname = "Fængsels Bus",
                model = "pbus",
                permissions = "police.service",
                vtype = "car",
                billed = "https://cdn.discordapp.com/attachments/470558175721160706/757658492046671972/Fngels_Bus.jpg"
            }
        } 
    },
    {
        name = "Politi Garage - DavisPD", 
        permissions = "police.service",
        showBlip = false,
        blipID = 357, 
        despawn_at_open_menu_coords = false,
        open_menu_location = {346.79885864258,-1641.5739746094,24.784442901611},
        vehicle_spawn_location = {343.60195922852,-1630.3463134766,23.784454345703,225.97},
        vehicle_despawn_location = {348.15036010742,-1635.1982421875,23.784446716309},
        vehicles = {
            {
                displayname = "Schafter (Uniformeret)",
                model = "pschafter2",
                permissions = "police.service",
                vtype = "car",
                billed = "https://cdn.discordapp.com/attachments/470558175721160706/757660186751271083/Schafter.jpg"
            },
            {
                displayname = "Baller (Uniformeret)",
                model = "pballer2",
                permissions = "police.service",
                vtype = "car",
                billed = "https://cdn.discordapp.com/attachments/470558175721160706/757640719249965066/Baller.jpg"
            },
            {
                displayname = "Raiden (Uniformeret)",
                model = "raidenp",
                permissions = "police.service",
                vtype = "car",
                billed = "https://cdn.discordapp.com/attachments/470558175721160706/757659893053390858/Raiden.jpg"
            },
            {
                displayname = "Sentinel (Uniformeret)",
                model = "bcpd6",
                permissions = "police.service",
                vtype = "car",
                billed = "https://cdn.discordapp.com/attachments/470558175721160706/757660712654078043/Sentinel.jpg"
            },
            {
                displayname = "Felon (Uniformeret)",
                model = "bcpd10",
                permissions = "police.service",
                vtype = "car",
                billed = "https://cdn.discordapp.com/attachments/470558175721160706/757657855678611556/Felon.jpg"
            },
            {
                displayname = "Vapid Scout (Uniformeret)",
                model = "fibp62",
                permissions = "police.service",
                vtype = "car",
                billed = "https://cdn.discordapp.com/attachments/470558175721160706/757662735684337917/Vapid_Scout.jpg"
            },
            {
                displayname = "Vapid Scout (Blå)",
                model = "fibp63",
                permissions = "police.service",
                vtype = "car",
                billed = "https://cdn.discordapp.com/attachments/470558175721160706/757663014676856873/Vapid_Scout_Bla.jpg"
            },
            {
                displayname = "Drafter (Civil)",
                model = "cdrafter",
                permissions = "police.service",
                vtype = "car",
                billed = "https://cdn.discordapp.com/attachments/470558175721160706/757657471723765872/Drafter_Civil.jpg"
            },
            {
                displayname = "Oracle (Civil)",
                model = "coracle",
                permissions = "police.service",
                vtype = "car",
                billed = "https://cdn.discordapp.com/attachments/470558175721160706/757659509098283199/Oracle_Civil.jpg"
            },
            {
                displayname = "Granger (Civil)",
                model = "cgranger",
                permissions = "police.service",
                vtype = "car",
                billed = "https://cdn.discordapp.com/attachments/470558175721160706/757659254499836144/Granger_Civil.jpg"
            },
            {
                displayname = "Baller (Civil)",
                model = "cballer",
                permissions = "police.service",
                vtype = "car",
                billed = "https://cdn.discordapp.com/attachments/470558175721160706/757641711353725080/Baller_Civil.jpg"
            },
            {
                displayname = "Buffalo (Civil)",
                model = "BB2018U",
                permissions = "police.service",
                vtype = "car",
                billed = "https://cdn.discordapp.com/attachments/470558175721160706/757657011600228372/Buffalo_Civil.jpg"
            },
            {
                displayname = "Sultan (Civil)",
                model = "KSRS2018U",
                permissions = "police.service",
                vtype = "car",
                billed = "https://cdn.discordapp.com/attachments/470558175721160706/757661003524866179/Sultan_Civil.jpg"
            },
            {
                displayname = "Baller (Indsatsleder)",
                model = "iballer2",
                permissions = "police.service",
                vtype = "car",
                billed = "https://cdn.discordapp.com/attachments/470558175721160706/757641415995162684/Baller_Indsatsleder.jpg"
            },
            {
                displayname = "Schafter (Indsatsleder)",
                model = "ischafter2",
                permissions = "police.service",
                vtype = "car",
                billed = "https://cdn.discordapp.com/attachments/470558175721160706/757660471812816988/Schafter_Indsatsleder.jpg"
            },
            {
                displayname = "Hakuchou (Motorcykel)",
                model = "pmcv",
                permissions = "police.service",
                vtype = "bike",
                billed = "https://cdn.discordapp.com/attachments/470558175721160706/757662286188904548/Hakuchou_MC.jpg"
            },
            {
                displayname = "Thruster (Motorcykel)",
                model = "polthrust",
                permissions = "police.service",
                vtype = "bike",
                billed = "https://cdn.discordapp.com/attachments/470558175721160706/757661989530108037/Thruster_MC.jpg"
            },
            {
                displayname = "Offroad (Motorcykel)",
                model = "policeb2",
                permissions = "police.service",
                vtype = "bike",
                billed = "https://cdn.discordapp.com/attachments/470558175721160706/757661519734505572/Offroad_MC.jpg"
            },
            {
                displayname = "Fængsels Bus",
                model = "pbus",
                permissions = "police.service",
                vtype = "car",
                billed = "https://cdn.discordapp.com/attachments/470558175721160706/757658492046671972/Fngels_Bus.jpg"
            }
        } 
    },
    {
        name = "Politi Garage - SandyPD", 
        permissions = "police.service",
        showBlip = false,
        blipID = 357, 
        despawn_at_open_menu_coords = false,
        open_menu_location = {1863.0548095703,3704.1857910156,34.437225341797},
        vehicle_spawn_location = {1866.8670654297,3697.3891601563,33.595905303955,225.97},
        vehicle_despawn_location = {1866.8670654297,3697.3891601563,33.595905303955},
        vehicles = {
            {
                displayname = "Schafter (Uniformeret)",
                model = "pschafter2",
                permissions = "police.service",
                vtype = "car",
                billed = "https://cdn.discordapp.com/attachments/470558175721160706/757660186751271083/Schafter.jpg"
            },
            {
                displayname = "Baller (Uniformeret)",
                model = "pballer2",
                permissions = "police.service",
                vtype = "car",
                billed = "https://cdn.discordapp.com/attachments/470558175721160706/757640719249965066/Baller.jpg"
            },
            {
                displayname = "Raiden (Uniformeret)",
                model = "raidenp",
                permissions = "police.service",
                vtype = "car",
                billed = "https://cdn.discordapp.com/attachments/470558175721160706/757659893053390858/Raiden.jpg"
            },
            {
                displayname = "Sentinel (Uniformeret)",
                model = "bcpd6",
                permissions = "police.service",
                vtype = "car",
                billed = "https://cdn.discordapp.com/attachments/470558175721160706/757660712654078043/Sentinel.jpg"
            },
            {
                displayname = "Felon (Uniformeret)",
                model = "bcpd10",
                permissions = "police.service",
                vtype = "car",
                billed = "https://cdn.discordapp.com/attachments/470558175721160706/757657855678611556/Felon.jpg"
            },
            {
                displayname = "Vapid Scout (Uniformeret)",
                model = "fibp62",
                permissions = "police.service",
                vtype = "car",
                billed = "https://cdn.discordapp.com/attachments/470558175721160706/757662735684337917/Vapid_Scout.jpg"
            },
            {
                displayname = "Vapid Scout (Blå)",
                model = "fibp63",
                permissions = "police.service",
                vtype = "car",
                billed = "https://cdn.discordapp.com/attachments/470558175721160706/757663014676856873/Vapid_Scout_Bla.jpg"
            },
            {
                displayname = "Drafter (Civil)",
                model = "cdrafter",
                permissions = "police.service",
                vtype = "car",
                billed = "https://cdn.discordapp.com/attachments/470558175721160706/757657471723765872/Drafter_Civil.jpg"
            },
            {
                displayname = "Oracle (Civil)",
                model = "coracle",
                permissions = "police.service",
                vtype = "car",
                billed = "https://cdn.discordapp.com/attachments/470558175721160706/757659509098283199/Oracle_Civil.jpg"
            },
            {
                displayname = "Granger (Civil)",
                model = "cgranger",
                permissions = "police.service",
                vtype = "car",
                billed = "https://cdn.discordapp.com/attachments/470558175721160706/757659254499836144/Granger_Civil.jpg"
            },
            {
                displayname = "Baller (Civil)",
                model = "cballer",
                permissions = "police.service",
                vtype = "car",
                billed = "https://cdn.discordapp.com/attachments/470558175721160706/757641711353725080/Baller_Civil.jpg"
            },
            {
                displayname = "Buffalo (Civil)",
                model = "BB2018U",
                permissions = "police.service",
                vtype = "car",
                billed = "https://cdn.discordapp.com/attachments/470558175721160706/757657011600228372/Buffalo_Civil.jpg"
            },
            {
                displayname = "Sultan (Civil)",
                model = "KSRS2018U",
                permissions = "police.service",
                vtype = "car",
                billed = "https://cdn.discordapp.com/attachments/470558175721160706/757661003524866179/Sultan_Civil.jpg"
            },
            {
                displayname = "Baller (Indsatsleder)",
                model = "iballer2",
                permissions = "police.service",
                vtype = "car",
                billed = "https://cdn.discordapp.com/attachments/470558175721160706/757641415995162684/Baller_Indsatsleder.jpg"
            },
            {
                displayname = "Schafter (Indsatsleder)",
                model = "ischafter2",
                permissions = "police.service",
                vtype = "car",
                billed = "https://cdn.discordapp.com/attachments/470558175721160706/757660471812816988/Schafter_Indsatsleder.jpg"
            },
            {
                displayname = "Hakuchou (Motorcykel)",
                model = "pmcv",
                permissions = "police.service",
                vtype = "bike",
                billed = "https://cdn.discordapp.com/attachments/470558175721160706/757662286188904548/Hakuchou_MC.jpg"
            },
            {
                displayname = "Thruster (Motorcykel)",
                model = "polthrust",
                permissions = "police.service",
                vtype = "bike",
                billed = "https://cdn.discordapp.com/attachments/470558175721160706/757661989530108037/Thruster_MC.jpg"
            },
            {
                displayname = "Offroad (Motorcykel)",
                model = "policeb2",
                permissions = "police.service",
                vtype = "bike",
                billed = "https://cdn.discordapp.com/attachments/470558175721160706/757661519734505572/Offroad_MC.jpg"
            },
            {
                displayname = "Fængsels Bus",
                model = "pbus",
                permissions = "police.service",
                vtype = "car",
                billed = "https://cdn.discordapp.com/attachments/470558175721160706/757658492046671972/Fngels_Bus.jpg"
            }
        } 
    },
    {
        name = "Politi Garage - Mission Row", 
        permissions = "police.service",
        showBlip = false,
        blipID = 357, 
        despawn_at_open_menu_coords = false,
        open_menu_location = {457.7099609375,-1008.421081543,29.295286178589},
        vehicle_spawn_location = {451.88522338867,-1020.3665771484,28.491017913818,279.97},
        vehicle_despawn_location = {462.89651489258,-1019.5952758789,28.205550765991},
        vehicles = {
            {
                displayname = "Schafter (Uniformeret)",
                model = "pschafter2",
                permissions = "police.service",
                vtype = "car",
                billed = "https://cdn.discordapp.com/attachments/470558175721160706/757660186751271083/Schafter.jpg"
            },
            {
                displayname = "Baller (Uniformeret)",
                model = "pballer2",
                permissions = "police.service",
                vtype = "car",
                billed = "https://cdn.discordapp.com/attachments/470558175721160706/757640719249965066/Baller.jpg"
            },
            {
                displayname = "Raiden (Uniformeret)",
                model = "raidenp",
                permissions = "police.service",
                vtype = "car",
                billed = "https://cdn.discordapp.com/attachments/470558175721160706/757659893053390858/Raiden.jpg"
            },
            {
                displayname = "Sentinel (Uniformeret)",
                model = "bcpd6",
                permissions = "police.service",
                vtype = "car",
                billed = "https://cdn.discordapp.com/attachments/470558175721160706/757660712654078043/Sentinel.jpg"
            },
            {
                displayname = "Felon (Uniformeret)",
                model = "bcpd10",
                permissions = "police.service",
                vtype = "car",
                billed = "https://cdn.discordapp.com/attachments/470558175721160706/757657855678611556/Felon.jpg"
            },
            {
                displayname = "Vapid Scout (Uniformeret)",
                model = "fibp62",
                permissions = "police.service",
                vtype = "car",
                billed = "https://cdn.discordapp.com/attachments/470558175721160706/757662735684337917/Vapid_Scout.jpg"
            },
            {
                displayname = "Vapid Scout (Blå)",
                model = "fibp63",
                permissions = "police.service",
                vtype = "car",
                billed = "https://cdn.discordapp.com/attachments/470558175721160706/757663014676856873/Vapid_Scout_Bla.jpg"
            },
            {
                displayname = "Drafter (Civil)",
                model = "cdrafter",
                permissions = "police.service",
                vtype = "car",
                billed = "https://cdn.discordapp.com/attachments/470558175721160706/757657471723765872/Drafter_Civil.jpg"
            },
            {
                displayname = "Oracle (Civil)",
                model = "coracle",
                permissions = "police.service",
                vtype = "car",
                billed = "https://cdn.discordapp.com/attachments/470558175721160706/757659509098283199/Oracle_Civil.jpg"
            },
            {
                displayname = "Granger (Civil)",
                model = "cgranger",
                permissions = "police.service",
                vtype = "car",
                billed = "https://cdn.discordapp.com/attachments/470558175721160706/757659254499836144/Granger_Civil.jpg"
            },
            {
                displayname = "Baller (Civil)",
                model = "cballer",
                permissions = "police.service",
                vtype = "car",
                billed = "https://cdn.discordapp.com/attachments/470558175721160706/757641711353725080/Baller_Civil.jpg"
            },
            {
                displayname = "Buffalo (Civil)",
                model = "BB2018U",
                permissions = "police.service",
                vtype = "car",
                billed = "https://cdn.discordapp.com/attachments/470558175721160706/757657011600228372/Buffalo_Civil.jpg"
            },
            {
                displayname = "Sultan (Civil)",
                model = "KSRS2018U",
                permissions = "police.service",
                vtype = "car",
                billed = "https://cdn.discordapp.com/attachments/470558175721160706/757661003524866179/Sultan_Civil.jpg"
            },
            {
                displayname = "Baller (Indsatsleder)",
                model = "iballer2",
                permissions = "police.service",
                vtype = "car",
                billed = "https://cdn.discordapp.com/attachments/470558175721160706/757641415995162684/Baller_Indsatsleder.jpg"
            },
            {
                displayname = "Schafter (Indsatsleder)",
                model = "ischafter2",
                permissions = "police.service",
                vtype = "car",
                billed = "https://cdn.discordapp.com/attachments/470558175721160706/757660471812816988/Schafter_Indsatsleder.jpg"
            },
            {
                displayname = "Hakuchou (Motorcykel)",
                model = "pmcv",
                permissions = "police.service",
                vtype = "bike",
                billed = "https://cdn.discordapp.com/attachments/470558175721160706/757662286188904548/Hakuchou_MC.jpg"
            },
            {
                displayname = "Thruster (Motorcykel)",
                model = "polthrust",
                permissions = "police.service",
                vtype = "bike",
                billed = "https://cdn.discordapp.com/attachments/470558175721160706/757661989530108037/Thruster_MC.jpg"
            },
            {
                displayname = "Offroad (Motorcykel)",
                model = "policeb2",
                permissions = "police.service",
                vtype = "bike",
                billed = "https://cdn.discordapp.com/attachments/470558175721160706/757661519734505572/Offroad_MC.jpg"
            },
            {
                displayname = "Fængsels Bus",
                model = "pbus",
                permissions = "police.service",
                vtype = "car",
                billed = "https://cdn.discordapp.com/attachments/470558175721160706/757658492046671972/Fngels_Bus.jpg"
            }
        } 
    },
    {
        name = "Sundhedsvæsnet Garage - Pillbox", 
        permissions = "emergency.service",
        showBlip = false,
        blipID = 357, 
        despawn_at_open_menu_coords = false,
        open_menu_location = {325.87295532227,-549.26025390625,29.743453979492},
        vehicle_spawn_location = {345.38522338867,-546.63659667969,28.743450164795,345.63},
        vehicle_despawn_location = {329.4919128418,-557.29431152344,28.743434906006},
        vehicles = {
            {
                displayname = "Ambulance",
                model = "lsambulance",
                permissions = "emergency.service",
                vtype = "car",
                billed = "https://cdn.discordapp.com/attachments/470558175721160706/757667820174573649/Ambulance.jpg"
            }, 
            {
                displayname = "Vapid Speedo",
                model = "ambulance22",
                permissions = "emergency.service",
                vtype = "car",
                billed = "https://cdn.discordapp.com/attachments/470558175721160706/757670425114312925/Vapid_Speedo.jpg"
            },
            {
                displayname = "Specialambulance",
                model = "ambulance3",
                permissions = "emergency.service",
                vtype = "car",
                billed = "https://cdn.discordapp.com/attachments/470558175721160706/757668800521961825/Specialambulance.jpg"
            },
            {
                displayname = "Vapid Interceptor",
                model = "ems",
                permissions = "emergency.service",
                vtype = "car",
                billed = "https://cdn.discordapp.com/attachments/470558175721160706/757670045030809660/Vapid_Interceptor.jpg"
            },
            {
                displayname = "Felon",
                model = "bcpd10a",
                permissions = "emergency.service",
                vtype = "car",
                billed = "https://cdn.discordapp.com/attachments/470558175721160706/757668377731793027/Felon.jpg"
            },
            {
                displayname = "Baller",
                model = "lballer2",
                permissions = "emergency.service",
                vtype = "car",
                billed = "https://cdn.discordapp.com/attachments/470558175721160706/757668058067238953/Baller.jpg"
            },
        }
    },
    {
        name = "Sundhedsvæsnet Garage - Sandy", 
        permissions = "emergency.service",
        showBlip = false,
        blipID = 357, 
        despawn_at_open_menu_coords = false,
        open_menu_location = {1837.0622558594,3695.2751464844,35.268363952637},
        vehicle_spawn_location = {1842.9603271484,3706.2746582031,33.61137008667,345.63},
        vehicle_despawn_location = {1842.9603271484,3706.2746582031,33.61137008667},
        vehicles = {
            {
                displayname = "Ambulance",
                model = "lsambulance",
                permissions = "emergency.service",
                vtype = "car",
                billed = "https://cdn.discordapp.com/attachments/470558175721160706/757667820174573649/Ambulance.jpg"
            }, 
            {
                displayname = "Vapid Speedo",
                model = "ambulance22",
                permissions = "emergency.service",
                vtype = "car",
                billed = "https://cdn.discordapp.com/attachments/470558175721160706/757670425114312925/Vapid_Speedo.jpg"
            },
            {
                displayname = "Specialambulance",
                model = "ambulance3",
                permissions = "emergency.service",
                vtype = "car",
                billed = "https://cdn.discordapp.com/attachments/470558175721160706/757668800521961825/Specialambulance.jpg"
            },
            {
                displayname = "Vapid Interceptor",
                model = "ems",
                permissions = "emergency.service",
                vtype = "car",
                billed = "https://cdn.discordapp.com/attachments/470558175721160706/757670045030809660/Vapid_Interceptor.jpg"
            },
            {
                displayname = "Felon",
                model = "bcpd10a",
                permissions = "emergency.service",
                vtype = "car",
                billed = "https://cdn.discordapp.com/attachments/470558175721160706/757668377731793027/Felon.jpg"
            },
            {
                displayname = "Baller",
                model = "lballer2",
                permissions = "emergency.service",
                vtype = "car",
                billed = "https://cdn.discordapp.com/attachments/470558175721160706/757668058067238953/Baller.jpg"
            },
        }
    },
    {
        name = "Lægehelikopter garage - Pillbox", 
        permissions = "emergency.service",
        showBlip = false,
        blipID = 198, 
        despawn_at_open_menu_coords = true,
        open_menu_location = {344.90777587891,-583.03253173828,75.165580749512},
        vehicle_spawn_location = {351.44213867188,-588.30847167969,74.165657043457},
        vehicle_despawn_location = {351.44213867188,-588.30847167969,74.165657043457},
        vehicles = {
            {
                displayname = "Lægehelikopter",
                model = "supervolito",
                permissions = "emergency.service",
                vtype = "car",
                billed = "https://cdn.discordapp.com/attachments/470558175721160706/757671015437565994/Lge_Helikopter.jpg"
            }
        }
    },
    {
        name = "Lægehelikopter garage - Sandy", 
        permissions = "emergency.service",
        showBlip = false,
        blipID = 198, 
        despawn_at_open_menu_coords = true,
        open_menu_location = {1846.9332275391,3648.73828125,35.177955627441},
        vehicle_spawn_location = {1849.7747802734,3639.005859375,35.778388977051},
        vehicle_despawn_location = {1849.7747802734,3639.005859375,35.778388977051},
        vehicles = {
            {
                displayname = "Lægehelikopter",
                model = "supervolito",
                permissions = "emergency.service",
                vtype = "car",
                billed = "https://cdn.discordapp.com/attachments/470558175721160706/757671015437565994/Lge_Helikopter.jpg"
            }
        }
    },
    {
        name = "Politihelikopter garage - Mission Row PD", 
        permissions = "police.service",
        showBlip = false,
        blipID = 198, 
        despawn_at_open_menu_coords = true,
        open_menu_location = {457.21258544922,-979.064453125,44.691970825195},
        vehicle_spawn_location = {449.15075683594,-981.29034423828,43.691738128662},
        vehicle_despawn_location = {449.15075683594,-981.29034423828,43.691738128662},
        vehicles = {
            {
                displayname = "Politihelikopter",
                model = "polmav",
                permissions = "police.service",
                vtype = "car",
                billed = "https://cdn.discordapp.com/attachments/470558175721160706/757663681055162569/Politi_Helikopter.jpg"
            }
        }
    },
    {
        name = "Politihelikopter garage - PaletoPD", 
        permissions = "police.service",
        showBlip = false,
        blipID = 198, 
        despawn_at_open_menu_coords = true,
        open_menu_location = {-462.58316040039,5994.1376953125,32.245737075806},
        vehicle_spawn_location = {-475.09326171875,5988.5190429688,31.336708068848},
        vehicle_despawn_location = {-475.09326171875,5988.5190429688,31.336708068848},
        vehicles = {
            {
                displayname = "Politihelikopter",
                model = "polmav",
                permissions = "police.service",
                vtype = "car",
                billed = "https://cdn.discordapp.com/attachments/470558175721160706/757663681055162569/Politi_Helikopter.jpg"
            }
        }
    },
    {
        name = "Politihelikopter garage - SandyPD", 
        permissions = "police.service",
        showBlip = false,
        blipID = 198, 
        despawn_at_open_menu_coords = true,
        open_menu_location = {1863.0886230469,3658.3989257813,34.924682617188},
        vehicle_spawn_location = {1866.0939941406,3648.4204101563,35.778396606445},
        vehicle_despawn_location = {1866.0939941406,3648.4204101563,35.778396606445},
        vehicles = {
            {
                displayname = "Politihelikopter",
                model = "polmav",
                permissions = "police.service",
                vtype = "car",
                billed = "https://cdn.discordapp.com/attachments/470558175721160706/757663681055162569/Politi_Helikopter.jpg"
            }
        }
    },
    {
        name = "Taxa garage", 
        permissions = "taxi.service",
        showBlip = true,
        blipID = 198, 
        despawn_at_open_menu_coords = true,
        open_menu_location = {890.1708984375,-159.08192443848,77.69303894043},
        vehicle_spawn_location = {897.41900634766,-152.65521240234,76.569175720215},
        vehicle_despawn_location = {897.41900634766,-152.65521240234,76.569175720215},
        vehicles = {
            {
                displayname = "Taxa",
                model = "taxi",
                permissions = "taxi.service",
                vtype = "car",
                billed = "https://cdn.discordapp.com/attachments/470558175721160706/757656536289116245/Taxi.jpg"
            }
        }
    },
    {
        name = "Mekaniker - Garage", 
        permissions = "repair.vehicle",
        showBlip = false,
        blipID = 402, 
        despawn_at_open_menu_coords = true,
        open_menu_location = {-176.85108947754,-1289.1965332031,32.295980453491},
        vehicle_spawn_location = {-184.75386047363,-1289.25,31.295980453491,185.06},
        vehicle_despawn_location = {-188.7463684082,-1277.3228759766,31.296010971069},
        vehicles = {
            {
                displayname = "Tow Truck",
                model = "towtruck",
                permissions = "repair.vehicle",
                vtype = "car"
            },
            {
                displayname = "Flatbed",
                model = "flatbed",
                permissions = "repair.vehicle",
                vtype = "car"
            }
        }
    },
    {
        name = "Nico's Mekaniker Firma", 
        permissions = "repair.vehicle",
        showBlip = false,
        blipID = 402, 
        despawn_at_open_menu_coords = true,
        open_menu_location = {548.29956054688,-204.5320892334,55.298519134521},
        vehicle_spawn_location = {542.70080566406,-224.79780578613,50.917762756348,147.06},
        vehicle_despawn_location = {542.70080566406,-224.79780578613,50.917762756348},
        vehicles = {
            {
                displayname = "Tow Truck",
                model = "towtruck",
                permissions = "repair.vehicle",
                vtype = "car"
            },
            {
                displayname = "Flatbed",
                model = "flatbed",
                permissions = "repair.vehicle",
                vtype = "car"
            }
        }
    },
  --[[  {
        name = "Autohjørnet", 
        permissions = "auto.garage",
        showBlip = true,
        blipID = 402, 
        despawn_at_open_menu_coords = true,
        open_menu_location = {1123.3566894531,-784.75823974609,58.653896331787},
        vehicle_spawn_location = {1122.2139892578,-768.44714355469,57.695655822754,2.06},
        vehicle_despawn_location = {1121.2227783203,-792.75738525391,57.740306854248},
        vehicles = {
            {
                displayname = "Tow Truck",
                model = "towtruck",
                permissions = "auto.garage",
                vtype = "car"
            },
            {
                displayname = "Flatbed",
                model = "flatbed",
                permissions = "auto.garage",
                vtype = "car"
            }
        }
    },]]
    {
        name = "Minebil garage", 
        permissions = "miner.adgang",
        showBlip = true,
        blipID = 318, 
        despawn_at_open_menu_coords = true,
        open_menu_location = {501.69110107422,-1971.1076660156,25.862276077271},
        vehicle_spawn_location = {495.33065795898,-1968.0748291016,24.904434204102,120.15},
        vehicle_despawn_location = {495.33065795898,-1968.0748291016,24.904434204102},
        vehicles = {
            {
                displayname = "Minebilen",
                model = "tiptruck",
                permissions = "miner.adgang",
                vtype = "car"
            }
        }
    },
    {
        name = "Skraldevogn garage", 
        permissions = "skralde.vehicle",
        showBlip = true,
        blipID = 318, 
        despawn_at_open_menu_coords = true,
        open_menu_location = {1532.1922607422,-2088.8073730469,78.071876525879},
        vehicle_spawn_location = {1540.1734619141,-2093.4157714844,77.10327911377,6.15},
        vehicle_despawn_location = {1528.5354003906,-2098.2331542969,77.014625549316},
        vehicles = {
            {
                displayname = "Skraldevogn",
                model = "trash",
                permissions = "skralde.vehicle",
                vtype = "car"
            }
        }
    },
    {
        name = "Pizzajob garage", 
        permissions = "delivery.vehicle",
        showBlip = true,
        blipID = 56, 
        despawn_at_open_menu_coords = true,
        open_menu_location = {407.00921630859,106.6736907959,102.28582000732},
        vehicle_spawn_location = {412.5032043457,107.30745697021,100.92597198486,247.15},
        vehicle_despawn_location = {412.5032043457,107.30745697021,100.92597198486},
        vehicles = {
            {
                displayname = "Scooter",
                model = "faggio2",
                permissions = "delivery.vehicle",
                vtype = "car"
            }
        }
    },
    {
        name = "Falck Vagt garage", 
        permissions = "falckvagt.garage",
        showBlip = false,
        blipID = 56, 
        despawn_at_open_menu_coords = true,
        open_menu_location = {343.66088867188,-563.52160644531,29.743453979492},
        vehicle_spawn_location = {343.94052124023,-556.50622558594,28.743452072144,342.15},
        vehicle_despawn_location = {343.94052124023,-556.50622558594,28.743452072144},
        vehicles = {
            {
                displayname = "Vagt Bil",
                model = "falckvagt",
                permissions = "falckvagt.garage",
                vtype = "car"
            }
        }
    },
    {
        name = "Lastbil garage", 
        permissions = "trucker.vehicle",
        showBlip = true,
        blipID = 85, 
        despawn_at_open_menu_coords = true,
        open_menu_location = {160.06260681152,6407.921875,32.162828445435},
        vehicle_spawn_location = {143.68907165527,6397.2612304688,31.185230255127,142.98},
        vehicle_despawn_location = {129.82096862793,6410.419921875,31.296552658081},
        vehicles = {
            {
                displayname = "Phantom",
                model = "phantom",
                permissions = "trucker.vehicle",
                vtype = "car"
            },
            {
                displayname = "Packer",
                model = "packer",
                permissions = "trucker.vehicle",
                vtype = "car"
            }
        }
    }
}