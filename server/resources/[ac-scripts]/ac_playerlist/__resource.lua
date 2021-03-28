resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'Playerlist'

ui_page 'html/scoreboard.html'

export "getUsers"

client_scripts {
	"lib/Proxy.lua",
	"lib/Tunnel.lua",
	"client.lua"
}

server_scripts {
	"@vrp/lib/utils.lua",
	"server.lua"
}

files {
	'html/scoreboard.html',
	'html/style.css',
	'html/logo.png',
	'html/reset.css',
	'html/listener.js'
}