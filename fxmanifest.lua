fx_version 'cerulean'
game 'gta5'

author 'TuNombre'
description 'Script para crear tiendas en ESX'
version '1.0'

client_script 'client/main.lua'
server_script {'server/main.lua',
'@mysql-async/lib/MySQL.lua',

}

dependency 'oxmysql'
