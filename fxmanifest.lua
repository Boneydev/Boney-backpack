fx_version 'cerulean'
game 'gta5'

name 'Boney-backpack'
author 'Boney'
description 'Boney backpack with stash'
version '3.1.0'

lua54 'yes'

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua'
}

client_scripts {
    'client.lua'
}

server_scripts {
    'server.lua'
}