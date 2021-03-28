models = {}


RegisterServerEvent("clothes:spawn")
AddEventHandler("clothes:spawn",function()
	local source = source
	local identifier = getID("steam",source)
	TriggerClientEvent("clothes:spawn", source, models[identifier])
end)

RegisterServerEvent("clothes:loaded")
AddEventHandler("clothes:loaded",function()
	-- Give weapons etc
end)

RegisterServerEvent("clothes:save")
AddEventHandler("clothes:save",function(player_data)
	local source = source
	local identifier = getID("steam",source)
	models[identifier] = player_data
	--saveModels()
	-- Give weapons etc
end)

function loadModels()
    models = LoadResourceFile(GetCurrentResourceName(), "models.txt") or "[]"
    models = json.decode(models)
end

function saveModels()
	--SaveResourceFile(GetCurrentResourceName(), "models.txt", json.encode(models), -1)
end

function getID(type, source)
    for k,v in ipairs(GetPlayerIdentifiers(source)) do
        if string.sub(tostring(v), 1, string.len("steam:")) == "steam:" and (type == "steam" or type == 1) then
            return v
        elseif string.sub(tostring(v), 1, string.len("license:")) == "license:" and (type == "license" or type == 2) then
            return v
        elseif string.sub(tostring(v), 1, string.len("ip:")) == "ip:" and (type == "ip" or type == 3) then
            return v
        end
    end
    return nil
end

loadModels()