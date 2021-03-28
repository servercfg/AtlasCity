--==Connections==--
local Tunnel = module('vrp', 'lib/Tunnel')
local Proxy = module('vrp', 'lib/Proxy')

vRP = Proxy.getInterface('vRP')
--==============================--

--==Events==--
RegisterServerEvent('V1N:getUserData')
AddEventHandler('V1N:getUserData', function()
    local source = source
    local user_id = vRP.getUserId({source})
    local userMoney = vRP.getUserTmpTable({user_id})
    local walletAmount = userMoney.wallet
    local bankAmount = userMoney.bank
    local dirtymoneyAmount = vRP.getInventoryItemAmount({user_id, "dirty_money"})
    vRP.getUserIdentity({user_id, function(identity)
        nuserIdentity = ''..identity.firstname..' '..identity.name..' - '..identity.age..' år' 
        local data = {userIdentity = nuserIdentity, bank = bankAmount, wallet = walletAmount, dirtymoney = dirtymoneyAmount}
        TriggerClientEvent('V1N:setUserData', source, data)
    end})
end)
--==============================--
