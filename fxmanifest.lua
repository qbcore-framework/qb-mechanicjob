fx_version 'cerulean'
game 'gta5'

description 'QB-MechanicJob'
version '1.0.0'

shared_scripts { 
	'@qb-core/import.lua',
	'config.lua'
}

client_scripts {
	'client/main.lua',
	'client/gui.lua',
	'client/drivingdistance.lua'
}

server_script 'server/main.lua'

exports {
	'GetVehicleStatusList',
	'GetVehicleStatus',
	'SetVehicleStatus'
}
