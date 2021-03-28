--[[
─────────────────────────────────────────────────────────────────────────────────────────────────────────
─██████──████████─██████████████─██████████████████─██████████████─██████████████─██████──────────██████─
─██░░██──██░░░░██─██░░░░░░░░░░██─██░░░░░░░░░░░░░░██─██░░░░░░░░░░██─██░░░░░░░░░░██─██░░██████████──██░░██─
─██░░██──██░░████─██░░██████░░██─████████████░░░░██─██░░██████░░██─██░░██████░░██─██░░░░░░░░░░██──██░░██─
─██░░██──██░░██───██░░██──██░░██─────────████░░████─██░░██──██░░██─██░░██──██░░██─██░░██████░░██──██░░██─
─██░░██████░░██───██░░██████░░██───────████░░████───██░░██──██░░██─██░░██──██░░██─██░░██──██░░██──██░░██─
─██░░░░░░░░░░██───██░░░░░░░░░░██─────████░░████─────██░░██──██░░██─██░░██──██░░██─██░░██──██░░██──██░░██─
─██░░██████░░██───██░░██████░░██───████░░████───────██░░██──██░░██─██░░██──██░░██─██░░██──██░░██──██░░██─
─██░░██──██░░██───██░░██──██░░██─████░░████─────────██░░██──██░░██─██░░██──██░░██─██░░██──██░░██████░░██─
─██░░██──██░░████─██░░██──██░░██─██░░░░████████████─██░░██████░░██─██░░██████░░██─██░░██──██░░░░░░░░░░██─
─██░░██──██░░░░██─██░░██──██░░██─██░░░░░░░░░░░░░░██─██░░░░░░░░░░██─██░░░░░░░░░░██─██░░██──██████████░░██─
─██████──████████─██████──██████─██████████████████─██████████████─██████████████─██████──────────██████─
─────────────────────────────────────────────────────────────────────────────────────────────────────────
]]--

local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
MySQL = module("vrp_mysql", "MySQL")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","kaz_skunknew")

vRPcc = {}
Tunnel.bindInterface("kaz_skunknew",vRPcc)
Proxy.addInterface("kaz_skunknew",vRPcc)
vRPccC = Tunnel.getInterface("kaz_skunknew","kaz_skunknew")

antaltilbage2 = 0
notstarted = false
guesskode = "39das89dsa78"
notspawned = false

local guesses = {
{message="Jo flere du tager, jo flere vil være bag dig, hvad er det?", guesspass="et skridt"},
{message="Davids far har 3 sønner: Søren, Peter og?", guesspass="david"},
{message="Hvornår kommer Christmas før Thanksgiving?", guesspass="en ordbog"},
{message="Jeg er ikke i live, men jeg vokser. Jeg har ikke nogen lunger men skal bruge luft. Jeg har ikke en mund, men vand kan dræbe mig - Hvad er jeg?", guesspass="ild"},
{message="Hvad kan pege i alle retninger, men aldrig nå destinationen af sig selv?", guesspass="din finger"},
{message="Hvad er sort når du køber det, rødt når du bruger det, og grå når du smider det ud?", guesspass="trækul"},
{message="Jeg laver en person til 2, hvad er jeg?", guesspass="et spejl"},
{message="Hvad tilhører dig, men bruges oftere af andre?", guesspass="navn"},
{message="Jeg er hvid når jeg er beskidt, og sort når jeg er ren - Hvad er jeg?", guesspass="en tavle"},
{message="Før Mount Everest var opdaget, hvad var det højeste bjerg på jorden?", guesspass="mount everest"},
}

RegisterServerEvent('kaz_hash:plantedonenowplant')
AddEventHandler('kaz_hash:plantedonenowplant', function(_, newplantename)
local source = source
local user_id = vRP.getUserId({source})
	vRP.giveInventoryItem({user_id,"skunk1000",1,false})
	TriggerClientEvent('kaz_hash:plantedonenow2plant', -1, _, newplantename)
end)
RegisterServerEvent('kaz_hash:plantcoolplant')
AddEventHandler('kaz_hash:plantcoolplant', function(_, plantename)
local source = source
	TriggerClientEvent('kaz_hash:plantcoolplant', -1, _, plantename)
	Citizen.Wait(300000)
	TriggerClientEvent('kaz_hash:updateplantmodel', source, _, plantename)
end)

RegisterServerEvent('kaz_edited')
AddEventHandler('kaz_edited', function()
local source = source
print("DU HAR ÆNDRET TING DU IKKE MÅ ÆNDRE!!")
print("DU HAR ÆNDRET TING DU IKKE MÅ ÆNDRE!!")
print("DU HAR ÆNDRET TING DU IKKE MÅ ÆNDRE!!")
DropPlayer(source,"DER ER ÆNDRET TING DER IKKE MÅ ÆNDRES!")
end)

RegisterServerEvent('kaz_hash:settodryplant')
AddEventHandler('kaz_hash:settodryplant', function()
local source = source
local user_id = vRP.getUserId({source})
	if vRP.tryGetInventoryItem({user_id,"skunkfro",1,false}) then
		TriggerClientEvent('kaz_hash:settodry2plant', source)
	end
end)
RegisterServerEvent('kaz_hash:updatedplantmodel')
AddEventHandler('kaz_hash:updatedplantmodel', function(_, plantename)
TriggerClientEvent('kaz_hash:updateplantmodelall', -1, _, plantename)
end)
AddEventHandler("vRP:playerSpawn", function(user_id, source, first_spawn)
TriggerClientEvent("kaz_hash:updateguess", -1, guesskode)
    if first_spawn then
        TriggerClientEvent("kaz_hash:joined", source)
    end
end)

RegisterServerEvent('kaz_hash:koebantal')
AddEventHandler('kaz_hash:koebantal', function(antaltilbage3, antalkoeb)
local source = source
local user_id = vRP.getUserId({source})
pricehash = antalkoeb*10
	if vRP.tryGetInventoryItem({user_id,"dirty_money",pricehash,false}) then
		vRP.giveInventoryItem({user_id,"skunkfro",antalkoeb,false})
		antaltilbage2 = antaltilbage3
		TriggerClientEvent('kaz_hash:antaltilbage2', -1, antaltilbage2)
		TriggerClientEvent("pNotify:SendNotification", source,{text = "Du købte "..antalkoeb.." frø.", type = "error", queue = "global", timeout = 12000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
		TriggerClientEvent('kaz_hash:harkoebtnu', source)
		PerformHttpRequest('https://discordapp.com/api/webhooks/773264798577852486/-2HwFkLLG4g7qgWo2zEk7f4lTw4YyFY3vhtCskXnqolFxt_Ev02TL1eW7KcmqDMtkhU-', function(err, text, headers) end, 'POST', json.encode({username = "kazhash", content = "```Brugeren: "..user_id.." købte "..antalkoeb.." frø```"}), { ['Content-Type'] = 'application/json' })
	else
		TriggerClientEvent("pNotify:SendNotification", source,{text = "Ikke nok sorte penge.", type = "error", queue = "global", timeout = 12000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
	end
end)
RegisterServerEvent('kaz_hash:updateantal')
AddEventHandler('kaz_hash:updateantal', function()
antalleft = antaltilbage2
TriggerClientEvent('kaz_hash:antaltilbage2', source, antalleft)
end)
RegisterServerEvent('kaz_hash:plantedonenow')
AddEventHandler('kaz_hash:plantedonenow', function(_, newplantename)
local source = source
local user_id = vRP.getUserId({source})
local new_weight = vRP.getInventoryWeight({user_id})+vRP.getItemWeight({"skunk2"})
if new_weight <= vRP.getInventoryMaxWeight({user_id}) then
	kazoonskunk = math.random(170,270)
	vRP.giveInventoryItem({user_id,"skunk2",kazoonskunk,false})
	TriggerClientEvent('kaz_hash:plantedonenow2', -1, _, newplantename)
	TriggerClientEvent("pNotify:SendNotification", source,{text = "Planten indeholdt "..kazoonskunk.." g skunk.", type = "error", queue = "global", timeout = 12000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
else
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Du har ikke nok plads', length = '5000', style = {}})
end 
end)
RegisterServerEvent('kaz_hash:plantcool')
AddEventHandler('kaz_hash:plantcool', function(_, plantename)
	TriggerClientEvent('kaz_hash:plantcool', -1, _, plantename)
end)
RegisterServerEvent('kaz_hash:settodry')
AddEventHandler('kaz_hash:settodry', function()
local source = source
local user_id = vRP.getUserId({source})
	if vRP.tryGetInventoryItem({user_id,"skunk1000",1,false}) then
		TriggerClientEvent('kaz_hash:settodry2', source)
	end
end)
RegisterServerEvent('kaz_hash:skunkipose')
AddEventHandler('kaz_hash:skunkipose', function()
local source = source
local user_id = vRP.getUserId({source})
	if vRP.tryGetInventoryItem({user_id,"skunk2",100,false}) then
		vRP.giveInventoryItem({user_id,"klump10",10,false})
	elseif vRP.tryGetInventoryItem({user_id,"skunk",1,false}) then
		vRP.giveInventoryItem({user_id,"klump10",30,false})
	else
		TriggerClientEvent("pNotify:SendNotification", source,{text = "Du har ikke nok skunk (kræver 100g)", type = "error", queue = "global", timeout = 12000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
	end
end)


