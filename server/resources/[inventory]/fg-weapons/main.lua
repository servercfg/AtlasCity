--[[vRP = nil

Citizen.CreateThread(function()
	while vRP == nil do
		TriggerEvent('vRP:getSharedObject', function(obj) vRP = obj end)
		Citizen.Wait(0)
	end
end)]]

local weapons = {
	---### HOBBY VÅBEN ###---
	{name = 'WEAPON_KNIFE'},
	{name = 'WEAPON_SWITCHBLADE'},
	{name = 'WEAPON_HATCHET'},
	{name = 'WEAPON_MACHETE'},
	{name = 'WEAPON_BAT'},
	{name = 'WEAPON_CROWBAR'},
	{name = 'WEAPON_GOLFCLUB'},
	{name = 'WEAPON_WRENCH'},
	{name = 'WEAPON_HAMMER'},
	---### RARE VÅBEN ###---
	{name = 'WEAPON_KNUCKLE'},
	{name = 'WEAPON_PISTOL'},
	{name = 'WEAPON_HEAVYPISTOL'},
	{name = 'WEAPON_SNSPISTOL'},
	---### MISC TING ###---
	{name = 'WEAPON_FIREEXTINGUISHER'},
	--{name = 'WEAPON_PETROLCAN'},
	{name = 'WEAPON_FIREWORK'},
	---### POLITI VÅBEN ###---
	{name = 'WEAPON_FLASHLIGHT'},
	{name = 'WEAPON_NIGHTSTICK'},
	{name = 'WEAPON_STUNGUN'},
	{name = 'WEAPON_COMBATPISTOL'},
	{name = 'WEAPON_SMG'},
	---### AKS VÅBEN ###---
	{name = 'WEAPON_SMOKEGRENADE'},
	{name = 'WEAPON_PUMPSHOTGUN'},
	{name = 'WEAPON_SPECIALCARBINE_MK2'},
	{name = 'WEAPON_HEAVYSNIPER'}
}		

Citizen.CreateThread(function()
	while true do
		checkweapons()
		Citizen.Wait(0)
  	end
end)

function checkweapons()
	local Ped = GetPlayerPed(-1)
	for k,v in pairs(weapons) do
		if exports["fg-inventory"]:hasEnoughOfItem(v.name,1) then
			GiveWeaponToPed(Ped, v.name, 0, false, false)
		else
			RemoveWeaponFromPed(Ped,v.name)
		end
	end
end

function giveWeapon(itemid,amount,ammo)
	local Ped = GetPlayerPed(-1)
	TriggerServerEvent("fg-weapons:giveWeapon", itemid, amount)
	AddAmmoToPed(Ped,itemid,ammo)
end