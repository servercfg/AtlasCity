resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'vrp_lockpick'

version '1.0.0'

client_script {
	'main.lua'
}

server_script {
	"@vrp/lib/utils.lua"
	--'server.lua'
}

files {
	'background.png'
}
