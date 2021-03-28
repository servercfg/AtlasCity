
resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"

ui_page "client/html/ui.html"

files {
	"client/html/ui.html",
	"client/html/styles.css",
	"client/html/scripts.js",
	"client/configNui.js",
	"client/html/debounce.min.js",
	"client/html/sweetalert2.all.min.js",
}
client_scripts {
    'lib/Proxy.lua',
    'lib/Tunnel.lua',
    "config.lua",
    "client/main.lua",
}

server_scripts {
    "@vrp/lib/utils.lua",
    "config.lua",
    "server/main.lua",
}