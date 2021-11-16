fx_version 'cerulean'
game 'gta5'

description 'QB-MechanicJob'
version '1.0.0'

shared_script 'config.lua'

client_scripts {
	'client/main.lua',
	'client/drivingdistance.lua'
}

server_script 'server/main.lua'

lua54 'yes'