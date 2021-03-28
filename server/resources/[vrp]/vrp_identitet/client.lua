-------------------------------------
------- MADE BY OGKUSH#2526 ---------
-------------------------------------

local keybind = 246 -- Y kan ændres på https://docs.fivem.net/docs/game-references/controls/

RegisterNetEvent("vrp_identitet:open:c")
AddEventHandler("vrp_identitet:open:c", function(money,bank,id,job)
    SendNUIMessage({
        show = true,
        money = money,
        bank = bank,
        id = id,
        job = job
    })
end)


Citizen.CreateThread( function()
	while true do
        Citizen.Wait(1)
        if IsControlJustPressed(1, keybind) then 
            toggle1()
		end
	end
end)


local on = false
function toggle()
    on = not on
    if (on) then
        TriggerServerEvent("vrp_identitet:open")
    else
        SendNUIMessage({
            show = false
        })
    end
end


function toggle1()
    toggle()
end