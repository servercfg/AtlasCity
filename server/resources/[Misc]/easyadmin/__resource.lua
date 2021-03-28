resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"

server_scripts {
	'@vrp/lib/utils.lua',
	"util_shared.lua",
	"admin_server.lua",
}

client_scripts {
	"lib/Tunnel.lua",
	"lib/Proxy.lua",
	"dependencies/NativeUI.lua",
	"util_shared.lua",
	"admin_client.lua",
	"gui_c.lua",
}

convar_json "settings.json"