fx_version 'bodacious'
game 'gta5'

-- dependency 'vrp'

ui_page 'html/index.html'

server_scripts {
	'@vrp/lib/utils.lua',
	'@mysql-async/lib/MySQL.lua',
	'serverCallbackLib/server.lua',
	'server.lua'
}

client_scripts {
	"lib/Tunnel.lua",
	"lib/Proxy.lua",
	'serverCallbackLib/client.lua',
	'client.lua',
	'config.lua'
}

files {
	'html/assets/images/frame.png',
	'html/assets/images/user.png',
	'html/assets/images/background.png',
	'html/index.html',
	'html/assets/fonts/roboto/Roboto-Bold.woff',
	'html/assets/fonts/roboto/Roboto-Bold.woff2',
	'html/assets/fonts/roboto/Roboto-Light.woff',
	'html/assets/fonts/roboto/Roboto-Light.woff2',
	'html/assets/fonts/roboto/Roboto-Medium.woff',
	'html/assets/fonts/roboto/Roboto-Medium.woff2',
	'html/assets/fonts/roboto/Roboto-Regular.woff',
	'html/assets/fonts/roboto/Roboto-Regular.woff2',
	'html/assets/fonts/roboto/Roboto-Thin.woff',
	'html/assets/fonts/roboto/Roboto-Thin.woff2',
	'html/assets/css/materialize.min.css',
	'html/assets/css/style.css',
	'html/assets/js/jquery.js',
	'html/assets/js/materialize.js',
	'html/assets/js/passwords.js',
	'html/assets/js/regelverk.js',
	'html/assets/js/init.js',
}
