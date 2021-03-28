
--==Variables==--
local hudEnabled = cfg.hudEnabled -- Om den skal være på lige når man joiner.
local datawalletAmount = nil
local databankAmount = nil
local datadirtymoneyAmount = nil
local datauserIdentity = nil
--==============================--

--==Threads==--
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1*650)
        if hudEnabled then
            TriggerServerEvent('V1N:getUserData')
            Citizen.Wait(1*150)
            RegisterNetEvent('V1N:setUserData')
            AddEventHandler('V1N:setUserData', function(data)
                datas = data
            end)
            if datas then
                local datawalletAmount = datas.wallet
                local databankAmount = datas.bank
                local datadirtymoneyAmount = datas.dirtymoney
                local datauserIdentity = datas.userIdentity
                SendNUIMessage({
                    type = 'ui',
                    status = true,
                    walletAmount = ''..tostring(datawalletAmount)..'',
                    bankAmount = ''..tostring(databankAmount)..'',
                    dirtymoneyAmount = ''..tostring(datadirtymoneyAmount)..'',
                    userIdentityen = ''..tostring(datauserIdentity)..''
                })
            end
        end
    end
end)
--==============================--

--==Commands==--
RegisterCommand(cfg.commandName, function()
    if hudEnabled then
        hudEnabled = false
        SendNUIMessage({
            type = 'ui',
            status = false
        })
    else
        hudEnabled = true
    end
end)
--==============================--