-- CONFIG --

-- Blacklisted weapons
weaponblacklist = {
   "WEAPON_PUMPSHOTGUN",
   "WEAPON_RAYPISTOL",
   "WEAPON_RPG",
   "WEAPON_COMBATMG",
   "WEAPON_MICROSMG",
   "WEAPON_COMBATMG",
   "WEAPON_ASSAULTRIFLE",
   "WEAPON_MACHINEPISTOL",
   "WEAPON_MG",
   "WEAPON_FIREWORK",
   "WEAPON_MARKSMANRIFLE",
   "WEAPON_PISTOL_MK2"
}

-- Don't allow any weapons at all (overrides the blacklist)
disableallweapons = false

-- CODE --

Citizen.CreateThread(function()
	while true do
		Wait(1)

		playerPed = GetPlayerPed(-1)
		if playerPed then
			nothing, weapon = GetCurrentPedWeapon(playerPed, true)

			if disableallweapons then
				RemoveAllPedWeapons(playerPed, true)
			else
				if isWeaponBlacklisted(weapon) then
					RemoveWeaponFromPed(playerPed, weapon)
					sendForbiddenMessage("This weapon is blacklisted!")
				end
			end
		end
	end
end)

function isWeaponBlacklisted(model)
	for _, blacklistedWeapon in pairs(weaponblacklist) do
		if model == GetHashKey(blacklistedWeapon) then
			return true
		end
	end

	return false
end