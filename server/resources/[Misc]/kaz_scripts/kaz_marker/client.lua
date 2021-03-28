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

vRP = Proxy.getInterface("vRP")

local farm = false
local amf1 = cfg.amf1
local amf2 = cfg.amf2
--local salg = cfg.salg
local kokain1 = cfg.kokain1
local kokain2 = cfg.kokain2
local meth1 = cfg.meth1
local meth2 = cfg.meth2
local guld1 = cfg.guld1
local guld2 = cfg.guld2
local guld3 = cfg.guld3
local alu1 = cfg.alu1
local alu2 = cfg.alu2
local alu3 = cfg.alu3
local wea1 = cfg.wea1
local wea2 = cfg.wea2
local wea3 = cfg.wea3
local wea4 = cfg.wea4
local wea5 = cfg.wea5
local wea6 = cfg.wea6
local key = cfg.key
local sku1 = cfg.sku1
local sku2 = cfg.sku2
local juv1 = cfg.juv1

Citizen.CreateThread(function()
	while true do
	Citizen.Wait(0)
			-- Skunk FARM
			if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), sku1.x, sku1.y, sku1.z, true ) < 6 then
				if farm == false then 
					DrawText3Ds(sku1.x,sku1.y,sku1.z+0.4, "~w~Tryk [~g~E~w~] for at ~g~farme~w~.", 3.0, 7)	
						if IsControlJustPressed(1, key) then
							local spiller = PlayerPedId()
							TaskStartScenarioInPlace(spiller, "PROP_HUMAN_PARKING_METER")
							FreezeEntityPosition(spiller,true)	
							farm = true
						end	
				else 
					DrawText3Ds(sku1.x,sku1.y,sku1.z+0.4, "~w~Tryk [~g~E~w~] for at ~r~stoppe~w~.", 3.0, 7)	
						if IsControlJustPressed(1, key) then
							local spiller = PlayerPedId()
							FreezeEntityPosition(spiller,false)
							ClearPedTasksImmediately(spiller)
							farm = false
						end	
				end
			-- Skunk Tørring
			elseif GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), sku2.x, sku2.y, sku2.z, true ) < 6 then
				if farm == false then 
					DrawText3Ds(sku2.x,sku2.y,sku2.z+0.4, "~w~Tryk [~g~E~w~] for at ~g~fremstile~w~.", 3.0, 7)	
						if IsControlJustPressed(1, key) then
							local spiller = PlayerPedId()
							TaskStartScenarioInPlace(spiller, "PROP_HUMAN_PARKING_METER")
							FreezeEntityPosition(spiller,true)	
							farm = true
						end	
				else 
					DrawText3Ds(sku2.x,sku2.y,sku2.z+0.4, "~w~Tryk [~g~E~w~] for at ~r~stoppe~w~.", 3.0, 7)	
						if IsControlJustPressed(1, key) then
							local spiller = PlayerPedId()
							FreezeEntityPosition(spiller,false)
							ClearPedTasksImmediately(spiller)
							farm = false
						end	
				end
				-- Juveler
			elseif GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), juv1.x, juv1.y, juv1.z, true ) < 6 then
				if farm == false then 
					DrawText3Ds(juv1.x,juv1.y,juv1.z+0.4, "~w~Tryk [~g~E~w~] for at ~g~sælge~w~.", 3.0, 7)	
						if IsControlJustPressed(1, key) then
							local spiller = PlayerPedId()
							TaskStartScenarioInPlace(spiller, "WORLD_HUMAN_CLIPBOARD")
							FreezeEntityPosition(spiller,true)	
							farm = true
						end	
				else 
					DrawText3Ds(juv1.x,juv1.y,juv1.z+0.4, "~w~Tryk [~g~E~w~] for at ~r~stoppe~w~.", 3.0, 7)	
						if IsControlJustPressed(1, key) then
							local spiller = PlayerPedId()
							FreezeEntityPosition(spiller,false)
							ClearPedTasksImmediately(spiller)
							farm = false
						end	
				end
			-- METH FARM
			elseif GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), meth1.x, meth1.y, meth1.z, true ) < 6 then
				if farm == false then 
					DrawText3Ds(meth1.x,meth1.y,meth1.z+0.4, "~w~Tryk [~g~E~w~] for at ~g~arbejde~w~.", 3.0, 7)	
						if IsControlJustPressed(1, key) then
							local spiller = PlayerPedId()
							TaskStartScenarioInPlace(spiller, "PROP_HUMAN_PARKING_METER")
							FreezeEntityPosition(spiller,true)	
							farm = true
						end	
				else 
					DrawText3Ds(meth1.x,meth1.y,meth1.z+0.4, "~w~Tryk [~g~E~w~] for at ~r~stoppe~w~.", 3.0, 7)	
						if IsControlJustPressed(1, key) then
							local spiller = PlayerPedId()
							FreezeEntityPosition(spiller,false)
							ClearPedTasksImmediately(spiller)
							farm = false
						end	
				end
				-- METH LAB
			elseif GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), meth2.x, meth2.y, meth2.z, true ) < 6 then
				if farm == false then 
					DrawText3Ds(meth2.x,meth2.y,meth2.z+0.4, "~w~Tryk [~g~E~w~] for at ~g~arbejde~w~.", 3.0, 7)	
						if IsControlJustPressed(1, key) then
							local spiller = PlayerPedId()
							TaskStartScenarioInPlace(spiller, "PROP_HUMAN_PARKING_METER")
							FreezeEntityPosition(spiller,true)	
							farm = true
						end	
				else 
					DrawText3Ds(meth2.x,meth2.y,meth2.z+0.4, "~w~Tryk [~g~E~w~] for at ~r~stoppe~w~.", 3.0, 7)	
						if IsControlJustPressed(1, key) then
							local spiller = PlayerPedId()
							FreezeEntityPosition(spiller,false)
							ClearPedTasksImmediately(spiller)
							farm = false
						end	
				end
				-- AMF FARM
			elseif GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), amf1.x, amf1.y, amf1.z, true ) < 6 then
				if farm == false then 
					DrawText3Ds(amf1.x,amf1.y,amf1.z+0.4, "~w~Tryk [~g~E~w~] for at ~g~arbejde~w~.", 3.0, 7)	
						if IsControlJustPressed(1, key) then
							local spiller = PlayerPedId()
							TaskStartScenarioInPlace(spiller, "PROP_HUMAN_PARKING_METER")
							FreezeEntityPosition(spiller,true)	
							farm = true
						end	
				else 
					DrawText3Ds(amf1.x,amf1.y,amf1.z+0.4, "~w~Tryk [~g~E~w~] for at ~r~stoppe~w~.", 3.0, 7)	
						if IsControlJustPressed(1, key) then
							local spiller = PlayerPedId()
							FreezeEntityPosition(spiller,false)
							ClearPedTasksImmediately(spiller)
							farm = false
						end	
				end
			-- AMF LAB
			elseif GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), amf2.x, amf2.y, amf2.z, true ) < 3 then
				if farm == false then 
					DrawText3Ds(amf2.x,amf2.y,amf2.z+0.4, "~w~Tryk [~g~E~w~] for at ~g~arbejde~w~.", 3.0, 7)	
						if IsControlJustPressed(1, key) then
							local spiller = PlayerPedId()
							TaskStartScenarioInPlace(spiller, "PROP_HUMAN_PARKING_METER")
							FreezeEntityPosition(spiller,true)	
							farm = true
						end	
				else 
					DrawText3Ds(amf2.x,amf2.y,amf2.z+0.4, "~w~Tryk [~g~E~w~] for at ~r~stoppe~w~.", 3.0, 7)	
						if IsControlJustPressed(1, key) then
							local spiller = PlayerPedId()
							FreezeEntityPosition(spiller,false)
							ClearPedTasksImmediately(spiller)
							farm = false
						end	
				end
				-- KOKAINFARM
			elseif GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), kokain1.x, kokain1.y, kokain1.z, true ) < 3 then
				if farm == false then 
					DrawText3Ds(kokain1.x,kokain1.y,kokain1.z+0.4, "~w~Tryk [~g~E~w~] for at ~g~farme~w~.", 3.0, 7)	
						if IsControlJustPressed(1, key) then
							local spiller = PlayerPedId()
							TaskStartScenarioInPlace(spiller, "PROP_HUMAN_PARKING_METER")
							FreezeEntityPosition(spiller,true)	
							farm = true
						end	
				else 
					DrawText3Ds(kokain1.x,kokain1.y,kokain1.z+0.4, "~w~Tryk [~g~E~w~] for at ~r~stoppe~w~.", 3.0, 7)	
						if IsControlJustPressed(1, key) then
							local spiller = PlayerPedId()
							FreezeEntityPosition(spiller,false)
							ClearPedTasksImmediately(spiller)
							farm = false
						end	
				end
				
				-- KOKAINFREM
			elseif GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), kokain2.x, kokain2.y, kokain2.z, true ) < 3 then
				if farm == false then 
					DrawText3Ds(kokain2.x,kokain2.y,kokain2.z+0.4, "~w~Tryk [~g~E~w~] for at ~g~arbejde~w~.", 3.0, 7)	
						if IsControlJustPressed(1, key) then
							local spiller = PlayerPedId()
							TaskStartScenarioInPlace(spiller, "PROP_HUMAN_PARKING_METER")
							FreezeEntityPosition(spiller,true)	
							farm = true
						end	
				else 
					DrawText3Ds(kokain2.x,kokain2.y,kokain2.z+0.4, "~w~Tryk [~g~E~w~] for at ~r~stoppe~w~.", 3.0, 7)	
						if IsControlJustPressed(1, key) then
							local spiller = PlayerPedId()
							FreezeEntityPosition(spiller,false)
							ClearPedTasksImmediately(spiller)
							farm = false
						end	
				end
--				-- GULDFARM
			elseif GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), guld1.x, guld1.y, guld1.z, true ) < 3 then
				if farm == false then 
					DrawText3Ds(guld1.x,guld1.y,guld1.z+0.4, "~w~Tryk [~g~E~w~] for at ~g~arbejde~w~.", 3.0, 7)	
						if IsControlJustPressed(1, key) then
							local spiller = PlayerPedId()
							TaskStartScenarioInPlace(spiller, "WORLD_HUMAN_CONST_DRILL")
							FreezeEntityPosition(spiller,true)	
							farm = true
						end	
				else 
					DrawText3Ds(guld1.x,guld1.y,guld1.z+0.4, "~w~Tryk [~g~E~w~] for at ~r~stoppe~w~.", 3.0, 7)	
						if IsControlJustPressed(1, key) then
							local spiller = PlayerPedId()
							FreezeEntityPosition(spiller,false)
							ClearPedTasksImmediately(spiller)
							farm = false
						end	
				end
				-- GULDFREM
			elseif GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), guld2.x, guld2.y, guld2.z, true ) < 3 then
				if farm == false then 
					DrawText3Ds(guld2.x,guld2.y,guld2.z+0.4, "~w~Tryk [~g~E~w~] for at ~g~arbejde~w~.", 3.0, 7)	
						if IsControlJustPressed(1, key) then
							local spiller = PlayerPedId()
							TaskStartScenarioInPlace(spiller, "PROP_HUMAN_PARKING_METER")
							FreezeEntityPosition(spiller,true)	
							farm = true
						end	
				else 
					DrawText3Ds(guld2.x,guld2.y,guld2.z+0.4, "~w~Tryk [~g~E~w~] for at ~r~stoppe~w~.", 3.0, 7)	
						if IsControlJustPressed(1, key) then
							local spiller = PlayerPedId()
							FreezeEntityPosition(spiller,false)
							ClearPedTasksImmediately(spiller)
							farm = false
						end	
				end
				-- GULDSALG
			elseif GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), guld3.x, guld3.y, guld3.z, true ) < 3 then
				if farm == false then 
					DrawText3Ds(guld3.x,guld3.y,guld3.z+0.4, "~w~Tryk [~g~E~w~] for at ~g~arbejde~w~.", 3.0, 7)	
						if IsControlJustPressed(1, key) then
							local spiller = PlayerPedId()
							TaskStartScenarioInPlace(spiller, "WORLD_HUMAN_CLIPBOARD")
							FreezeEntityPosition(spiller,true)	
							farm = true
						end	
				else 
					DrawText3Ds(guld3.x,guld3.y,guld3.z+0.4, "~w~Tryk [~g~E~w~] for at ~r~stoppe~w~.", 3.0, 7)	
						if IsControlJustPressed(1, key) then
							local spiller = PlayerPedId()
							FreezeEntityPosition(spiller,false)
							ClearPedTasksImmediately(spiller)
							farm = false
						end	
				end
			-- aluFARM
			elseif GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), alu1.x, alu1.y, alu1.z, true ) < 3 then
				if farm == false then 
					DrawText3Ds(alu1.x,alu1.y,alu1.z+0.4, "~w~Tryk [~g~E~w~] for at ~g~arbejde~w~.", 3.0, 7)	
						if IsControlJustPressed(1, key) then
							local spiller = PlayerPedId()
							TaskStartScenarioInPlace(spiller, "WORLD_HUMAN_CONST_DRILL")
							FreezeEntityPosition(spiller,true)	
							farm = true
						end	
				else 
					DrawText3Ds(alu1.x,alu1.y,alu1.z+0.4, "~w~Tryk [~g~E~w~] for at ~r~stoppe~w~.", 3.0, 7)	
						if IsControlJustPressed(1, key) then
							local spiller = PlayerPedId()
							FreezeEntityPosition(spiller,false)
							ClearPedTasksImmediately(spiller)
							farm = false
						end	
				end
				-- aluFREM
			elseif GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), alu2.x, alu2.y, alu2.z, true ) < 3 then
				if farm == false then 
					DrawText3Ds(alu2.x,alu2.y,alu2.z+0.4, "~w~Tryk [~g~E~w~] for at ~g~arbejde~w~.", 3.0, 7)	
						if IsControlJustPressed(1, key) then
							local spiller = PlayerPedId()
							TaskStartScenarioInPlace(spiller, "PROP_HUMAN_PARKING_METER")
							FreezeEntityPosition(spiller,true)	
							farm = true
						end	
				else 
					DrawText3Ds(alu2.x,alu2.y,alu2.z+0.4, "~w~Tryk [~g~E~w~] for at ~r~stoppe~w~.", 3.0, 7)	
						if IsControlJustPressed(1, key) then
							local spiller = PlayerPedId()
							FreezeEntityPosition(spiller,false)
							ClearPedTasksImmediately(spiller)
							farm = false
						end	
				end
				-- aluSALG
			elseif GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), alu3.x, alu3.y, alu3.z, true ) < 3 then
				if farm == false then 
					DrawText3Ds(alu3.x,alu3.y,alu3.z+0.4, "~w~Tryk [~g~E~w~] for at ~g~arbejde~w~.", 3.0, 7)	
						if IsControlJustPressed(1, key) then
							local spiller = PlayerPedId()
							TaskStartScenarioInPlace(spiller, "WORLD_HUMAN_CLIPBOARD")
							FreezeEntityPosition(spiller,true)	
							farm = true
						end	
				else 
					DrawText3Ds(alu3.x,alu3.y,alu3.z+0.4, "~w~Tryk [~g~E~w~] for at ~r~stoppe~w~.", 3.0, 7)	
						if IsControlJustPressed(1, key) then
							local spiller = PlayerPedId()
							FreezeEntityPosition(spiller,false)
							ClearPedTasksImmediately(spiller)
							farm = false
						end	
				end
				-- Lav Frames
			elseif GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), wea1.x, wea1.y, wea1.z, true ) < 3 then
				DrawMarker(27, wea1.x, wea1.y, wea1.z - 0.95, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 1555, 0, 0,255, 0, 0, 0,0)
				if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), wea1.x, wea1.y, wea1.z, true ) < 1 then
					if farm == false then 
						DrawText3Ds(wea1.x,wea1.y,wea1.z+0.4, "~w~Tryk [~g~E~w~] for at ~g~arbejde~w~.", 3.0, 7)	
							if IsControlJustPressed(1, key) then
								local spiller = PlayerPedId()
								TaskStartScenarioInPlace(spiller, "PROP_HUMAN_PARKING_METER")
								FreezeEntityPosition(spiller,true)	
								farm = true
							end	
					else 
						DrawText3Ds(wea1.x,wea1.y,wea1.z+0.4, "~w~Tryk [~g~E~w~] for at ~r~stoppe~w~.", 3.0, 7)	
							if IsControlJustPressed(1, key) then
								local spiller = PlayerPedId()
								FreezeEntityPosition(spiller,false)
								ClearPedTasksImmediately(spiller)
								farm = false
							end	
					end
				end	
				-- Saml Frames
			elseif GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), wea2.x, wea2.y, wea2.z, true ) < 3 then
				DrawMarker(27, wea2.x, wea2.y, wea2.z - 0.95, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 1555, 0, 0,255, 0, 0, 0,0)
				if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), wea2.x, wea2.y, wea2.z, true ) < 1 then
					if farm == false then 
						DrawText3Ds(wea2.x,wea2.y,wea2.z+0.4, "~w~Tryk [~g~E~w~] for at ~g~arbejde~w~.", 3.0, 7)	
							if IsControlJustPressed(1, key) then
								local spiller = PlayerPedId()
								TaskStartScenarioInPlace(spiller, "PROP_HUMAN_PARKING_METER")
								FreezeEntityPosition(spiller,true)	
								farm = true
							end	
					else 
						DrawText3Ds(wea2.x,wea2.y,wea2.z+0.4, "~w~Tryk [~g~E~w~] for at ~r~stoppe~w~.", 3.0, 7)	
							if IsControlJustPressed(1, key) then
								local spiller = PlayerPedId()
								FreezeEntityPosition(spiller,false)
								ClearPedTasksImmediately(spiller)
								farm = false
							end	
					end
				end	
				-- saml våben
			elseif GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), wea3.x, wea3.y, wea3.z, true ) < 3 then
				DrawMarker(27, wea3.x, wea3.y, wea3.z - 0.95, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 1555, 0, 0,255, 0, 0, 0,0)
				if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), wea3.x, wea3.y, wea3.z, true ) < 1 then
					if farm == false then 
						DrawText3Ds(wea3.x,wea3.y,wea3.z+0.4, "~w~Tryk [~g~E~w~] for at ~g~arbejde~w~.", 3.0, 7)	
							if IsControlJustPressed(1, key) then
								local spiller = PlayerPedId()
								TaskStartScenarioInPlace(spiller, "PROP_HUMAN_PARKING_METER")
								FreezeEntityPosition(spiller,true)	
								farm = true
							end	
					else 
						DrawText3Ds(wea3.x,wea3.y,wea3.z+0.4, "~w~Tryk [~g~E~w~] for at ~r~stoppe~w~.", 3.0, 7)	
							if IsControlJustPressed(1, key) then
								local spiller = PlayerPedId()
								FreezeEntityPosition(spiller,false)
								ClearPedTasksImmediately(spiller)
								farm = false
							end	
					end
				end
					-- LAV SKUD
			elseif GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), wea4.x, wea4.y, wea4.z, true ) < 3 then
				DrawMarker(27, wea4.x, wea4.y, wea4.z - 0.95, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 1555, 0, 0,255, 0, 0, 0,0)
				if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), wea4.x, wea4.y, wea4.z, true ) < 1 then
					if farm == false then 
						DrawText3Ds(wea4.x,wea4.y,wea4.z+0.4, "~w~Tryk [~g~E~w~] for at ~g~arbejde~w~.", 3.0, 7)	
							if IsControlJustPressed(1, key) then
								local spiller = PlayerPedId()
								TaskStartScenarioInPlace(spiller, "PROP_HUMAN_PARKING_METER")
								FreezeEntityPosition(spiller,true)	
								farm = true
							end	
					else 
						DrawText3Ds(wea4.x,wea4.y,wea4.z+0.4, "~w~Tryk [~g~E~w~] for at ~r~stoppe~w~.", 3.0, 7)	
							if IsControlJustPressed(1, key) then
								local spiller = PlayerPedId()
								FreezeEntityPosition(spiller,false)
								ClearPedTasksImmediately(spiller)
								farm = false
							end	
					end
				end	
				-- saml våben
			elseif GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), wea6.x, wea6.y, wea6.z, true ) < 3 then
				DrawMarker(27, wea6.x, wea6.y, wea6.z - 0.95, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 1555, 0, 0,255, 0, 0, 0,0)
				if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), wea6.x, wea6.y, wea6.z, true ) < 1 then
					if farm == false then 
						DrawText3Ds(wea6.x,wea6.y,wea6.z+0.4, "~w~Tryk [~g~E~w~] for at ~g~arbejde~w~.", 3.0, 7)	
							if IsControlJustPressed(1, key) then
								local spiller = PlayerPedId()
								TaskStartScenarioInPlace(spiller, "PROP_HUMAN_PARKING_METER")
								FreezeEntityPosition(spiller,true)	
								farm = true
							end	
					else 
						DrawText3Ds(wea6.x,wea6.y,wea6.z+0.4, "~w~Tryk [~g~E~w~] for at ~r~stoppe~w~.", 3.0, 7)	
							if IsControlJustPressed(1, key) then
								local spiller = PlayerPedId()
								FreezeEntityPosition(spiller,false)
								ClearPedTasksImmediately(spiller)
								farm = false
							end	
					end
				end	
				-- KØB BARREL
			elseif GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), wea5.x, wea5.y, wea5.z, true ) < 5 then	
				DrawMarker(27, wea5.x, wea5.y, wea5.z - 0.95, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 1555, 0, 0,255, 0, 0, 0,0)
			end
		
	end
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
