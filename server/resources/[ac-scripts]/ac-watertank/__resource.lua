--------------------------------------------------------------------------------------------
------- Created by OGKUSH#2625  - Made for AltasCity FiveM - Owned by Olsen1157#5852 -------
--------------------------------------------------------------------------------------------

resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"

client_scripts {
	"@vrp/lib/utils.lua",
	"lib/Tunnel.lua",
	"lib/Proxy.lua",
	'serverCallbackLib/client.lua',
	"config.lua",
	"client/functions.lua",
	"client/main.lua"
}

server_scripts {
	"@vrp/lib/utils.lua",
	"lib/Tunnel.lua",
	"lib/Proxy.lua",
	'serverCallbackLib/server.lua',
	"config.lua",
	"server/main.lua"
}