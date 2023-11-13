local initialData = {}

local availableHandling = {
    'fMass',
    'fInitialDragCoeff',
    'fDownforceModifier',
    'nInitialDriveGears',
    'fInitialDriveForce',
    'fDriveInertia',
    'fDriveBiasFront',
    'fInitialDriveMaxFlatVel',
    'fClutchChangeRateScaleUpShift',
    'fClutchChangeRateScaleDownShift',
    'fSteeringLock',
    'fBrakeForce',
    'fBrakeBiasFront',
    'fHandBrakeForce',
    'fTractionCurveMax',
    'fTractionCurveMin',
    'fTractionCurveLateral',
    'fTractionSpringDeltaMax',
    'fLowSpeedTractionLossMult',
    'fTractionBiasFront',
    'fCamberStiffnesss',
    'fTractionLossMult',
    'vecCentreOfMassOffset',
    'vecInertiaMultiplier',
    'fSuspensionForce',
    'fSuspensionCompDamp',
    'fSuspensionReboundDamp',
    'fSuspensionUpperLimit',
    'fSuspensionLowerLimit',
    'fSuspensionRaise',
    'fSuspensionBiasFront',
    'fAntiRollBarForce',
    'fAntiRollBarBiasFront',
    'fRollCentreHeightFront',
    'fRollCentreHeightRear',
    'fPercentSubmerged',
    'fCollisionDamageMult',
    'fDeformationDamageMult',
    'fWeaponDamageMult',
    'fEngineDamageMult',
    'fPetrolTankVolume',
    'fOilVolume',
    'nMonetaryValue'
}

-- Functions

local function GetVehicleStats(vehicle)
    local vehicleStats = {}
    local plate = QBCore.Functions.GetPlate(vehicle)

    for _, handlingName in pairs(availableHandling) do
        local value
        if handlingName == 'nInitialDriveGears' or handlingName == 'nMonetaryValue' then
            value = GetVehicleHandlingInt(vehicle, 'CHandlingData', handlingName)
        else
            value = GetVehicleHandlingFloat(vehicle, 'CHandlingData', handlingName)
        end
        vehicleStats[handlingName] = value
    end

    if not initialData[plate] then
        initialData[plate] = vehicleStats
    end

    return vehicleStats
end

local function SetVehData(data)
    local vehicle = GetVehiclePedIsUsing(PlayerPedId())
    if not vehicle then return end
    for k, v in pairs(data) do
        local numValue = tonumber(v)
        if numValue then
            if k == 'nInitialDriveGears' or k == 'nMonetaryValue' then
                SetVehicleHandlingInt(vehicle, 'CHandlingData', k, math.floor(numValue))
            else
                SetVehicleHandlingFloat(vehicle, 'CHandlingData', k, numValue + 0.0)
            end
        end
    end
end

local function ResetVeh()
    local vehicle = GetVehiclePedIsUsing(PlayerPedId())
    if not vehicle then return end
    local plate = QBCore.Functions.GetPlate(vehicle)
    if not plate then return end
    if not initialData[plate] then return end
    for k, v in pairs(initialData) do
        local numValue = tonumber(v)
        if numValue then
            if k == 'nInitialDriveGears' or k == 'nMonetaryValue' then
                SetVehicleHandlingInt(vehicle, 'CHandlingData', k, math.floor(numValue))
            else
                SetVehicleHandlingFloat(vehicle, 'CHandlingData', k, numValue + 0.0)
            end
        end
    end
end

-- NUI Callbacks

RegisterNUICallback('saveTune', function(data, cb)
    SetVehData(data)
    cb('ok')
end)

RegisterNUICallback('reset', function(_, cb)
    ResetVeh()
    TriggerEvent('qb-mechanicjob:client:openChip')
    cb('ok')
end)

RegisterNUICallback('closeTuner', function(_, cb)
    SetNuiFocus(false, false)
    cb('ok')
end)

-- Events

RegisterNetEvent('qb-mechanicjob:client:checkTune', function()
    local vehicle, distance = QBCore.Functions.GetClosestVehicle()
    if vehicle == 0 or distance > 5.0 then return end
    local plate = QBCore.Functions.GetPlate(vehicle)
    if not plate then return end
    QBCore.Functions.TriggerCallback('qb-mechanicjob:server:checkTune', function(status)
        if status then
            QBCore.Functions.Notify(Lang:t('success.tuned'), 'success')
        else
            QBCore.Functions.Notify(Lang:t('warning.not_tuned'), 'error')
        end
    end, plate)
end)

RegisterNetEvent('qb-mechanicjob:client:openChip', function()
    local ped = PlayerPedId()
    local inVehicle = IsPedInAnyVehicle(ped, false)
    if inVehicle then
        local vehicle = GetVehiclePedIsUsing(ped)
        local vehicleClass = GetVehicleClass(vehicle)
        if Config.IgnoreClasses[vehicleClass] then return end
        local plate = QBCore.Functions.GetPlate(vehicle)
        QBCore.Functions.Progressbar('connect_laptop', Lang:t('progress.tuner_chip'), 2000, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function()
            TriggerServerEvent('qb-mechanicjob:server:tuneStatus', plate)
            SetNuiFocus(true, true)
            SendNUIMessage({
                action = 'openTuner',
                stats = GetVehicleStats(vehicle)
            })
        end)
    end
end)
