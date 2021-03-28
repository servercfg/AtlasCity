-- Original Script & Idea from Jsfour @ https://github.com/jonassvensson4

resource_manifest_version "77731fab-63ca-442c-a67b-abc70f28dfa5"

server_script {
	'@vrp/lib/utils.lua',
	'lib/Proxy.lua',
	'server.lua'
}

client_script {
	'lib/Tunnel.lua',
	'lib/Proxy.lua',
	'config.lua',
	'client.lua'
}
