resource_manifest_version '05cfa83c-a124-4cfa-a768-c24a5811d8f9'

dependency "vrp"

server_script {
    "@vrp/lib/utils.lua",
    "lib/Proxy.lua",
    "server.lua"
}

client_script {
    "lib/Proxy.lua",
    "lib/Tunnel.lua",
	"client.lua",
	"config.lua"
}