fx_version 'bodacious'
game 'gta5'

name 'vCAD Sync - ESX Version'
author 'Mîhó'
version '1.0'

client_scripts {
    'configs/*.lua',
    'client/*.lua'
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'configs/*.lua',
    'server/*.lua',
}
