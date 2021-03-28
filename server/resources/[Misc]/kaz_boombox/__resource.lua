resource_manifest_version "77731fab-63ca-442c-a67b-abc70f28dfa5"

client_script {
  'lib/Proxy.lua',
  'lib/Tunnel.lua',
  "client.lua",
  'config.lua'
}

server_script {
  'lib/Proxy.lua',
  '@vrp/lib/utils.lua',
  'server.lua',
  'config.lua'
}

ui_page('html/index.html')

files {
    'html/index.html',
    'html/app.js'
}