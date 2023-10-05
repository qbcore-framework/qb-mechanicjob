VehicleStatus = {}
PlayerData = {}
local onDuty = false

-- zone check
local isInsideDutyZone = false
local isInsideStashZone = false
local isInsideGarageZone = false
local isInsidePaintZone = false

-- Handlers

AddEventHandler('OnResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then return end
    PlayerData = QBCore.Functions.GetPlayerData()
end)

AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerData.job = JobInfo
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    PlayerData = {}
end)

-- Functions

local function GetVehicleStatusList(plate)
    local retval = nil
    if VehicleStatus[plate] ~= nil then
        retval = VehicleStatus[plate]
    end
    return retval
end

local function GetVehicleStatus(plate, part)
    local retval = nil
    if VehicleStatus[plate] ~= nil then
        retval = VehicleStatus[plate][part]
    end
    return retval
end

local function SetVehicleStatus(plate, part, level)
    TriggerServerEvent("qb-mechanicjob:server:updatePart", plate, part, level)
end

exports('GetVehicleStatusList', GetVehicleStatusList)
exports('GetVehicleStatus', GetVehicleStatus)
exports('SetVehicleStatus', SetVehicleStatus)

local function SpawnListVehicle(model, spawnPoint)
    QBCore.Functions.TriggerCallback('QBCore:Server:SpawnVehicle', function(netId)
        local veh = NetToVeh(netId)
        SetVehicleNumberPlateText(veh, "ACBV"..tostring(math.random(1000, 9999)))
        SetEntityHeading(veh, spawnPoint.w)
        exports['LegacyFuel']:SetFuel(veh, 100.0)
        TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
        TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(veh))
        SetVehicleEngineOn(veh, true, true)
    end, model, spawnPoint, true)
end

local function VehicleList()
    local vehicleMenu = {
        {
            header = "Vehicle List",
            isMenuHeader = true
        }
    }
    for _,v in pairs(Config.Shops['lscustoms'].vehicles.list) do
        vehicleMenu[#vehicleMenu+1] = {
            header = QBCore.Shared.Vehicles[v].name,
            params = {
                event = "qb-mechanicjob:client:SpawnListVehicle",
                args = {
                    spawnName = v,
                    location = Config.Shops['lscustoms'].vehicles.spawn
                }
            }
        }
    end
    vehicleMenu[#vehicleMenu+1] = {
        header = Lang:t('nodamage_menu.c_menu'),
        txt = "",
        params = {
            event = "qb-menu:client:closeMenu"
        }

    }
    exports['qb-menu']:openMenu(vehicleMenu)
end

-- Events

RegisterNetEvent("qb-mechanicjob:client:SpawnListVehicle",function(data)
    local vehicleSpawnName = data.spawnName
    local spawnPoint = data.location
    SpawnListVehicle(vehicleSpawnName, spawnPoint)
end)

-- Target Setup

CreateThread(function()

    -- Duty

    for k, v in pairs(Config.Shops) do
        exports['qb-target']:AddBoxZone(k..'_duty', v.duty, 1.5, 1.5, {
            name = k..'_duty',
            heading = 0,
            debugPoly = false,
            minZ = v.duty.z - 1.0,
            maxZ = v.duty.z + 1.0,
        }, {
            options = {{
                type = 'server',
                event = 'QBCore:ToggleDuty',
                label = 'Toggle Duty',
                icon = 'fas fa-user-clock',
                job = v.job
            }},
            distance = 2.0
        })
    end

    -- Stash

    for _, v in pairs(Config.Shops) do
        exports['qb-target']:AddBoxZone(v.job..'_jobstash', v.stash, 1.5, 1.5, {
            name = v.job..'_jobstash',
            heading = 0,
            debugPoly = false,
            minZ = v.stash.z - 1.0,
            maxZ = v.stash.z + 1.0,
        }, {
            options = {{
                label = 'Stash',
                icon = 'fas fa-box-open',
                job = v.job,
                action = function()
                    TriggerEvent("inventory:client:SetCurrentStash", v.job..'_jobstash')
                    TriggerServerEvent("inventory:server:OpenInventory", "stash", v.job..'_jobstash', {
                        maxweight = 4000000,
                        slots = 500,
                    })
                end
            }},
            distance = 2.0
        })
    end

    -- Shop

    for _, v in pairs(Config.Shops) do
        exports['qb-target']:AddBoxZone(v.job..'_shop', v.shop, 1.5, 1.5, {
            name = v.job..'_shop',
            heading = 0,
            debugPoly = false,
            minZ = v.shop.z - 1.0,
            maxZ = v.shop.z + 1.0,
        }, {
            options = {{
                label = 'Shop',
                icon = 'fas fa-cart-shopping',
                job = v.job,
                action = function()
                    local ShopItems = {}
                    ShopItems.items = {}
                    ShopItems.label = v.job..'_shop'
                    for i=1, #Config.Products[v.job] do
                        ShopItems.items[#ShopItems.items + 1] = {
                            name = Config.Products[v.job][i].name,
                            item = Config.Products[v.job][i].name,
                            price = Config.Products[v.job][i].price,
                            amount = Config.Products[v.job][i].amount,
                            type = Config.Products[v.job][i].type,
                            slot = i,
                        }
                    end
                    TriggerServerEvent('inventory:server:OpenInventory', 'shop', v.job..'_shop', ShopItems)
                end
            }},
            distance = 2.0
        })
    end

    -- Vehicle Spawner

    for _, v in pairs(Config.Shops) do
        exports['qb-target']:AddBoxZone(v.job..'_spawner', v.vehicles.withdraw, 1.5, 1.5, {
            name = v.job..'_spawner',
            heading = 0,
            debugPoly = false,
            minZ = v.vehicles.withdraw - 1.0,
            maxZ = v.vehicles.withdraw + 1.0,
        }, {
            options = {
                {
                    label = 'Withdraw Vehicle',
                    icon = 'fas fa-car',
                    job = v.job,
                    canInteract = function()
                        local inVehicle = GetVehiclePedIsUsing(PlayerPedId())
                        if inVehicle ~= 0 then
                            return false
                        else
                            return true
                        end
                    end,
                    action = function()
                        VehicleList()
                    end
                },
                {
                    label = 'Deposit Vehicle',
                    icon = 'fas fa-car',
                    job = v.job,
                    canInteract = function()
                        local inVehicle = GetVehiclePedIsUsing(PlayerPedId())
                        if inVehicle ~= 0 then
                            return true
                        else
                            return false
                        end
                    end,
                    action = function()
                        SetEntityAsMissionEntity(GetVehiclePedIsUsing(PlayerPedId()), true ,true)
                        DeleteVehicle(GetVehiclePedIsUsing(PlayerPedId()))
                    end
                }
            },
            distance = 5.0
        })
    end
end)

-- Threads

CreateThread(function()
    for _, v in pairs(Config.Shops) do
        if v['showBlip'] then
            local blip = AddBlipForCoord(v['blipCoords'])
            SetBlipSprite(blip, v['blipSprite'])
            SetBlipDisplay(blip, 4)
            SetBlipScale(blip, 0.6)
            SetBlipColour(blip, v['blipColor'])
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(v['shopLabel'])
            EndTextCommandSetBlipName(blip)
        end
    end
end)

-- Non-Target Zones

-- CreateThread(function()
--     local wait = 500
--     while not LocalPlayer.state.isLoggedIn do
--         -- do nothing
--         Wait(wait)
--     end

--     RegisterGarageZone()
--     RegisterDutyTarget()
--     RegisterStashTarget()
--     SetVehiclePlateZones()

--     while true do
--         wait = 500
--         SetClosestPlate()

--         if PlayerJob.type == 'mechanic' then

--             if isInsideDutyZone then
--                 wait = 0
--                 if IsControlJustPressed(0, 38) then
--                     TriggerServerEvent("QBCore:ToggleDuty")
--                 end
--             end

--             if onDuty then
--                 if isInsideStashZone then
--                     wait = 0
--                     if IsControlJustPressed(0, 38) then
--                         TriggerEvent("qb-mechanicjob:client:target:OpenStash")
--                     end
--                 end

--                 if isInsideGarageZone then
--                     wait = 0
--                     local inVehicle = IsPedInAnyVehicle(PlayerPedId())
--                     if IsControlJustPressed(0, 38) then
--                         if inVehicle then
--                             DeleteVehicle(GetVehiclePedIsIn(PlayerPedId()))
--                             exports['qb-core']:HideText()
--                         else
--                             VehicleList()
--                             exports['qb-core']:HideText()
--                         end
--                     end
--                 end

--                 if isInsideVehiclePlateZone then
--                     wait = 0
--                     local attachedVehicle = Config.Plates[ClosestPlate].AttachedVehicle
--                     local coords = Config.Plates[ClosestPlate].coords
--                     if attachedVehicle then
--                         if IsControlJustPressed(0, 38) then
--                             exports['qb-core']:HideText()
--                             OpenMenu()
--                         end
--                     else
--                         if IsControlJustPressed(0, 38) and IsPedInAnyVehicle(PlayerPedId()) then
--                             local veh = GetVehiclePedIsIn(PlayerPedId())
--                             DoScreenFadeOut(150)
--                             Wait(150)
--                             Config.Plates[ClosestPlate].AttachedVehicle = veh
--                             SetEntityCoords(veh, coords)
--                             SetEntityHeading(veh, coords.w)
--                             FreezeEntityPosition(veh, true)
--                             Wait(500)
--                             DoScreenFadeIn(150)
--                             TriggerServerEvent('qb-mechanicjob:server:SetAttachedVehicle', veh, ClosestPlate)

--                             DestroyVehiclePlateZone(ClosestPlate)
--                             RegisterVehiclePlateZone(ClosestPlate, Config.Plates[ClosestPlate])
--                         end
--                     end
--                 end
--             end
--         end
--         Wait(wait)
--     end
-- end)