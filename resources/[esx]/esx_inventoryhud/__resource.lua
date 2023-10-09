resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"

description "ESX Inventory HUD"

version "1.1"

ui_page "html/ui.html"

client_scripts {
	"@es_extended/locale.lua",
	"config.lua",
	"client/*.lua",
	-- "client/main.lua",
	-- "client/trunk.lua",
	-- "client/property.lua",
	-- "client/player.lua",
	"locales/en.lua",
}

server_scripts {
	"@mysql-async/lib/MySQL.lua",
	"@es_extended/locale.lua",
	"config.lua",
	"server/main.lua",
	"locales/en.lua",
}

files {
	"html/ui.html",
	"html/css/ui.css",
	"html/css/scotty.css",
	"html/css/jquery-ui.css",
	"html/css/bootstrap.min.css",
	"html/js/inventory.js",
	"html/js/config.js",
	"html/js/scotty.js",
	"html/fonts/osifont.ttf",
	-- JS LOCALES
	-- "html/locales/cs.js",
	"html/locales/en.js",
	-- "html/locales/fr.js",
	-- IMAGES
	'html/img/logo.png',
	'html/img/logo.gif',
	'html/img/bullet.png',
	'html/img/items/knife_pig.png',
	-- 'html/img/items/*.gif',
	'html/img/items/*.png',
    -- ICONS
}

