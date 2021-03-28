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
local sanitizes = module("vrp", "cfg/sanitizes")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP_chests")

local function create_wardrobenow(owner_access, x, y, z, player, name)
	local namex = name or "Garderobe"
	local wardrobe_enter = nil
		wardrobe_enter = function(player,area)
			local user_id = vRP.getUserId({player})
				if user_id ~= nil then
				  local data = vRP.getUserDataTable({user_id})
				  local menu = {name="Garderobe",css={top = "75px", header_color="rgba(0,255,125,0.75)"}}
					if vRP.hasPermission({user_id,"garderobe.adgang"}) then
							vRP.getUData({user_id, "vRP:home:wardrobe", function(data)
								local sets = json.decode(data)
									if sets == nil then
										sets = {}
									end
										menu["1. GEM OUTFIT"] = {function(player, choice)
											vRP.prompt({player, "Navn på outfit?", "", function(player, setname)
											setname = sanitizeString(setname, sanitizes.text[1], sanitizes.text[2])
												if string.len(setname) > 0 then
													vRPclient.getCustomization(player,{},function(custom)
													sets[setname] = custom
													vRP.setUData({user_id,"vRP:home:wardrobe",json.encode(sets)})
													wardrobe_enter(player, area)
													end)
												else
													TriggerClientEvent("pNotify:SendNotification", player,{text = {"INVALID"}, type = "error", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
												end
											end})
										end,"Gem Outfittet."}
		local menu2 = {name="Garderobe",css={top = "75px", header_color="rgba(0,255,125,0.75)"} }
        local choosen = ""

        local choose_set = function(player,choice)
          choosen = choice
          vRP.openMenu({player,menu2})
        end
        
        for k,v in pairs(sets) do
          menu[k] = {choose_set}
        end

        menu2["> Tag outfit på"] = {function(player, choice)
          local custom = sets[choosen]
          if custom ~= nil then
            vRPclient.getHealth(player,{},function(health)
              TriggerEvent("vRP:cloakroom:update", player)
              vRPclient.setCustomization(player,{custom})
              SetTimeout(500,function()
                vRPclient.setHealth(player,{health})
                vRP.getUData({user_id,"vRP:tattoos",function(value)
                  local tattoos = json.decode(value)
                  if tattoos ~= nil then
                    for k,v in pairs(tattoos) do
                      vRPclient.drawMyTattoo(player,{k,v})
                    end
                  end
                end})
              end)
            end)
          end
        end}
        menu2["Skift outfitnavn"] = {function(player, choice)
          local custom = sets[choosen]
          if custom ~= nil then
            vRP.prompt({player, "Dit nye outfitnavn? (Imellem 1 og 20)", choosen, function(player, name)
              name = sanitizeString(name, sanitizes.text[1], sanitizes.text[2])
              if string.len(name) >= 1 and string.len(name) <= 20 then
                for k,v in pairs(sets) do
                  if k == choosen then
                    sets[name] = sets[k]
                    sets[k] = nil
                    vRP.setUData({user_id,"vRP:home:wardrobe",json.encode(sets)})
                  end
                end
              else
                TriggerClientEvent("pNotify:SendNotification",player,{text = "Navnet skal være imellem 1 og 20 bogstaver!", type = "error", timeout = (3000),layout = "centerRight"})
              end
              wardrobe_enter(player, area)
            end})
          end
        end}
        menu2["Slet outfit"] = {function(player, choice)
            for k,v in pairs(sets) do
              if k == choosen then
                sets[k] = nil
                vRP.setUData({user_id,"vRP:home:wardrobe",json.encode(sets)})
              end
            end
            wardrobe_enter(player, area)
        end}
        	vRP.openMenu({player,menu})
							end})
					else
						menu["1. KØB GARDEROBE"] = {function(player, choice)			
							local pris = 100000
								if vRP.tryFullPayment({user_id,pris}) then
									vRP.addUserGroup({user_id,"Garderobe"})
									TriggerClientEvent("pNotify:SendNotification", player,{text = "Du købte adgang til garderober i alle tøjbutikkerne!", type = "error", queue = "global", timeout = 10000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
									vRP.closeMenu({player})
								else
									TriggerClientEvent("pNotify:SendNotification", player,{text = "Du havde ikke råd!", type = "error", queue = "global", timeout = 10000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
								end
						end,"Køb adgang til garderober (100.000)"}
						menu["2. FORLAD"] = {function(player, choice)			
							vRP.closeMenu({player})
						end,"Forlad Garderoben."}
							vRP.openMenu({player,menu})
				end
			end
		end	
			local wardrobe_leave = function(player,area)
				vRP.closeMenu({player})
			end
			local nid = "vRP:static-"..namex..":"..owner_access
			vRP.setArea({player,nid,x,y,z,1,1.5,wardrobe_enter,wardrobe_leave})
			vRPclient.addMarker(player,{x,y,z-0.87,0.7,0.7,0.5,0,255,125,125,150})
end


AddEventHandler("vRP:playerSpawn",function(user_id,source,first_spawn)
  if first_spawn then
create_wardrobenow(1, 7.7569289207458, 6518.0170898438, 31.889335632324, source, "Garderobe") -- Tøjbutik Palito
create_wardrobenow(2, 1190.7557373047,2708.3713378906,38.234100341797, source, "Garderobe") -- Tøjbutik Sandy
create_wardrobenow(3, -711.85894775391,-150.8761138916,37.415157318115, source, "Garderobe") -- Tøjbutik Luksusbutik midtby ved jobcenter
create_wardrobenow(4, 126.20694732666,-219.99166870117,54.557872772217, source, "Garderobe") -- Tøjbutik nord for hospital
create_wardrobenow(5, 423.70013427734,-800.28088378906,29.502630233765, source, "Garderobe") -- Tøjbutik ved stripklub
create_wardrobenow(6, 77.654502868652,-1398.6373291016,29.387630462646, source, "Garderobe") -- Tøjbutik ved PD
create_wardrobenow(7, 453.12554931641,-992.52124023438,30.689664840698, source, "Garderobe") -- MissionRow PD
create_wardrobenow(8, 8.7849617004395,528.20184326172,170.63502502441, source, "Garderobe") -- Franklins Hus
create_wardrobenow(9, 982.666015625,-92.102149963379,74.652241516113, source, "Garderobe") -- SonsOfAnarchy
create_wardrobenow(10, 269.47576904297,-1360.5870361328,24.537792205811, source, "Garderobe") -- Sygehus Kælder
create_wardrobenow(11, -448.68127441406,6015.9873046875,31.71639251709, source, "Garderobe") -- Palito PD
create_wardrobenow(12, 1839.2312011719,3690.4438476563,34.310104370117, source, "Garderobe") -- Sandy PD
create_wardrobenow(13, -1619.814453125,-3019.7976074219,-75.205032348633, source, "Garderobe") -- Nightclub VIP
create_wardrobenow(14, -813.26336669922,173.45562744141,76.740783691406, source, "Garderobe") -- Micheals Hus
create_wardrobenow(15, 300.84085083008,-597.18640136719,43.283992767334, source, "Garderobe") -- Pillbox-upper
create_wardrobenow(16, 105.43682098389,-1303.0806884766,28.768779754639, source, "Garderobe") -- Stripklubben
create_wardrobenow(17, -1150.8197021484,-1513.3920898438,10.632716178894, source, "Garderobe") -- BeachHouse Custom 17
create_wardrobenow(18, -53.116542816162,-2525.1457519531,7.4011693000793, source, "Garderobe") -- Håndværker
create_wardrobenow(19, -225.79182434082,-1319.9919433594,30.890476226807, source, "Garderobe") -- Mekaniker
create_wardrobenow(20, 1399.9045410156,1139.7523193359,114.33360290527, source, "Garderobe") -- Mafia
create_wardrobenow(21, 342.74810791016,-2025.3514404297,25.594638824463, source, "Garderobe") -- Vagos
create_wardrobenow(22, -565.25988769531,279.76672363281,82.975410461426, source, "Garderobe")
create_wardrobenow(23, 380.03826904297,-1609.3865966797,29.292055130005, source, "Garderobe") -- DavisPD
create_wardrobenow(24, -110.66664886475,-14.737296104431,70.519630432129, source, "Garderobe") -- MO
create_wardrobenow(25, -1886.1533203125,2073.2001953125,145.57379150391, source, "Garderobe") -- Vingården
  end
end)


--[[
RegisterServerEvent('kaz_wardrobe:buy')
AddEventHandler('kaz_wardrobe:buy', function()
local source = source
local user_id = vRP.getUserId({source})
local pris = 100000
	if vRP.tryFullPayment({user_id,pris}) then
		vRP.addUserGroup({user_id,"Garderobe"})
		TriggerClientEvent("pNotify:SendNotification", source,{text = "Du købte adgang til garderober i alle tøjbutikkerne!", type = "error", queue = "global", timeout = 10000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
	else
		TriggerClientEvent("pNotify:SendNotification", source,{text = "Du havde ikke råd!", type = "error", queue = "global", timeout = 10000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
	end
end)
]]--

