--------------------------------------------------------------------------------------------
------- Created by OGKUSH#2625  - Made for AltasCity FiveM - Owned by Olsen1157#5852 -------
--------------------------------------------------------------------------------------------

local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "ac-watertank")

acWT.RegisterServerCallback("ac-watertank:validatePurchase", function(source, callback)
	local user_id = vRP.getUserId({source})
	local money 
	if user_id then
		if vRP.getMoney({user_id}) >= Config.WaterPrice then

		vRP.tryPayment({user_id,Config.WaterPrice})

			callback(true)
		else
			callback(false)
		end
	else
		callback(false)
	end
end)

RegisterServerEvent('vRP-thirst:setThirst')
AddEventHandler('vRP-thirst:setThirst', function()
	local user_id = vRP.getUserId({source})
	local thirst = vRP.getThirst({user_id})
		Citizen.Wait(3000)
		vRP.setThirst({user_id, thirst - 10})
		--vRP.varyThirst(user_id, thirst + 10)
    end)