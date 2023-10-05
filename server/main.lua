local QBCore = exports['qb-core']:GetCoreObject()
local VehicleStatus = {}
local VehicleDrivingDistance = {}
local tunedVehicles = {}
local Threshold = {
    ['boost'] = {min = 1, max = 5},
    ['acceleration'] = {min = 1, max = 5},
    ['gearchange'] = {min = 1, max = 5},
    ['breaking'] = {min = 1, max = 5},
    ['drivetrain'] = {min = 1, max = 3},
}

-- Functions

function IsVehicleOwned(plate)
    local result = MySQL.scalar.await('SELECT 1 from player_vehicles WHERE plate = ?', {plate})
    if result then
        return true
    else
        return false
    end
end

function GetVehicleStatus(plate)
    local retval = nil
    local result = MySQL.query.await('SELECT status FROM player_vehicles WHERE plate = ?', {plate})
    if result[1] ~= nil then
        retval = result[1].status ~= nil and json.decode(result[1].status) or nil
    end
    return retval
end

-- Callbacks

QBCore.Functions.CreateCallback('qb-mechanicjob:server:GetDrivingDistances', function(_, cb)
    cb(VehicleDrivingDistance)
end)

QBCore.Functions.CreateCallback('qb-mechanicjob:server:IsVehicleOwned', function(_, cb, plate)
    local retval = false
    local result = MySQL.scalar.await('SELECT 1 from player_vehicles WHERE plate = ?', {plate})
    if result then
        retval = true
    end
    cb(retval)
end)

QBCore.Functions.CreateCallback('qb-mechanicjob:server:IsMechanicAvailable', function(_, cb)
    local amount = 0
    for _, v in pairs(QBCore.Functions.GetPlayers()) do
        local Player = QBCore.Functions.GetPlayer(v)
        if Player ~= nil then
            if (Player.PlayerData.job.name == "mechanic" and Player.PlayerData.job.onduty) then
                amount = amount + 1
            end
        end
    end
    cb(amount)
end)

QBCore.Functions.CreateCallback('qb-mechanicjob:server:GetStatus', function(_, cb, plate)
    if VehicleStatus[plate] ~= nil and next(VehicleStatus[plate]) ~= nil then
        cb(VehicleStatus[plate])
    else
        cb(nil)
    end
end)

QBCore.Functions.CreateCallback('qb-mechanicjob:server:HasChip', function(source, cb, data)
    local src = source
    local Ply = QBCore.Functions.GetPlayer(src)
    local Chip = Ply.Functions.GetItemByName('tunerlaptop')
    if data then
        for k,v in pairs(data) do
            if Threshold[k].min > tonumber(v) or Threshold[k].max < tonumber(v) then Chip = nil end
        end
    end
    if Chip then cb(true) return end
    DropPlayer(src, Lang:t("text.this_is_not_the_idea_is_it"))
    cb(false)
end)

QBCore.Functions.CreateCallback('qb-mechanicjob:server:GetStatus', function(_, cb, plate)
    cb(tunedVehicles[plate])
end)

-- Events

RegisterNetEvent('qb-mechanicjob:server:TuneStatus', function(plate, bool)
    if bool then
        tunedVehicles[plate] = bool
    else
        tunedVehicles[plate] = nil
    end
end)

RegisterNetEvent('qb-mechanicjob:server:SaveVehicleProps', function(vehicleProps)
    if IsVehicleOwned(vehicleProps.plate) then
        MySQL.update('UPDATE player_vehicles SET mods = ? WHERE plate = ?',
            {json.encode(vehicleProps), vehicleProps.plate})
    end
end)

RegisterNetEvent('qb-mechanicjob:server:setupVehicleStatus', function(plate, engineHealth, bodyHealth)
    engineHealth = engineHealth ~= nil and engineHealth or 1000.0
    bodyHealth = bodyHealth ~= nil and bodyHealth or 1000.0
    if VehicleStatus[plate] == nil then
        if IsVehicleOwned(plate) then
            local statusInfo = GetVehicleStatus(plate)
            if statusInfo == nil then
                statusInfo = {
                    ["engine"] = engineHealth,
                    ["body"] = bodyHealth,
                    ["radiator"] = Config.MaxStatusValues["radiator"],
                    ["axle"] = Config.MaxStatusValues["axle"],
                    ["brakes"] = Config.MaxStatusValues["brakes"],
                    ["clutch"] = Config.MaxStatusValues["clutch"],
                    ["fuel"] = Config.MaxStatusValues["fuel"]
                }
            end
            VehicleStatus[plate] = statusInfo
            TriggerClientEvent("qb-mechanicjob:client:setVehicleStatus", -1, plate, statusInfo)
        else
            local statusInfo = {
                ["engine"] = engineHealth,
                ["body"] = bodyHealth,
                ["radiator"] = Config.MaxStatusValues["radiator"],
                ["axle"] = Config.MaxStatusValues["axle"],
                ["brakes"] = Config.MaxStatusValues["brakes"],
                ["clutch"] = Config.MaxStatusValues["clutch"],
                ["fuel"] = Config.MaxStatusValues["fuel"]
            }
            VehicleStatus[plate] = statusInfo
            TriggerClientEvent("qb-mechanicjob:client:setVehicleStatus", -1, plate, statusInfo)
        end
    else
        TriggerClientEvent("qb-mechanicjob:client:setVehicleStatus", -1, plate, VehicleStatus[plate])
    end
end)

RegisterNetEvent('qb-mechanicjob:server:UpdateDrivingDistance', function(amount, plate)
    VehicleDrivingDistance[plate] = amount
    TriggerClientEvent('qb-mechanicjob:client:UpdateDrivingDistance', -1, VehicleDrivingDistance[plate], plate)
    local result = MySQL.query.await('SELECT plate FROM player_vehicles WHERE plate = ?', {plate})
    if result[1] ~= nil then
        MySQL.update('UPDATE player_vehicles SET drivingdistance = ? WHERE plate = ?', {amount, plate})
    end
end)

RegisterNetEvent('qb-mechanicjob:server:LoadStatus', function(veh, plate)
    VehicleStatus[plate] = veh
    TriggerClientEvent("qb-mechanicjob:client:setVehicleStatus", -1, plate, veh)
end)

RegisterNetEvent('qb-mechanicjob:server:updatePart', function(plate, part, level)
    if VehicleStatus[plate] ~= nil then
        if part == "engine" or part == "body" then
            VehicleStatus[plate][part] = level
            if VehicleStatus[plate][part] < 0 then
                VehicleStatus[plate][part] = 0
            elseif VehicleStatus[plate][part] > 1000 then
                VehicleStatus[plate][part] = 1000.0
            end
        else
            VehicleStatus[plate][part] = level
            if VehicleStatus[plate][part] < 0 then
                VehicleStatus[plate][part] = 0
            elseif VehicleStatus[plate][part] > 100 then
                VehicleStatus[plate][part] = 100
            end
        end
        TriggerClientEvent("qb-mechanicjob:client:setVehicleStatus", -1, plate, VehicleStatus[plate])
    end
end)

RegisterNetEvent('qb-mechanicjob:server:SetPartLevel', function(plate, part, level)
    if VehicleStatus[plate] ~= nil then
        VehicleStatus[plate][part] = level
        TriggerClientEvent("qb-mechanicjob:client:setVehicleStatus", -1, plate, VehicleStatus[plate])
    end
end)

RegisterNetEvent('qb-mechanicjob:server:fixEverything', function(plate)
    if VehicleStatus[plate] ~= nil then
        for k, v in pairs(Config.MaxStatusValues) do
            VehicleStatus[plate][k] = v
        end
        TriggerClientEvent("qb-mechanicjob:client:setVehicleStatus", -1, plate, VehicleStatus[plate])
    end
end)

RegisterNetEvent('qb-mechanicjob:server:saveStatus', function(plate)
    if VehicleStatus[plate] ~= nil then
        MySQL.update('UPDATE player_vehicles SET status = ? WHERE plate = ?',
            { json.encode(VehicleStatus[plate]), plate }
        )
    end
end)

RegisterNetEvent('qb-mechanicjob:server:SetAttachedVehicle', function(veh, k)
    if veh ~= false then
        Config.Plates[k].AttachedVehicle = veh
        TriggerClientEvent('qb-mechanicjob:client:SetAttachedVehicle', -1, veh, k)
    else
        Config.Plates[k].AttachedVehicle = nil
        TriggerClientEvent('qb-mechanicjob:client:SetAttachedVehicle', -1, false, k)
    end
end)

RegisterNetEvent('qb-mechanicjob:server:CheckForItems', function(part)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local RepairPart = Player.Functions.GetItemByName(Config.RepairCostAmount[part].item)

    if RepairPart ~= nil then
        if RepairPart.amount >= Config.RepairCostAmount[part].costs then
            TriggerClientEvent('qb-mechanicjob:client:RepaireeePart', src, part)
            Player.Functions.RemoveItem(Config.RepairCostAmount[part].item, Config.RepairCostAmount[part].costs)

            for _ = 1, Config.RepairCostAmount[part].costs, 1 do
                TriggerClientEvent('inventory:client:ItemBox', src,
                    QBCore.Shared.Items[Config.RepairCostAmount[part].item], "remove")
                Wait(500)
            end
        else
            TriggerClientEvent('QBCore:Notify', src, Lang:t('notifications.not_enough') ..QBCore.Shared.Items[Config.RepairCostAmount[part].item]["label"].. " (min. " ..Config.RepairCostAmount[part].costs.. "x)", "error")
        end
    else
        TriggerClientEvent('QBCore:Notify', src, Lang:t('notifications.not_have') ..QBCore.Shared.Items[Config.RepairCostAmount[part].item]["label"], "error")
    end
end)

RegisterNetEvent('qb-mechanicjob:server:removePart', function(part, amount)
    local Player = QBCore.Functions.GetPlayer(source)

    if not Player then return end

    Player.Functions.RemoveItem(Config.RepairCost[part], amount)
end)

-- Commands

QBCore.Commands.Add("setvehiclestatus", "Set Vehicle Status", {{
    name = "part",
    help = "Type The Part You Want To Edit"
}, {
    name = "amount",
    help = "The Percentage Fixed"
}}, true, function(source, args)
    local part = args[1]:lower()
    local level = tonumber(args[2])
    TriggerClientEvent("qb-mechanicjob:client:setPartLevel", source, part, level)
end, "god")

-- Items

QBCore.Functions.CreateUseableItem('veh_toolbox', function(source)
    TriggerClientEvent('qb-mechanicjob:client:PartsMenu', source)
end)

local performanceParts = {
    'veh_armor',
    'veh_brakes',
    'veh_engine',
    'veh_suspension',
    'veh_transmission',
    'veh_turbo',
}

for i=1, #performanceParts do
    QBCore.Functions.CreateUseableItem(performanceParts[i], function(source, item)
        local Player = QBCore.Functions.GetPlayer(source)
        if Player.Functions.RemoveItem(item.name, 1) then
            TriggerClientEvent('qb-mechanicjob:client:installPart', source, item.name)
        end
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

for i=1, #cosmeticParts do
    QBCore.Functions.CreateUseableItem(cosmeticParts[i], function(source, item)
        local Player = QBCore.Functions.GetPlayer(source)
        if Player.Functions.RemoveItem(item.name, 1) then
            TriggerClientEvent('qb-mechanicjob:client:installCosmetic', source, item.name)
        end
    end)
end

-- Nitrous

QBCore.Functions.CreateUseableItem("nitrous", function(source)
    TriggerClientEvent('smallresource:client:LoadNitrous', source)
end)

RegisterNetEvent('nitrous:server:LoadNitrous', function(Plate)
    TriggerClientEvent('nitrous:client:LoadNitrous', -1, Plate)
end)

RegisterNetEvent('nitrous:server:SyncFlames', function(netId)
    TriggerClientEvent('nitrous:client:SyncFlames', -1, netId, source)
end)

RegisterNetEvent('nitrous:server:UnloadNitrous', function(Plate)
    TriggerClientEvent('nitrous:client:UnloadNitrous', -1, Plate)
end)

RegisterNetEvent('nitrous:server:UpdateNitroLevel', function(Plate, level)
    TriggerClientEvent('nitrous:client:UpdateNitroLevel', -1, Plate, level)
end)

RegisterNetEvent('nitrous:server:StopSync', function(plate)
    TriggerClientEvent('nitrous:client:StopSync', -1, plate)
end)

RegisterNetEvent('nitrous:server:removeItem', function()
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then return end
    Player.Functions.RemoveItem('nitrous', 1)
end)

-- Tuner Chip

QBCore.Functions.CreateUseableItem("tunerlaptop", function(source)
    TriggerClientEvent('qb-tunerchip:client:openChip', source)
end)