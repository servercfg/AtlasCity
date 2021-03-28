-------------------------------------------------------
-----------    Script converted by Flake		-----------
                ---   19/09/2019	---
   ---  Copyright 2019 Flake. All rights reserved	---
-------------------Discord:Flake#0845--------------------

dependency 'vrp'

client_scripts {
	'config.lua',
	'client/client.lua'
}

server_scripts {
  "@vrp/lib/utils.lua",
    '@mysql-async/lib/MySQL.lua',
	'config.lua',
	'server/server.lua'
}
