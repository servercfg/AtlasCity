vRPcc = {}
Tunnel.bindInterface("vrp_radio",vRPcc)
Proxy.addInterface("vrp_radio",vRPcc)
vRP = Proxy.getInterface("vRP")

function LocalPed()
  return GetPlayerPed(-1)
end

local radioMenu = false

function PrintChatMessage(text)
    TriggerEvent('chatMessage', "system", { 255, 0, 0 }, text)
end


function enableRadio(enable)

  SetNuiFocus(true, true)
  radioMenu = enable

  SendNUIMessage({

    type = "enableui",
    enable = enable

  })

end

RegisterNetEvent("ultimate15:radio_join")
AddEventHandler("ultimate15:radio_join", function()
               enableRadio(true)
               local ped = PlayerPedId()
               local radioModel = "prop_cs_hand_radio"
               dict = "cellphone@"
               anim = "cellphone_text_read_base"
               RequestAnimDict(dict)
               
               while not HasAnimDictLoaded(dict) do
                   Citizen.Wait(1)
               end
               TaskPlayAnim(ped, dict, anim, 3.0, -1, -1, 50, 0, false, false, false)
               radioProp = CreateObject(radioModel, 1.0, 1.0, 1.0, 1, 1, 0)
               local bone = GetPedBoneIndex(ped, 28422)
               AttachEntityToEntity(radioProp, ped, bone, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1, 1, 0, 0, 2, 1)
end, false)

RegisterCommand('radiotest', function(source, args)
  local playerName = GetPlayerName(PlayerId())
  local data = exports.tokovoip_script:getPlayerData(playerName, "radio:channel")

  print(tonumber(data))

  if data == "nil" then
    exports['mythic_notify']:DoHudText('inform', Config.messages['not_on_radio'])
  else
   exports['mythic_notify']:DoHudText('inform', Config.messages['on_radio'] .. data .. '.00 MHz </b>')
 end

end, false)

RegisterNUICallback('joinRadio', function(data, cb)
    local playerName = GetPlayerName(PlayerId())
    _G.playerNaemGlobal = playerName
    _G.rdata = data
    _G.rcb = cb
    local getPlayerRadioChannel = exports.tokovoip_script:getPlayerData(playerName, "radio:channel")
    local player = PlayerPedId()

    if tonumber(data.channel) ~= tonumber(getPlayerRadioChannel) then
        if tonumber(data.channel) <= Config.RestrictedChannels then
          print('before username: ' .. playerName)
          TriggerServerEvent('ls-radio:connectCop', player)
        end
        if tonumber(data.channel) > Config.RestrictedChannels then
          exports.tokovoip_script:removePlayerFromRadio(getPlayerRadioChannel)
          exports.tokovoip_script:setPlayerData(playerName, "radio:channel", tonumber(data.channel), true);
          exports.tokovoip_script:addPlayerToRadio(tonumber(data.channel))
          exports['mythic_notify']:DoHudText('inform', Config.messages['joined_to_radio'] .. data.channel .. '.00 MHz </b>')
        end
      else
        exports['mythic_notify']:DoHudText('error', Config.messages['you_on_radio'] .. data.channel .. '.00 MHz </b>')
      end
    cb('ok')
end)

RegisterNetEvent("ls-radio:copConnect")
AddEventHandler("ls-radio:copConnect", function()
  local playerName = _G.playerNaemGlobal
  data = _G.rdata
  cb = _G.rcb
  
  local getPlayerRadioChannel = exports.tokovoip_script:getPlayerData(playerName, "radio:channel")

  print ('Your player name is: ' .. playerName)

  exports.tokovoip_script:removePlayerFromRadio(getPlayerRadioChannel)
  exports.tokovoip_script:setPlayerData(playerName, "radio:channel", tonumber(data.channel), true);
  exports.tokovoip_script:addPlayerToRadio(tonumber(data.channel))
  exports['mythic_notify']:DoHudText('inform', Config.messages['joined_to_radio'] .. data.channel .. '.00 MHz </b>')
  cb('ok')
end)

RegisterNetEvent("ls-radio:notAllowedCop")
AddEventHandler("ls-radio:notAllowedCop", function()
  exports['mythic_notify']:DoHudText('error', Config.messages['restricted_channel_error'])
end)

RegisterNUICallback('leaveRadio', function(data, cb)
   local playerName = GetPlayerName(PlayerId())
   local getPlayerRadioChannel = exports.tokovoip_script:getPlayerData(playerName, "radio:channel")

    if getPlayerRadioChannel == "nil" then
      exports['mythic_notify']:DoHudText('inform', Config.messages['not_on_radio'])
        else
          exports.tokovoip_script:removePlayerFromRadio(getPlayerRadioChannel)
          exports.tokovoip_script:setPlayerData(playerName, "radio:channel", "nil", true)
          exports['mythic_notify']:DoHudText('inform', Config.messages['you_leave'] .. getPlayerRadioChannel .. '.00 MHz </b>')
    end

   cb('ok')
end)

RegisterNUICallback('escape', function(data, cb)

    enableRadio(false)
    SetNuiFocus(false, false)
    ClearPedSecondaryTask(PlayerPedId())
    DeleteObject(radioProp)
    DetachEntity(radioProp, true, false) 

    cb('ok')
end)

RegisterNetEvent('ls-radio:use')
AddEventHandler('ls-radio:use', function()
  enableRadio(true)
end)

RegisterNetEvent('ls-radio:onRadioDrop')
AddEventHandler('ls-radio:onRadioDrop', function(source)
  local playerName = GetPlayerName(source)
  local getPlayerRadioChannel = exports.tokovoip_script:getPlayerData(playerName, "radio:channel")


  if getPlayerRadioChannel ~= "nil" then

    exports.tokovoip_script:removePlayerFromRadio(getPlayerRadioChannel)
    exports.tokovoip_script:setPlayerData(playerName, "radio:channel", "nil", true)
    exports['mythic_notify']:DoHudText('inform', Config.messages['you_leave'] .. getPlayerRadioChannel .. '.00 MHz </b>')

  end
end)

Citizen.CreateThread(function()
    while true do
        if radioMenu then
            DisableControlAction(0, 1, guiEnabled) -- LookLeftRight
            DisableControlAction(0, 2, guiEnabled) -- LookUpDown

            DisableControlAction(0, 142, guiEnabled) -- MeleeAttackAlternate

            DisableControlAction(0, 106, guiEnabled) -- VehicleMouseControlOverride

            if IsDisabledControlJustReleased(0, 142) then -- MeleeAttackAlternate
                SendNUIMessage({
                    type = "click"
                })
            end
        end
        Citizen.Wait(0)
    end
end)