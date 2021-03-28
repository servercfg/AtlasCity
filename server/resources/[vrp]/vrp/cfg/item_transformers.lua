
local cfg = {}

-- define static item transformers
-- see https://github.com/ImagicTheCat/vRP to understand the item transformer concept/definition

cfg.item_transformers = {
    ---------------------------------------STYRKETRÆNING / FITNESS---------------------------------------
    {
        name="Styrketræning", -- menu name
        r=255,g=125,b=0, -- color
        max_units=500,
        units_per_minute=100,
        x=-36.17692565918,y=-1660.0881347656,z=29.486726760864,
        radius=7.5, height=1.5, -- area
        recipes = {
            ["Træn styrke"] = { -- action name
                description="Øger din styrke. Maks styrke du kan løfte er 100 KG", -- action description
                in_money=0, -- money taken per unit
                out_money=0, -- money earned per unit
                reagents={}, -- items taken per unit
                products={}, -- items given per unit
                aptitudes={ -- optional
                    ["physical.strength"] = 1 -- "group.aptitude", give 1 exp per unit
                }
            }
        }
    },
    {
        name="Styrketræning", -- menu name
        r=255,g=125,b=0, -- color
        max_units=500,
        units_per_minute=100,
        x=-1647.2000732422,y=2530.3559570313,z=45.564888000488,
        radius=7.5, height=1.5, -- area
        recipes = {
            ["Træn styrke"] = { -- action name
                description="Øger din styrke. Maks styrke du kan løfte er 100 KG", -- action description
                in_money=0, -- money taken per unit
                out_money=0, -- money earned per unit
                reagents={}, -- items taken per unit
                products={}, -- items given per unit
                aptitudes={ -- optional
                    ["physical.strength"] = 1 -- "group.aptitude", give 1 exp per unit
                }
            }
        }
    },
    {
        name="Styrketræning", -- menu name
        r=255,g=125,b=0, -- color
        max_units=500,
        units_per_minute=100,
        x=1638.5759277344,y=2525.8054199219,z=45.564891815186,
        radius=7.5, height=1.5, -- area
        recipes = {
            ["Træn styrke"] = { -- action name
                description="Øger din styrke. Maks styrke du kan løfte er 100 KG", -- action description
                in_money=0, -- money taken per unit
                out_money=0, -- money earned per unit
                reagents={}, -- items taken per unit
                products={}, -- items given per unit
                aptitudes={ -- optional
                    ["physical.strength"] = 1 -- "group.aptitude", give 1 exp per unit
                }
            }
        }
    },
    {
        name="Styrketræning", -- menu name
        r=255,g=125,b=0, -- color
        max_units=500,
        units_per_minute=100,
        x=-61.472442626953,y=-1282.4744873047,z=30.905097961426,
        radius=7.5, height=1.5, -- area
        recipes = {
            ["Træn styrke"] = { -- action name
                description="Øger din styrke. Maks styrke du kan løfte er 100 KG", -- action description
                in_money=0, -- money taken per unit
                out_money=0, -- money earned per unit
                reagents={}, -- items taken per unit
                products={}, -- items given per unit
                aptitudes={ -- optional
                    ["physical.strength"] = 1 -- "group.aptitude", give 1 exp per unit
                }
            }
        }
    },

    {
        name="Fiskehandler", -- menu name
        r=0,g=255,b=0, -- color
        max_units=250,
        units_per_minute=90,
        x=-1845.1474609375,y=-1195.791015625,z=19.184381484985, -- -1845.1474609375,-1195.791015625,19.184381484985
        radius=2, height=1.0, -- area
        recipes = {
            ["Sælg Torsk"] = { -- action name
                description="Sælg Torsk", -- action description
                in_money=0, -- money taken per unit
                out_money=400, -- money earned per unit
                reagents={ -- items taken per unit
                    ["fisk1"] = 1
                }, -- items taken per unit
               products={
                }, -- items given per unit
                aptitudes={}
                },
            ["Sælg Laks"] = { -- action name
                description="Sælg Laks", -- action description
                in_money=0, -- money taken per unit
                out_money=200, -- money earned per unit
                reagents={ -- items taken per unit
                    ["fisk2"] = 1
                }, -- items taken per unit
               products={
                }, -- items given per unit
                aptitudes={}
                },
            ["Sælg Sild"] = { -- action name
                description="Sælg Sild", -- action description
                in_money=0, -- money taken per unit
                out_money=300, -- money earned per unit
                reagents={ -- items taken per unit
                    ["fisk3"] = 1
                }, -- items taken per unit
               products={
                }, -- items given per unit
                aptitudes={}
                },
            ["Sælg Ørred"] = { -- action name
                description="Sælg Ørred", -- action description
                in_money=0, -- money taken per unit
                out_money=129, -- money earned per unit
                reagents={ -- items taken per unit
                    ["fisk4"] = 1
                }, -- items taken per unit
               products={
                }, -- items given per unit
                aptitudes={}
                },
                ["Sælg Makrel"] = { -- action name
                description="Sælg Makrel", -- action description
                in_money=0, -- money taken per unit
                out_money=187, -- money earned per unit
                reagents={ -- items taken per unit
                    ["fisk5"] = 1
                }, -- items taken per unit
               products={
                }, -- items given per unit
                aptitudes={}
                },
                ["Sælg Aborre"] = { -- action name
                description="Sælg Aborre", -- action description
                in_money=0, -- money taken per unit
                out_money=357, -- money earned per unit
                reagents={ -- items taken per unit
                    ["fisk6"] = 1
                }, -- items taken per unit
               products={
                }, -- items given per unit
                aptitudes={}
                }
            }
        },
---------------------------------------HUG TRÆ---------------------------------------
{
    name="Hug træ", -- menu name
    permissions = {"skovhugger.adgang"},
    r=0,g=255,b=0, -- color
    max_units=200,
    units_per_minute=5,
    x=-1586.6834716797,y=4700.263671875,z=45.322353363037,
    radius=7.5, height=1.5, -- area
    recipes = {
        ["Hugger træer"] = { -- action name
            description="Hugger træ", -- action description
            work=1,
            in_money=0, -- money taken per unit
            out_money=0, -- money earned per unit
            reagents={
            }, -- items taken per unit
            products={
                ["træ"] = 1
            }, -- items given per unit
            aptitudes={ -- optional

            }
        }
    }
},
---------------------------------------LAV PLANKER---------------------------------------
{
    name="Lav Planker", -- menu name
    permissions = {"skovhugger.adgang"},
    r=0,g=255,b=0, -- color
    max_units=200,
    units_per_minute=5,
    x=-525.5380859375,y=5290.7846679688,z=74.174438476563,
    radius=5, height=1.5, -- area
    recipes = {
        ["Laver Planker"] = { -- action name
            description="Laver Planker", -- action description
            work=1,
            in_money=0, -- money taken per unit
            out_money=0, -- money earned per unit
            reagents={
                ["træ"] = 2
            }, -- items taken per unit
            products={
                ["planke"] = 1
            }, -- items given per unit
            aptitudes={ -- optional

            }
        }
    }
},
---------------------------------------SÆLG PLANKER---------------------------------------
{
    name="Sælg Planker", -- menu name
    permissions = {"skovhugger.adgang"},
    r=0,g=255,b=0, -- color
    max_units=200,
    units_per_minute=5,
    x=27.032907485962,y=3636.0126953125,z=40.029407501221,
    radius=5, height=1.5, -- area
    recipes = {
        ["Sælg Planker"] = { -- action name
            description="Sælg Planker", -- action description
            work=1,
            in_money=0, -- money taken per unit
            out_money=200, -- money earned per unit
            reagents={
                ["planke"] = 1
            }, -- items taken per unit
            products={
            }, -- items given per unit
            aptitudes={ -- optional

            }
        }
    }
},

        ---------------------------------------Fængsel---------------------------------------
    {
        name="Fængselsarbejde", -- menu name
        permissions = {"civil.job"},
        r=0,g=255,b=0, -- color
        max_units=300,
        units_per_minute=50,
        x=1667.2224121094,y=2507.9050292969,z=45.564876556396,
        radius=8, height=1.5, -- area
        recipes = {
            ["Fej gulvet"] = { -- action name
                description="Fejer gulvet!", -- action description
                in_money=0, -- money taken per unit
                out_money=1, -- money earned per unit
                reagents={}, -- items taken per unit
                products={}, -- items given per unit
                aptitudes={ -- optional
                }
            }
        }
    },
    
    ---------------------------------------Træ Fældning---------------------------------------
    {
        name="Træfarm", -- menu name
        permissions = {"tree.cutter"},
        r=0,g=200,b=0, -- color
        max_units=350,
        units_per_minute=20,
        x=-636.44482421875,y=5471.7973632813,z=53.17057800293,
        radius=10,5, height=10,5, -- area
        recipes = {
            ["Fæld træer"] = { -- action name
                description="Fæld træer og få stammer ud af dem.", -- action description
                in_money=0, -- money taken per unit
                out_money=0, -- money earned per unit
                reagents={
                }, -- items taken per unit
                products={
                    ["tree"] = 1
                }, -- items given per unit
                aptitudes={ -- optional
                ["physical.strength"] = 1 -- "group.aptitude", give 1 exp per unit
                }
            }
        }
    },

    ---------------------------------------Træ Fremstilling---------------------------------------
    {
        name="Savværk", -- menu name
        permissions = {"tree.cutter"},
        r=0,g=200,b=0, -- color
        max_units=350,
        units_per_minute=35,
        x=-513.70294189453,y=5246.7944335938,z=80.209884643555,
        radius=8, height=5,5, -- area
        recipes = {
            ["Beskær stammer"] = { -- action name
                description="Skær dine stammer om til planker.", -- action description
                in_money=0, -- money taken per unit
                out_money=0, -- money earned per unit
                reagents={
                    ["tree"] = 1,
                }, -- items taken per unit
                products={
                    ["planks"] = 5,
                }, -- items given per unit
                aptitudes={ -- optional

                }
            }
        }
    },


    ---------------------------------------Træ SALG---------------------------------------
    {
        name="Byggepladser", -- menu name
        permissions = {"tree.cutter"},
        r=0,g=200,b=0, -- color
        max_units=350,
        units_per_minute=35,
         x=-497.61245727539,y=-954.251953125,z=23.958311080933,
        radius=1.5, height=1.5, -- area
        recipes = {
            ["Sælg Planker"] = { -- action name
                description="Sælger dine planker til byggepladsen", -- action description
                in_money=0, -- money taken per unit
                out_money=150, -- money earned per unit
                reagents={
                    ["planks"] = 3,
                }, -- items taken per unit
                products={
                }, -- items given per unit
                aptitudes={ -- optional

                }
            }
        }
    }
}



-- define transformers randomly placed on the map
cfg.hidden_transformers = {

}

-- time in minutes before hidden transformers are relocated (min is 5 minutes)
cfg.hidden_transformer_duration = 5*24*60 -- 5 days

-- configure the information reseller (can sell hidden transformers positions)
cfg.informer = {
    infos = {},
    positions = {},
    interval = 60, -- interval in minutes for the reseller respawn
    duration = 10, -- duration in minutes of the spawned reseller
    blipid = 0,
    blipcolor = 0
}

return cfg