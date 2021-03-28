resource_manifest_version "77731fab-63ca-442c-a67b-abc70f28dfa5"

dependency "vrp"


client_script {
  "lib/Tunnel.lua",
  "lib/Proxy.lua",
  "client.lua", 
  "config.lua",
  "GUI.lua",
}

server_script {
  "@vrp/lib/utils.lua",
  "server.lua",
  "config.lua",
}

server_export 'updateGarage'