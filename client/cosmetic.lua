QBCore = exports['qb-core']:GetCoreObject()

-- Paint

-- Special thanks to https://github.com/BryanLTU/bryan_paintjob
-- Saved me a lot of time and research!

local function HexToRgb(hex)
    hex = hex:gsub('#', '')
    return { r = tonumber('0x' .. hex:sub(1, 2)), g = tonumber('0x' .. hex:sub(3, 4)), b = tonumber('0x' .. hex:sub(5, 6)) }
end

local function SprayVehicleCustom(type, section, color)
    local vehicle = QBCore.Functions.GetClosestVehicle()
    FreezeEntityPosition(vehicle, true)
    while not HasNamedPtfxAssetLoaded('scr_paintnspray') do
        RequestNamedPtfxAsset('scr_paintnspray')
        Wait(10)
    end
    UseParticleFxAsset('scr_paintnspray')
    local particles = StartParticleFxLoopedOnEntity('scr_respray_smoke', vehicle, 0.2, 0.0, 0.1, 0.0, 80.0, 0.0, 1.2, 0, 0, 0)
    SetParticleFxLoopedAlpha(particles, 100.0)
    SetParticleFxLoopedColour(particles, color.r / 255.0, color.g / 255.0, color.b / 255.0)
    Wait(10 * 1000)
    StopParticleFxLooped(particles, 0)
    if section == 'primary' then
        SetVehicleModColor_1(vehicle, type, 0, 0)
        SetVehicleCustomPrimaryColour(vehicle, color.r, color.g, color.b)
    elseif section == 'secondary' then
        SetVehicleModColor_2(vehicle, type, 0)
        SetVehicleCustomSecondaryColour(vehicle, color.r, color.g, color.b)
    end
end

local function SprayVehicle(primary, secondary, pearlescent, wheel)
    local vehicle = QBCore.Functions.GetClosestVehicle()
    FreezeEntityPosition(vehicle, true)
    while not HasNamedPtfxAssetLoaded('scr_paintnspray') do
        RequestNamedPtfxAsset('scr_paintnspray')
        Wait(10)
    end
    UseParticleFxAsset('scr_paintnspray')
    local particles = StartParticleFxLoopedOnEntity('scr_respray_smoke', vehicle, 0.2, 0.0, 0.1, 0.0, 80.0, 0.0, 1.2, 0, 0, 0)
    SetParticleFxLoopedAlpha(particles, 100.0)
    SetParticleFxLoopedColour(particles, 211, 211, 211)
    Wait(10 * 1000)
    StopParticleFxLooped(particles, 0)
    if primary == 'none' and secondary ~= 'none' then -- only secondary
        local colorPrimary, _ = GetVehicleColours(vehicle)
        ClearVehicleCustomSecondaryColour(vehicle)
        SetVehicleColours(vehicle, colorPrimary, tonumber(secondary))
    elseif primary ~= 'none' and secondary == 'none' then -- only primary
        local _, colorSecondary = GetVehicleColours(vehicle)
        ClearVehicleCustomPrimaryColour(vehicle)
        SetVehicleColours(vehicle, tonumber(primary), colorSecondary)
    elseif primary ~= 'none' and secondary ~= 'none' then -- both
        ClearVehicleCustomPrimaryColour(vehicle)
        ClearVehicleCustomSecondaryColour(vehicle)
        SetVehicleColours(vehicle, tonumber(primary), tonumber(secondary))
    end
    if pearlescent == 'none' and wheel ~= 'none' then -- only wheels
        local pearlescentColor, _ = GetVehicleExtraColours(vehicle)
        SetVehicleExtraColours(vehicle, pearlescentColor, tonumber(wheel))
    elseif pearlescent ~= 'none' and wheel == 'none' then -- only pearl
        local _, wheelColor = GetVehicleExtraColours(vehicle)
        SetVehicleExtraColours(vehicle, tonumber(pearlescent), wheelColor)
    elseif pearlescent ~= 'none' and wheel ~= 'none' then -- both
        SetVehicleExtraColours(vehicle, tonumber(pearlescent), tonumber(wheel))
    end
    FreezeEntityPosition(vehicle, false)
end

local function GetPaints(category)
    local Paints = {}
    Paints[#Paints+1] = { value = "none", text = "None" }
    for i=1, #Config.Paints[category] do
        Paints[#Paints+1] = { value = Config.Paints[category][i].id, text = Config.Paints[category][i].label }
    end
    return Paints
end

local function PaintList(category)
    local dialog = exports['qb-input']:ShowInput({
        header = 'Paint Vehicle',
        submitText = 'Submit',
        inputs = {
            {
                text = 'Primary',
                name = 'primarypaint',
                type = 'select',
                options = GetPaints(category)
            },
            {
                text = 'Secondary',
                name = 'secondarypaint',
                type = 'select',
                options = GetPaints(category)
            },
            {
                text = 'Pearlescent',
                name = 'pearlescentpaint',
                type = 'select',
                options = GetPaints(category)
            },
            {
                text = 'Wheels',
                name = 'wheelpaint',
                type = 'select',
                options = GetPaints(category)
            }
        }
    })
    if dialog.primarypaint and dialog.secondarypaint and dialog.pearlescentpaint and dialog.wheelpaint then
        SprayVehicle(dialog.primarypaint, dialog.secondarypaint, dialog.pearlescentpaint, dialog.wheelpaint)
    end
end

local function CustomColor()
    local dialog = exports['qb-input']:ShowInput({
        header = 'Custom Colors',
        submitText = 'Submit',
        inputs = {
            {
                text = 'HEX',
                name = 'hex',
                type = 'text',
                isRequired = true
            },
            {
                text = 'Section',
                name = 'section',
                type = 'radio',
                options = {
                    { value = 'primary', text = 'Primary' },
                    { value = 'secondary', text = 'Secondary' }
                }
            },
            {
                text = 'Type',
                name = 'type',
                type = 'radio',
                options = {
                    { value = 'Normal', text = 'Normal' },
                    { value = 'Metallic', text = 'Metallic' },
                    { value = 'Pearl', text = 'Pearl' },
                    { value = 'Matte', text = 'Matte' },
                    { value = 'Metal', text = 'Metal' },
                    { value = 'Chrome', text = 'Chrome' }
                }
            }
        }
    })
    if dialog.hex and dialog.section and dialog.type then
        SprayVehicleCustom(dialog.type, dialog.section, HexToRgb(dialog.hex))
    end
end

local function PaintCategories()
    local Paints = {}
    Paints[#Paints+1] = {
        header = 'Custom Color',
        icon = 'fas fa-fill',
        params = {
            isAction = true,
            event = function()
                CustomColor()
            end,
            args = {}
        }
    }
    for k in pairs(Config.Paints) do
        Paints[#Paints+1] = {
            header = k,
            icon = 'fas fa-fill',
            params = {
                isAction = true,
                event = function()
                    PaintList(k)
                end,
                args = {}
            }
        }
    end
    exports['qb-menu']:openMenu(Paints, true)
end

CreateThread(function ()
    for _, v in pairs(Config.Shops) do
        exports['qb-target']:AddBoxZone(v.job..'_paintbooth', v.paint, 1.5, 1.5, {
            name = v.job..'_paintbooth',
            heading = 0,
            debugPoly = false,
            minZ = v.paint.z - 1.0,
            maxZ = v.paint.z + 1.0,
        }, {
            options = {{
                label = 'Paint Vehicle',
                icon = 'fas fa-fill-drip',
                job = v.job,
                action = function()
                    PaintCategories()
                end
            }},
            distance = 2.0
        })
    end
end)

-- Interior

local function OpenInteriors()
    local vehicle = GetVehiclePedIsUsing(PlayerPedId())
    if vehicle == 0 then return end
    if GetVehicleModKit(vehicle) ~= 0 then SetVehicleModKit(vehicle, 0) end
    local mods = {}
    for i=1, #Config.InteriorCategories do
        local modCount = GetNumVehicleMods(vehicle, Config.InteriorCategories[i].id)
        if modCount > 0 then
            mods[#mods+1] = {
                header = Config.InteriorCategories[i].label,
                icon = 'fas fa-gears',
                params = {
                    isAction = true,
                    event = function()
                        InteriorModList(Config.InteriorCategories[i].id)
                    end,
                    args = {}
                }
            }
        end
    end
    exports['qb-menu']:openMenu(mods, true)
end

function InteriorModList(id)
    local vehicle = GetVehiclePedIsUsing(PlayerPedId())
    local mods = {}
    for i=1, GetNumVehicleMods(vehicle, id) - 1 do
        mods[#mods+1] = {
            header = GetLabelText(GetModTextLabel(vehicle, id, i)),
            icon = 'fas fa-gears',
            params = {
                isAction = true,
                event = function(data)
                    SetVehicleModKit(vehicle, 0)
                    SetVehicleMod(vehicle, data.modType, data.modIndex, false)
                    if id == 14 then
                        StartVehicleHorn(vehicle, 10000, 0, false)
                    end
                    InteriorModList(id)
                end,
                args = {
                    modType = id,
                    modIndex = i
                }
            }
        }
    end
    mods[#mods+1] = {
        header = 'Back',
        icon = 'fas fa-backward',
        params = {
            isAction = true,
            event = function()
                OpenInteriors()
            end,
            args = {}
        }
    }
    exports['qb-menu']:openMenu(mods)
end

-- Exterior

local function OpenExteriors()
    local vehicle = GetVehiclePedIsUsing(PlayerPedId())
    if vehicle == 0 then return end
    if GetVehicleModKit(vehicle) ~= 0 then SetVehicleModKit(vehicle, 0) end
    local mods = {}
    for i=1, #Config.ExteriorCategories do
        local modCount = GetNumVehicleMods(vehicle, Config.ExteriorCategories[i].id)
        if modCount > 0 then
            mods[#mods+1] = {
                header = Config.ExteriorCategories[i].label,
                icon = 'fas fa-gears',
                params = {
                    isAction = true,
                    event = function()
                        ExteriorModList(Config.ExteriorCategories[i].id)
                    end,
                    args = {}
                }
            }
        end
    end
    exports['qb-menu']:openMenu(mods, true)
end

function ExteriorModList(id)
    local vehicle = GetVehiclePedIsUsing(PlayerPedId())
    local mods = {}
    for i=1, GetNumVehicleMods(vehicle, id) - 1 do
        mods[#mods+1] = {
            header = GetLabelText(GetModTextLabel(vehicle, id, i)),
            icon = 'fas fa-gears',
            params = {
                isAction = true,
                event = function()
                    SetVehicleModKit(vehicle, 0)
                    SetVehicleMod(vehicle, id, i, false)
                    ExteriorModList(id)
                end,
                args = {}
            }
        }
    end
    mods[#mods+1] = {
        header = 'Back',
        icon = 'fas fa-backward',
        params = {
            isAction = true,
            event = function()
                OpenExteriors()
            end,
            args = {}
        }
    }
    exports['qb-menu']:openMenu(mods)
end

-- Tire Smoke

local function GetSmokeList()
    local smokes = {}
    for i=1, #Config.TyreSmoke do
        smokes[#smokes+1] = {
            value = Config.TyreSmoke[i].label,
            text = Config.TyreSmoke[i].label
        }
    end
    return smokes
end

local function GetSmokeColors(color)
    for i=1, #Config.TyreSmoke do
        if Config.TyreSmoke[i].label == color then
            return Config.TyreSmoke[i].r, Config.TyreSmoke[i].g, Config.TyreSmoke[i].b
        end
    end
end

local function TireSmoke()
    local vehicle = GetVehiclePedIsUsing(PlayerPedId())
    if vehicle == 0 then return end
    if IsThisModelABicycle(joaat(vehicle)) then return end
    local dialog = exports['qb-input']:ShowInput({
        header = 'Tire Smoke',
        submitText = 'Submit',
        inputs = {
            {
                text = 'HEX',
                name = 'hex',
                type = 'text',
                isRequired = false
            },
            {
                text = 'Standard',
                name = 'color',
                type = 'select',
                options = GetSmokeList()
            },
            {
                text = 'Toggle',
                name = 'toggle',
                type = 'radio',
                options = {
                    { value = 'togglehex', text = 'HEX' },
                    { value = 'togglestandard', text = 'Standard' },
                }
            }
        }
    })
    if dialog.toggle == 'togglehex' then
        local color = HexToRgb(dialog.hex)
        ToggleVehicleMod(vehicle, 20, true)
        SetVehicleTyreSmokeColor(vehicle, color.r, color.g, color.b)
    else
        ToggleVehicleMod(vehicle, 20, true)
        SetVehicleTyreSmokeColor(vehicle, GetSmokeColors(dialog.color))
    end
end

-- Wheels

local function OpenWheels()
    local vehicle = GetVehiclePedIsUsing(PlayerPedId())
    if vehicle == 0 then return end
    if IsThisModelABicycle(joaat(vehicle)) then return end
    local mods = {}
    for i=1, #Config.WheelCategories do
        mods[#mods+1] = {
            header = Config.WheelCategories[i].label,
            icon = 'fas fa-truck-monster',
            params = {
                isAction = true,
                event = function()
                    OpenWheelList(Config.WheelCategories[i].id)
                end,
                args = {}
            }
        }
    end
    mods[#mods+1] = {
        header = 'Tire Smoke',
        icon = 'fas fa-smog',
        params = {
            isAction = true,
            event = function()
                TireSmoke()
            end,
            args = {}
        }
    }
    exports['qb-menu']:openMenu(mods)
end

function OpenWheelList(id)
    local vehicle = GetVehiclePedIsUsing(PlayerPedId())
    local mods = {}
    SetVehicleWheelType(vehicle, id)
    for i=1, GetNumVehicleMods(vehicle, 23) - 1 do
        mods[#mods+1] = {
            header = GetLabelText(GetModTextLabel(vehicle, 23, i)),
            icon = 'fas fa-truck-monster',
            params = {
                isAction = true,
                event = function()
                    SetVehicleModKit(vehicle, 0)
                    SetVehicleMod(vehicle, 23, i, false)
                    OpenWheelList(id)
                end,
                args = {}
            }
        }
    end
    mods[#mods+1] = {
        header = 'Back',
        icon = 'fas fa-backward',
        params = {
            isAction = true,
            event = function()
                OpenWheels()
            end,
            args = {}
        }
    }
    exports['qb-menu']:openMenu(mods)
end

-- Neons

local function GetNeonList()
    local neons = {}
    for i=1, #Config.NeonColors do
        neons[#neons+1] = {
            value = Config.NeonColors[i].label,
            text = Config.NeonColors[i].label
        }
    end
    return neons
end

local function GetNeonColors(color)
    for i=1, #Config.NeonColors do
        if Config.NeonColors[i].label == color then
            return Config.NeonColors[i].r, Config.NeonColors[i].g, Config.NeonColors[i].b
        end
    end
end

local function OpenNeon()
    local vehicle = GetVehiclePedIsUsing(PlayerPedId())
    if vehicle == 0 then return end
    if IsThisModelABicycle(joaat(vehicle)) then return end
    local dialog = exports['qb-input']:ShowInput({
        header = 'Neons',
        submitText = 'Submit',
        inputs = {
            {
                text = 'Color',
                name = 'color',
                type = 'select',
                options = GetNeonList()
            },
            {
                text = 'Front Toggle',
                name = 'frontenable',
                type = 'radio',
                options = {
                    { value = 'enable', text = 'Enabled' },
                    { value = 'disable', text = 'Disabled' },
                }
            },
            {
                text = 'Rear Toggle',
                name = 'rearenable',
                type = 'radio',
                options = {
                    { value = 'enable', text = 'Enabled' },
                    { value = 'disable', text = 'Disabled' },
                }
            },
            {
                text = 'Left Toggle',
                name = 'leftenable',
                type = 'radio',
                options = {
                    { value = 'enable', text = 'Enabled' },
                    { value = 'disable', text = 'Disabled' },
                }
            },
            {
                text = 'Right Toggle',
                name = 'rightenable',
                type = 'radio',
                options = {
                    { value = 'enable', text = 'Enabled' },
                    { value = 'disable', text = 'Disabled' },
                }
            }
        }
    })

    if dialog.frontenable == 'enable' then SetVehicleNeonLightEnabled(vehicle, 2, true)
    else SetVehicleNeonLightEnabled(vehicle, 2, false) end

    if dialog.rearenable == 'enable' then SetVehicleNeonLightEnabled(vehicle, 3, true)
    else SetVehicleNeonLightEnabled(vehicle, 3, false) end

    if dialog.leftenable == 'enable' then SetVehicleNeonLightEnabled(vehicle, 0, true)
    else SetVehicleNeonLightEnabled(vehicle, 0, false) end

    if dialog.rightenable == 'enable' then SetVehicleNeonLightEnabled(vehicle, 1, true)
    else SetVehicleNeonLightEnabled(vehicle, 1, false) end

    SetVehicleNeonLightsColour(vehicle, GetNeonColors(dialog.color))
end

-- Headlights

local function GetXenonList()
    local xenons = {}
    for i=1, #Config.Xenon do
        xenons[#xenons+1] = {
            value = Config.Xenon[i].id,
            text = Config.Xenon[i].label
        }
    end
    return xenons
end

local function OpenXenon()
    local vehicle = GetVehiclePedIsUsing(PlayerPedId())
    if vehicle == 0 then return end
    if IsThisModelABicycle(joaat(vehicle)) then return end
    local dialog = exports['qb-input']:ShowInput({
        header = 'Xenon Headlights',
        submitText = 'Submit',
        inputs = {
            {
                text = 'HEX',
                name = 'hex',
                type = 'text',
                isRequired = false
            },
            {
                text = 'Color',
                name = 'color',
                type = 'select',
                options = GetXenonList()
            },
            {
                text = 'Toggle',
                name = 'toggle',
                type = 'radio',
                options = {
                    { value = 'enable', text = 'Enabled' },
                    { value = 'disable', text = 'Disabled' },
                }
            }
        }
    })
    if dialog.hex and dialog.color == -1 then
        local color = HexToRgb(dialog.hex)
        ToggleVehicleMod(vehicle, 22, true)
        SetVehicleXenonLightsCustomColor(vehicle, color.r, color.g, color.b)
    end
    if dialog.hex and dialog.color ~= -1 then
        ToggleVehicleMod(vehicle, 22, true)
        ClearVehicleXenonLightsCustomColor(vehicle)
        SetVehicleXenonLightsColor(vehicle, tonumber(dialog.color))
    end
    if dialog.toggle == 'disable' then
        ToggleVehicleMod(vehicle, 22, false)
    end
end

-- Window Tint

local function WindowTint()
    local vehicle = GetVehiclePedIsUsing(PlayerPedId())
    if vehicle == 0 then return end
    if IsThisModelABicycle(joaat(vehicle)) then return end
    local tints = {}
    if GetNumVehicleWindowTints() > 0 then
        for i=1, #Config.WindowTints do
            tints[#tints+1] = {
                header = Config.WindowTints[i].label,
                icon = 'fas fa-window-maximize',
                params = {
                    isAction = true,
                    event = function()
                        SetVehicleModKit(vehicle, 0)
                        SetVehicleWindowTint(vehicle, Config.WindowTints[i].id)
                        WindowTint()
                    end,
                    args = {}
                }
            }
        end
    end
    exports['qb-menu']:openMenu(tints)
end

-- Plates

local function PlateIndex()
    local vehicle = GetVehiclePedIsUsing(PlayerPedId())
    if vehicle == 0 then return end
    if IsThisModelABicycle(joaat(vehicle)) then return end
    local plates = {}
    for i=1, #Config.PlateIndexes do
        plates[#plates+1] = {
            header = Config.PlateIndexes[i].label,
            icon = 'far fa-id-card',
            params = {
                isAction = true,
                event = function(data)
                    SetVehicleNumberPlateTextIndex(vehicle, Config.PlateIndexes[i].id)
                    PlateIndex()
                end,
                args = {}
            }
        }
    end
    exports['qb-menu']:openMenu(plates)
end

-- Events

RegisterNetEvent('qb-mechanicjob:client:installCosmetic', function(item)
    local vehicle = QBCore.Functions.GetClosestVehicle()
    if GetVehicleModKit(vehicle) ~= 0 then SetVehicleModKit(vehicle, 0) end
    if item == 'veh_interior' then
        OpenInteriors()
    elseif item == 'veh_exterior' then
        OpenExteriors()
    elseif item == 'veh_wheels' then
        OpenWheels()
    elseif item == 'veh_neon' then
        OpenNeon()
    elseif item == 'veh_xenon' then
        OpenXenon()
    elseif item == 'veh_tint' then
        WindowTint()
    elseif item == 'veh_plate' then
        PlateIndex()
    end
end)