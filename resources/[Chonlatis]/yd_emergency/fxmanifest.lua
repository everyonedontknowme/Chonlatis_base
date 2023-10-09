fx_version 'adamant'
game 'gta5'

author 'DIPSCode'

description 'DIPSCode Team - ESX - Agency Notification'

version '1.0'

ui_page 'view/ui.html'

client_scripts {
    '@es_extended/locale.lua',
    'client/client.lua',
    'config.lua'
}

server_scripts {
    '@es_extended/locale.lua',
    'server/server.lua',
}

files {
    'view/ui.html',
    'view/css/style.css',
    'view/js/app.js',
    'view/alert.mp3'
}

server_exports {
    'sendAlert'
}