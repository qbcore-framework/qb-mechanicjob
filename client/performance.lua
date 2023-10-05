local function GetArmor(vehicle)
    local armorMenu = {}
    for i=-1, GetNumVehicleMods(vehicle, 16) - 1 do
        local header = 'Armor Level: '..i
        if i == -1 then header = 'Armor Level: Stock' end
        if GetVehicleMod(vehicle, 16) == i then header = header..' (Installed)' end
        local armorItem = {
            header = header,
            txt = 'Install level '..i..' armor',
            icon = "fa-solid fa-wrench",
            params = {
                event = 'qb-mechanicjob:client:install',
                args = {
                    upgradeType = 'armor',
                    modType = 16,
                    upgradeIndex = i,
                    vehicle = vehicle
                }
            }
        }
        armorMenu[#armorMenu+1] = armorItem
    end
    exports['qb-menu']:openMenu(armorMenu, true)
end

local function GetBrakes(vehicle)
    local brakesMenu = {}
    for i=-1, GetNumVehicleMods(vehicle, 12) - 1 do
        local header = 'Brakes Level: '..i
        if i == -1 then header = 'Brakes Level: Stock' end
        if GetVehicleMod(vehicle, 12) == i then header = header..' (Installed)' end
        local brakesItem = {
            header = header,
            txt = 'Install level '..i..' brakes',
            icon = "fa-solid fa-wrench",
            params = {
                event = 'qb-mechanicjob:client:install',
                args = {
                    upgradeType = 'brakes',
                    modType = 12,
                    upgradeIndex = i,
                    vehicle = vehicle
                }
            }
        }
        brakesMenu[#brakesMenu+1] = brakesItem
    end
    exports['qb-menu']:openMenu(brakesMenu, true)
end

local function GetEngine(vehicle)
    local engineMenu = {}
    for i=-1, GetNumVehicleMods(vehicle, 11) - 1 do
        local header = 'Engine Level: '..i
        if i == -1 then header = 'Engine Level: Stock' end
        if GetVehicleMod(vehicle, 11) == i then header = header..' (Installed)' end
        local engineItem = {
            header = header,
            txt = 'Install level '..i..' engine',
            icon = "fa-solid fa-wrench",
            params = {
                event = 'qb-mechanicjob:client:install',
                args = {
                    upgradeType = 'engine',
                    modType = 11,
                    upgradeIndex = i,
                    vehicle = vehicle
                }
            }
        }
        engineMenu[#engineMenu+1] = engineItem
    end
    exports['qb-menu']:openMenu(engineMenu, true)
end

local function GetSuspension(vehicle)
    local suspensionMenu = {}
    for i=-1, GetNumVehicleMods(vehicle, 15) - 1 do
        local header = 'Suspension Level: '..i
        if i == -1 then header = 'Suspension Level: Stock' end
        if GetVehicleMod(vehicle, 15) == i then header = header..' (Installed)' end
        local suspensionItem = {
            header = header,
            txt = 'Install level '..i..' suspension',
            icon = "fa-solid fa-wrench",
            params = {
                event = 'qb-mechanicjob:client:install',
                args = {
                    upgradeType = 'suspension',
                    modType = 15,
                    upgradeIndex = i,
                    vehicle = vehicle
                }
            }
        }
        suspensionMenu[#suspensionMenu+1] = suspensionItem
    end
    exports['qb-menu']:openMenu(suspensionMenu, true)
end

local function GetTransmission(vehicle)
    local transmissionMenu = {}
    for i=-1, GetNumVehicleMods(vehicle, 13) - 1 do
        local header = 'Transmission Level: '..i
        if i == -1 then header = 'Transmission Level: Stock' end
        if GetVehicleMod(vehicle, 13) == i then header = header..' (Installed)' end
        local transmissionItem = {
            header = header,
            txt = 'Install level '..i..' transmission',
            icon = "fa-solid fa-wrench",
            params = {
                event = 'qb-mechanicjob:client:install',
                args = {
                    upgradeType = 'transmission',
                    modType = 13,
                    upgradeIndex = i,
                    vehicle = vehicle
                }
            }
        }
        transmissionMenu[#transmissionMenu+1] = transmissionItem
    end
    exports['qb-menu']:openMenu(transmissionMenu, true)
end

local function ToggleHood(vehicle)
    if GetVehicleDoorAngleRatio(vehicle, 4) > 0.0 then
        SetVehicleDoorShut(vehicle, 4, false)
    else
        SetVehicleDoorOpen(vehicle, 4, false, false)
    end
end

local function NearHood(vehicle)
    local playerCoords = GetEntityCoords(PlayerPedId())
    local vehicleCoords = GetOffsetFromEntityInWorldCoords(vehicle, 0.0, 1.5, 0.0)
    local distance = #(playerCoords - vehicleCoords)
    if distance > 1.5 then return false end
    return true
end

local function NearLeftWheel(vehicle)
    local playerCoords = GetEntityCoords(PlayerPedId())
    local vehicleCoords = GetOffsetFromEntityInWorldCoords(vehicle, 1.0, 0.0, 0.0)
    local distance = #(playerCoords - vehicleCoords)
    if distance > 1.5 then return false end
    return true
end

local function NearRightWheel(vehicle)
    local playerCoords = GetEntityCoords(PlayerPedId())
    local vehicleCoords = GetOffsetFromEntityInWorldCoords(vehicle, -1.0, 0.0, 0.0)
    local distance = #(playerCoords - vehicleCoords)
    if distance > 1.5 then return false end
    return true
end

-- Events

RegisterNetEvent('qb-mechanicjob:client:install', function(data)
    local upgradeIndex = data.upgradeIndex
    local modType = data.modType
    local partName = data.upgradeType
    if partName == 'engine' or partName == 'transmission' or partName == 'turbo' or partName == 'armor' then
        QBCore.Functions.Progressbar("mechanic_install", 'Installing '..partName, 5000, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = 'mini@repair',
            anim = 'fixing_a_ped',
            flags = 16,
        }, {}, {}, function() -- Done
            StopAnimTask(PlayerPedId(), 'mini@repair', 'fixing_a_ped', 1.0)
            SetVehicleMod(data.vehicle, modType, upgradeIndex, false)
            ToggleHood(data.vehicle)
            QBCore.Functions.Notify('Performance upgrade installed!', 'success')
        end, function() -- Cancel
            StopAnimTask(PlayerPedId(), 'mini@repair', 'fixing_a_ped', 1.0)
            ToggleHood(data.vehicle)
            QBCore.Functions.Notify('Cancelled', "error")
        end)
    end
end)

RegisterNetEvent('qb-mechanicjob:client:installPart', function(item)
    local vehicle = QBCore.Functions.GetClosestVehicle()
    if vehicle == 0 then return end
    if GetVehicleModKit(vehicle) ~= 0 then SetVehicleModKit(vehicle, 0) end
    if item == 'veh_armor' then
        if not NearLeftWheel(vehicle) and NearRightWheel(vehicle) then return end
        GetArmor(vehicle)
    elseif item == 'veh_brakes' then
        if not NearLeftWheel(vehicle) and NearRightWheel(vehicle) then return end
        GetBrakes(vehicle)
    elseif item == 'veh_engine' then
        if not NearHood(vehicle) then return end
        if GetVehicleDoorAngleRatio(vehicle, 4) <= 0.0 then SetVehicleDoorOpen(vehicle, 4, false, false) end
        GetEngine(vehicle)
    elseif item == 'veh_suspension' then
        if not NearLeftWheel(vehicle) and NearRightWheel(vehicle) then return end
        GetSuspension(vehicle)
    elseif item == 'veh_transmission' then
        if not NearHood(vehicle) then return end
        if GetVehicleDoorAngleRatio(vehicle, 4) <= 0.0 then SetVehicleDoorOpen(vehicle, 4, false, false) end
        GetTransmission(vehicle)
    elseif item == 'veh_turbo' then
        if not NearHood(vehicle) then return end
        if GetVehicleDoorAngleRatio(vehicle, 4) <= 0.0 then SetVehicleDoorOpen(vehicle, 4, false, false) end
        local turbo = IsToggleModOn(vehicle, 18)
        if turbo then
            ToggleVehicleMod(vehicle, 18, false)
            QBCore.Functions.Notify('Turbo has been removed', 'error')
        else
            ToggleVehicleMod(vehicle, 18, true)
            QBCore.Functions.Notify('Turbo has been installed', 'success')
        end
    end
end)