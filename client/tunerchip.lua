LastEngineMultiplier = 1.0

-- Functions

function setVehData(veh,data)
    local multp = 0.12
    local dTrain = 0.0
    if tonumber(data.drivetrain) == 2 then dTrain = 0.5 elseif tonumber(data.drivetrain) == 3 then dTrain = 1.0 end
    if not DoesEntityExist(veh) or not data then return nil end
    SetVehicleHandlingFloat(veh, "CHandlingData", "fInitialDriveForce", data.boost * multp)
    SetVehicleHandlingFloat(veh, "CHandlingData", "fDriveInertia", data.acceleration * multp)
    SetVehicleEnginePowerMultiplier(veh, data.gearchange * multp)
    LastEngineMultiplier = data.gearchange * multp
    SetVehicleHandlingFloat(veh, "CHandlingData", "fDriveBiasFront", dTrain*1.0)
    SetVehicleHandlingFloat(veh, "CHandlingData", "fBrakeBiasFront", data.breaking * multp)
end

function resetVeh(veh)
    SetVehicleHandlingFloat(veh, "CHandlingData", "fInitialDriveForce", 1.0)
    SetVehicleHandlingFloat(veh, "CHandlingData", "fDriveInertia", 1.0)
    SetVehicleEnginePowerMultiplier(veh, 1.0)
    SetVehicleHandlingFloat(veh, "CHandlingData", "fDriveBiasFront", 0.5)
    SetVehicleHandlingFloat(veh, "CHandlingData", "fBrakeBiasFront", 1.0)
end

function openTunerLaptop(bool)
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        action = "ui",
        toggle = bool
    })
end

-- NUI Callbacks

RegisterNUICallback('save', function(data, cb)
    QBCore.Functions.TriggerCallback('qb-tunerchip:server:HasChip', function(HasChip)
        if HasChip then
            local ped = PlayerPedId()
            local veh = GetVehiclePedIsUsing(ped)
            setVehData(veh, data)
            QBCore.Functions.Notify(Lang:t("error.tunerchip_vehicle_tuned"), 'error')

            TriggerServerEvent('qb-tunerchip:server:TuneStatus', QBCore.Functions.GetPlate(veh), true)
        end
        cb('ok')
    end, data)
end)

RegisterNUICallback('checkItem', function(data, cb)
    local retval = false
    local result = QBCore.Functions.HasItem(data.item)
    if result then
        retval = true
    end
    cb(retval)
end)

RegisterNUICallback('reset', function(_, cb)
    local ped = PlayerPedId()
    local veh = GetVehiclePedIsUsing(ped)
    resetVeh(veh)
    QBCore.Functions.Notify(Lang:t("error.tunerchip_vehicle_has_been_reset"), 'error')
    cb("ok")
end)

RegisterNUICallback('exit', function(_, cb)
    openTunerLaptop(false)
    SetNuiFocus(false, false)
    cb('ok')
end)

RegisterNUICallback('SetStancer', function(data, cb)
    local fOffset = data.fOffset * 100 / 1000
    local fRotation = data.fRotation * 100 / 1000
    local rOffset = data.rOffset * 100 / 1000
    local rRotation = data.rRotation * 100 / 1000
    local ped = PlayerPedId()
    local veh = GetVehiclePedIsIn(ped)
    exports["vstancer"]:SetWheelPreset(veh, -fOffset, -fRotation, -rOffset, -rRotation)
    cb("ok")
end)


-- Events

RegisterNetEvent('qb-tunerchip:client:TuneStatus', function()
    local ped = PlayerPedId()
    local closestVehicle = GetClosestVehicle(GetEntityCoords(ped), 5.0, 0, 70)
    local plate = QBCore.Functions.GetPlate(closestVehicle)
    local vehModel = GetEntityModel(closestVehicle)
    if vehModel ~= 0 then
        QBCore.Functions.TriggerCallback('qb-tunerchip:server:GetStatus', function(status)
            if status then
                QBCore.Functions.Notify(Lang:t("success.this_vehicle_has_been_tuned"), 'success')
            else
                QBCore.Functions.Notify(Lang:t("error.this_vehicle_has_not_been_tuned"), 'error')
            end
        end, plate)
    else
        QBCore.Functions.Notify(Lang:t("error.no_vehicle_nearby"), 'error')
    end
end)

RegisterNetEvent('qb-tunerchip:client:openChip', function()
    local ped = PlayerPedId()
    local inVehicle = IsPedInAnyVehicle(ped)

    if inVehicle then
        QBCore.Functions.Progressbar("connect_laptop", Lang:t("error.tunerchip_vehicle_has_been_reset"), 2000, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
            anim = "machinic_loop_mechandplayer",
            flags = 16,
        }, {}, {}, function() -- Done
            StopAnimTask(PlayerPedId(), "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 1.0)
            openTunerLaptop(true)
        end, function() -- Cancel
            StopAnimTask(PlayerPedId(), "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 1.0)
            QBCore.Functions.Notify(Lang:t("error.canceled"), "error")
        end)
    else
        QBCore.Functions.Notify(Lang:t("error.you_are_not_in_a_vehicle"), "error")
    end
end)