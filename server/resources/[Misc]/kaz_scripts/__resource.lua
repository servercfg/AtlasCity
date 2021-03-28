resource_manifest_version "77731fab-63ca-442c-a67b-abc70f28dfa5"

dependency "vrp"

client_script {
  "lib/Proxy.lua",
  "lib/Tunnel.lua",
  "kaz_carthief/client.lua",
  "kaz_gidsel/client.lua",
  "kaz_itemdrop/client.lua", 
  --"kaz_marker/cfg/marker.lua",
  --"kaz_marker/client.lua",
  "kaz_radar/client.lua",
  --"kaz_nightclub/client.lua",
  "kaz_hospital/client.lua",
}

server_script {
  "lib/Proxy.lua",
  "@vrp/lib/utils.lua",
  "kaz_carthief/server.lua",
  "kaz_gidsel/server.lua",
  "kaz_hospital/server.lua",
  "kaz_itemdrop/server.lua", 
  --"kaz_marker/cfg/marker.lua",
  "kaz_radar/server.lua",
  "kaz_wardrobe/server.lua",
}
