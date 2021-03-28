vRPlyd = {}
Tunnel.bindInterface("vrp_lyd",vRPlyd)
vRPserver = Tunnel.getInterface("vRP","vrp_lyd")
VDserver = Tunnel.getInterface("vrp_lyd","vrp_lyd")
vRP = Proxy.getInterface("vRP")

local key = 316 -- https://wiki.fivem.net/wiki/Controls
local voice = 1

function vRPlyd.setTalkerProxity(distance)
	NetworkSetTalkerProximity(distance) -- set range
end

function drawRct(x,y,width,height,r,g,b,a)
   DrawRect(x + width/2, y + height/2, width, height, r, g, b, a)
end


Citizen.CreateThread(function()
 	while true do
 		Citizen.Wait(0)
 		if IsControlJustPressed(1, key) then 
 			voice = voice + 1
			if voice > 3 then voice = 1 end
			VDserver.setVoiceDisplay({false,voice})
 		end
 	end
end)

Citizen.CreateThread(function()
 	while true do
 		Citizen.Wait(250)
 		if IsControlPressed(0, 249) then 
			if voice == 1 then
				SendNUIMessage({ heal = 60	});
			elseif voice == 2 then
				SendNUIMessage({ heal = 100	});
			else 
				SendNUIMessage({ heal = 20 	});
			end
 		end
 	end
end)

Citizen.CreateThread(function()
	while true do 
		Citizen.Wait(250)
			if NetworkIsPlayerTalking(PlayerId()) then
				SendNUIMessage({talking = true})
			else
				SendNUIMessage({talking = false})
			end
	end
end)

Citizen.CreateThread(function()
 	while true do
 		Citizen.Wait(250)
 		
			if voice == 1 then
				
				SendNUIMessage({ heal = 60	});
			elseif voice == 2 then
				
				SendNUIMessage({ heal = 100	});
			else 
				
				SendNUIMessage({ heal = 20 	});
			end
 		
 	end
end)

Citizen.CreateThread(function()
    while true do

        Citizen.Wait(250)
        
        if not IsPauseMenuActive() then
        SendNUIMessage({
        	show = true,
            action = "open",
        })
    else 
    	SendNUIMessage({
    		show = false,
            action = "close",
        })
    end
end
end)
