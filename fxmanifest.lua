fx_version "adamant"
game "gta5"
lua54 "yes"

author "ItsGisca"
description "JobCentre script | Gisco Development"

shared_scripts {
    "@es_extended/imports.lua",
    "@ox_lib/init.lua",
    "config.lua",
}

client_scripts {
    "@es_extended/locale.lua",
    "locales/*.lua",
    "scr/client/cl_main.lua",
    "scr/client/cl_functions.lua",
}

server_scripts {
    "@es_extended/locale.lua",
    "locales/*.lua",
    "scr/server/sv_main.lua",
    "scr/server/sv_logs.lua",
}