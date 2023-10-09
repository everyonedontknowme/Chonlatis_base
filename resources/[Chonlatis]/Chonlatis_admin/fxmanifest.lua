fx_version 'cerulean'
games { 'gta5' }

author 'Script create by Chonlatis'
description 'Chonlatis script'
version '1.0.0'

ui_page 'dist/index.html'

client_scripts {
    'core/client.lua',
    'core/nui.lua',
    'config.lua'
}

server_script {
    'core/server.lua',
} 

files {
    'dist/index.html',
    'dist/css/*.css',
    'dist/js/*.js'
}