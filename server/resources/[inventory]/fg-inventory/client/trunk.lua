AddEventHandler(
    "onResourceStop",
    function(resource)
        if resource == GetCurrentResourceName() then
            TriggerEvent("chat:removeSuggestion", "/openinventory")
        end
    end
)

RegisterNetEvent("fg-inventory:openTrunkInventory")
AddEventHandler("fg-inventory:openTrunkInventory", function()
    openTrunkInventory()
    setTrunkInventoryData()
end)

function refreshTrunkInventory()
    setTrunkInventoryData()
end

function setTrunkInventoryData()
    vrpPV.TriggerServerCallback("fg-inventory:server:getVehicleInventory", function(data)
        local inventory = data.inventory
        local items = {}
        if inventory ~= nil then
            for item_k, item_v in pairs(inventory) do
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
                    weight = item_v.weight,
                    plyweight = item_v.plyweight,
                    plymaxweight = item_v.plymaxweight
                }
            end
        end
        SendNUIMessage({action = "setSecondInventoryItems", itemList = items})
    end, GetPlayerServerId(PlayerId()))
end

function openTrunkInventory()
    loadPlayerInventory()
    isInInventory = true

    SendNUIMessage(
        {
            action = "display",
            type = "trunk"
        }
    )

    SetNuiFocus(true, true)
end

function setInfo(weight, maxweight,type)
    SendNUIMessage({
        action = "setSecondWeight", 
        text = "Weight: " ..string.format("%.2f", weight).. " / "..string.format("%.2f", maxweight)
    })

    SendNUIMessage(
        {
            action = "setTrunkInfoText",
            text = "Køretøj - "..type
        }
    )
end

RegisterNetEvent('fg-inventory:getTrunkWeight')
AddEventHandler('fg-inventory:getTrunkWeight', function(weight, maxweight,type)
    pweight = weight
    pmaxweight = maxweight
    ptype = type
    setInfo(weight, maxweight,type)
end)

RegisterNUICallback(
    "PutIntoTrunk",
    function(data, cb)
        if IsPedSittingInAnyVehicle(playerPed) then
            return
        end

        if type(data.number) == "number" and math.floor(data.number) == data.number then
            local count = tonumber(data.number)

            TriggerServerEvent("fg-inventory:PutIntoTrunk", data.item.type, data.item.name, count)
            --TriggerServerEvent("fg-inventory:TakeFromTrunk", data.item.type, data.item.name, count)
        end

        Wait(250)
        refreshTrunkInventory()
        loadPlayerInventory()

        cb("ok")
    end
)

RegisterNUICallback(
    "TakeFromTrunk",
    function(data, cb)
        if IsPedSittingInAnyVehicle(playerPed) then
            return
        end

        if type(data.number) == "number" and math.floor(data.number) == data.number then
            local count = tonumber(data.number)

            TriggerServerEvent("fg-inventory:TakeFromTrunk", data.item.type, data.item.name, count)
            --TriggerServerEvent("fg-inventory:PutIntoTrunk", data.item.type, data.item.name, count)
        end

        Wait(250)
        refreshTrunkInventory()
        loadPlayerInventory()

        cb("ok")
    end
)
