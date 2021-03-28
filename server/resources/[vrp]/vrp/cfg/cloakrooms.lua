
-- this file configure the cloakrooms on the map

local cfg = {}

-- prepare surgeries customizations
local surgery_male = { model = "mp_m_freemode_01" }
local surgery_female = { model = "mp_f_freemode_01" }
local police_male = { model = "s_m_y_hwaycop_01" }
local policeundercover_male = { model = "s_m_m_ciasec_01"}
local police2_male = { model = "s_m_y_cop_01"}
local ems_male = { model = "s_m_m_paramedic_01"}
local sheriff_male = { model ="s_m_y_sheriff_01"}
local factory_male = { model ="s_m_y_factory_01"}
local doctor_male = { model ="s_m_m_doctor_01"}
local autopsy_male = { model="s_m_y_autopsy_01"}
local hunde_male = { model ="s_m_m_snowcop_01"}
local scrubs_female = { model="s_f_y_scrubs_01"}
local lost_m1 = {model ="g_m_y_lost_01"}
local lost_m2 = {model ="g_m_y_lost_02"}
local lost_m3 = {model ="g_m_y_lost_03"}
local vest_p = {model ="u_m_m_doa_01"}
local child_abner = {model ="u_m_y_abner"}
local child_tourist1 = {model ="a_f_y_tourist_01"}
local child_tourist2 = {model ="a_f_y_tourist_02"}
local player_one = {model ="player_one"}
local player_two = {model ="player_two"}


for i=0,19 do
	surgery_female[i] = {0,0}
	surgery_male[i] = {0,0}
end

-- cloakroom types (_config, map of name => customization)
--- _config:
---- permissions (optional)
---- not_uniform (optional): if true, the cloakroom will take effect directly on the player, not as a uniform you can remove
cfg.cloakroom_types = {
["Politi Omklædningsrum"] = {
    _config = { permissions = {"police.cloakroom"} },
    ["Langærmet Uniform"] = {
      [11] = {118,0},
      [8] = {0,240},
      [6] = {25,0},
      [3] = {4,0},
      [4] = {49,0}
    },
    ["Kortærmet Skjorte"] = {
      [11] = {143,1},
      [8] = {0,240},
      [6] = {25,0},
      [3] = {11,0},
      [4] = {49,0}
    },
    ["Kriminaltekniker"] = {
      [11] = {15,0},
      [8] = {60,0},
      [6] = {25,0},
      [3] = {86,0},
      [4] = {49,0}
    },
    ["Striktrøje"] = {
      [11] = {246,1},
      [8] = {0,240},
      [6] = {25,0},
      [3] = {11,0},
      [4] = {49,0}
    },
    ["Regnjakke"] = {
      [11] = {69,1},
      [8] = {13,3},
      [6] = {25,0},
      [3] = {11,0},
      [4] = {49,0}
    },
    ["Lyseblå Polo"] = {
      [11] = {147,2},
      [8] = {0,240},
      [6] = {25,0},
      [3] = {0,0},
      [4] = {49,0}
    },
    ["Mørkeblå Polo"] = {
      [11] = {149,2},
      [8] = {0,240},
      [6] = {25,0},
      [3] = {0,0},
      [4] = {49,0}
    },
    ["MC Betjent"] = {
      [11] = {81,2},
      [8] = {0,240},
      [6] = {25,0},
      [3] = {31,0},
      [4] = {49,0},
      ["p0"] = {3,0}
    },
    ["Jakke"] = {
      [11] = {210,2},
      [8] = {13,3},
      [6] = {25,0},
      [3] = {14,0},
      [4] = {49,0}
    },
    ["Romeo"] = {
      [11] = {81,0},
      [6] = {25,0},
      [1] = {0,0},
      [4] = {9,7},
      [3] = {17,0},
      ["p0"] = {92,0},
      ["p1"] = {15,0}
    }
  },

  ["Læge Omklædningsrum"] = {
    _config = { permissions = {"emergency.market"} },
    ["Langærmet - Mand"] = {
      [11] = {15,0}, --Trøje
      [8] = {71,5}, --Tshirt
      [3] = {88,0}, --Arme
      [4] = {49,1}, --Bukser
      [6] = {24,0} --Sko
    },
    ["MC Tøj"] = {
      [11] = {147,1}, --Trøje
      [6] = {25,0}, --Sko
      [3] = {22,0}, --Arme
      [4] = {49,0}, --Bukser
      ["p0"] = {17,1} --Hjelm
    },
    ["Langærmet - Mand [Vest]"] = {
      [11] = {247,5}, --Trøje
      [8] = {71,5}, --Tshirt
      [3] = {88,0}, --Arme
      [4] = {49,1}, --Bukser
      [6] = {24,0} --Sko
    },
    ["Kortærmet - Mand"] = {
      [11] = {73,5}, --Trøje
      [3] = {85,0}, --Arme
      [4] = {49,1}, --Bukser
      [6] = {24,0} --Sko
    }
  }
}


cfg.cloakrooms = {
  {"Politi Omklædningsrum", 459.20251464844,-992.76586914063,30.689611434937},
  {"Læge Omklædningsrum", 298.80209350586,-598.50305175781,43.283931732178},
	{"Politi Omklædningsrum", -438.53897094727,6011.7836914063,31.616283798218},
  {"Politi Omklædningsrum", 1840.2637939453,3688.5578613281,34.286598205566},
  {"Politi Omklædningsrum", 381.72988891602,-1609.3837890625,29.292053222656},
}

return cfg
