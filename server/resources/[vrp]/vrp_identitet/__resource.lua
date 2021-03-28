ui_page "html/ui.html"

files {
    "html/ui.html",
    "html/ui.css",
    "html/ui.js",
    "html/job.png"
}

client_script "client.lua"

server_script {
    "@vrp/lib/utils.lua",
    "server.lua"
}