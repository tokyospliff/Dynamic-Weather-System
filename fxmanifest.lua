fx_version 'cerulean'
game 'gta5'

-- Author Signature
author 'tokyospliff'
description 'Dynamic Weather System with Advanced Effects and Farming Integration | GitHub: https://github.com/tokyospliff/dynamic-weather-system | License: MIT'
version '1.0.0'

-- Server scripts
server_scripts {
    'server/server.lua',
}

-- Client scripts
client_scripts {
    'client/client.lua',
    'farming/farming.lua',
}

-- UI files
ui_page 'ui/ui.html'

files {
    'ui/ui.html',
    'ui/style.css',
    'ui/script.js',
}