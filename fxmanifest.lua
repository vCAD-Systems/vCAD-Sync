fx_version 'bodacious'
game 'gta5'

name 'vCAD Sync - ESX Version'
author 'Mîhó'
version '1.0'

client_scripts {
    'config/*.lua',
    'client/*.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'config/*.lua',
    'server/*.lua'
}