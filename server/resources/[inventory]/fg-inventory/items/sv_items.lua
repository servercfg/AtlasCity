RegisterNetEvent("fg-inventory:joint")
AddEventHandler("fg-inventory:joint", function()
  local user_id = vRP.getUserId({source})
  count = 0
  repeat
    Citizen.Wait(1000)
    vRPclient.varyArmour(user_id,{1.5})
    count = count + 1
  until count == 5
  vRPclient.notify(user_id,{"Fuck det godt det her..."})
end)