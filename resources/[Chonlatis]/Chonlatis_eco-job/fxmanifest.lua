fx_version 'cerulean'

games { 'gta5' }

author 'Chonlatis'

ui_page 'dist/index.html'

client_scripts {
    'core/client.lua',
    'core/process.lua',
    'config.lua',
}

server_scripts {
    'core/server.lua',
    'config.lua',
}

files {
    'dist/js/*.js',
    'dist/css/*.css',
    'dist/index.html'
}