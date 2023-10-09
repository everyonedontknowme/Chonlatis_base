fx_version 'cerulean'
games { 'gta5' }

author 'Script create by Chonlatis'
description 'Chonlatis notify'
version '1.0.0'

ui_page 'dist/index.html'

client_scripts {
    'core/client.lua',
}

files {
    'dist/js/*.js',
    'dist/css/*.css',
    'dist/index.html'
}

exports {
    'MsgNotification'
}