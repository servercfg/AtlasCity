--[[
  __  __           _            _                 _  __                         _____  
 |  \/  |         | |          | |               | |/ /                        |  __ \ 
 | \  / | __ _  __| | ___      | |__  _   _      | ' / __ _ ___ _ __   ___ _ __| |__) |
 | |\/| |/ _` |/ _` |/ _ \     | '_ \| | | |     |  < / _` / __| '_ \ / _ \ '__|  _  / 
 | |  | | (_| | (_| |  __/     | |_) | |_| |     | . \ (_| \__ \ |_) |  __/ |  | | \ \ 
 |_|  |_|\__,_|\__,_|\___|     |_.__/ \__, |     |_|\_\__,_|___/ .__/ \___|_|  |_|  \_\
                                       __/ |                   | |                     
                                      |___/                    |_|                     

  Author: Kasper Rasmussen
  Steam: https://steamcommunity.com/id/kasperrasmussen
]]

local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

MySQL = module("vrp_mysql", "MySQL")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "kasperr_car_trader")

MySQL.createCommand("vRP/kasperr_car_trader_get","SELECT * FROM kasperr_car_trader")
MySQL.createCommand("vRP/kasperr_car_trader_get_single","SELECT * FROM kasperr_car_trader WHERE id = @id")
MySQL.createCommand("vRP/kasperr_car_trader_add","INSERT INTO kasperr_car_trader SET title = @title, image = @image, user_id = @user_id, author_name = @author_name, author_phone = @author_phone")
MySQL.createCommand("vRP/kasperr_car_trader_delete","DELETE FROM kasperr_car_trader WHERE id = @id")

kasperr = nil

TriggerEvent('kasperr_base:getBaseObjects', function(obj) kasperr = obj end)

kasperr.RegisterServerCallback('kasperr_car_trader:getVehicles', function (source, cb, data)
    local user_id = vRP.getUserId({source})
    local _source = source
  
    MySQL.query("vRP/kasperr_car_trader_get", {}, function(result, affected)
        if #result > 0 then
            cb({
                user_id = user_id,
                data = result
            })
        else
            cb({
                user_id = user_id,
                data = {}
            })
        end
    end)
end)

kasperr.RegisterServerCallback('kasperr_car_trader:addVehicle', function (source, cb, data)
    local user_id = vRP.getUserId({source})
    local _source = source
    
    vRP.getUserIdentity({user_id, function(identity)
        if identity then
            MySQL.query("vRP/kasperr_car_trader_add", {
                title = data[1],
                image = data[2],
                user_id = user_id,
                author_name = identity.firstname .. " " .. identity.name,
                author_phone = identity.phone
            }, function(result, affected)
                cb(true)
            end)
        else
            cb(false)
        end
    end})
end)

kasperr.RegisterServerCallback('kasperr_car_trader:deleteVehicle', function (source, cb, data)
    local user_id = vRP.getUserId({source})
    local _source = source

    getVehicle(data, function(vehicle)
        if vehicle ~= nil and vehicle.user_id == user_id then
            MySQL.query("vRP/kasperr_car_trader_delete", {id = vehicle.id}, function(result, affected)
                cb(true)
            end)
        else 
            cb(false)
        end
    end)
end)

function getVehicle(data, cb)
    MySQL.query("vRP/kasperr_car_trader_get_single", {id = data}, function(result, affected)
        if result[1] ~= nil then
            cb(result[1])
        else
            cb(nil)
        end
    end)
end