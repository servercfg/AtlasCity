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

Menu = {}
Menu.GUI = {}
Menu.buttonCount = 0
Menu.selection = 0
Menu.hidden = true
MenuTitle = "Garage"
NewStatus = false

function Menu.addButton(name, func,args)

	local yoffset = 0.2645
	local xoffset = 0.2
	local xmin = 0.0
	local xmax = 0.3
	local ymin = 0.05
	local ymax = 0.05
	Menu.GUI[Menu.buttonCount+1] = {}
	Menu.GUI[Menu.buttonCount+1]["name"] = name
	Menu.GUI[Menu.buttonCount+1]["func"] = func
	Menu.GUI[Menu.buttonCount+1]["args"] = args
	Menu.GUI[Menu.buttonCount+1]["active"] = false
	Menu.GUI[Menu.buttonCount+1]["xmin"] = xoffset
	Menu.GUI[Menu.buttonCount+1]["ymin"] = ymin * (Menu.buttonCount + 0.01) +yoffset
	Menu.GUI[Menu.buttonCount+1]["xmax"] = 0.2
	Menu.GUI[Menu.buttonCount+1]["ymax"] = ymax 
	Menu.buttonCount = Menu.buttonCount+1
end

RegisterNetEvent('KazNewOpen')

AddEventHandler('KazNewOpen', function(NewStatus)
	if NewStatus == true then
		KazMenuAktiv = true
	else 
		KazMenuAktiv = false
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1) 
		if KazMenuAktiv == true then 
			if IsControlJustPressed(3, 173) then
				if(Menu.selection < Menu.buttonCount -1 ) then
					Menu.selection = Menu.selection +1
					if Menu.GUI[Menu.selection +1]["func"] == "OptionVehicle" then 
						TriggerServerEvent('KazGarage:LoadLocal', Menu.GUI[Menu.selection +1]["args"])
						exports['ac_progressbar']:startUI(500, "Klargører køretøj")
						Citizen.Wait(500)
					else
						TriggerEvent('KazGarage:RemoveShowcar')
					end
				else
					Menu.selection = 0
					if Menu.GUI[Menu.selection +1]["func"] == "OptionVehicle" then 
						TriggerServerEvent('KazGarage:LoadLocal', Menu.GUI[Menu.selection +1]["args"])
						exports['ac_progressbar']:startUI(500, "Klargører køretøj")
						Citizen.Wait(500)
					else
						TriggerEvent('KazGarage:RemoveShowcar')
					end
				end	
			elseif IsControlJustPressed(3, 172) then
				if(Menu.selection > 0)then
					Menu.selection = Menu.selection -1
					if Menu.GUI[Menu.selection +1]["func"] == "OptionVehicle" then 
						TriggerServerEvent('KazGarage:LoadLocal', Menu.GUI[Menu.selection +1]["args"])
						exports['ac_progressbar']:startUI(500, "Klargører køretøj")
						Citizen.Wait(500)
					else
						TriggerEvent('KazGarage:RemoveShowcar')
					end
				else
					Menu.selection = Menu.buttonCount-1
					if Menu.GUI[Menu.selection +1]["func"] == "OptionVehicle" then 
						TriggerServerEvent('KazGarage:LoadLocal', Menu.GUI[Menu.selection +1]["args"])
						exports['ac_progressbar']:startUI(500, "Klargører køretøj")
						Citizen.Wait(500)
					else
						TriggerEvent('KazGarage:RemoveShowcar')
					end
				end	
			elseif IsControlJustPressed(3, 176)  then
				MenuCallFunction(Menu.GUI[Menu.selection +1]["func"], Menu.GUI[Menu.selection +1]["args"])
				if Menu.GUI[Menu.selection +1]["func"] == "OptionVehicle" then 
						TriggerServerEvent('KazGarage:LoadLocal', Menu.GUI[Menu.selection +1]["args"])
						exports['ac_progressbar']:startUI(500, "Klargører køretøj")
						Citizen.Wait(500)
				else
					TriggerEvent('KazGarage:RemoveShowcar')
				end
				if Menu.GUI[Menu.selection +1]["func"] == "CloseMenu" then
					TriggerEvent('KazGarage:RemoveShowcar')
				end
			end
		end
	end
end)


function Menu.updateSelection() 
	local iterator = 0
	for id, settings in ipairs(Menu.GUI) do
		Menu.GUI[id]["active"] = false
		if(iterator == Menu.selection ) then
			Menu.GUI[iterator +1]["active"] = true
		end
		iterator = iterator +1
	end
end

function Menu.renderGUI()
	if not Menu.hidden then
		Menu.renderButtons()
		Menu.updateSelection()
	end
end

function Menu.renderBox(xMin,xMax,yMin,yMax,color1,color2,color3,color4)
	DrawRect(xMin, yMin,xMax, yMax, color1, color2, color3, color4);
end

function Menu.renderButtons()
	
local yoffset = 0.2
local xoffset = 0.2
	
		SetTextFont(4)
        SetTextScale(0.0, 0.5)
        SetTextColour(255, 255, 255, 200)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(1, 0, 0, 0, 255)
        SetTextDropShadow()
        SetTextOutline()
        SetTextCentre(true)

		SetTextProportional(0)
		SetTextEntry("STRING")
		
		AddTextComponentString(MenuTitle)
		DrawText(xoffset, yoffset)
		Menu.renderBox(xoffset,0.2,yoffset+0.015,0.05,0,0,0,200)
		
		
	for id, settings in pairs(Menu.GUI) do
		local screen_w = 0
		local screen_h = 0
		screen_w, screen_h =  GetScreenResolution(0, 0)
		
		if(settings["active"]) then
			boxColor = {255,255,255,50}
			SetTextColour(0, 0, 0, 255)
		else			
			boxColor = {0,0,0,150}
			SetTextColour(255, 255, 255, 255)	
		end
		SetTextFont(0)
		SetTextScale(0.0,0.35)
		SetTextCentre(true)
--		SetTextDropShadow(0, 0, 0, 0, 0)
		SetTextEdge(0, 0, 0, 0, 0)
		SetTextEntry("STRING") 
		AddTextComponentString(settings["name"])
		DrawText(settings["xmin"], (settings["ymin"] - 0.0125 )) 
		Menu.renderBox(settings["xmin"] ,settings["xmax"], settings["ymin"], settings["ymax"],boxColor[1],boxColor[2],boxColor[3],boxColor[4])
	 end
end

function ClearMenu()
	--Menu = {}
	Menu.GUI = {}
	Menu.buttonCount = 0
	Menu.selection = 0
end

function MenuCallFunction(fnc, arg)
	_G[fnc](arg)
end