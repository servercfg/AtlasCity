local a = module("vrp", "lib/Tunnel")
local b = module("vrp", "lib/Proxy")
RMySQL = module("vrp_mysql", "MySQL")
vRP = b.getInterface("vRP")
vRPclient = a.getInterface("vRP", "vrp_roveri")
vRPSmdc = {}
a.bindInterface("vrp_mdc", vRPSmdc)
b.addInterface("vrp_mdc", vRPSmdc)
vRPCliMDC = a.getInterface("vrp_mdc", "vrp_mdc")
math.randomseed(os.time())
RMySQL.createCommand("vRP/fetch_logs", "SELECT * FROM mdc_logs")
RMySQL.createCommand("vRP/get_incident", "SELECT * FROM mdc_incidents WHERE number = @number")
RMySQL.createCommand("vRP/get_all_incidents", "SELECT * FROM mdc_incidents")
RMySQL.createCommand("vRP/get_veh", "SELECT * FROM vrp_user_vehicles WHERE vehicle_plate = @plate")
RMySQL.createCommand(
    "vRP/get_car_details",
    "SELECT owner, incident, inspected FROM mdc_cardetails WHERE identifier = @identifier AND plate = @plate"
)
RMySQL.createCommand(
    "vRP/insert_car_detail",
    "INSERT INTO mdc_cardetails (plate, owner, inspected, identifier) VALUES (@plate, @owner, @inspected, @identifier)"
)
RMySQL.createCommand(
    "vRP/get_criminalrecord",
    "SELECT * FROM kr_criminalrecord WHERE dob = @dob AND identifier = @identifier"
)
RMySQL.createCommand("vRP/get_crime", "SELECT incident, crime FROM mdc_efterlysningar WHERE dob = @dob")
RMySQL.createCommand("vRP/remove_efterlysning", "DELETE FROM mdc_efterlysningar WHERE dob = @dob")
RMySQL.createCommand("vRP/remove_incident", "DELETE FROM mdc_incidents WHERE number = @number")
RMySQL.createCommand("vRP/get_id_criminalrecord", "SELECT identifier FROM kr_criminalrecord WHERE offense = @offense")
RMySQL.createCommand("vRP/get_all_criminalrecords", "SELECT * FROM kr_criminalrecord WHERE identifier = @identifier")
RMySQL.createCommand("vRP/remove_criminalrecord", "DELETE FROM kr_criminalrecord WHERE offense = @offense")
RMySQL.createCommand("vRP/remove_userinfo", "DELETE FROM kr_criminaluserinfo WHERE identifier = @identifier")
RMySQL.createCommand("vRP/insert_log", "INSERT INTO mdc_logs (type, remover, wanted) VALUES (@type, @remover, @wanted)")
RMySQL.createCommand("vRP/get_log", "SELECT pk,remover FROM mdc_logs WHERE type = @type AND remover = @user")
RMySQL.createCommand("vRP/upd_log", "UPDATE mdc_logs SET wanted = @time WHERE pk = @pk")
oMarkez.RegisterServerCallback(
    "vrp_mdc:save",
    function(c, d, e)
        RMySQL.query(
            "vRP/get_from_reg",
            {cpr = e.signedInUser},
            function(f, g)
                if #f > 0 then
                    local h = f[1].firstname .. " " .. f[1].name
                    local i = string.char(math.random(97, 122)) .. math.random(100, 9999)
                    if e.type == "incident" then
                        RMySQL.execute(
                            "vRP/insert_incident",
                            {number = i, text = e.text, uploader = h, date = os.date("%d/%m/%Y")}
                        )
                        d(i)
                    elseif e.type == "car" then
                        RMySQL.query(
                            "vRP/select_car",
                            {plate = e.plate},
                            function(f, g)
                                if #f > 0 then
                                    local j = {}
                                    local k = json.decode(f[1].incident)
                                    for l = 1, #k, 1 do
                                        table.insert(j, k[l])
                                    end
                                    table.insert(j, e.incident .. " (" .. os.date("%d/%m/%Y") .. ")")
                                    RMySQL.execute("vRP/update_cars", {incident = json.encode(j), plate = e.plate})
                                    d("updated")
                                end
                            end
                        )
                    elseif e.type == "efterlysning" then
                        RMySQL.execute(
                            "vRP/add_efterlysning",
                            {
                                wanted = e.wanted,
                                dob = e.lastdigits,
                                crime = e.crime,
                                uploader = h,
                                date = os.date("%d/%m/%Y"),
                                incident = e.incident
                            }
                        )
                    end
                else
                    print(
                        "Politi-Tablet Fejl - Kan ikke finde en person med dette CPR-Nummer: " ..
                            e.lastdigits
                    )
                end
            end
        )
    end
)

oMarkez.RegisterServerCallback(
    "vrp_mdc:fetch",
    function(c, d, e)
        if e.type == "efterlysning" then
            RMySQL.query(
                "vRP/fetch_efterlysninger",
                {},
                function(f, g)
                    if #f > 0 then
                        d(f)
                    else
                        d("error")
                    end
                end
            )
        elseif e.type == "logs" then
            RMySQL.query(
                "vRP/fetch_logs",
                {},
                function(f, g)
                    if #f > 0 then
                        d(f)
                    else
                        d("error")
                    end
                end
            )
        elseif e.type == "incident" then
            RMySQL.query(
                "vRP/get_incident",
                {number = e.number},
                function(f, g)
                    if #f > 0 then
                        d(f)
                    else
                        d("error")
                    end
                end
            )
        elseif e.type == "incidenter" then
            RMySQL.query(
                "vRP/get_all_incidents",
                {},
                function(f, g)
                    if #f > 0 then
                        d(f)
                    else
                        d("error")
                    end
                end
            )
        elseif e.type == "car" then
            local t = false
            RMySQL.query(
                "vRP/get_veh",
                {plate = e.plate},
                function(u, g)
                    if #u > 0 then
                        t = true
                        local v = u[1].user_id
                        if v then
                            vRP.getUserIdentity(
                                {
                                    v,
                                    function(w)
                                        if w then
                                            RMySQL.query(
                                                "vRP/get_car_details",
                                                {identifier = v, plate = e.plate},
                                                function(x, g)
                                                    if x[1] ~= nil then
                                                        local x = x
                                                        local y = {}
                                                        local z = json.decode(x[1].incident)
                                                        for l = 1, #z, 1 do
                                                            table.insert(y, z[l])
                                                        end
                                                        local A = {result = w, carDetails = x, carIncidents = y}
                                                        d(A)
                                                    else
                                                        RMySQL.execute(
                                                            "vRP/insert_car_detail",
                                                            {
                                                                plate = e.plate,
                                                                owner = w.firstname .. " " .. w.name,
                                                                inspected = "Ja",
                                                                identifier = v
                                                            }
                                                        )
                                                        d("rerun")
                                                    end
                                                end
                                            )
                                        end
                                    end
                                }
                            )
                        elseif not t then
                            d("error")
                        end
                    else
                        d("error")
                    end
                end
            )
        elseif e.type == "person" then
            local B
            local C
            local D
            RMySQL.query(
                "vRP/get_from_reg",
                {cpr = e.lastdigits},
                function(f, g)
                    if #f > 0 then
                        B = f
                        local v = f[1].user_id
                        if v then
                            RMySQL.query(
                                "vRP/get_criminalrecord",
                                {dob = f[1].registration, identifier = v},
                                function(E, g)
                                    if #E > 0 then
                                        C = E
                                    else
                                        C = nil
                                    end
                                    RMySQL.query(
                                        "vRP/get_crime",
                                        {dob = e.lastdigits},
                                        function(F, g)
                                            if #F > 0 then
                                                D = F
                                            else
                                                D = nil
                                            end
                                            local A = {result = B, brottsregister = C, efterlysningar = D}
                                            d(A)
                                        end
                                    )
                                end
                            )
                        end
                    else
                        d("error")
                    end
                end
            )
        end
    end
)
oMarkez.RegisterServerCallback(
    "mdc_remove",
    function(c, d, e)
        if e.type == "efterlysning" then
            RMySQL.execute("vRP/remove_efterlysning", {dob = e.dob})
        elseif e.type == "incident" then
            RMySQL.execute("vRP/remove_incident", {number = e.incident})
        elseif e.type == "brottsregister" then
            RMySQL.query(
                "vRP/get_id_criminalrecord",
                {offense = e.offense},
                function(G)
                    RMySQL.query(
                        "vRP/get_all_criminalrecords",
                        {identifier = G[1].identifier},
                        function(H, g)
                            if #H < 2 then
                                RMySQL.execute("vRP/remove_userinfo", {identifier = G[1].identifier})
                                RMySQL.execute("vRP/remove_criminalrecord", {offense = e.offense})
                            else
                                RMySQL.execute("vRP/remove_criminalrecord", {offense = e.offense})
                            end
                            d("ok")
                        end
                    )
                end
            )
        elseif e.type == "car" then
            RMySQL.query(
                "vRP/select_car",
                {plate = e.plate},
                function(B, g)
                    if B[1] ~= nil then
                        local j = {}
                        local k = json.decode(B[1].incident)
                        for l = 1, #k, 1 do
                            table.insert(j, k[l])
                        end
                        for l = 1, #j, 1 do
                            if j[l] == e.incident then
                                table.remove(j, l)
                            end
                        end
                        RMySQL.execute("vRP/update_cars", {incident = json.encode(j), plate = e.plate})
                        d("updated")
                    end
                end
            )
        end
        RMySQL.query(
            "vRP/get_from_reg",
            {cpr = e.signedin},
            function(B, g)
                if #B > 0 then
                    local I = B[1].firstname .. " " .. B[1].name
                    local J = " "
                    if e.type == "efterlysning" then
                        J = e.dob
                    elseif e.type == "incident" then
                        J = e.incident
                        e.type = "Hændelse"
                    elseif e.type == "brottsregister" then
                        J = e.dob
                        e.type = "Kriminelregister"
                    elseif e.type == "car" then
                        J = e.plate
                    end
                    RMySQL.execute("vRP/insert_log", {type = e.type, wanted = J, remover = I})
                end
            end
        )
        d("removed")
    end
)

RegisterCommand('tablet', function(source, args, rawCommand)
    local source = source
    local user_id = vRP.getUserId({source})
    if vRP.hasPermission({user_id,"police.pc"}) then 
        vRPclient.isHandcuffed(source,{}, function(handcuffed)
            if handcuffed then
                TriggerClientEvent("pNotify:SendNotification", source,{text = "Du er i strips/håndjern!",type = "error",timeout = (3000),layout = "centerRight",queue = "global",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})      
            else
                TriggerClientEvent("jabimo:polititablet", source)
            end
        end)
    else
        TriggerClientEvent("pNotify:SendNotification", source,{text = "Du har ikke adgang til Politi Ipaden!",type = "error",timeout = (3000),layout = "centerRight",queue = "global",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})  
    end
end)

RegisterCommand('ipad', function(source, args, rawCommand)
    local source = source
    local user_id = vRP.getUserId({source})
    if vRP.hasPermission({user_id,"police.pc"}) then 
        vRPclient.isHandcuffed(source,{}, function(handcuffed)
            if handcuffed then
                TriggerClientEvent("pNotify:SendNotification", source,{text = "Du er i strips/håndjern!",type = "error",timeout = (3000),layout = "centerRight",queue = "global",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})      
            else
                TriggerClientEvent("jabimo:polititablet", source)
            end
        end)
    else
        TriggerClientEvent("pNotify:SendNotification", source,{text = "Du har ikke adgang til Politi Ipaden!",type = "error",timeout = (3000),layout = "centerRight",queue = "global",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})  
    end
end)