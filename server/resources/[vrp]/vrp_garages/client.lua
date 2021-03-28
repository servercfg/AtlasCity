--[[Proxy/Tunnel]]--

vRPgt = {}
Tunnel.bindInterface("vRP_garages",vRPgt)
Proxy.addInterface("vRP_garages",vRPgt)
vRP = Proxy.getInterface("vRP")

--[[Local/Global]]--
garage2 = 0
GVEHICLES = {}
local inrangeofgarage = false
local currentlocation = nil

local garages = {
  {name="Garage", colour=3, id=357, marker=27, x=215.124, y=-791.377, z=29.946, h=0.0, hidden=false}, -- Centrum P-Plads
  {name="Garage", colour=3, id=357, marker=27, x=-334.685, y=289.773, z=84.905, h=0.0, hidden=false}, -- Tequilala ved P-Plads
  {name="Garage", colour=3, id=357, marker=27, x=-55.272, y=-1838.71, z=25.638, h=0.0, hidden=false}, -- Gang P-Plads
  {name="Garage", colour=3, id=357, marker=27, x=126.434, y=6610.04, z=30.880, h=0.0, hidden=false}, -- Paleto Bay P-Plads
  {name="Garage", colour=3, id=357, marker=27, x=-2035.372, y=-470.555, z=10.466, h=0.0, hidden=false}, -- Strand P-Plads
  {name="Garage", colour=3, id=357, marker=27, x=-24.482690811157, y=-1438.7679443359, z=30.653129577637-0.8, h=0.0, hidden=true}, -- Grove street
  {name="Garage", colour=3, id=357, marker=27, x=291.60162353516, y=-336.40170288086, z=44.219876098633, h=0.0, hidden=false}, -- Retssal-garage
  {name="Garage", colour=3, id=357, marker=27, x=2006.6551, y=3055.0170, z=46.1497, h=0.0, hidden=false}, --Yellow Jack P-Plads
  {name="Garage", colour=3, id=357, marker=27, x=-1063.9470214844, y=-1419.7119140625, z=4.545440788269, h=0.0, hidden=false}, --Vestlig P-Plads
  {name="Garage", colour=3, id=357, marker=27, x=436.12869262695, y=-1021.3997192383, z=27.8041456604, h=0.0, hidden=true}, -- Garage PD
  {name="Garage", colour=3, id=357, marker=27, x=-463.47357177734, y=6037.0473632813, z=30.340528488159, h=0.0, hidden=true}, -- Paleto PD
  {name="Garage", colour=3, id=357, marker=27, x=2661.7719726563, y=2848.2077636719, z=38.47466583252, h=0.0, hidden=false}, -- P-Plads ved minearbejder
  {name="Garage", colour=3, id=357, marker=27, x=180.84309387207, y=2821.6760253906, z=43.489575958252, h=0.0, hidden=false}, -- P-Plads et sted i Sandyshores.
  {name="Garage", colour=3, id=357, marker=27, x=1862.4067382813, y=2567.0131835938, z=44.7, h=0.0, hidden=false}, -- Fængsel
  {name="Garage", colour=3, id=357, marker=27,  x=1866.0242919922, y=3698.72265625,  z=32.68, h=0.0, hidden=true}, -- PD i Sandy Shores
  {name="Garage", colour=3, id=357, marker=27,  x=1702.7520751953, y=3601.423828125,  z=34.531148529053, h=0.0, hidden=false}, -- Sandy Shores
  {name="Garage", colour=3, id=357, marker=27,  x=-103.9112, y=-607.6959,  z=35.0732, h=0.0, hidden=true}, -- ADVOKAT
  {name="Garage", colour=3, id=357, marker=27, x=-456.49612426758, y=-1698.6625976563, z=18.100004592896, h=0.0, hidden=true}, -- Skraldemandsjob
  {name="Garage", colour=3, id=357, marker=27,  x=-82.44026184082, y=-810.80102539063,  z=35.382328796387, h=0.0, hidden=true}, -- UnderHøjhus
  {name="Garage", colour=3, id=357, marker=27,  x=-576.91052246094, y=5250.8061523438,  z=69.46715087891, h=0.0, hidden=true}, -- Træhugger job
  {name="Garage", colour=3, id=357, marker=27,  x=1122.0435791016, y=-776.86370849609,  z=56.752811431885, h=0.0, hidden=true}, -- Offentlige værksted
  {name="Garage", colour=3, id=357, marker=27,  x=329.81008911133, y=-552.78381347656,  z=27.793797302246, h=0.0, hidden=true}, -- Bag hospital
  {name="Garage", colour=3, id=357, marker=27,  x=1754.7917480469, y=3325.6540527344,  z=40.192261505127, h=0.0, hidden=true}, -- Speedrunners
  {name="Garage", colour=3, id=357, marker=27,  x=441.81103515625, y=-1961.3717041016,  z=22.030880737305, h=0.0, hidden=true}, -- Taxi
  {name="Garage", colour=3, id=357, marker=27,  x=1017.6873168945, y=-3130.2258300781,  z=4.9507787704468, h=0.0, hidden=true}, -- Lager
  {name="Garage", colour=3, id=357, marker=27,  x=3546.6213378906, y=3795.0249023438,  z=29.213718414307, h=0.0, hidden=true}, -- kok salg
  {name="Garage", colour=3, id=357, marker=27,  x=13.807333946228, y=548.83166503906,  z=175.28215942383, h=0.0, hidden=true}, -- franklink garage
  {name="Garage", colour=3, id=357, marker=27,  x=295.93246459961, y=-606.12902832031,  z=42.324146270752, h=0.0, hidden=true}, -- pillbox garage
  {name="Garage", colour=3, id=357, marker=27,  x=-1080.6154785156, y=-2908.9074707031,  z=13.94749546051, h=0.0, hidden=true}, -- Santos Airport
  {name="Garage", colour=3, id=357, marker=27,  x=-11.422784805298, y=-1085.3405761719,  z=25.693977355957, h=0.0, hidden=true}, -- Bilforhandler
  {name="Garage", colour=3, id=357, marker=27,  x=-51.266178131104, y=-1684.9272460938,  z=28.491729736328, h=0.0, hidden=true}, -- Fitness
  {name="Garage", colour=3, id=357, marker=27,  x=1223.6704101563, y=2706.9733886719,  z=38.005973815918, h=0.0, hidden=false}, -- Sandy

  -- Gruppering / specielle huse garager
  {name="Garage", colour=3, id=357, marker=27,  x=1393.4357, y=1117.334,  z=113.8976, h=0.0, hidden=true}, -- La Torre
  {name="Garage", colour=3, id=357, marker=27,  x=982.97839355469, y=-134.43994140625,  z=73.078065673828, h=0.0, hidden=true}, -- The Lost MC
  {name="Garage", colour=3, id=357, marker=27,  x=-445.52520751953, y=-2166.99609375,  z=9.216661834717, h=0.0, hidden=true}, -- The Lost MC
  {name="Garage", colour=3, id=357, marker=27,  x=401.2536315918, y=-1642.9594726563,  z=28.341938781738, h=0.0, hidden=true}, -- Impound
  {name="Garage", colour=3, id=357, marker=27,  x= 487.46499633789, y=-1334.2957763672,  z=28.358185577393, h=0.0, hidden=true}, -- James Auto
  {name="Garage", colour=3, id=357, marker=27,  x= 91.771362304688, y=-1279.4671630859,  z=28.154225234985, h=0.0, hidden=true}, -- Kazoons håndværker Firma
  {name="Garage", colour=3, id=357, marker=27,  x= -490.83068847656, y=-690.37432861328,  z=32.011982727051, h=0.0, hidden=true}, -- Garage v lejlighed4
  {name="Garage", colour=3, id=357, marker=27,  x= -2221.0112304688, y=3481.9440917969,  z=29.21934967041, h=0.0, hidden=true}, -- Våbenlager
  {name="Garage", colour=3, id=357, marker=27,  x= -1099.6397705078, y=-258.78372192383,  z=37.659603118896-0.8, h=0.0, hidden=true}, -- Lifeinvader
  {name="Garage", colour=3, id=357, marker=27,  x= -284.81875610352, y=-921.63940429688,  z=31.08062171936-0.8, h=0.0, hidden=true}, -- Lejlighed kompleks 18
  {name="Garage", colour=3, id=357, marker=27,  x= -1126.1207275391, y=-1610.9158935547,  z=4.3984303474426-0.8, h=0.0, hidden=true}, -- Northside
  {name="Garage", colour=3, id=357, marker=27,  x= -1627.4010009766, y=-3005.5908203125,  z=-78.143684387207-1.8, h=0.0, hidden=true}, -- Natklub
  {name="Garage", colour=3, id=357, marker=27,  x= 220.15553283691, y=1252.3254394531,  z=225.45983886719-1.8, h=0.0, hidden=true}, -- Eventscenen
  {name="Garage", colour=3, id=357, marker=27,  x= 102.15643310547, y=-2189.3088378906,  z=5.9748597145081-0.9, h=0.0, hidden=true}, -- The lost
  {name="Garage", colour=3, id=357, marker=27,  x= -218.97383117676, y=-1294.1651611328,  z=31.295969009399-0.9, h=0.0, hidden=true}, -- Bennys
  {name="Garage", colour=3, id=357, marker=27,  x= 969.66253662109, y=-1617.5541992188,  z=30.110677719116-1.4, h=0.0, hidden=true}, -- 2fast
  {name="Garage", colourF=3, id=357, marker=27,  x= -64.014060974121, y=-2528.2998046875,  z=6.0100026130676-1.4, h=0.0, hidden=true}, -- Håndværker
  {name="Garage", colourF=3, id=357, marker=27,  x= 727.90625, y=-1195.357421875,  z=24.276197433472-1.4, h=0.0, hidden=true}, -- Skaterpark
  {name="Garage", colour=3, id=357, marker=27,  x= -824.8037109375, y=180.43966674805,  z=70.941513061523, h=0.0, hidden=true}, -- Micheals hus
}
vehicles = {}
garageSelected = {x=nil, y=nil, z=nil, h=nil}
selectedPage = 0

lang_string = {
menu1 = "Parker køretøj",
menu2 = "Hent køretøj",
menu3 = "Luk",
menu4 = "Køretøjer",
menu5 = "Valgmuligheder",
menu6 = "Hent",
menu7 = "Tilbage",
menu8 = "[~g~E~s~] for at åbne garagen",
menu9 = "Sælg",
menu10 = "[~g~E~s~] for at sælge køretøjet",
menu11 = "Opdater bilen",
menu12 = "Næste",
state1 = "Ude",
state2 = "Inde",
text1 = "Området er overfyldt",
text2 = "Køretøjet er ikke parkeret",
text3 = "Køretøjer er ude",
text4 = "Dette er ikke dit køretøj",
text5 = "Køretøj parkeret",
text6 = "Intet køretøj i nærheden",
text7 = "Køretøj solgt",
text8 = "Køretøj købt, god tur",
text9 = "Du har ikke råd",
text10 = "Køretøj opdateret",
text11 = "Du kan ikke bruge garagen når du er i koma"
}
--[[Functions]]--

function vRPgt.spawnGarageVehicle(vtype, name, vehicle_plate, vehicle_colorprimary, vehicle_colorsecondary, vehicle_pearlescentcolor, vehicle_wheelcolor, vehicle_plateindex, vehicle_neoncolor1, vehicle_neoncolor2, vehicle_neoncolor3, vehicle_windowtint, vehicle_wheeltype, vehicle_mods0, vehicle_mods1, vehicle_mods2, vehicle_mods3, vehicle_mods4, vehicle_mods5, vehicle_mods6, vehicle_mods7, vehicle_mods8, vehicle_mods9, vehicle_mods10, vehicle_mods11, vehicle_mods12, vehicle_mods13, vehicle_mods14, vehicle_mods15, vehicle_mods16, vehicle_turbo, vehicle_tiresmoke, vehicle_xenon, vehicle_mods23, vehicle_mods24, vehicle_neon0, vehicle_neon1, vehicle_neon2, vehicle_neon3, vehicle_bulletproof, vehicle_smokecolor1, vehicle_smokecolor2, vehicle_smokecolor3, vehicle_modvariation) -- vtype is the vehicle type (one vehicle per type allowed at the same time)

  local vehicle = vehicles[vtype]
  if vehicle and not IsVehicleDriveable(vehicle[3]) then -- precheck if vehicle is undriveable
    -- despawn vehicle
    SetVehicleHasBeenOwnedByPlayer(vehicle[3],false)
    Citizen.InvokeNative(0xAD738C3085FE7E11, vehicle[3], false, true) -- set not as mission entity
    SetVehicleAsNoLongerNeeded(Citizen.PointerValueIntInitialized(vehicle[3]))
    Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(vehicle[3]))
	
                  
	  TriggerEvent("vrp_garages:setVehicle", vtype, nil)
  end

  vehicle = vehicles[vtype]
  if vehicle == nil then
    -- load vehicle model
    local mhash = GetHashKey(name)

    local i = 0
    while not HasModelLoaded(mhash) and i < 10000 do
      RequestModel(mhash)
      Citizen.Wait(10)
      i = i+1
    end

    -- spawn car
    if HasModelLoaded(mhash) then
      local x,y,z = vRP.getPosition({})
      local nveh = CreateVehicle(mhash, x,y,z+0.5, GetEntityHeading(GetPlayerPed(-1)), true, false) -- added player heading
      SetVehicleOnGroundProperly(nveh)
      SetEntityInvincible(nveh,false)
      SetPedIntoVehicle(GetPlayerPed(-1),nveh,-1) -- put player inside
      SetVehicleNumberPlateText(nveh, vehicle_plate)
      --Citizen.InvokeNative(0xAD738C3085FE7E11, nveh, true, true) -- set as mission entity
      SetVehicleHasBeenOwnedByPlayer(nveh,true)

	  local nid = NetworkGetNetworkIdFromEntity(nveh)
      SetNetworkIdCanMigrate(nid,true)

	  
    TriggerEvent("vrp_garages:setVehicle", vtype, {vtype,name,nveh})

      SetModelAsNoLongerNeeded(mhash)
    
    --grabbing customization
      local plate = plate
      local primarycolor = tonumber(vehicle_colorprimary)
      local secondarycolor = tonumber(vehicle_colorsecondary)
      local pearlescentcolor = vehicle_pearlescentcolor
      local wheelcolor = vehicle_wheelcolor
      local plateindex = tonumber(vehicle_plateindex)
      local neoncolor = {vehicle_neoncolor1,vehicle_neoncolor2,vehicle_neoncolor3}
      local windowtint = vehicle_windowtint
      local wheeltype = tonumber(vehicle_wheeltype)
      local mods0 = tonumber(vehicle_mods0)
      local mods1 = tonumber(vehicle_mods1)
      local mods2 = tonumber(vehicle_mods2)
      local mods3 = tonumber(vehicle_mods3)
      local mods4 = tonumber(vehicle_mods4)
      local mods5 = tonumber(vehicle_mods5)
      local mods6 = tonumber(vehicle_mods6)
      local mods7 = tonumber(vehicle_mods7)
      local mods8 = tonumber(vehicle_mods8)
      local mods9 = tonumber(vehicle_mods9)
      local mods10 = tonumber(vehicle_mods10)
      local mods11 = tonumber(vehicle_mods11)
      local mods12 = tonumber(vehicle_mods12)
      local mods13 = tonumber(vehicle_mods13)
      local mods14 = tonumber(vehicle_mods14)
      local mods15 = tonumber(vehicle_mods15)
      local mods16 = tonumber(vehicle_mods16)
      local turbo = vehicle_turbo
      local tiresmoke = vehicle_tiresmoke
      local xenon = vehicle_xenon
      local mods23 = tonumber(vehicle_mods23)
      local mods24 = tonumber(vehicle_mods24)
      local neon0 = vehicle_neon0
      local neon1 = vehicle_neon1
      local neon2 = vehicle_neon2
      local neon3 = vehicle_neon3
      local bulletproof = vehicle_bulletproof
      local smokecolor1 = vehicle_smokecolor1
      local smokecolor2 = vehicle_smokecolor2
      local smokecolor3 = vehicle_smokecolor3
      local variation = vehicle_modvariation
    
    --setting customization
      SetVehicleColours(nveh, primarycolor, secondarycolor)
      SetVehicleExtraColours(nveh, tonumber(pearlescentcolor), tonumber(wheelcolor))
      SetVehicleNumberPlateTextIndex(nveh,plateindex)
      SetVehicleNeonLightsColour(nveh,tonumber(neoncolor[1]),tonumber(neoncolor[2]),tonumber(neoncolor[3]))
      SetVehicleTyreSmokeColor(nveh,tonumber(smokecolor1),tonumber(smokecolor2),tonumber(smokecolor3))
      SetVehicleModKit(nveh,0)
      SetVehicleMod(nveh, 0, mods0)
      SetVehicleMod(nveh, 1, mods1)
      SetVehicleMod(nveh, 2, mods2)
      SetVehicleMod(nveh, 3, mods3)
      SetVehicleMod(nveh, 4, mods4)
      SetVehicleMod(nveh, 5, mods5)
      SetVehicleMod(nveh, 6, mods6)
      SetVehicleMod(nveh, 7, mods7)
      SetVehicleMod(nveh, 8, mods8)
      SetVehicleMod(nveh, 9, mods9)
      SetVehicleMod(nveh, 10, mods10)
      SetVehicleMod(nveh, 11, mods11)
      SetVehicleMod(nveh, 12, mods12)
      SetVehicleMod(nveh, 13, mods13)
      SetVehicleMod(nveh, 14, mods14)
      SetVehicleMod(nveh, 15, mods15)
      SetVehicleMod(nveh, 16, mods16)
      if turbo == "on" then
        ToggleVehicleMod(nveh, 18, true)
      else          
        ToggleVehicleMod(nveh, 18, false)
      end
      if tiresmoke == "on" then
        ToggleVehicleMod(nveh, 20, true)
      else          
        ToggleVehicleMod(nveh, 20, false)
      end
      if xenon == "on" then
        ToggleVehicleMod(nveh, 22, true)
      else          
        ToggleVehicleMod(nveh, 22, false)
      end
    SetVehicleWheelType(nveh, tonumber(wheeltype))
      SetVehicleMod(nveh, 23, mods23)
      SetVehicleMod(nveh, 24, mods24)
      if neon0 == "on" then
        SetVehicleNeonLightEnabled(nveh,0, true)
      else
        SetVehicleNeonLightEnabled(nveh,0, false)
      end
      if neon1 == "on" then
        SetVehicleNeonLightEnabled(nveh,1, true)
      else
        SetVehicleNeonLightEnabled(nveh,1, false)
      end
      if neon2 == "on" then
        SetVehicleNeonLightEnabled(nveh,2, true)
      else
        SetVehicleNeonLightEnabled(nveh,2, false)
      end
      if neon3 == "on" then
        SetVehicleNeonLightEnabled(nveh,3, true)
      else
        SetVehicleNeonLightEnabled(nveh,3, false)
      end
      if bulletproof == "on" then
        SetVehicleTyresCanBurst(nveh, false)
      else
        SetVehicleTyresCanBurst(nveh, true)
      end
      --if variation == "on" then
      --  SetVehicleModVariation(nveh,23)
      --else
      --  SetVehicleModVariation(nveh,23, false)
      --end
      SetVehicleWindowTint(nveh,tonumber(windowtint))
    end
  else
    local cartype = ""
	if vtype == "car" then
        cartype = "bil"
	elseif vtype == "bike" then 
        cartype = "motorcykel"
	elseif vtype == "citybike" then
        cartype = "cykel"
	end
  TriggerEvent("pNotify:SendNotification",{text = "Du kan kun have én <b style='color:#B22222'>"..cartype.."</b> ude",type = "info",timeout = (2000),layout = "bottomCenter",queue = "global",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
  end
end

function vRPgt.spawnBoughtVehicle(vtype, name)

local vehicle = vehicles[vtype]
  if vehicle then -- precheck if vehicle is undriveable
    -- despawn vehicle
    SetVehicleHasBeenOwnedByPlayer(vehicle[3],false)
    SetEntityAsMissionEntity(vehicle[3], false, true) -- set not as mission entity
    SetVehicleAsNoLongerNeeded(Citizen.PointerValueIntInitialized(vehicle[3]))
    Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(vehicle[3]))
  TriggerEvent("vrp_garages:setVehicle", vtype, nil)
  end

  vehicle = vehicles[vtype]
  if vehicle == nil then
    -- load vehicle model
    local mhash = GetHashKey(name)

    local i = 0
    while not HasModelLoaded(mhash) and i < 10000 do
      RequestModel(mhash)
      Citizen.Wait(10)
      i = i+1
    end

    -- spawn car
    if HasModelLoaded(mhash) then
      local x,y,z = vRP.getPosition({})
      local nveh = CreateVehicle(mhash, x,y,z+0.5, GetEntityHeading(GetPlayerPed(-1)), true, false) -- added player heading
      SetVehicleOnGroundProperly(nveh)
      SetEntityInvincible(nveh,false)
      SetPedIntoVehicle(GetPlayerPed(-1),nveh,-1) -- put player inside
      SetVehicleNumberPlateText(nveh, "DK" .. vRP.getRegistrationNumber({}))
      Citizen.InvokeNative(0xAD738C3085FE7E11, nveh, true, true) -- set as mission entity
      SetVehicleHasBeenOwnedByPlayer(nveh,true)

      local nid = NetworkGetNetworkIdFromEntity(nveh)
      SetNetworkIdCanMigrate(nid,true)

    TriggerEvent("vrp_garages:setVehicle", vtype, {vtype,name,nveh})

    Citizen.CreateThread(function()
      Citizen.Wait(1000)
      TriggerEvent("advancedFuel:setEssence", 100, GetVehicleNumberPlateText(GetVehiclePedIsUsing(GetPlayerPed(-1))), GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsUsing(GetPlayerPed(-1)))))
    end)

      SetModelAsNoLongerNeeded(mhash)
    end
  else
	if vtype == "car" then
        local cartype = "bil"
	elseif vtype == "bike" then 
        local cartype = "motorcykel"
	elseif vtype == "citybike" then
        local cartype = "cykel"
	end
  TriggerEvent("pNotify:SendNotification",{text = "Du kan kun have én <b style='color:#B22222'>"..cartype.."</b> ude",type = "info",timeout = (2000),layout = "bottomRight",queue = "global",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
  end
end

function vRPgt.despawnGarageVehicle(vtype,max_range)
  local vehicle = vehicles[vtype]
    if vehicle then
      local x,y,z = table.unpack(GetEntityCoords(vehicle[3],true))
      local px,py,pz = vRP.getPosition()

      if GetDistanceBetweenCoords(x,y,z,px,py,pz,true) < max_range then -- check distance with the vehicule
         -- remove vehicle
		local caissei = GetClosestVehicle(garageSelected.x, garageSelected.y, garageSelected.z, 3.000, 0, 70)
        SetVehicleHasBeenOwnedByPlayer(caissei,false)
        Citizen.InvokeNative(0xAD738C3085FE7E11, caissei, false, true) -- set not as mission entity
        DeleteEntity(caissei)
        SetVehicleAsNoLongerNeeded(Citizen.PointerValueIntInitialized(caissei))
        Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(caissei))
		DetachEntity(caissei, 1, 1)
                    DeleteEntity(caissei)
					DeleteObject(caissei)

        TriggerEvent("vrp_garages:setVehicle", vtype, nil)

        TriggerEvent("pNotify:SendNotification",{text = "Køretøj <b style='color:#4E9350'>parkeret</b>",type = "success",timeout = (3000),layout = "bottomCenter",queue = "global",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
         else
        TriggerEvent("pNotify:SendNotification",{text = "Du er for <b style='color:#DB4646'>langt væk</b> fra køretøjet",type = "error",timeout = (3000),layout = "bottomCenter",queue = "global",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
      end
        else
      TriggerEvent("pNotify:SendNotification",{text = "Du har <b style='color:#DB4646'>intet</b> køretøj ude",type = "info",timeout = (3000),layout = "bottomCenter",queue = "global",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
    end
end

function MenuGarage()
    ped = GetPlayerPed(-1)
  selectedPage = 0
    MenuTitle = "Garage"
    ClearMenu()
    Menu.addButton(lang_string.menu1,"StoreVehicle",nil)
    Menu.addButton(lang_string.menu2,"ListVehicle",selectedPage)
    Menu.addButton(lang_string.menu3,"CloseMenu",nil) 
end

function StoreVehicle()
  Citizen.CreateThread(function()
	local caissei = GetVehiclePedIsIn(GetPlayerPed(-1), false)
    SetEntityAsMissionEntity(caissei, true, true)
    local plate = GetVehicleNumberPlateText(caissei)
	local vtype = "car"
	if IsThisModelABike(GetEntityModel(caissei)) and not IsThisModelABicycle(GetEntityModel(caissei)) then
		vtype = "bike"
	end
	if IsThisModelAQuadbike(GetEntityModel(caissei)) then
		vtype = "bike"
	end
	if IsThisModelABicycle(GetEntityModel(caissei)) then
		vtype = "citybike"
	end
	if DoesEntityExist(caissei) then
		local damage = GetVehicleBodyHealth(caissei)
		if damage < 980 or not AreAllVehicleWindowsIntact(caissei) or IsVehicleDoorDamaged(caissei,0) or IsVehicleDoorDamaged(caissei,1) or IsVehicleDoorDamaged(caissei,2) or IsVehicleDoorDamaged(caissei,3) then
			TriggerEvent("pNotify:SendNotification",{text = "Dit køretøj er skadet, reparer det før du parkerer",type = "info",timeout = (2000),layout = "bottomCenter",queue = "global",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
		else
		TriggerServerEvent('ply_garages:CheckForVeh', plate, vehicles[vtype][2],vtype)
			 -- remove vehicle
		end
	else
     TriggerEvent("pNotify:SendNotification",{text = "Intet køretøj i nærheden ude",type = "info",timeout = (2000),layout = "bottomCenter",queue = "global",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
    end   
  end)
  CloseMenu()
end

function ListVehicle(page)
    ped = GetPlayerPed(-1)
  selectedPage = page
    MenuTitle = lang_string.menu4
    ClearMenu()
  local count = 0
    for ind, value in pairs(GVEHICLES) do
    if ((count >= (page*10)) and (count < ((page*10)+10))) then
        Menu.addButton(tostring(value.vehicle_name), "OptionVehicle", tostring(value.vehicle_model))
    end
    count = count + 1
    end   
    Menu.addButton(lang_string.menu12,"ListVehicle",page+1)
  if page == 0 then
      Menu.addButton(lang_string.menu7,"MenuGarage",nil)
  else
      Menu.addButton(lang_string.menu7,"ListVehicle",page-1)
  end
end

function OptionVehicle(vehID)
  local vehID = vehID
    MenuTitle = "Valg"
    ClearMenu()
    Menu.addButton(lang_string.menu6, "SpawnVehicle", vehID)
    Menu.addButton(lang_string.menu7, "ListVehicle", selectedPage)
end

function SpawnVehicle(vehID)
  local vehID = vehID
  local player = GetPlayerPed(-1)
  exports['ac_progressbar']:startUI(2000, "Henter...")
  Citizen.Wait(2000)
  TriggerServerEvent('ply_garages:CheckForSpawnVeh', vehID)
  local bil = GetVehiclePedIsIn(player, false)
  TriggerServerEvent('kaz:loadvehicle', vehID, player, bil)
  CloseMenu()
end


function drawNotification(text)
  SetNotificationTextEntry("STRING")
  AddTextComponentString(text)
  DrawNotification(false, false)
end

function CloseMenu()
    Menu.hidden = true    
    TriggerServerEvent("ply_garages:CheckGarageForVeh")
end

function LocalPed()
  return GetPlayerPed(-1)
end

function IsPlayerInRangeOfGarage()
  return inrangeofgarage
end

function Chat(debugg)
    TriggerEvent('chatMessage', '', { 0, 0x99, 255 }, tostring(debugg))
end

function ply_drawTxt(text,font,centre,x,y,scale,r,g,b,a)
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

--[[Citizen]]--
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(2500)
    for _, garage1 in pairs(garages) do
		if GetDistanceBetweenCoords(garage1.x, garage1.y, garage1.z, GetEntityCoords(LocalPed())) < 20 then
			garage2 = garage1
		end
	end
  end
end)
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
	garage = garage2
  if garage ~= 0 then
	  if GetDistanceBetweenCoords(garage.x, garage.y, garage.z, GetEntityCoords(LocalPed())) < 20 then
      DrawMarker(27, garage.x, garage.y, garage.z, 0, 0, 0, 0, 0, 0, 3.001, 3.0001, 0.5001, 101, 153, 186, 200, 0, 1, 0, 50)
      end      	
      	if GetDistanceBetweenCoords(garage.x, garage.y, garage.z, GetEntityCoords(LocalPed())) < 3 then
			local player = GetPlayerPed(-1)
      local health = GetEntityHealth(player)
      vehicle = GetVehiclePedIsIn(PlayerPedId())
			veh = GetVehiclePedIsIn(GetPlayerPed(-1), false)
			if(GetPedInVehicleSeat(veh, -1) == GetPlayerPed(-1))then
				if health >= 106 then
					DrawText3Ds(garage.x,garage.y,garage.z+1.25, "~w~[~g~E~w~] for at parkere.", 3.0, 7)
          if IsControlJustPressed(1, 51) then
          exports['ac_progressbar']:startUI(2000, "Parkere...")
          FreezeEntityPosition(vehicle, true)
          Citizen.Wait(2000)
          FreezeEntityPosition(vehicle, false)
					local ok, vtype, name = vRP.getNearestOwnedVehicle({7})	
					bil = GetVehiclePedIsIn(player, false)
						if bil ~= 0 then 
							vehicle = GetVehiclePedIsIn(player)
							bilskaden = (GetVehicleEngineHealth(vehicle))
						end	
					TriggerEvent("hp:deletevehicle", player)
					TriggerServerEvent('kaz:savevehicle', player, name, bilskaden) 
					end
				else
					ply_drawTxt(lang_string.text11,0,1,0.5,0.8,0.6,255,255,255,255)
				end
			else	
					if health >= 106 then
					  DrawText3Ds(garage.x,garage.y,garage.z+1.25, "~w~[~g~E~w~] for at åbne garagen.", 3.0, 7)
						if IsControlJustPressed(1, 51) then
							garageSelected.x = garage.x
							garageSelected.y = garage.y
							garageSelected.z = garage.z
							MenuGarage()
							Menu.hidden = not Menu.hidden 
							TriggerServerEvent("ply_garages:CheckGarageForVeh")
						end
					  Menu.renderGUI() 
					else
					 ply_drawTxt(lang_string.text11,0,1,0.5,0.8,0.6,255,255,255,255)
				   end
			end	   
       end
    end
  end
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(1000)
	local near = false
    for _, garage in pairs(garages) do    
      if (GetDistanceBetweenCoords(garage.x, garage.y, garage.z, GetEntityCoords(LocalPed())) < 3 and near ~= true) then 
        near = true             
      end
    end
    if near == false then 
      Menu.hidden = true
    end
  end
end)

Citizen.CreateThread(function()
  for _, item in pairs(garages) do
    if not item.hidden then
      item.blip = AddBlipForCoord(item.x, item.y, item.z)
      SetBlipSprite(item.blip, item.id)
      SetBlipAsShortRange(item.blip, true)
      SetBlipColour(item.blip, item.colour)
      SetBlipScale(item.blip, 0.6)
      BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(item.name)
      EndTextCommandSetBlipName(item.blip)
    end
  end
end)


--[[Events]]--

RegisterNetEvent('vrp_garages:setVehicle')
AddEventHandler('vrp_garages:setVehicle', function(vtype, vehicle)
  vehicles[vtype] = vehicle
end)

RegisterNetEvent('ply_garages:addAptGarage')
AddEventHandler('ply_garages:addAptGarage', function(gx,gy,gz,gh)
local alreadyExists = false
for _, garage in pairs(garages) do
  if garage.x == gx and garage.y == gy then
    alreadyExists = true
  end
end
if not alreadyExists then
  table.insert(garages, #garages + 1, {name="Lejligheds garage", colour=3, id=357, x=gx, y=gy, z=gz, h=gh})
end
end)

RegisterNetEvent('ply_garages:getVehicles')
AddEventHandler("ply_garages:getVehicles", function(THEVEHICLES)
    GVEHICLES = {}
    GVEHICLES = THEVEHICLES
end)

AddEventHandler("playerSpawned", function()
    TriggerServerEvent("ply_garages:CheckGarageForVeh")
    TriggerServerEvent("ply_garages:CheckForAptGarages")
end)

function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())

    SetTextScale(0.32, 0.32)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 255)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 0, 0, 0, 80)
end