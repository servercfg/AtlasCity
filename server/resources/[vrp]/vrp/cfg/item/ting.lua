local items = {}

-- Cigaret pakke Menu
local pakkeryge_choices = {}
pakkeryge_choices["> Tag cigaretter"] = {function(player,choice)
    local user_id = vRP.getUserId(player)
    if user_id ~= nil then
        if vRP.tryGetInventoryItem(user_id,"cigaretpakke",1) then
          vRP.giveInventoryItem(user_id,"cigaret",20,true)
            vRP.closeMenu(player)
        end
    end
end}

-- Hammer Menu
local hammer_choices = {}
hammer_choices["> Brug hammer"] = {function(player,choice)
    local user_id = vRP.getUserId(player)
    if user_id ~= nil then
        if vRP.tryGetInventoryItem(user_id,"hammer",1) then
            vRPclient.playAnim(player,{false,{task="WORLD_HUMAN_HAMMERING"},false})
            vRP.closeMenu(player)
        end
    end
end}

-- Kamera Menu
local kamera_choices = {}
kamera_choices["> Brug kamera"] = {function(player,choice)
    local user_id = vRP.getUserId(player)
    if user_id ~= nil then
        if vRP.tryGetInventoryItem(user_id,"kamera",1) then
            vRPclient.playAnim(player,{false,{task="WORLD_HUMAN_PAPARAZZI"},false})
            vRP.closeMenu(player)
        end
    end
end}

-- Fiskestang Menu
local fiske_choices = {}
fiske_choices["> Brug fiskestang"] = {function(player,choice)
    local user_id = vRP.getUserId(player)
    if user_id ~= nil then
        if vRP.tryGetInventoryItem(user_id,"fiskestang",1) then
            vRPclient.playAnim(player,{false,{task="WORLD_HUMAN_STAND_FISHING"},false})
            vRP.closeMenu(player)
        end
    end
end}

-- Guitar Menu
local guitar_choices = {}
guitar_choices["> Brug guitar"] = {function(player,choice)
    local user_id = vRP.getUserId(player)
    if user_id ~= nil then
        if vRP.tryGetInventoryItem(user_id,"guitar",1) then
            vRPclient.playAnim(player,{false,{task="WORLD_HUMAN_MUSICIAN"},false})
            vRP.closeMenu(player)
        end
    end
end}

-- Kort Menu
local kort_choices = {}
kort_choices["> Brug kort"] = {function(player,choice)
    local user_id = vRP.getUserId(player)
    if user_id ~= nil then
        if vRP.tryGetInventoryItem(user_id,"kort",1) then
            vRPclient.playAnim(player,{false,{task="WORLD_HUMAN_TOURIST_MAP"},false})
            vRP.closeMenu(player)
        end
    end
end}

local puzzlespil1_choices = {}
puzzlespil1_choices["> Udpak puzzlespil 1/4"] = {function(player,choice)
    local user_id = vRP.getUserId(player)
    if user_id ~= nil then
        if vRP.tryGetInventoryItem(user_id,"puzzlespil1",1) then
          vRP.giveInventoryItem(user_id,"puzzle_1",1,true)
          vRP.giveInventoryItem(user_id,"puzzle_2",1,true)
          vRP.giveInventoryItem(user_id,"puzzle_3",1,true)
          vRP.giveInventoryItem(user_id,"puzzle_4",1,true)
          vRP.giveInventoryItem(user_id,"puzzle_5",1,true)
          vRP.giveInventoryItem(user_id,"puzzle_6",1,true)
          vRP.giveInventoryItem(user_id,"puzzle_7",1,true)
            vRP.closeMenu(player)
        end
    end
end}

local puzzlespil2_choices = {}
puzzlespil2_choices["> Udpak puzzlespil 2/4"] = {function(player,choice)
    local user_id = vRP.getUserId(player)
    if user_id ~= nil then
        if vRP.tryGetInventoryItem(user_id,"puzzlespil2",1) then
          vRP.giveInventoryItem(user_id,"puzzle_1_2",1,true)
          vRP.giveInventoryItem(user_id,"puzzle_2_2",1,true)
          vRP.giveInventoryItem(user_id,"puzzle_3_2",1,true)
          vRP.giveInventoryItem(user_id,"puzzle_4_2",1,true)
          vRP.giveInventoryItem(user_id,"puzzle_5_2",1,true)
          vRP.giveInventoryItem(user_id,"puzzle_6_2",1,true)
          vRP.giveInventoryItem(user_id,"puzzle_7_2",1,true)
          vRP.giveInventoryItem(user_id,"puzzle_8_2",1,true)
            vRP.closeMenu(player)
        end
    end
end}

local puzzlespil3_choices = {}
puzzlespil3_choices["> Udpak puzzlespil 3/4"] = {function(player,choice)
    local user_id = vRP.getUserId(player)
    if user_id ~= nil then
        if vRP.tryGetInventoryItem(user_id,"puzzlespil3",1) then
          vRP.giveInventoryItem(user_id,"puzzle_1_3",1,true)
          vRP.giveInventoryItem(user_id,"puzzle_2_3",1,true)
          vRP.giveInventoryItem(user_id,"puzzle_3_3",1,true)
          vRP.giveInventoryItem(user_id,"puzzle_4_3",1,true)
          vRP.giveInventoryItem(user_id,"puzzle_5_3",1,true)
          vRP.giveInventoryItem(user_id,"puzzle_6_3",1,true)
          vRP.giveInventoryItem(user_id,"puzzle_7_3",1,true)
          vRP.giveInventoryItem(user_id,"puzzle_8_3",1,true)
            vRP.closeMenu(player)
        end
    end
end}

local puzzlespil4_choices = {}
puzzlespil4_choices["> Udpak puzzlespil 4/4"] = {function(player,choice)
    local user_id = vRP.getUserId(player)
    if user_id ~= nil then
        if vRP.tryGetInventoryItem(user_id,"puzzlespil4",1) then
          vRP.giveInventoryItem(user_id,"puzzle_1_4",1,true)
          vRP.giveInventoryItem(user_id,"puzzle_2_4",1,true)
          vRP.giveInventoryItem(user_id,"puzzle_3_4",1,true)
          vRP.giveInventoryItem(user_id,"puzzle_4_4",1,true)
          vRP.giveInventoryItem(user_id,"puzzle_5_4",1,true)
          vRP.giveInventoryItem(user_id,"puzzle_6_4",1,true)
          vRP.giveInventoryItem(user_id,"puzzle_7_4",1,true)
          vRP.giveInventoryItem(user_id,"puzzle_8_4",1,true)
            vRP.closeMenu(player)
        end
    end
end}

items["cigaretpakke"] = {"Prince Light","En vanedannende cigaretter",function(args) return pakkeryge_choices end,0.21}
items["hammer"] = {"Hammer","En håndværker hammer. Til fx. Tømrearbejde.",function(args) return hammer_choices end,0.4}
items["kamera"] = {"Kamera","Et godt kamera der tager gode billeder.",function(args) return kamera_choices end,0.2}
items["fiskestang"] = {"Fiskestang","En fiskestang til at fiske med.",function(args) return fiske_choices end,1,2}
items["guitar"] = {"Guitar","En guitar, giver du koncert?",function(args) return guitar_choices end,1}
items["kort"] = {"Kort","Kan du ikke finde vej?",function(args) return kort_choices end,0.1}
items["ol"] = {"Øl","En kold øl",function(args) return ol_choices end,0.25}


return items
