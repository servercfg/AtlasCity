-- ATLAS ITEMDROP BY JustKaos and OGKUSH#2625

-- DESCRIPTION

When you drop items, then some items gets made into the props that they actually are.

    And if you drop money it changes depending on how much you drop.


If the item is not a prop, it will be put into a purse that will be put on the ground.


-- DROP UNDER THE DROP FUNCTION IN YOUR vrp_inventory or what you are using


-- FG-INVENTORY/server/server.lua/linje.32 så smid det her ind i linje 33
TriggerEvent("atlas-itemdrop:drop", player, item, amount)