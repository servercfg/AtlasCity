local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
local cfg = module("vrp_lyd", "cfg/display")
vRPlyd = {}
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vrp_lyd")
VDclient = Tunnel.getInterface("vrp_lyd","vrp_lyd")
Tunnel.bindInterface("vrp_lyd",vRPlyd)

function vRPlyd.setVoiceDisplay(player,volume)
	if not player then player = source end
    --vRPclient.setDiv(player,{"voice_icon",cfg[volume].css,cfg[volume].text})
	TriggerClientEvent("pNotify:SetQueueMax", -1, "lmao", 3)
	TriggerClientEvent("pNotify:SendNotification", player,{text = "Talerækkevide: <b style='color: #4E9350'>"..cfg[volume].text.."</b>", type = "info", queue = "lmao",timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer=true})  
	VDclient.setTalkerProxity(player,{cfg[volume].distance})
end

function vRPlyd.setVoiceDisplays(player,volume)
	if not player then player = source end
    --vRPclient.setDiv(player,{"voice_icon",cfg[volume].css,cfg[volume].text})
	VDclient.setTalkerProxity(player,{cfg[volume].distance})
end

AddEventHandler("vRP:playerSpawn",function(user_id, source, first_spawn)
	vRPlyd.setVoiceDisplays(source,1)
end)