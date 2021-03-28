--[[
────────────────────────────────────────────────
─███████╗███╗───██╗ ██████╗ ██╗────██╗██╗───██╗─  
─╚══███╔╝████╗──██║██╔═══██╗██║────██║╚██╗─██╔╝─  
───███╔╝─██╔██╗─██║██║───██║██║─█╗─██║─╚████╔╝──   
──███╔╝──██║╚██╗██║██║───██║██║███╗██║──╚██╔╝───    
─███████╗██║─╚████║╚██████╔╝╚███╔███╔╝───██║────     
─╚══════╝╚═╝──╚═══╝─╚═════╝──╚══╝╚══╝────╚═╝────     
────────────────────────────────────────────────
]]-- 

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","znowy_mechtire")

RegisterNetEvent("znowy_mechtire:perm2")
AddEventHandler("znowy_mechtire:perm2", function()
  TriggerServerEvent("znowy_mechtire:perm")
end)

RegisterNetEvent("znowy_mechtire:function")
AddEventHandler("znowy_mechtire:function", function()
  exports['ac_progressbar']:startUI(10000, "Skifter dæk")
  RequestAnimDict('anim@amb@clubhouse@tutorial@bkr_tut_ig3@')
    while not HasAnimDictLoaded('anim@amb@clubhouse@tutorial@bkr_tut_ig3@') do
    Citizen.Wait(0)
  end
  TaskPlayAnim(GetPlayerPed(-1), 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@' , 'machinic_loop_mechandplayer' ,8.0, -8.0, -1, 1, 0, false, false, false )	
  tyre = CreateObject(GetHashKey("prop_rub_tyre_01"), 0, 0, 0, true, true, true)
  AttachEntityToEntity(tyre, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.18, -0.02, -0.02, 350.0, 100.00, 140.0, true, true, false, true, 1, true)	
  Wait(10000)	
      local ped = PlayerPedId()
      local pos = GetEntityCoords(PlayerPedId())
      local vehicle = GetClosestVehicle(pos.x, pos.y, pos.z, 3.000, 0, 70)
      SetVehicleTyreFixed(vehicle, 0)
      SetVehicleTyreFixed(vehicle, 1)
      SetVehicleTyreFixed(vehicle, 2)
      SetVehicleTyreFixed(vehicle, 3)
      SetVehicleTyreFixed(vehicle, 4)
      SetVehicleTyreFixed(vehicle, 5)
      ClearPedTasks(ped)
      DeleteObject(tyre)
end)
-----------------------------------------------------
--                    FUNCTIONS                    --
-----------------------------------------------------  

function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
  end