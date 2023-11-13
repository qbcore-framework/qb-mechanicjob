local vehicle, plate, netId
local nitrousActive = false
local nitrousVehicles = {}

-- Functions

local function ListenForNitrous()
    CreateThread(function()
        while true do
            Wait(0)
            if not vehicle then break end
            local ped = PlayerPedId()
            local isDriver = GetPedInVehicleSeat(vehicle, -1) == ped
            if isDriver then
                if IsControlJustPressed(0, 155) then
                    AnimpostfxPlay('RaceTurbo', 0, true)
                    TriggerServerEvent('qb-mechanicjob:server:syncNitrousFlames', netId, true)
                    nitrousActive = true
                end
                if nitrousActive then -- per frame effect & updates
                    SetVehicleBoostActive(vehicle, true)
                    SetVehicleCheatPowerIncrease(vehicle, Config.NitrousBoost)
                    nitrousVehicles[plate].level = nitrousVehicles[plate].level - Config.NitrousUsage
                    TriggerEvent('hud:client:UpdateNitrous', nitrousVehicles[plate].level, nitrousVehicles[plate].hasnitro)
                end
                if IsControlJustReleased(0, 155) or nitrousVehicles[plate].level <= 0 then
                    nitrousActive = false
                    AnimpostfxStop('RaceTurbo')
                    SetVehicleBoostActive(vehicle, false)
                    TriggerServerEvent('qb-mechanicjob:server:syncNitrousFlames', netId, false)
                    if nitrousVehicles[plate].level <= 0 then
                        nitrousVehicles[plate].hasnitro = false
                        TriggerServerEvent('qb-mechanicjob:server:syncNitrous', plate, false)
                        TriggerEvent('hud:client:UpdateNitrous', 0, false)
                        plate = nil
                        vehicle = nil
                        netId = nil
                        break
                    else
                        TriggerServerEvent('qb-mechanicjob:server:syncNitrous', plate, true, nitrousVehicles[plate].level)
                    end
                end
            else
                plate = nil
                vehicle = nil
                netId = nil
                nitrousActive = false
                TriggerEvent('hud:client:UpdateNitrous', 0, false)
                break
            end
        end
    end)
end

-- Handler

AddEventHandler('gameEventTriggered', function(event)
    if event == 'CEventNetworkPlayerEnteredVehicle' then
        vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
        plate = QBCore.Functions.GetPlate(vehicle)
        netId = NetworkGetNetworkIdFromEntity(vehicle)
        QBCore.Functions.TriggerCallback('qb-mechanicjob:server:getnitrousVehicles', function(vehs)
            nitrousVehicles = vehs
            if nitrousVehicles[plate] and nitrousVehicles[plate].hasnitro and nitrousVehicles[plate].level > 0 then
                TriggerEvent('hud:client:UpdateNitrous', nitrousVehicles[plate].level, true)
                ListenForNitrous()
            end
        end)
    end
end)

-- Events

RegisterNetEvent('qb-mechanicjob:client:syncNitrousFlames', function(net, toggle)
    if not NetworkDoesEntityExistWithNetworkId(net) then return end
    local veh = NetworkGetEntityFromNetworkId(net)
    SetVehicleNitroEnabled(veh, toggle)
end)

RegisterNetEvent('qb-mechanicjob:client:installNitrous', function()
    if IsPedInAnyVehicle(PlayerPedId(), false) then return end
    local closestVehicle, distance = QBCore.Functions.GetClosestVehicle()
    if closestVehicle == 0 or distance > 5.0 then return end
    local vehicleClass = GetVehicleClass(closestVehicle)
    if Config.IgnoreClasses[vehicleClass] then return end
    local vehiclePlate = QBCore.Functions.GetPlate(closestVehicle)
    if not vehiclePlate then return end
    if not IsNearBone(closestVehicle, 'engine') then return end
    ToggleHood(closestVehicle)
    QBCore.Functions.Progressbar('use_nos', Lang:t('progress.nitrous'), 5000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = 'mini@repair',
        anim = 'fixing_a_player',
        flags = 1,
    }, {
        model = 'imp_prop_impexp_span_03',
        bone = 28422,
        coords = vec3(0.06, 0.01, -0.02),
        rotation = vec3(0.0, 0.0, 0.0),
    }, {}, function()
        ToggleHood(closestVehicle)
        TriggerServerEvent('qb-mechanicjob:server:removeItem', 'nitrous')
        TriggerServerEvent('qb-mechanicjob:server:syncNitrous', vehiclePlate, true, 100)
        if not nitrousVehicles[vehiclePlate] then
            nitrousVehicles[vehiclePlate] = { hasnitro = true, level = 100 }
        else
            nitrousVehicles[vehiclePlate].hasnitro = true
            nitrousVehicles[vehiclePlate].level = 100
        end
    end)
end)

-- Threads

CreateThread(function()
    RequestNamedPtfxAsset('veh_xs_vehicle_mods')
    while not HasNamedPtfxAssetLoaded('veh_xs_vehicle_mods') do
        Wait(0)
        RequestNamedPtfxAsset('veh_xs_vehicle_mods')
    end
end)
