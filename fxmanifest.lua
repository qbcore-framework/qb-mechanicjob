fx_version 'cerulean'
game 'gta5'
lua54 'yes'
description 'QB-MechanicJob'
version '3.0.0'

files { "carcols_gen9.meta", "carmodcols_gen9.meta" }

data_file "CARCOLS_GEN9_FILE" "carcols_gen9.meta"
data_file "CARMODCOLS_GEN9_FILE" "carmodcols_gen9.meta"

shared_scripts {
    '@qb-core/shared/locale.lua',
    'locales/en.lua',
    'locales/*.lua',
    'config.lua',
}

client_scripts {
    'client/*.lua',
    '@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/CircleZone.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/main.lua'
}