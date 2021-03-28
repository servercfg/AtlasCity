-- Exterior Items
RequestIpl("ba_barriers_case5")
RequestIpl("ba_case5_solomun")

local EntitySets = { "Int01_ba_security_upgrade", "Int01_ba_equipment_setup", "Int01_ba_Style02", "Int01_ba_style02_podium", "int01_ba_lights_screen", 
					"Int01_ba_Screen", "Int01_ba_bar_content", "Int01_ba_dj02", "DJ_04_Lights_01", "Int01_ba_lightgrid_01", "Int01_ba_equipment_upgrade", 
					"Int01_ba_clubname_01", "Int01_ba_dry_ice", "Int01_ba_deliverytruck", "Int01_ba_trophy04", "Int01_ba_trophy05", "Int01_ba_trophy07", "Int01_ba_trophy09", 
					"Int01_ba_trophy08", "Int01_ba_trophy11", "Int01_ba_trophy10", "Int01_ba_trophy03", "Int01_ba_trophy01", "Int01_ba_trophy02", "Int01_ba_trad_lights", "DJ_04_Lights_04" }

local function ButtonMessage(text)
    BeginTextCommandScaleformString("STRING")
    AddTextComponentScaleform(text)
    EndTextCommandScaleformString()
end

local function Button(ControlButton)
    PushScaleformMovieMethodParameterButtonName(ControlButton)
end

local function setupScaleform(scaleform, itemString, button)
    local scaleform = RequestScaleformMovie(scaleform)
    while not HasScaleformMovieLoaded(scaleform) do
        Citizen.Wait(0)
    end
    PushScaleformMovieFunction(scaleform, "CLEAR_ALL")
    PopScaleformMovieFunctionVoid()
    PushScaleformMovieFunction(scaleform, "SET_CLEAR_SPACE")
    PushScaleformMovieFunctionParameterInt(200)
    PopScaleformMovieFunctionVoid()
    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(0)
	if button ~= nil then
		Button(GetControlInstructionalButton(2, 38, true))
	end
    ButtonMessage(itemString)
    PopScaleformMovieFunctionVoid()
    PushScaleformMovieFunction(scaleform, "DRAW_INSTRUCTIONAL_BUTTONS")
    PopScaleformMovieFunctionVoid()
    PushScaleformMovieFunction(scaleform, "SET_BACKGROUND_COLOUR")
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(80)
    PopScaleformMovieFunctionVoid()
    return scaleform
end

local intLoc = vec3(-1569.4, -3017.0, -74.5)
local intLoc2 = vec3(-1641.4266357422,-2990.0234375,-77.077697753906)
local extLoc = vec3(-1285.0, -652.2, 26.5)
local extLoc2 = vec3(-1262.4162597656,-656.33819580078,26.664106369019)
local intID = GetInteriorAtCoords(intLoc)
local clubsmoke = {
	{vec(-1600.0, -3012.0, -78.2),vec(0.0, 0.0, 0.0)},
	{vec(-1595.0, -3012.0, -78.2),vec(0.0, 0.0, 0.0)},
	{vec(-1590.0, -3012.0, -78.2),vec(0.0, 0.0, 0.0)},
	{vec(-1602.932, -3019.1, -78.2),vec(0.0, -10.0, 66.0)},
	{vec(-1593.238, -3017.05, -78.2),vec(0.0, -10.0, 110.0)},
	{vec(-1597.134, -3008.2, -78.2),vec(0.0, -10.0, -122.53)},
	{vec(-1589.966, -3008.518, -78.2),vec(0.0, -10.0, -166.97)},
}
local spawnedclubsmoke = {}
local smokemachines = {
	{vec(-1602.932, -3019.1, -79.99),vec(0.0, -10.0, 66.0)},
	{vec(-1593.238, -3017.05, -79.99),vec(0.0, -10.0, 110.0)},
	{vec(-1597.134, -3008.2, -79.99),vec(0.0, -10.0, -122.53)},
	{vec(-1589.966, -3008.518, -79.99),vec(0.0, -10.0, -166.97)},
}
local spawnedsmokemachines = {}

local InsidePeds = {
	["Bouncer1"] 		= {false, 25, "s_m_m_bouncer_01", vec3(-1568.34, -3002.85, -76.21), 0.0, "WORLD_HUMAN_GUARD_STAND", vec3(-1568.34, -3002.85, -76.21), 146.68},
	["Bouncer2"] 		= {false, 25, "s_m_m_bouncer_01", vec3(-1576.45, -3010.22, -79.01), 0.0, "WORLD_HUMAN_GUARD_STAND", vec3(-1576.45, -3010.22, -79.01), 4.69},
	["Bouncer3"] 		= {false, 25, "s_m_m_bouncer_01", vec3(-1602.02, -3018.44, -79.01), 0.0, "WORLD_HUMAN_GUARD_STAND", vec3(-1602.02, -3018.44, -79.01), 321.31},
	["Bouncer4"] 		= {false, 25, "s_m_m_bouncer_01", vec3(-1605.83, -3007.60, -76.00), 0.0, "WORLD_HUMAN_GUARD_STAND", vec3(-1605.83, -3007.60, -76.00), 318.89},
	["Bouncer5"] 		= {false, 25, "s_m_m_bouncer_01", vec3(-1609.64, -3005.60, -79.01), 0.0, "WORLD_HUMAN_GUARD_STAND", vec3(-1609.64, -3005.60, -79.01), 177.59},
	["Bouncer6"] 		= {false, 25, "s_m_m_bouncer_01", vec3(-1590.43, -3014.74, -79.01), 0.0, "WORLD_HUMAN_GUARD_STAND", vec3(-1590.43, -3014.74, -79.01), 93.51},
	["Bouncer7"] 		= {false, 25, "s_m_m_bouncer_01", vec3(-1581.97, -3019.10, -79.01), 0.0, "WORLD_HUMAN_GUARD_STAND", vec3(-1581.97, -3019.10, -79.01), 336.55},
	["Bouncer8"] 		= {false, 25, "s_m_m_bouncer_01", vec3(-1600.48, -3005.26, -79.01), 0.0, "WORLD_HUMAN_GUARD_STAND", vec3(-1600.48, -3005.26, -79.01), 98.54},
	["Bouncer9"] 		= {false, 25, "s_m_m_bouncer_01", vec3(-1570.64, -3017.02, -74.41), 0.0, "WORLD_HUMAN_CLIPBOARD", vec3(-1570.64, -3017.02, -74.41), 271.0},
	--["Bar1"] 			= {false, 25, "s_f_y_clubbar_01", vec3(-1576.27, -3016.55, -79.90), 0.0},
	--["Bar2"] 			= {false, 25, "s_f_y_clubbar_01", vec3(-1578.14, -3016.54, -79.90), 0.0},
	--["Bar3"] 			= {false, 25, "s_f_y_clubbar_01", vec3(-1585.03, -3012.61, -76.90), 90.0},
	["EntranceG"] 		= {false, 25, "s_f_y_clubbar_01", vec3(-1585.03, -3012.61, -76.90), 0.0, "PROP_HUMAN_SEAT_CHAIR", vec3(-1572.17, -3013.49, -74.70), 270.94},
	["SittingGirl"] 	= {false, 25, "a_f_y_clubcust_02", vec3(-1612.689, -3010.791, -80.2060), -90.0},
	--["Attendant"] 		= {false, 25, "s_m_y_clubbar_01", vec3(-1611.937, -3009.152, -79.2519), 0.0, "PROP_HUMAN_SEAT_CHAIR", vec3(-1611.937, -3009.152, -79.2519), -131.39},
	--["PhoneGuy"] 		= {false, 25, "a_m_y_business_02", vec3(-1611.937, -3009.152, -79.2519), 0.0, "WORLD_HUMAN_STAND_MOBILE", vec3(-1611.21, -3018.67, -79.01), 0.0},
	--["VomittingFemale"] = {false, 25, "s_f_y_hooker_02", vec3(-1609.22, -3015.61, -80.01), 270.0},
	["DJ"] 				= {false, 25, "ig_sol", vec3(-1602.78, -3012.62, -78.80), 270.0},
	--["Dancer1"] 		= {false, 25, "u_f_y_dancerave_01", vec3(-1596.14, -3008.08, -79.21), 200.0},
	--["Dancer2"] 		= {false, 25, "u_f_y_dancerave_01", vec3(-1598.42, -3015.70, -79.21), 352.0},
	--["Tony"]			= {false, 25, "ig_tonyprince", vec3(-1572.28, -571.89, 108.52), 0.0, "WORLD_HUMAN_STAND_MOBILE", vec3(-1607.90, -3014.93, -75.21), 94.46},
}

local PedComponents = {
	["EntranceG"] 		= {false, 0, 3, 0, 0},
	["EntranceG"] 		= {false, 2, 3, 0, 0},
	["EntranceG"] 		= {false, 3, 3, 0, 0},
	["EntranceG"] 		= {false, 4, 1, 0, 0},
	["EntranceG"] 		= {false, 8, 1, 0, 0},
	["Bar1"] 			= {false, 0, 0, 0, 0},
	["Bar1"] 			= {false, 2, 0, 0, 0},
	["Bar1"] 			= {false, 3, 0, 0, 0},
	["Bar1"] 			= {false, 4, 0, 0, 0},
	["Bar1"] 			= {false, 8, 0, 0, 0},
	["Bar2"] 			= {false, 0, 2, 0, 0},
	["Bar2"] 			= {false, 2, 2, 0, 0},
	["Bar2"] 			= {false, 3, 2, 0, 0},
	["Bar2"] 			= {false, 4, 1, 0, 0},
	["Bar2"] 			= {false, 8, 0, 0, 0},
	["Bar3"] 			= {false, 0, 4, 0, 0},
	["Bar3"] 			= {false, 2, 4, 0, 0},
	["Bar3"] 			= {false, 3, 4, 0, 0},
	["Bar3"] 			= {false, 4, 0, 0, 0},
	["Bar3"] 			= {false, 8, 1, 0, 0},
}

local PedAnims = {
	["Bar1"] 			= {false, "mini@strip_club@drink@idle_a", "idle_a_bartender"},
	["Bar2"] 			= {false, "mini@strip_club@drink@idle_a", "idle_a_bartender"},
	["Bar3"] 			= {false, "mini@strip_club@drink@idle_a", "idle_a_bartender"},
	["SittingGirl"] 	= {false, "anim@amb@nightclub@peds@", "amb_world_human_seat_wall_female_hands_by_sides_idle_c"},
	["VomittingFemale"] = {false, "timetable@tracy@ig_7@base", "base"},
	["DJ"] 				= {false, "anim@amb@nightclub@djs@solomun@", "sol_idle_ctr_mid_a_sol"},
	--["Dancer1"] 		= {false, "anim@amb@nightclub@dancers@podium_dancers@", "hi_dance_facedj_17_v2_female^2"},
	--["Dancer2"] 		= {false, "anim@amb@nightclub@dancers@podium_dancers@", "hi_dance_facedj_17_v2_male^5"},
}

function RequestEntModel(model)
	RequestModel(model)
	while not HasModelLoaded(model) do Citizen.Wait(0) end
	SetModelAsNoLongerNeeded(model)
end

function playAnim(ped, animDict, animName)
	RequestAnimDict(animDict)
	while not HasAnimDictLoaded(animDict) do Citizen.Wait(0) end
	TaskPlayAnim(ped, animDict, animName, 1.0, -1.0, -1, 1, 1, false, false, false)
	RemoveAnimDict(animDict)
end

function CreatePeds()
	for k,v in pairs(InsidePeds) do
		if not v[1] then
			RequestEntModel(v[3])
			v[1] = CreatePed(v[2], v[3], v[4], v[5], false, true)
			if v[6] ~= nil then
				TaskStartScenarioAtPosition(v[1], v[6], v[7], v[8], -1, false, true)
			end
			DecorSetInt(v[1], "propHack", 74)
			SetModelAsNoLongerNeeded(v[2])
		end
		for q,t in pairs(PedComponents) do
			if q == k then
				t[1] = v[1]
			end
		end
		for i,o in pairs(PedAnims) do
			if i == k then
				o[1] = v[1]
			end
		end
		if k == "Dancer1" or k == "Dancer2" then
			FreezeEntityPosition(v[1], true)
		end
		if k == "Tony" then
			SetPedPropIndex(v[1], 1, 0, 0, true)
		end
		SetPedAsEnemy(v[1], false)
		SetBlockingOfNonTemporaryEvents(v[1], true)
		SetPedResetFlag(v[1], 249, true)
		SetPedConfigFlag(v[1], 185, true)
		SetPedConfigFlag(v[1], 108, true)
		SetPedConfigFlag(v[1], 106, true)
		SetPedCanEvasiveDive(v[1], false)
		N_0x2f3c3d9f50681de4(v[1], 1)
		SetPedCanRagdollFromPlayerImpact(v[1], false)
		SetPedCanRagdoll(v[1], false)
		SetPedConfigFlag(v[1], 208, true)
	end
	for k,v in pairs(PedComponents) do
		SetPedComponentVariation(v[1], v[2], v[3], v[4], v[5])
	end
	for k,v in pairs(PedAnims) do
		playAnim(v[1], v[2], v[3])
	end
end

function DeletePeds()
	for k,v in pairs(InsidePeds) do
		if DoesEntityExist(v[1]) then
			DeleteEntity(v[1])
			v[1] = false
		end
	end
	for k,v in pairs(spawnedclubsmoke) do
		if DoesParticleFxLoopedExist(v) then
			StopParticleFxLooped(v, false)
		end
	end
	for k,v in pairs(spawnedsmokemachines) do
		if DoesParticleFxLoopedExist(v) then
			StopParticleFxLooped(v, false)
		end
	end
end

function CreateNamedRenderTargetForModel(name, model)
	local handle = 0
	if not IsNamedRendertargetRegistered(name) then
		RegisterNamedRendertarget(name, 0)
	end
	if not IsNamedRendertargetLinked(model) then
		LinkNamedRendertarget(model)
	end
	if IsNamedRendertargetRegistered(name) then
		handle = GetNamedRendertargetRenderId(name)
	end
	return handle
end

function EnterClub()
	PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
	BeginTextCommandBusyString("FMMC_PLYLOAD")
	EndTextCommandBusyString(4)
	DoScreenFadeOut(1000)
	Citizen.Wait(1000)
	RequestIpl("ba_int_placement_ba_interior_0_dlc_int_01_ba_milo_")
	for _, EntitySet in ipairs(EntitySets) do
		ActivateInteriorEntitySet(intID, EntitySet)
	end
	RefreshInterior(intID)
	CreatePeds()
    RequestNamedPtfxAsset("scr_ba_club")
	while not HasNamedPtfxAssetLoaded("scr_ba_club") do Citizen.Wait(0) end
    for i,v in ipairs(clubsmoke) do
        if not DoesParticleFxLoopedExist(spawnedclubsmoke[i]) then
            UseParticleFxAssetNextCall("scr_ba_club")
            spawnedclubsmoke[i] = StartParticleFxLoopedAtCoord("scr_ba_club_smoke", v[1], v[2], 1.0, 0, 0, 0, 1)
            SetParticleFxLoopedColour(spawnedclubsmoke[i], 255.0, 255.0, 255.0, 1)
        end
	end
	for i,v in ipairs(smokemachines) do
        if not DoesParticleFxLoopedExist(spawnedsmokemachines[i]) then
            UseParticleFxAssetNextCall("scr_ba_club")
            spawnedsmokemachines[i] = StartParticleFxLoopedAtCoord("scr_ba_club_smoke_machine", v[1], v[2], 5.0, 0, 0, 0, 1)
            SetParticleFxLoopedColour(spawnedsmokemachines[i], 255.0, 255.0, 255.0, 1)
        end
    end
	RemovePtfxAsset("scr_ba_club")
	local tvmodel = "ba_prop_club_screens_01"
	local tvpos = vec3(-1600.02, -3012.55, -77.71)
	local tventity = GetClosestObjectOfType(tvpos, 0.05, tvmodel, 0, 0, 0)
	local handle = CreateNamedRenderTargetForModel("club_projector", tvmodel)
	Citizen.CreateThread(function()
		while true do
			SetTextRenderId(handle)
			SetUiLayer(4)
			SetScriptGfxDrawBehindPausemenu(1)
			DrawTvChannel(0.5, 0.5, 1.0, 1.0, 0.0, 255, 255, 255, 255)
			SetTextRenderId(GetDefaultScriptRendertargetRenderId())
			SetScriptGfxDrawBehindPausemenu(0)
			Citizen.Wait(0)
		end
	end)
	LoadTvChannelSequence(0, "PL_SOL_LED_GALAXY", 1)
	SetTvAudioFrontend(1)
	SetTvVolume(-1.0)
	SetTvChannel(0)
	SetEntityCoords(GetPlayerPed(-1), intLoc)
	SetEntityHeading(GetPlayerPed(-1), 0.0)
	SetGameplayCamRelativeHeading(0.0)
	Citizen.Wait(1000)
	RemoveLoadingPrompt()
	DoScreenFadeIn(2000)
	Citizen.Wait(1000)
	for k,v in pairs(InsidePeds) do
		FreezeEntityPosition(v[1], true)
	end
end

function EnterClub2()
	PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
	BeginTextCommandBusyString("FMMC_PLYLOAD")
	EndTextCommandBusyString(4)
	DoScreenFadeOut(1000)
	Citizen.Wait(1000)
	RequestIpl("ba_int_placement_ba_interior_0_dlc_int_01_ba_milo_")
	for _, EntitySet in ipairs(EntitySets) do
		ActivateInteriorEntitySet(intID, EntitySet)
	end
	RefreshInterior(intID)
	CreatePeds()
    RequestNamedPtfxAsset("scr_ba_club")
	while not HasNamedPtfxAssetLoaded("scr_ba_club") do Citizen.Wait(0) end
    for i,v in ipairs(clubsmoke) do
        if not DoesParticleFxLoopedExist(spawnedclubsmoke[i]) then
            UseParticleFxAssetNextCall("scr_ba_club")
            spawnedclubsmoke[i] = StartParticleFxLoopedAtCoord("scr_ba_club_smoke", v[1], v[2], 1.0, 0, 0, 0, 1)
            SetParticleFxLoopedColour(spawnedclubsmoke[i], 255.0, 255.0, 255.0, 1)
        end
	end
	for i,v in ipairs(smokemachines) do
        if not DoesParticleFxLoopedExist(spawnedsmokemachines[i]) then
            UseParticleFxAssetNextCall("scr_ba_club")
            spawnedsmokemachines[i] = StartParticleFxLoopedAtCoord("scr_ba_club_smoke_machine", v[1], v[2], 5.0, 0, 0, 0, 1)
            SetParticleFxLoopedColour(spawnedsmokemachines[i], 255.0, 255.0, 255.0, 1)
        end
    end
	RemovePtfxAsset("scr_ba_club")
	local tvmodel = "ba_prop_club_screens_01"
	local tvpos = vec3(-1600.02, -3012.55, -77.71)
	local tventity = GetClosestObjectOfType(tvpos, 0.05, tvmodel, 0, 0, 0)
	local handle = CreateNamedRenderTargetForModel("club_projector", tvmodel)
	Citizen.CreateThread(function()
		while true do
			SetTextRenderId(handle)
			SetUiLayer(4)
			SetScriptGfxDrawBehindPausemenu(1)
			DrawTvChannel(0.5, 0.5, 1.0, 1.0, 0.0, 255, 255, 255, 255)
			SetTextRenderId(GetDefaultScriptRendertargetRenderId())
			SetScriptGfxDrawBehindPausemenu(0)
			Citizen.Wait(0)
		end
	end)
	LoadTvChannelSequence(0, "PL_SOL_LED_GALAXY", 1)
	SetTvAudioFrontend(1)
	SetTvVolume(-1.0)
	SetTvChannel(0)
	--SetEntityCoords(GetPlayerPed(-1), intLoc2)
	--SetEntityHeading(GetPlayerPed(-1), 0.0)
	SetGameplayCamRelativeHeading(0.0)
	Citizen.Wait(1000)
	RemoveLoadingPrompt()
	DoScreenFadeIn(2000)
	Citizen.Wait(1000)
	for k,v in pairs(InsidePeds) do
		FreezeEntityPosition(v[1], true)
	end
end

function ExitClub()
	PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
	BeginTextCommandBusyString("FMMC_PLYLOAD")
	EndTextCommandBusyString(4)
	DoScreenFadeOut(1000)
	Citizen.Wait(1000)
	for _, EntitySet in ipairs(EntitySets) do
		DeactivateInteriorEntitySet(intID, EntitySet)
	end
	RefreshInterior(intID)
	RemoveIpl("ba_int_placement_ba_interior_0_dlc_int_01_ba_milo_")
	DeletePeds()
	EnableAllControlActions(0)
	SetEntityCoords(GetPlayerPed(-1), extLoc)
	SetEntityHeading(GetPlayerPed(-1), 42.0)
	SetGameplayCamRelativeHeading(0.0)
	Citizen.Wait(1000)
	RemoveLoadingPrompt()
	DoScreenFadeIn(2000)
	Citizen.Wait(1000)
end

function ExitClub2()
	PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
	BeginTextCommandBusyString("FMMC_PLYLOAD")
	EndTextCommandBusyString(4)
	DoScreenFadeOut(1000)
	Citizen.Wait(1000)
	for _, EntitySet in ipairs(EntitySets) do
		DeactivateInteriorEntitySet(intID, EntitySet)
	end
	RefreshInterior(intID)
	RemoveIpl("ba_int_placement_ba_interior_0_dlc_int_01_ba_milo_")
	DeletePeds()
	EnableAllControlActions(0)
	--SetEntityCoords(GetPlayerPed(-1), extLoc2)
	--SetEntityHeading(GetPlayerPed(-1), 42.0)
	SetGameplayCamRelativeHeading(0.0)
	Citizen.Wait(1000)
	RemoveLoadingPrompt()
	DoScreenFadeIn(2000)
	Citizen.Wait(1000)
end


Citizen.CreateThread(function()
    while true do
	Citizen.Wait(0)
			if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), -1262.4162597656,-656.33819580078,26.664106369019, true ) < 30 then
				DrawMarker(21, -1262.4162597656,-656.33819580078,26.664106369019, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 138, 43, 255, 100, false, true, 2, true, false, false, false)
				if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -1262.4162597656,-656.33819580078,26.664106369019, true ) < 5 then
					DrawText3Ds(-1262.4162597656,-656.33819580078,26.664106369019+0.1, "~c~[~b~E~c~] for at gå til natklubben.", 3.0, 7)
					if IsControlJustPressed(1, 38) then
						EnterClub2()
						local targetPed =GetPlayerPed(-1)
						local targetVeh = GetVehiclePedIsUsing(targetPed)
							if(IsPedInAnyVehicle(targetPed))then
								targetPed = targetVeh
							end
						DoScreenFadeOut(1000)
						while IsScreenFadingOut() do Citizen.Wait(0) end
						NetworkFadeOutEntity(GetPlayerPed(-1), true, false)
						Wait(1000)
						SetEntityCoordsNoOffset(targetPed, -1641.4266357422,-2990.0234375,-77.077697753906, 0, 0, 1)		
						SetEntityHeading(targetPed, 268.31323242188)
						NetworkFadeInEntity(GetPlayerPed(-1), 0)
						Wait(1000)
						SimulatePlayerInputGait(PlayerId(), 1.0, 100, 1.0, 1, 0)
						DoScreenFadeIn(1000)
						while IsScreenFadingIn() do Citizen.Wait(0)	end
					end
				end
			end
			if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -1641.4266357422,-2990.0234375,-77.077697753906, true ) < 30 then
				if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -1641.4266357422,-2990.0234375,-77.077697753906, true ) < 5 then
					DrawText3Ds(-1641.4266357422,-2990.0234375,-77.077697753906+0.3, "~c~[~b~E~c~] for at gå ud fra natklubben.", 3.0, 7)
					if IsControlJustPressed(1, 38) then
						ExitClub2()
						local targetPed =GetPlayerPed(-1)
						local targetVeh = GetVehiclePedIsUsing(targetPed)
							if(IsPedInAnyVehicle(targetPed))then
								targetPed = targetVeh
							end
						DoScreenFadeOut(1000)
						while IsScreenFadingOut() do Citizen.Wait(0) end
						NetworkFadeOutEntity(GetPlayerPed(-1), true, false)
						Wait(1000)
						SetEntityCoordsNoOffset(targetPed, -1262.4162597656,-656.33819580078,26.664106369019, 0, 0, 1)		
						SetEntityHeading(targetPed, 151.6213684082)
						NetworkFadeInEntity(GetPlayerPed(-1), 0)
						Wait(1000)
						SimulatePlayerInputGait(PlayerId(), 1.0, 100, 1.0, 1, 0)
						DoScreenFadeIn(1000)
						while IsScreenFadingIn() do Citizen.Wait(0)	end
					end
				end
			end
	end
end)

Citizen.CreateThread(function()
	while true do Citizen.Wait(0)
		if GetInteriorAtCoords(GetEntityCoords(GetPlayerPed(-1))) == 271617 then
			if not DoesEntityExist(InsidePeds["Bouncer1"][1]) then
				ExitClub()
			end
			--DisableControlAction(0, 24, true)
			--DisableControlAction(0, 25, true)
			--DisableControlAction(0, 37, true)
			--DisableControlAction(0, 140, true)
		end
		if #(GetEntityCoords(GetPlayerPed(-1)) - extLoc) < 50.0 then
			DrawMarker(21, extLoc, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 138, 43, 255, 100, false, true, 2, true, false, false, false)
			if not IsPedInAnyVehicle(GetPlayerPed(-1), true) then
				if #(GetEntityCoords(GetPlayerPed(-1)) - extLoc) < 1.0 then
					form = setupScaleform("instructional_buttons", "Tilgå Klubben", 38)
					DrawScaleformMovieFullscreen(form, 255, 255, 255, 255, 0)
					if IsControlJustReleased(2, 38) then
						EnterClub()
					end
				end
			end
		end
		if #(GetEntityCoords(GetPlayerPed(-1)) - intLoc) < 15.0 then
			DrawMarker(21, intLoc, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 138, 43, 255, 100, false, true, 2, true, false, false, false)
			if not IsPedInAnyVehicle(GetPlayerPed(-1), true) then
				if #(GetEntityCoords(GetPlayerPed(-1)) - intLoc) < 1.0 then
					form = setupScaleform("instructional_buttons", "Forlad Klubben", 38)
					DrawScaleformMovieFullscreen(form, 255, 255, 255, 255, 0)
					if IsControlJustReleased(2, 38) then
						ExitClub()
					end
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
	clubBlip = AddBlipForCoord(extLoc)
	SetBlipDisplay(clubBlip, 4)
	SetBlipSprite(clubBlip, 93)
	SetBlipColour(clubBlip, 58)
	SetBlipScale(clubBlip, 0.6)
	SetBlipAsShortRange(clubBlip, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Tordenskjold")
	EndTextCommandSetBlipName(clubBlip)
end)


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
  