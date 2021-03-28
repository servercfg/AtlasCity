function drawScreenText(x,y ,width,height,scale, text, outline, font, center)
    SetTextFont(8)
    SetTextProportional(0)
    SetTextScale(0.23, 0.23)
	SetTextColour(255 , 255, 255, 255 )
    --SetTextDropShadow(1, 1, 1, 1,255)
    SetTextEdge(1, 1, 1, 1, 255)
    --SetTextDropShadow()
	SetTextCentre(center)
	SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end

function CalculateDayOfWeekToDisplay()
	if dayOfWeek == 1 then
		dayOfWeek = "Duminica"
	elseif dayOfWeek == 2 then
		dayOfWeek = "Luni"
	elseif dayOfWeek == 3 then
		dayOfWeek = "Marti"
	elseif dayOfWeek == 4 then
		dayOfWeek = "Miercuri"
	elseif dayOfWeek == 5 then
		dayOfWeek = "Joi"
	elseif dayOfWeek == 6 then
		dayOfWeek = "Vineri"
	elseif dayOfWeek == 7 then
		dayOfWeek = "Sambata"
	end
end

function CalculateDateToDisplay()
	if month == 1 then
		month = "01"
	elseif month == 2 then
		month = "02"
	elseif month == 3 then
		month = "03"
	elseif month == 4 then
		month = "04"
	elseif month == 5 then
		month = "05"
	elseif month == 6 then
		month = "06"
	elseif month == 7 then
		month = "07"
	elseif month == 8 then
		month = "08"
	elseif month == 9 then
		month = "09"
	elseif month == 10 then
		month = "10"
	elseif month == 11 then
		month = "11"
	elseif month == 12 then
		month = "12"
	end
end

function CalculateTimeToDisplay()
	if hour < 10 then
		hour = tostring("0" .. hour)
	end
	if minute < 10 then
		minute = tostring("0" .. minute)
	end
end

Citizen.CreateThread(function()
	while true do
		Wait(1)		
			year, month, dayOfWeek, hour, minute = GetLocalTime()
			timeAndDateString = ""
			jucatori = #GetActivePlayers().." i byen"

			CalculateTimeToDisplay()
			timeAndDateString = timeAndDateString .. " " .. hour .. ":" .. minute.. " »"
			CalculateDateToDisplay()
			timeAndDateString = timeAndDateString .. " " .. dayOfWeek .. "/" .. month .. "/" .. year
			
			jucatori = "".. jucatori .. " "
			
			drawScreenText(0.50, 0.096, 0.0, 0.0, 0.23, timeAndDateString, 255, 255, 255, 255, 1, 7, 1)
			drawScreenText(0.50, 0.113, 0.0, 0.0, 0.23, jucatori, 255, 255, 255, 255, 1, 7, 1)
	end
end)