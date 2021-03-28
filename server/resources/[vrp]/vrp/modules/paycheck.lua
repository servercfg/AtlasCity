local salary = {
	["Politi"] = {salary = 25000, perm = "politi.paycheck"},
	["Politi Ledelse"] = {salary = 75000, perm = "ledelse.paycheck"},

	["Dommer"] = {salary = 30000, perm = "dommer.paycheck"},

	["EMS"] = {salary = 20000, perm = "ems.paycheck"},

	["Mekaniker Chef"] = {salary = 16500, perm = "mekanikerchef.paycheck"},
	["Mekaniker"] = {salary = 12500, perm = "mekaniker.paycheck"},

	["Advokat"] = {salary = 27500, perm = "advokat.paycheck"},

	["Journalist"] = {salary = 9500, perm = "journalist.paycheck"},
--Strip
	["Vagt"] = {salary = 7500, perm = "vagt.paycheck"},
	["Stripklub Arbejder"] = {salary = 11000, perm = "strip.paycheck"},
	
	["Bilforhandler"] = {salary = 12000, perm = "bilforhandler.paycheck"},

	["Taxa"] = {salary = 8000, perm = "taxi.paycheck"},

	["Pizzabud"] = {salary = 8000, perm = "delivery.paycheck"},

	["Burgershot Medarbejder"] = {salary = 7500, perm = "burger.paycheck"},

	["Lastbil Chauffør"] = {salary = 8000, perm = "trucker.paycheck"},
    ["Psykolog"] = {salary = 17500, perm = "psyko.paycheck"},
	["Miner"] = {salary = 8000, perm = "miner.paycheck"},
	["Arbejdsløs"] = {salary = 5000, perm = "nojob.paycheck"},
	["Falck Vagt"] = {salary = 12500, perm = "emsvagt.paycheck"},
}

Citizen.CreateThread(function ()
	while true do
		Citizen.Wait(1800000) -- Every X ms you'll get paid (300000 = 5 min)
		for user_id,source in pairs(vRP.getUsers()) do
			for k,v in pairs(salary) do
				Citizen.Wait(50)
				if vRP.hasPermission(user_id,v.perm) then
					vRP.giveBankMoney(user_id,tonumber(v.salary))
					TriggerClientEvent("pNotify:SendNotification", source,{text = "Lønudbetaling: <b style='color: #4E9350'>"..format_thousands(math.floor(tonumber(v.salary))).." DKK</b>.<br/>Erhverv: <b style='color: #72AEE5'>"..k.."</b>.", type = "info", queue = "global",timeout = 4000, layout = "bottomCenter",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}, sounds = { sources = {"cash.ogg"}, volume = 0.6, conditions = {"docVisible"}}})
					break
				end
			end
		end
	end
end)

function format_thousands(v)
	local s = string.format("%d", math.floor(v))
	local pos = string.len(s) % 3
	if pos == 0 then pos = 3 end
	return string.sub(s, 1, pos)
			.. string.gsub(string.sub(s, pos+1), "(...)", ".%1")
end
