local QBCore = exports['qb-core']:GetCoreObject()
local vehicleComponents = {}
local drivingDistance = {}
local tunedVehicles = {}
local nitrousVehicles = {}

-- Functions

function Trim(plate)
    return (string.gsub(plate, '^%s*(.-)%s*$', '%1'))
end

local function IsVehicleOwned(plate)
    local result = MySQL.scalar.await('SELECT 1 from player_vehicles WHERE plate = ?', { plate })
    if result then return true end
    return false
end

local function StartParticles(coords, netId, color)
    for _, playerId in ipairs(GetPlayers()) do
        local playerPed = GetPlayerPed(playerId)
        local playerCoords = GetEntityCoords(playerPed)
        local distance = #(coords - playerCoords)
        if distance < 10 then
            Player(playerId).state:set('paint_particles', true, false)
            TriggerClientEvent('qb-mechanicjob:client:startParticles', playerId, netId, color)
        end
    end
end

local function StopParticles()
    for _, playerId in ipairs(GetPlayers()) do
        if Player(playerId).state.paint_particles then
            Player(playerId).state:set('paint_particles', false, false)
            TriggerClientEvent('qb-mechanicjob:client:stopParticles', playerId)
        end
    end
end

local function LerpColor(colorFrom, colorTo, fraction)
    return {
        r = colorFrom.r + (colorTo.r - colorFrom.r) * fraction,
        g = colorFrom.g + (colorTo.g - colorFrom.g) * fraction,
        b = colorFrom.b + (colorTo.b - colorFrom.b) * fraction
    }
end

local function TransitionVehicleColor(vehicle, section, currentColor, targetColor, duration)
    local startTime = GetGameTimer()
    local endTime = startTime + duration
    while GetGameTimer() <= endTime do
        local currentTime = GetGameTimer()
        local fraction = (currentTime - startTime) / duration
        local newColor = LerpColor(currentColor, targetColor, fraction)
        if section == 'primary' then
            SetVehicleCustomPrimaryColour(vehicle, math.floor(newColor.r), math.floor(newColor.g), math.floor(newColor.b))
        elseif section == 'secondary' then
            SetVehicleCustomSecondaryColour(vehicle, math.floor(newColor.r), math.floor(newColor.g), math.floor(newColor.b))
        end
        Wait(0)
    end
end

local function GetPaintTypeIndex(type)
    if type == 'metallic' then return 0 end
    if type == 'matte' then return 12 end
    if type == 'chrome' then return 120 end
    return 0
end

-- Callbacks

QBCore.Functions.CreateCallback('qb-mechanicjob:server:getnitrousVehicles', function(_, cb)
    cb(nitrousVehicles)
end)

QBCore.Functions.CreateCallback('qb-mechanicjob:server:checkTune', function(_, cb, plate)
    if not tunedVehicles[plate] then cb(false) end
    cb(tunedVehicles[plate])
end)

QBCore.Functions.CreateCallback('qb-mechanicjob:server:getVehicleStatus', function(_, cb, plate)
    if not vehicleComponents[plate] then cb(false) end
    cb(vehicleComponents[plate])
end)

QBCore.Functions.CreateCallback('qb-mechanicjob:server:hasPermission', function(source, cb)
    if QBCore.Functions.HasPermission(source, { 'god', 'admin', 'command' }) then
        cb(true)
    else
        cb(false)
    end
end)

-- Events

RegisterNetEvent('qb-mechanicjob:server:stash', function(data)
    local src = source
    local shopName = data.job
    if not Config.Shops[shopName] then return end
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    if Config.Shops[shopName].managed and Player.PlayerData.job.name ~= shopName then return end
    local playerPed = GetPlayerPed(src)
    local playerCoords = GetEntityCoords(playerPed)
    local stashCoords = Config.Shops[shopName].stash
    if #(playerCoords - stashCoords) < 2.5 then
        local stashName = shopName .. '_stash'
        exports['qb-inventory']:OpenInventory(src, stashName, {
            maxweight = 4000000,
            slots = 100,
        })
    end
end)

RegisterNetEvent('qb-mechanicjob:server:sprayVehicleCustom', function(netId, section, type, color)
    local vehicle = NetworkGetEntityFromNetworkId(netId)
    local vehicleCoords = GetEntityCoords(vehicle)
    local paintTypeIndex = GetPaintTypeIndex(type)
    FreezeEntityPosition(vehicle, true)
    StartParticles(vehicleCoords, netId, color)
    local r, g, b
    if section == 'primary' then
        local _, colorSecondary = GetVehicleColours(vehicle)
        SetVehicleColours(vehicle, paintTypeIndex, colorSecondary)
        r, g, b = GetVehicleCustomPrimaryColour(vehicle)
    elseif section == 'secondary' then
        local colorPrimary, _ = GetVehicleColours(vehicle)
        SetVehicleColours(vehicle, colorPrimary, paintTypeIndex)
        r, g, b = GetVehicleCustomSecondaryColour(vehicle)
    end
    local currentColor = { r = r, g = g, b = b }
    TransitionVehicleColor(vehicle, section, currentColor, color, Config.PaintTime * 1000)
    StopParticles()
    FreezeEntityPosition(vehicle, false)
end)

RegisterNetEvent('qb-mechanicjob:server:sprayVehicle', function(netId, primary, secondary, pearlescent, wheel, colors)
    local vehicle = NetworkGetEntityFromNetworkId(netId)
    local vehicleCoords = GetEntityCoords(vehicle)
    FreezeEntityPosition(vehicle, true)

    if colors.primary then
        StartParticles(vehicleCoords, netId, colors.primary)
        Wait(Config.PaintTime * 1000)
        -- local _, colorSecondary = GetVehicleColours(vehicle)
        -- ClearVehicleCustomPrimaryColour(vehicle) -- does not exist yet
        -- SetVehicleColours(vehicle, tonumber(primary), colorSecondary)
        TriggerClientEvent('qb-mechanicjob:client:vehicleSetColors', -1, netId, 'primary', primary)
        StopParticles()
    end

    if colors.secondary then
        StartParticles(vehicleCoords, netId, colors.secondary)
        Wait(Config.PaintTime * 1000)
        -- local colorPrimary, _ = GetVehicleColours(vehicle)
        -- ClearVehicleCustomSecondaryColour(vehicle) -- does not exist yet
        -- SetVehicleColours(vehicle, colorPrimary, tonumber(secondary))
        TriggerClientEvent('qb-mechanicjob:client:vehicleSetColors', -1, netId, 'secondary', secondary)
        StopParticles()
    end

    if colors.pearlescent then
        StartParticles(vehicleCoords, netId, colors.pearlescent)
        Wait(Config.PaintTime * 1000)
        -- local pearlescentColor, wheelColor = GetVehicleExtraColours(vehicle) -- does not exist yet
        -- SetVehicleExtraColours(vehicle, tonumber(pearlescent) or pearlescentColor, tonumber(wheel) or wheelColor) -- does not exist yet
        TriggerClientEvent('qb-mechanicjob:client:vehicleSetColors', -1, netId, 'pearlescent', pearlescent)
        StopParticles()
    end

    if colors.wheel then
        StartParticles(vehicleCoords, netId, colors.wheel)
        Wait(Config.PaintTime * 1000)
        -- local pearlescentColor, wheelColor = GetVehicleExtraColours(vehicle) -- does not exist yet
        -- SetVehicleExtraColours(vehicle, tonumber(pearlescent) or pearlescentColor, tonumber(wheel) or wheelColor) -- does not exist yet
        TriggerClientEvent('qb-mechanicjob:client:vehicleSetColors', -1, netId, 'wheel', wheel)
        StopParticles()
    end

    FreezeEntityPosition(vehicle, false)
end)

RegisterNetEvent('qb-mechanicjob:server:syncNitrous', function(plate, hasnitro, level)
    if not nitrousVehicles[plate] then
        nitrousVehicles[plate] = { hasnitro = hasnitro, level = level }
    else
        nitrousVehicles[plate].hasnitro = hasnitro
        nitrousVehicles[plate].level = level
    end
end)

RegisterNetEvent('qb-mechanicjob:server:syncNitrousFlames', function(netId, toggle)
    TriggerClientEvent('qb-mechanicjob:client:syncNitrousFlames', -1, netId, toggle)
end)

RegisterNetEvent('qb-mechanicjob:server:tuneStatus', function(plate)
    if not tunedVehicles[plate] then
        tunedVehicles[plate] = true
    end
end)

RegisterNetEvent('qb-mechanicjob:server:SaveVehicleProps', function(vehicleProps)
    if IsVehicleOwned(vehicleProps.plate) then
        MySQL.update('UPDATE player_vehicles SET mods = ? WHERE plate = ?', { json.encode(vehicleProps), vehicleProps.plate })
    end
end)

RegisterNetEvent('qb-mechanicjob:server:repairVehicleComponent', function(plate, component)
    if plate and component then
        if not vehicleComponents[plate] then return end
        if vehicleComponents[plate][component] then
            vehicleComponents[plate][component] = 100
        end
    end
end)

RegisterNetEvent('qb-mechanicjob:server:updateVehicleComponents', function(plate, componentData)
    if plate and componentData then
        if vehicleComponents[plate] then
            vehicleComponents[plate] = componentData
        else
            vehicleComponents[plate] = componentData
        end
    end
    local isOwned = IsVehicleOwned(plate)
    if isOwned then MySQL.update('UPDATE player_vehicles SET status = ? WHERE plate = ?', { json.encode(vehicleComponents[plate]), plate }) end
end)

RegisterNetEvent('qb-mechanicjob:server:updateDrivingDistance', function(plate, distance)
    if plate and distance then
        if drivingDistance[plate] then
            drivingDistance[plate] = drivingDistance[plate] + distance
        else
            drivingDistance[plate] = distance
        end
    end
    local isOwned = IsVehicleOwned(plate)
    if isOwned then MySQL.update('UPDATE player_vehicles SET drivingdistance = drivingdistance + ? WHERE plate = ?', { drivingDistance[plate], plate }) end
end)

RegisterNetEvent('qb-mechanicjob:server:removeItem', function(part, amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    if not amount then amount = 1 end
    if not exports['qb-inventory']:RemoveItem(src, part, amount, false, 'qb-mechanicjob:server:removeItem') then DropPlayer(src, 'qb-mechanicjob:server:removeItem') end
    TriggerClientEvent('qb-inventory:client:ItemBox', src, QBCore.Shared.Items[part], 'remove')
end)

-- Items

local performanceParts = {
    'veh_armor',
    'veh_brakes',
    'veh_engine',
    'veh_suspension',
    'veh_transmission',
    'veh_turbo',
}

for i = 1, #performanceParts do
    QBCore.Functions.CreateUseableItem(performanceParts[i], function(source, item)
        local Player = QBCore.Functions.GetPlayer(source)
        if not Player then return end
        if Config.RequireJob and Player.PlayerData.job.type ~= 'mechanic' then return end
        TriggerClientEvent('qb-mechanicjob:client:installPart', source, item.name)
    end)
end

local cosmeticParts = {
    'veh_interior',
    'veh_exterior',
    'veh_wheels',
    'veh_neons',
    'veh_xenons',
    'veh_tint',
    'veh_plates',
}

for i = 1, #cosmeticParts do
    QBCore.Functions.CreateUseableItem(cosmeticParts[i], function(source, item)
        local Player = QBCore.Functions.GetPlayer(source)
        if not Player then return end
        if Config.RequireJob and Player.PlayerData.job.type ~= 'mechanic' then return end
        TriggerClientEvent('qb-mechanicjob:client:installCosmetic', source, item.name)
    end)
end

QBCore.Functions.CreateUseableItem('veh_toolbox', function(source)
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then return end
    if Config.RequireJob and Player.PlayerData.job.type ~= 'mechanic' then return end
    TriggerClientEvent('qb-mechanicjob:client:PartsMenu', source)
end)

QBCore.Functions.CreateUseableItem('tunerlaptop', function(source)
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then return end
    if Config.RequireJob and Player.PlayerData.job.type ~= 'mechanic' then return end
    TriggerClientEvent('qb-mechanicjob:client:openChip', source)
end)

QBCore.Functions.CreateUseableItem('nitrous', function(source)
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then return end
    if Config.RequireJob and Player.PlayerData.job.type ~= 'mechanic' then return end
    TriggerClientEvent('qb-mechanicjob:client:installNitrous', source)
end)

QBCore.Functions.CreateUseableItem('tirerepairkit', function(source)
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then return end
    TriggerClientEvent('qb-mechanicjob:client:repairTire', source)
end)

QBCore.Functions.CreateUseableItem('repairkit', function(source)
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then return end
    TriggerClientEvent('qb-mechanicjob:client:repairVehicle', source)
end)

QBCore.Functions.CreateUseableItem('advancedrepairkit', function(source)
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then return end
    TriggerClientEvent('qb-mechanicjob:client:repairVehicleFull', source)
end)

QBCore.Functions.CreateUseableItem('cleaningkit', function(source)
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then return end
    TriggerClientEvent('qb-mechanicjob:client:cleanVehicle', source)
end)

-- Commands

QBCore.Commands.Add('fix', 'Repair your vehicle (Admin Only)', {}, false, function(source)
    local ped = GetPlayerPed(source)
    local vehicle = GetVehiclePedIsIn(ped, false)
    if not vehicle then return end
    local plate = GetVehicleNumberPlateText(vehicle)
    if not plate then return end
    local trimmedPlate = Trim(plate)
    if vehicleComponents[trimmedPlate] then
        for k in pairs(vehicleComponents[trimmedPlate]) do
            vehicleComponents[trimmedPlate][k] = 100
        end
    end
    TriggerClientEvent('qb-mechanicjob:client:fixEverything', source)
end, 'admin')
