local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP_chests")

--- Config
-- list of static chests
-- {access, x, y, z, name-optional}
-- access = can be user_id, user_permission or user_group. Set it to "none" to give to all players access to the chest.
-- name = if you have multiple chests with same access you need to set different name, or the chests with same access will containt same items.
local chests = {}
chests = {
	--{"Tordenskjold", -1619.6948242188,-3010.9750976563,-75.205024719238, "Tordenskjold"},
	{"Hells Angels", -808.44750976563,175.35078430176,76.740737915039, "Hells Angels"},
	{"Politi-Job", 478.48883056641,-984.86486816406,24.914697647095, "Politi-Job"},
	{"LTF", -5.5060467720032,530.19885253906,170.61706542969, "LTF"},
	{"Vagos", 337.51019287109,-2012.0970458984,22.394874572754, "Vagos"},
	--{"Jan", 1103.8826904297,-3096.7563476563,-38.999954223633, "Jan"},
	--{"Narko", -574.19586181641,293.37551879883,79.176666259766, "Narko"},
	--{"MO", -113.73868560791,-12.227765083313,70.519561767578, "MO"},
	--{"Ballas", 106.33321380615,-1981.3391113281,20.962627410889, "Ballas"},
	--{"vin", -1881.6343994141,2063.9345703125,135.91508483887, "vin"}
}
-- I've put some random locations just for test, change them.
---#

local function create_pleschest(owner_access, x, y, z, player, name)
	local namex = name or "chest"
	
	local chest_enter = function(player, area)
		local user_id = vRP.getUserId({player})
		if user_id ~= nil then
			if owner_access == "none" or user_id == tonumber(owner_access) or vRP.hasGroup({user_id, owner_access}) or vRP.hasPermission({user_id, owner_access}) then
				vRP.openChest({player, "static:"..owner_access..":"..namex, 1000, nil, nil, nil})
			end
		end
	end

	local chest_leave = function(player,area)
		vRP.closeMenu({player})
	end
	
	local nid = "vRP:static-"..namex..":"..owner_access
	vRPclient.setNamedMarker(player,{nid,x,y,z-1,0.7,0.7,0.5,0,148,255,125,150})
	vRP.setArea({player,nid,x,y,z,1,1.5,chest_enter,chest_leave})
end

AddEventHandler("vRP:playerSpawn",function(user_id,source,first_spawn)
  if first_spawn then
	for k, v in pairs(chests) do
		create_pleschest(v[1], v[2], v[3], v[4], source, v[5])
		--TriggerClientEvent('chatMessage', -1, "Chest created: "..v[1]..", "..v[2]..", "..v[3]..", "..v[4]..", "..v[5]..".") -- debuging.
	end
  end
end)
