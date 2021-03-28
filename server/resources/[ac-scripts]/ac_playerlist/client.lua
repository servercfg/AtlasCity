vRPsb = {}
Tunnel.bindInterface("ac_playerlist1",vRPsb)
users = {}
isEmergency = false
playerBlips = {}

function getUsers()
    return users
end

RegisterNetEvent("hp:playerlist")
AddEventHandler("hp:playerlist", function(user_id,data)
  local source, name, job, hbvip = table.unpack(data)
  if user_id ~= nil then
    if source ~= nil and name ~= nil then
      users[tonumber(user_id)] = { source = tonumber(source), name = tostring(name), job = tostring(job), hbvip = tostring(hbvip) }
      if PlayerId() == GetPlayerFromServerId(tonumber(source)) then
        if tostring(job) == "Politi-Job" or tostring(job) == "EMS-Job" or tostring(job) == "PET" or tostring(job) == "Falck Vagt" or tostring(job) == "EMS" then
          isEmergency = true
        else
          isEmergency = false
        end
      end
    else
      users[tonumber(user_id)] = nil
    end
  end
end)



function DrawText3D(x,y,z,text)
  local onScreen,_x,_y=World3dToScreen2d(x,y,z)
  local px,py,pz=table.unpack(GetGameplayCamCoords())
  local dist = GetDistanceBetweenCoords(px,py,pz,x,y,z,1)

  local scale = (1/dist)*2
  local fov = (1/GetGameplayCamFov())*100
  local scale = scale*fov

  if onScreen then
    SetTextScale(0.0*scale, 0.45*scale)
    SetTextFont(0)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 255)
    SetTextDropshadow(0, 0, 0, 0, 255)
    SetTextEdge(2, 0, 0, 0, 150)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
  end
end

function updatePlayerBlip(id,ped,idtype,idcolor,text)
  if not DoesBlipExist(playerBlips[id]) then
    playerBlips[id] = AddBlipForEntity(ped)
    SetBlipSprite(playerBlips[id], idtype)
    SetBlipAsShortRange(playerBlips[id], true)
    SetBlipColour(playerBlips[id],idcolor)
    ShowHeadingIndicatorOnBlip(playerBlips[id], true)
    SetBlipScale(playerBlips[id],0.8)
    if text ~= nil and text ~= '' then
      BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(text)
      EndTextCommandSetBlipName(playerBlips[id])
    end
  end
end

Citizen.CreateThread(function()
  listOn = false
  while true do
    Citizen.Wait(1)
    if IsControlPressed(0, 121) then
      if not listOn then
        local players = {}
        local playersOn = 0
        --local playerCount = 0
		    local secondCounter = 0
		    local police = 0
        local ems = 0
        local lawyer = 0
        local mechanic = 0
        local taxi = 0
        local ejen = 0
		    local jour = 0

        local policeStatus = "❌"
        local emsStatus = "❌"
        local lawyerStatus = "❌"
        local mechanicStatus = "❌"
        local taxiStatus = "❌"
        local ejenStatus = "❌"
        local jourStatus = "❌"

        for k, v in pairs(users) do
		      if k ~= nil and v.source ~= nil and v.name ~= nil and NetworkIsPlayerActive(GetPlayerFromServerId(v.source)) then
			  playersOn = playersOn+1
			  if v.job == "Politi-Job" then
				police = police+1

        if(police >= 1) then
          policeStatus = "✔️"
        end
			  elseif v.job == "EMS-Job" then
				ems = ems+1

        if(ems >= 1) then
          emsStatus = "✔️"
        end
			  elseif v.job == "EMS-Jobelev" then
				ems = ems+1

        if(ems >= 1) then
          emsStatus = "✔️"
        end
			  elseif v.job == "Advokat" then
				lawyer = lawyer+1

        if(lawyer >= 1) then
          lawyerStatus = "✔️"
        end
			  elseif v.job == "Dommer" then
        lawyer = lawyer+1

        if(lawyer >= 1) then
          lawyerStatus = "✔️"
        end
			  elseif v.job == "Journalist" then
				jour = jour+1

        if(jour >= 1) then
          jourStatus = "✔️"
        end
			  elseif v.job == "Mekaniker" then
				mechanic = mechanic+1

        if(mechanic >= 1) then
          mechanicStatus = "✔️"
        end
      elseif v.job == "Autohjørnet" then
				mechanic = mechanic+1

        if(mechanic >= 1) then
          mechanicStatus = "✔️"
        end
			  elseif v.job == "Taxi Chauffør" then
				taxi = taxi+1

        if(taxi >= 1) then
          taxiStatus = "✔️"
        end
			  elseif v.job == "Ejendom" then
			    ejen = ejen+1
          
          if(ejen >= 1) then
            ejenStatus = "✔️"
          end
			  end
			  TriggerEvent('kaz:sendpolice', police)
			  TriggerEvent('kaz:sendems', ems)
		  end
        end


    table.insert(players,'<tr class="online"><td class="text"><div align="center">ONLINE '..playersOn..'/64 </div></td><td class="bluebartext"></td></tr>')
    table.insert(players,'<tr class="redbar"><td class="bluebartext"><div align="center">🚓 Betjente - '..policeStatus.. ' </div></td><td class="bluebartext"></td></tr>')
    table.insert(players,'<tr class="bluebar"><td class="bluebartext"><div align="center">🚑 Læger - '..emsStatus.. ' </div></td><td class="bluebartext"></td></tr>')
    table.insert(players,'<tr class="redbar"><td class="bluebartext"><div align="center">💼 Advokater - '..lawyerStatus..' </div></td><td class="bluebartext"></td></tr>')
    --table.insert(players,'<tr class="bluebar"><td class="bluebartext"><div align="center">📷 Journalister - '..jourStatus..'</div></td><td class="bluebartext"></td></tr>')
    table.insert(players,'<tr class="bluebar"><td class="bluebartext"><div align="center">🔧 Mekanikere - '..mechanicStatus..' </div></td><td class="bluebartext"></td></tr>')
    table.insert(players,'<tr class="redbar"><td class="bluebartext"><div align="center">🚖 Taxachauffører - '..taxiStatus..'</div></td><td class="bluebartext"></td></tr>')

        SendNUIMessage({text = table.concat(players)})
        listOn = true
        while listOn do
          Citizen.Wait(0)
          if(IsControlPressed(0, 121) == false) then
            listOn = false
            SendNUIMessage({meta = 'close'})
            break
          end
        end
      end
    end
  end
end)


Citizen.CreateThread(function()
  while true do
    Citizen.Wait(10000)
    for i=0,255 do
      RemoveMpGamerTag(i)
    end
    if isEmergency == true then
      for k, v in pairs(users) do
        if v.source ~= nil and NetworkIsPlayerActive(GetPlayerFromServerId(v.source)) then
          if isEmergency and v.job == "Politi-Job" and GetPlayerPed(-1) ~= GetPlayerPed(GetPlayerFromServerId(v.source)) then
            updatePlayerBlip(k,GetPlayerPed(GetPlayerFromServerId(v.source)),1,29,tostring(v.name).. " | Politi")
          elseif isEmergency and v.job == "AKS" and GetPlayerPed(-1) ~= GetPlayerPed(GetPlayerFromServerId(v.source)) then
            updatePlayerBlip(k,GetPlayerPed(GetPlayerFromServerId(v.source)),1,35,tostring(v.name).. " | AKS")
          elseif isEmergency and v.job == "Elev" and GetPlayerPed(-1) ~= GetPlayerPed(GetPlayerFromServerId(v.source)) then
            updatePlayerBlip(k,GetPlayerPed(GetPlayerFromServerId(v.source)),1,18,tostring(v.name).. " | ELEV")
          elseif isEmergency and v.job == "EMS-Jobelev" and GetPlayerPed(-1) ~= GetPlayerPed(GetPlayerFromServerId(v.source)) then
            updatePlayerBlip(k,GetPlayerPed(GetPlayerFromServerId(v.source)),1,18,tostring(v.name).. " | EMS-ELEV")
          elseif isEmergency and v.job == "EMS-Job" and GetPlayerPed(-1) ~= GetPlayerPed(GetPlayerFromServerId(v.source)) then
            updatePlayerBlip(k,GetPlayerPed(GetPlayerFromServerId(v.source)),1,69,tostring(v.name).. " | EMS")
          elseif isEmergency and v.job == "Falck Vagt" and GetPlayerPed(-1) ~= GetPlayerPed(GetPlayerFromServerId(v.source)) then
            updatePlayerBlip(k,GetPlayerPed(GetPlayerFromServerId(v.source)),1,69,tostring(v.name).. " | FALCK")
          else
            if DoesBlipExist(playerBlips[k]) then RemoveBlip(playerBlips[k]) end
              playerBlips[k] = nil
            end
        else
          if DoesBlipExist(playerBlips[k]) then RemoveBlip(playerBlips[k]) end
          playerBlips[k] = nil
        end
      end
    end
  end
end)

Citizen.CreateThread(function()
	while true do
    Citizen.Wait(0)
		for k, v in pairs(users) do
			if IsControlPressed(3,121) then
				if v.source ~= nil and NetworkIsPlayerActive(GetPlayerFromServerId(v.source)) then
					x2, y2, z2 = table.unpack(GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(v.source)),true))
					if GetPlayerPed(-1) ~= GetPlayerPed(GetPlayerFromServerId(v.source)) and IsEntityVisible(GetPlayerPed(GetPlayerFromServerId(v.source))) then
						DrawText3D(x2,y2,z2+1.25,k)
					end
				end
			end
			if NetworkIsPlayerTalking(GetPlayerFromServerId(v.source)) then
				x2, y2, z2 = table.unpack(GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(v.source)),true))
				if GetPlayerPed(-1) ~= GetPlayerPed(GetPlayerFromServerId(v.source)) and IsEntityVisible(GetPlayerPed(GetPlayerFromServerId(v.source))) then
					if v.hbvip == "true" then
						DrawMarker(27,x2, y2, z2 - 0.98, 0, 0, 0, 0, 0, 1, 1.0, 1.0, 10.3, 239, 255, 0 , 200 , 0, 0, 0, true)
					else
						DrawMarker(27,x2, y2, z2 - 0.98, 0, 0, 0, 0, 0, 1, 1.0, 1.0, 10.3, 55, 160, 205 , 200 , 0, 0, 0, true)
					end
				end
			end
		end
	end
end)
