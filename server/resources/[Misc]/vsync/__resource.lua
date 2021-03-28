resource_manifest_version "77731fab-63ca-442c-a67b-abc70f28dfa5"

dependency "vrp"

client_scripts {
	"@vrp/client/Tunnel.lua",
	"@vrp/client/Proxy.lua",
    'vs_client.lua',
}

server_scripts {
	"@vrp/lib/utils.lua",
    'vs_server.lua',
}
