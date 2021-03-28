dependency "vrp"

server_scripts {
    "@vrp/lib/utils.lua",
	"server/main.lua"	
}

client_scripts {
    "lib/Tunnel.lua",
    "lib/Proxy.lua",
	"config.lua",
	"client/main.lua"
}
