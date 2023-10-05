local openingDoor = false

-- Functions

local function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Wait(5)
    end
end

local function ScrapAnim(time)
    time = time / 1000
    loadAnimDict("mp_car_bomb")
    TaskPlayAnim(PlayerPedId(), "mp_car_bomb", "car_bomb_mechanic" ,3.0, 3.0, -1, 16, 0, false, false, false)
    openingDoor = true
    CreateThread(function()
        while openingDoor do
            TaskPlayAnim(PlayerPedId(), "mp_car_bomb", "car_bomb_mechanic", 3.0, 3.0, -1, 16, 0, 0, 0, 0)
            Wait(2000)
            time = time - 2
            if time <= 0 then
                openingDoor = false
                StopAnimTask(PlayerPedId(), "mp_car_bomb", "car_bomb_mechanic", 1.0)
            end
        end
    end)
end

-- Toolbox

local function RepairPart(part)
    local PartData = Config.RepairCostAmount[part]
    local hasitem = false
    local indx = 0
    local countitem = 0
    QBCore.Functions.TriggerCallback('qb-inventory:server:GetStashItems', function(StashItems)
        for k,v in pairs(StashItems) do
            if v.name == PartData.item then
                hasitem = true
                if v.amount >= PartData.costs then
                    countitem = v.amount
                    indx = k
                end
            end
        end
        if hasitem and countitem >= PartData.costs then
            TriggerEvent('animations:client:EmoteCommandStart', {"mechanic"})
            QBCore.Functions.Progressbar("repair_part", Lang:t('labels.progress_bar') ..Config.ValuesLabels[part], math.random(5000, 10000), false, true, {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            }, {}, {}, {}, function() -- Done
                TriggerEvent('animations:client:EmoteCommandStart', {"c"})
                if (countitem - PartData.costs) <= 0 then
                    StashItems[indx] = nil
                else
                    countitem = (countitem - PartData.costs)
                    StashItems[indx].amount = countitem
                end
                TriggerEvent('qb-mechanicjob:client:RepaireeePart', part)
                TriggerServerEvent('qb-inventory:server:SaveStashItems', "mechanicstash", StashItems)
                SetTimeout(250, function()
                    PartsMenu()
                end)
            end, function()
                QBCore.Functions.Notify(Lang:t('notifications.rep_canceled'), "error")
            end)
        else
            QBCore.Functions.Notify(Lang:t('notifications.not_materials'), 'error')
        end
    end, "mechanicstash")
end

local function PartMenu(data)
    local partName = data.name
    local part = data.parts
    local TestMenu1 = {
        {
            header = Lang:t('parts_menu.menu_header'),
            isMenuHeader = true
        },
        {
            header = ""..partName.."",
            txt = Lang:t('parts_menu.repair_op')..QBCore.Shared.Items[Config.RepairCostAmount[part].item]["label"].." "..Config.RepairCostAmount[part].costs.."x",
            params = {
                isAction = true,
                event = function()
                    RepairPart(part)
                end,
                args = {}
            }
        },
        {
            header = Lang:t('parts_menu.b_menu'),
            txt = Lang:t('parts_menu.d_menu'),
            params = {
                isAction = true,
                event = function()
                    PartsMenu()
                end,
                args = {}
            }
        },
        {
            header = Lang:t('parts_menu.c_menu'),
            txt = "",
            params = {
                event = "qb-menu:client:closeMenu",
            }
        },
    }
    exports['qb-menu']:openMenu(TestMenu1)
end

local function NoDamage()
    local noDamage = {
        {
            header = Lang:t('nodamage_menu.header'),
            isMenuHeader = true
        },
        {
            header = Lang:t('nodamage_menu.bh_menu'),
            txt = Lang:t('nodamage_menu.bd_menu'),
            params = {
                isAction = true,
                event = function()
                    PartsMenu()
                end,
                args = {}
            }
        },
        {
            header = Lang:t('nodamage_menu.c_menu'),
            txt = "",
            params = {
                event = "qb-menu:client:closeMenu",
            }
        },
    }
    exports['qb-menu']:openMenu(noDamage)
end

function PartsMenu()
    local vehicle = QBCore.Functions.GetClosestVehicle()
    local plate = QBCore.Functions.GetPlate(vehicle)
    if VehicleStatus[plate] ~= nil then
        local vehicleMenu = {
            {
                header = "Status",
                isMenuHeader = true
            }
        }
        for k,v in pairs(Config.ValuesLabels) do
            if math.ceil(VehicleStatus[plate][k]) ~= Config.MaxStatusValues[k] then
                local percentage = math.ceil(VehicleStatus[plate][k])
                if percentage > 100 then
                    percentage = math.ceil(VehicleStatus[plate][k]) / 10
                end
                vehicleMenu[#vehicleMenu+1] = {
                    header = v,
                    txt = Lang:t('parts_menu.status') .. percentage .. "% / 100.0%",
                    params = {
                        isAction = true,
                        event = function(data)
                            PartMenu(data)
                        end,
                        args = {
                            name = v,
                            parts = k
                        }
                    }
                }
            else
                local percentage = math.ceil(Config.MaxStatusValues[k])
                if percentage > 100 then
                    percentage = math.ceil(Config.MaxStatusValues[k]) / 10
                end
                vehicleMenu[#vehicleMenu+1] = {
                    header = v,
                    txt = Lang:t('parts_menu.status') .. percentage .. "% / 100.0%",
                    params = {
                        isAction = true,
                        event = function()
                            NoDamage()
                        end,
                    }
                }
            end
        end
        vehicleMenu[#vehicleMenu+1] = {
            header = Lang:t('lift_menu.c_menu'),
            txt = "",
            params = {
                event = "qb-menu:client:closeMenu"
            }
        }
        exports['qb-menu']:openMenu(vehicleMenu)
    end
end

RegisterNetEvent("qb-mechanicjob:client:PartsMenu",function()
    PartsMenu()
end)

-- Events

RegisterNetEvent('qb-mechanicjob:client:repairPart', function(part, level, needAmount)
    if not IsPedInAnyVehicle(PlayerPedId(), false) then
        local veh = GetVehiclePedIsIn(PlayerPedId(), true)
        if veh ~= nil and veh ~= 0 then
            local vehpos = GetEntityCoords(veh)
            local pos = GetEntityCoords(PlayerPedId())
            if #(pos - vehpos) < 5.0 then
                if not IsThisModelABicycle(GetEntityModel(veh)) then
                    local plate = QBCore.Functions.GetPlate(veh)
                    if VehicleStatus[plate] ~= nil and VehicleStatus[plate][part] ~= nil then
                        local lockpickTime = (1000 * level)
                        if part == "body" then
                            lockpickTime = lockpickTime / 10
                        end
                        ScrapAnim(lockpickTime)
                        QBCore.Functions.Progressbar("repair_advanced", Lang:t('notifications.progress_bar'), lockpickTime, false, true, {
                            disableMovement = true,
                            disableCarMovement = true,
                            disableMouse = false,
                            disableCombat = true,
                        }, {
                            animDict = "mp_car_bomb",
                            anim = "car_bomb_mechanic",
                            flags = 16,
                        }, {}, {}, function() -- Done
                            openingDoor = false
                            ClearPedTasks(PlayerPedId())
                            if part == "body" then
                                local enhealth = GetVehicleEngineHealth(veh)
                                SetVehicleBodyHealth(veh, GetVehicleBodyHealth(veh) + level)
                                SetVehicleFixed(veh)
                                SetVehicleEngineHealth(veh, enhealth)
                                TriggerServerEvent("qb-mechanicjob:server:updatePart", plate, part, GetVehicleBodyHealth(veh))
                                TriggerServerEvent("qb-mechanicjob:server:removePart", part, needAmount)
                                TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[Config.RepairCostAmount[part].item], "remove")
                            elseif part ~= "engine" then
                                TriggerServerEvent("qb-mechanicjob:server:updatePart", plate, part, GetVehicleStatus(plate, part) + level)
                                TriggerServerEvent("qb-mechanicjob:server:removePart", part, level)
                                TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[Config.RepairCostAmount[part].item], "remove")
                            end
                        end, function() -- Cancel
                            openingDoor = false
                            ClearPedTasks(PlayerPedId())
                            QBCore.Functions.Notify(Lang:t('notifications.process_canceled'), "error")
                        end)
                    else
                        QBCore.Functions.Notify(Lang:t('notifications.not_part'), "error")
                    end
                else
                    QBCore.Functions.Notify(Lang:t('notifications.not_valid'), "error")
                end
            else
                QBCore.Functions.Notify(Lang:t('notifications.not_close'), "error")
            end
        else
            QBCore.Functions.Notify(Lang:t('notifications.veh_first'), "error")
        end
    else
        QBCore.Functions.Notify(Lang:t('notifications.not_vehicle'), "error")
    end
end)

RegisterNetEvent('qb-mechanicjob:client:RepaireeePart', function(part)
    local veh = QBCore.Functions.GetClosestVehicle()
    local plate = QBCore.Functions.GetPlate(veh)
    if part == "engine" then
        SetVehicleEngineHealth(veh, Config.MaxStatusValues[part])
        TriggerServerEvent("qb-mechanicjob:server:updatePart", plate, "engine", Config.MaxStatusValues[part])
    elseif part == "body" then
        local enhealth = GetVehicleEngineHealth(veh)
        local realFuel = GetVehicleFuelLevel(veh)
        SetVehicleBodyHealth(veh, Config.MaxStatusValues[part])
        TriggerServerEvent("qb-mechanicjob:server:updatePart", plate, "body", Config.MaxStatusValues[part])
        SetVehicleFixed(veh)
        SetVehicleEngineHealth(veh, enhealth)
        if GetVehicleFuelLevel(veh) ~= realFuel then
            SetVehicleFuelLevel(veh, realFuel)
        end
    else
        TriggerServerEvent("qb-mechanicjob:server:updatePart", plate, part, Config.MaxStatusValues[part])
    end
    QBCore.Functions.Notify(Lang:t('notifications.partrep', {value = Config.ValuesLabels[part]}))
end)
RegisterNetEvent('qb-mechanicjob:client:setVehicleStatus', function(plate, status)
    VehicleStatus[plate] = status
end)

RegisterNetEvent('qb-mechanicjob:client:fixEverything', function()
    if (IsPedInAnyVehicle(PlayerPedId(), false)) then
        local veh = GetVehiclePedIsIn(PlayerPedId(),false)
        if not IsThisModelABicycle(GetEntityModel(veh)) and GetPedInVehicleSeat(veh, -1) == PlayerPedId() then
            local plate = QBCore.Functions.GetPlate(veh)
            TriggerServerEvent("qb-mechanicjob:server:fixEverything", plate)
        else
            QBCore.Functions.Notify(Lang:t('notifications.wrong_seat'), "error")
        end
    else
        QBCore.Functions.Notify(Lang:t('notifications.not_vehicle'), "error")
    end
end)

RegisterNetEvent('qb-mechanicjob:client:setPartLevel', function(part, level)
    if (IsPedInAnyVehicle(PlayerPedId(), false)) then
        local veh = GetVehiclePedIsIn(PlayerPedId(),false)
        if not IsThisModelABicycle(GetEntityModel(veh)) and GetPedInVehicleSeat(veh, -1) == PlayerPedId() then
            local plate = QBCore.Functions.GetPlate(veh)
            if part == "engine" then
                SetVehicleEngineHealth(veh, level)
                TriggerServerEvent("qb-mechanicjob:server:updatePart", plate, "engine", GetVehicleEngineHealth(veh))
            elseif part == "body" then
                SetVehicleBodyHealth(veh, level)
                TriggerServerEvent("qb-mechanicjob:server:updatePart", plate, "body", GetVehicleBodyHealth(veh))
            else
                TriggerServerEvent("qb-mechanicjob:server:updatePart", plate, part, level)
            end
        else
            QBCore.Functions.Notify(Lang:t('notifications.wrong_seat'), "error")
        end
    else
        QBCore.Functions.Notify(Lang:t('notifications.wrong_seat'), "error")
    end
end)