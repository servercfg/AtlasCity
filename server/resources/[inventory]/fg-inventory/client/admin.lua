RegisterNetEvent("fg-inventory:openAdminInventory")
AddEventHandler("fg-inventory:openAdminInventory", function()
    OpenAdminInv("admin")
end)


function OpenAdminInv(shoptype)
    text = ""
    data = {text = text}
    inventory = {}

    vRP.TriggerServerCallback("fg-inventory:getAdminItems", function(adminInv)
        for i = 1, #adminInv, 1 do
            inventory[#inventory + 1] = adminInv[i]
        end
    end, shoptype)

    Citizen.Wait(500)
    openAdminInventory(data, inventory)
end

function openAdminInventory()
    loadPlayerInventory()
    isInInventory = true

    SendNUIMessage(
        {
            action = "display",
            type = "admin"
        }
    )

    SendNUIMessage(
        {
            action = "setAdminInventoryItems",
            itemList = inventory
        }
    )

    SetNuiFocus(true, true)
end


RegisterNUICallback("TakeFromAdmin", function(data, cb)
    if type(data.number) == "number" and math.floor(data.number) == data.number then
        TriggerServerEvent("fg-inventory:adminGiveItem", data.item.type, data.item.name, tonumber(data.number))
    end

    Wait(150)
    loadPlayerInventory()

    cb("ok")
end)