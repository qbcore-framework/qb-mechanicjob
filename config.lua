Config = {}

-- **** IMPORTANT ****
-- UseTarget should only be set to true when using qb-target
Config.UseTarget = GetConvar('UseTarget', false)
--Config.UseTarget = true
Config.Targets = {}

Config.AttachedVehicle = nil

Config.AuthorizedIds = {
    -- "insertcitizenidhere",
}

Config.MaxStatusValues = {
    ["engine"] = 1000.0,
    ["body"] = 1000.0,
    ["radiator"] = 100,
    ["axle"] = 100,
    ["brakes"] = 100,
    ["clutch"] = 100,
    ["fuel"] = 100,
}

Config.ValuesLabels = {
    ["engine"] = "引擎",
    ["body"] = "鈑件",
    ["radiator"] = "散熱器",
    ["axle"] = "傳動軸",
    ["brakes"] = "剎車",
    ["clutch"] = "離合器",
    ["fuel"] = "油箱",
}

Config.RepairCost = {
    ["body"] = "plastic",
    ["radiator"] = "plastic",
    ["axle"] = "steel",
    ["brakes"] = "iron",
    ["clutch"] = "aluminum",
    ["fuel"] = "plastic",
}

Config.RepairCostAmount = {
    ["engine"] = {
        item = "metalscrap",
        costs = 2,
    },
    ["body"] = {
        item = "plastic",
        costs = 3,
    },
    ["radiator"] = {
        item = "steel",
        costs = 5,
    },
    ["axle"] = {
        item = "aluminum",
        costs = 7,
    },
    ["brakes"] = {
        item = "copper",
        costs = 5,
    },
    ["clutch"] = {
        item = "copper",
        costs = 6,
    },
    ["fuel"] = {
        item = "plastic",
        costs = 5,
    },
}

Config.Businesses = {
    "Auto Repair",
}

Config.Plates = {
    [1] = {
        coords = vector4(-326.95, -144.36, 39.01, 70.0),
        boxData = {
            heading = 70.0,
            length = 7.4,
            width = 4.0,
            debugPoly = true
        },
        AttachedVehicle = nil,
    },
    [2] = {
        coords = vector4(-324.96, -139.25, 39.01, 70.0),
        boxData = {
            heading = 70.0,
            length = 7.4,
            width = 4.0,
            debugPoly = true
        },
        AttachedVehicle = nil,
    },
    [3] = {
        coords = vector4(-323.1, -134.06, 39.01, 70.0),
        boxData = {
            heading = 70.0,
            length = 7.4,
            width = 4.0,
            debugPoly = true
        },
        AttachedVehicle = nil,
    },
    [4] = {
        coords = vector4(-321.21, -128.82, 39.01, 70.0),
        boxData = {
            heading = 70.0,
            length = 7.4,
            width = 4.0,
            debugPoly = true
        },
        AttachedVehicle = nil,
    },
    [5] = {
        coords = vector4(-319.3, -123.68, 39.01, 70.0),
        boxData = {
            heading = 70.0,
            length = 7.4,
            width = 4.0,
            debugPoly = true
        },
        AttachedVehicle = nil,
    },
    [6] = {
        coords = vector4(-317.46, -118.48, 39.01, 70.0),
        boxData = {
            heading = 70.0,
            length = 7.4,
            width = 4.0,
            debugPoly = true
        },
        AttachedVehicle = nil,
    },
    [7] = {
        coords = vector4(-315.48, -113.28, 39.01, 70.0),
        boxData = {
            heading = 70.0,
            length = 7.4,
            width = 4.0,
            debugPoly = true
        },
        AttachedVehicle = nil,
    },
    [8] = {
        coords = vector4(-313.62, -108.1, 39.01, 70.0),
        boxData = {
            heading = 70.0,
            length = 7.4,
            width = 4.0,
            debugPoly = true
        },
        AttachedVehicle = nil,
    },
    [9] = {
        coords = vector4(-311.76, -102.96, 39.01, 70.0),
        boxData = {
            heading = 70.0,
            length = 7.4,
            width = 4.0,
            debugPoly = true
        },
        AttachedVehicle = nil,
    },
    [10] = {
        coords = vector4(-349.54, -131.19, 39.01, 250.0),
        boxData = {
            heading = 250.0,
            length = 7.4,
            width = 4.0,
            debugPoly = true
        },
        AttachedVehicle = nil,
    },
    [11] = {
        coords = vector4(-347.14, -124.44, 39.01, 250.0),
        boxData = {
            heading = 250.0,
            length = 7.4,
            width = 4.0,
            debugPoly = true
        },
        AttachedVehicle = nil,
    },
    [12] = {
        coords = vector4(-343.24, -113.53, 39.01, 250.0),
        boxData = {
            heading = 250.0,
            length = 7.4,
            width = 4.0,
            debugPoly = true
        },
        AttachedVehicle = nil,
    },
    [13] = {
        coords = vector4(-365.98, -85.33, 39.01, 250.0),
        boxData = {
            heading = 250.0,
            length = 11.6,
            width = 5.4,
            debugPoly = true
        },
        AttachedVehicle = nil,
    },
    [14] = {
        coords = vector4(-352.56, -90.18, 39.02, 250.0),
        boxData = {
            heading = 250.0,
            length = 11.6,
            width = 5.4,
            debugPoly = true
        },
        AttachedVehicle = nil,
    },
    [15] = {
        coords = vector4(-339.12, -95.03, 39.01, 250.0),
        boxData = {
            heading = 250.0,
            length = 11.6,
            width = 5.4,
            debugPoly = true
        },
        AttachedVehicle = nil,
    },
    [16] = {
        coords = vector4(-583.04, -931.78, 23.89, 270.0),
        boxData = {
            heading = 270.0,
            length = 4.4,
            width = 2.4,
            debugPoly = true
        },
        AttachedVehicle = nil,
    },
    [17] = {
        coords = vector4(-583.01, -924.66, 23.89, 270.0),
        boxData = {
            heading = 270.0,
            length = 4.4,
            width = 2.4,
            debugPoly = true
        },
        AttachedVehicle = nil,
    },
    [18] = {
        coords = vector4(-583.03, -917.56, 23.89, 270.0),
        boxData = {
            heading = 270.0,
            length = 4.4,
            width = 2.4,
            debugPoly = true
        },
        AttachedVehicle = nil,
    },
}

Config.Locations = {
    ["exit"] = {
        {
            coord = vector3(-339.04, -135.53, 39),
            label = '聖維特大道總店',
        },
        {
            coord = vector3(-604.57, -919.56, 23.89),
            label = '小首爾分店',
        },
    },
    
    ["duty"] = {
        {
            coord = vector3(-341.47, -162.89, 44.59), 
            length = 0.95,
            width = 0.85,
            heading = 359,
            debugPoly = true,
            minZ = 43.59,
            maxZ = 45.69
        },
        {
            coord = vector3(-589.87, -931.33, 23.89), 
            length = 1.2,
            width = 0.6,
            heading = 0,
            debugPoly = true,
            minZ = 23.59,
            maxZ = 24.09
        },
    },
    ["stash"] = {
        {
            coord = vector3(-319.49, -131.9, 38.98), 
            length = 0.95,
            width = 0.85,
            heading = 359,
            debugPoly = true,
            minZ = 43.59,
            maxZ = 45.69,
        },
        {
            coord = vector3(-584.06, -939.58, 23.89),
            length = 1.0,
            width = 4.0,
            heading = 0,
            debugPoly = true,
            minZ = 22.89,
            maxZ = 25.14
        },
    },
    ["vehicle"] = {
        {
            coord = vector4(-370.51, -107.88, 38.35, 72.56),
            length = 5,
            width = 15,
            heading = 340.0,
            debugPoly = true,
            minZ = 22.89,
            maxZ = 25.14
        },
        {
            coord = vector4(-572.02, -924.16, 23.89, 180),
            length = 3.6,
            width = 6.0,
            heading = 270.0,
            debugPoly = true,
            minZ = 22.89,
            maxZ = 26.49
        }
    },
}

Config.Vehicles = {
    "flatbed",
    "towtruck",
    "minivan",
    "blista",
}

Config.MinimalMetersForDamage = {
    [1] = {
        min = 8000,
        max = 12000,
        multiplier = {
            min = 1,
            max = 8,
        }
    },
    [2] = {
        min = 12000,
        max = 16000,
        multiplier = {
            min = 8,
            max = 16,
        }
    },
    [3] = {
        min = 12000,
        max = 16000,
        multiplier = {
            min = 16,
            max = 24,
        }
    },
}

Config.Damages = {
    ["radiator"] = "散熱器",
    ["axle"] = "傳動軸",
    ["brakes"] = "剎車",
    ["clutch"] = "離合器",
    ["fuel"] = "油箱",
}
