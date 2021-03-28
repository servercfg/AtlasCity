resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

server_scripts {
    "@vrp/lib/utils.lua",
    "server.lua",
    "config.lua"
}

client_scripts {
	"lib/Tunnel.lua",
	"lib/Proxy.lua",
    "client.lua",
    "config.lua"
}

ui_page 'ui/index.html'

files {
	'ui/index.html',
	'ui/script.js',
	'ui/css/style.css',
	'ui/libraries/axios.min.js',
	'ui/libraries/vue.min.js',
	'ui/libraries/vuetify.css',
	'ui/libraries/vuetify.js',
}