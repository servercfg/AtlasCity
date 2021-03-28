local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP_job_display")

local cfg = module("vrp_job_display", "cfg/display")


AddEventHandler("vRP:playerSpawn",function(user_id, source, first_spawn)
  if first_spawn then
    local job = vRP.getUserGroupByType({user_id,"job"})
    if (job == nil or job == "") and cfg.firstjob then
	  vRP.addUserGroup({user_id,cfg.firstjob})
	  job = cfg.firstjob
	end
	if cfg.group_icons[""..job] ~= nil and cfg.group_icons[""..job] ~= "" then
      vRPclient.setDiv(source,{"job_icon",cfg.icon_display_css .. cfg.group_icons[""..job],""})
	else
      vRPclient.setDiv(source,{"job_icon",cfg.icon_display_css,""})
	end
  end
end)


AddEventHandler("vRP:playerJoinGroup", function(user_id, group, gtype)
  local player = vRP.getUserSource({user_id})
  if gtype == "job" then 
	vRPclient.setDivContent(player,{"job",group})
	if cfg.group_icons[""..group] ~= nil and cfg.group_icons[""..group] ~= "" then
      vRPclient.setDiv(player,{"job_icon",cfg.icon_display_css .. cfg.group_icons[""..group],""})
	else
      vRPclient.setDiv(player,{"job_icon",cfg.icon_display_css,""})
	end
  end
end)


AddEventHandler("vRP:playerLeaveGroup", function(user_id, group, gtype)
  local player = vRP.getUserSource({user_id})
  if gtype == "job" then 
	vRPclient.setDivContent(player,{"job",""})
    vRPclient.setDiv(player,{"job_icon",cfg.icon_display_css,""})
  end
end)