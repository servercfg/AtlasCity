local a=module("vrp","lib/Tunnel")
local b=module("vrp","lib/Proxy")
vRP=b.getInterface("vRP")
vRPclient=a.getInterface("vRP","fg-inventory")
local c=module("cfg/inventory")
vrpPV.RegisterServerCallback("fg-inventory:server:getPlayerInventory",function(d,e,f)
local g=vRP.getUserId({f})
local h=vRP.getInventoryWeight({g})
local i=vRP.getInventoryMaxWeight({g})
if g~=nil then
  local j=vRP.getUserDataTable({g})
  if j and j.inventory then
    local k={}for l,m in pairs(j.inventory)
    do for n,o in ipairs(Config.items)
      do if l==o.name then
        table.insert(k,{name=o.name,label=o.label,usableType=o.type,amount=m.amount,desc=o.description,weight=o.weight*m.amount,plyweight=h,plymaxweight=i,choice=o.choices})
      end
    end
  end
  TriggerClientEvent('fg-inventory:getWeight',d,h,i)
  e({inventory=k,plyid=g})
else
  e(nil)
end
end
end)
vrpPV.RegisterServerCallback("fg-inventory:server:getVehicleInventory",function(d,e)
    local g=vRP.getUserId({d})
    if g~=nil then
      vRPclient.getNearestOwnedVehicle(d,{10},function(p,q,r)
      local s="chest:u"..g.."veh_"..string.lower(r)
      vRP.getSData({s,function(t)
      local k={}
      local u=json.decode(t)or{}
      local h=vRP.computeItemsWeight({u})
      local i=c.vehicle_chest_weights[string.lower(r)]or c.default_vehicle_chest_weight
      for l,m in pairs(u)do
        for n,o in ipairs(Config.items)do
          if l==o.name then
            table.insert(k,{name=o.name,label=o.label,usableType=o.type,amount=m.amount,desc=o.description,weight=o.weight*m.amount,choice=o.choices})
          end
        end
      end
      TriggerClientEvent('fg-inventory:getTrunkWeight',d,h,i,r)
      e({inventory=k})
    end})
  end)
else
  e(nil)
end
end)
