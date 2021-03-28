local markets = Config.markets
local market_types = Config.market_types

Citizen.CreateThread(function()
    while true do
        local name = GetCurrentResourceName() .. math.random(999)
        local shop = getCurrentZone(1.5)
        if IsInShopZone(1.5) then
            AddTextEntry(name, "Tryk"..' ~INPUT_CONTEXT~ ' .. 'for at åbne shoppen.')
            DisplayHelpTextThisFrame(name, false)
            local group = market_types[shop]
            local gcfg = group._config
            if IsControlPressed(0, Keys["E"]) then
                print(json.encode(gcfg))
                if gcfg.perm then
                    vrpPV.TriggerServerCallback("fg-inventory:havePerm", function(data)
                        if data then 
                            OpenShopInv(shop)
                            while IsControlPressed(0, Keys["E"]) do
                                Citizen.Wait(0)
                            end
                        else
                            print("ingen adgang")
                        end
                    end, gcfg.perm)
                else
                    OpenShopInv(shop)

                    while IsControlPressed(0, Keys["E"]) do
                        Citizen.Wait(0)
                    end
                end
            end
        end
        Citizen.Wait(65)
    end
end)

function OpenShopInv(shoptype)
    text = "Butik"
    data = {text = text}
    inventory = {}

    vrpPV.TriggerServerCallback("fg-inventory:getShopItems", function(shopInv)
        for i = 1, #shopInv, 1 do
            inventory[#inventory + 1] = shopInv[i]
        end
    end, shoptype)

    Citizen.Wait(300)
    openShopInventory(data, inventory)
end

function openShopInventory(data, inventory)
    loadPlayerInventory()
    isInInventory = true

    SendNUIMessage(
        {
            action = "display",
            type = "shop"
        }
    )

    SendNUIMessage(
        {
            action = "setInfoText",
            text = data.text
        }
    )
    SendNUIMessage(
        {
            action = "setShopInventoryItems",
            itemList = inventory
        }
    )

    SetNuiFocus(true, true)
end

RegisterNUICallback("TakeFromShop", function(data, cb)
    if IsPedSittingInAnyVehicle(playerPed) then
        return
    end

    if type(data.number) == "number" and math.floor(data.number) == data.number then
        TriggerServerEvent("fg-inventory:SellItemToPlayer", GetPlayerServerId(PlayerId()), data.item.type, data.item.name, tonumber(data.number))
    end

    Wait(150)
    loadPlayerInventory()

    cb("ok")
end)

function getCurrentZone(distance)
	for k,v in pairs(markets) do
        if #(GetEntityCoords(PlayerPedId()) - vector3(v[2],v[3],v[4])) < distance then
            return v[1]
        end
    end
    return "none"
end

function IsInShopZone(distance)
    if not (getCurrentZone(distance) == "none") then
        return true
    end
    return false
end
