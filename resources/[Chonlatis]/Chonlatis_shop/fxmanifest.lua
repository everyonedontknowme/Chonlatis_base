fx_version 'cerulean'
games { 'gta5' }

author 'Chonlatis'
description 'Script create by @Chonlatis.'
version '0.0.1'

ui_page 'dist/index.html'

client_scripts {
    'core/client.lua',
    'config.lua'
}
server_script {
	'core/server.lua',
	'config.lua'
}

files {
	'dist/js/*.js',
	'dist/css/*.css',
	'dist/index.html'
}