resource_manifest_version "77731fab-63ca-442c-a67b-abc70f28dfa5"

dependency "vrp"

server_scripts {
	"@vrp/lib/utils.lua",
	"ac_s.lua",
	"in_s.lua",
} 

client_scripts {
	"lib/Proxy.lua",
    "lib/Tunnel.lua",
    "lib/enum.lua",
	"ac_c.lua",
	"in_c.lua",
}
