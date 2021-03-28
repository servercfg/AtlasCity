resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"

ui_page "html/ui.html"

client_scripts {
  "lib/Tunnel.lua",
  "lib/Proxy.lua",
  'serverCallbackLib/client.lua',
  "config.lua",
  "items/cl_items.lua",
  "client/*.lua"
}

server_scripts {
  "@vrp/lib/utils.lua",
  'serverCallbackLib/server.lua',
  "server/utils.lua",
  "config.lua",
  "items/sv_items.lua",
  "server/server.lua"
}

exports{
	'hasEnoughOfItem', -- Example: if exports["fg-inventory"]:hasEnoughOfItem("crack",1) then something
	'getQuantity' -- Return the amount of an specifik item: exports["fg-inventory"]:getQuantity("crack")
}

files {
  "html/ui.html",
  "html/css/ui.css",
  "html/css/jquery-ui.css",
  "html/js/inventory.js",
  -- IMAGES
  "html/img/added-item.png",
  "html/img/used-item.png",
  -- ICONS
  "html/img/items/*.png",
  
}
