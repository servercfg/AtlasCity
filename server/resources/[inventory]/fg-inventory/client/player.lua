local targetPlayer

-- Citizen.CreateThread(
--     function()
--         TriggerEvent(
--             "chat:addSuggestion",
--             "/openinventory",
--             _U("openinv_help"),
--             {
--                 {name = _U("openinv_id"), help = _U("openinv_help")}
--             }
--         )
--     end
-- )

AddEventHandler(
    "onResourceStop",
    function(resource)
        if resource == GetCurrentResourceName() then
            TriggerEvent("chat:removeSuggestion", "/openinventory")
        end
    end
)

RegisterNetEvent("fg-inventory:openPlayerInventory")
AddEventHandler("fg-inventory:openPlayerInventory", function(target, playerName)
    targetPlayer = target
    setPlayerInventoryData()
    openPlayerInventory()
end)

function refreshPlayerInventory()
    setPlayerInventoryData()
end

function setPlayerInventoryData()
    vrpPV.TriggerServerCallback("fg-inventory:server:getPlayerInventory", function(data)
        local inventory = data.inventory
        local items = {}
        if inventory ~= nil then
            for item_k, item_v in ipairs(inventory) do
                local usable = false
                local usableType = false
                if item_v.usableType ~= nil then
                    usable = true
                    usableType = item_v.usableType
                end
                items[#items + 1] = {
                    label = item_v.label,
                    name = item_v.name,
                    desc = item_v.desc,
                    limit = -1,
                    usable = usable,
                    usabletype = item_v.usableType,
                    choice = item_v.choice,
                    rare = 0,
                    canRemove = 1,
                    type = "item_standard",
                    count = item_v.amount,
                    weight = item_v.weight
                }
            end
        end
        SendNUIMessage({action = "setSecondInventoryItems", itemList = items})
    end, targetPlayer)
end

function openPlayerInventory()
    loadPlayerInventory()
    isInInventory = true

    SendNUIMessage(
        {
            action = "display",
            type = "player"
        }
    )

    SetNuiFocus(true, true)
end

RegisterNUICallback(
    "PutIntoPlayer",
    function(data, cb)
        if IsPedSittingInAnyVehicle(playerPed) then
            return
        end

        if type(data.number) == "number" and math.floor(data.number) == data.number then
            local count = tonumber(data.number)

            TriggerServerEvent("fg-inventory:PutIntoPlayer", targetPlayer, data.item.type, data.item.name, count)
        end

        Wait(250)
        refreshPlayerInventory()
        loadPlayerInventory()

        cb("ok")
    end
)

RegisterNUICallback(
    "TakeFromPlayer",
    function(data, cb)
        if IsPedSittingInAnyVehicle(playerPed) then
            return
        end

        if type(data.number) == "number" and math.floor(data.number) == data.number then
            local count = tonumber(data.number)

            TriggerServerEvent("fg-inventory:TakeFromPlayer", targetPlayer, data.item.type, data.item.name, count)
        end

        Wait(250)
        refreshPlayerInventory()
        loadPlayerInventory()

        cb("ok")
    end
)
