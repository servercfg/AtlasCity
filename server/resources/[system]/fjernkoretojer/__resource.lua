--__  __           _        ____          _____                 _            
--|  \/  |         | |      |  _ \        |  __ \               | |           
--| \  / | __ _  __| | ___  | |_) |_   _  | |__) |__ _ _ __ ___ | | _____   __
--| |\/| |/ _` |/ _` |/ _ \ |  _ <| | | | |  _  // _` | '_ ` _ \| |/ _ \ \ / /
--| |  | | (_| | (_| |  __/ | |_) | |_| | | | \ \ (_| | | | | | | | (_) \ V / 
--|_|  |_|\__,_|\__,_|\___| |____/ \__, | |_|  \_\__,_|_| |_| |_|_|\___/ \_/  
--                                  __/ |                                     
--                                 |___/                                     



dependency "vrp"

server_script {
    "@vrp/lib/utils.lua",
    'config.lua',
    'server/server.lua'
}
client_scripts {
    "lib/Proxy.lua",
    "lib/Tunnel.lua",
    'config.lua',
    'client/client.lua',
    'client/entityiter.lua'
}

