Config = {}

Config.AttachedVehicle = nil

Config.AuthorizedIds = {
    "insertcitizenidhere",
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
    ["engine"] = "Motor",
    ["body"] = "Body",
    ["radiator"] = "Radiator",
    ["axle"] = "Drive Shaft",
    ["brakes"] = "Brakes",
    ["clutch"] = "Clutch",
    ["fuel"] = "Fuel Ttank",
}

Config.RepairCost = {
    ["body"] = "bodykit",
    ["radiator"] = "radiator",
    ["axle"] = "driveshaft",
    ["brakes"] = "stock_brakes",
    ["clutch"] = "clutch",
    ["fuel"] = "plastic",
}

Config.RepairCostAmount = {
    ["engine"] = {
        item = "engine",
        costs = 1,
    },
    ["body"] = {
        item = "bodykit",
        costs = 1,
    },
    ["radiator"] = {
        item = "radiator",
        costs = 1,
    },
    ["axle"] = {
        item = "driveshaft",
        costs = 1,
    },
    ["brakes"] = {
        item = "stock_brakes",
        costs = 4,
    },
    ["clutch"] = {
        item = "clutch",
        costs = 1,
    },
    ["fuel"] = {
        item = "plastic",
        costs = 10,
    },
}

Config.Businesses = {
    "Auto Repair",
}

Config.Plates = {
    [1] = {
        coords = vector4(-340.95, -128.24, 39, 160.46),
        AttachedVehicle = nil,
    },
}

Config.Locations = {
    ["exit"] = vector3(-339.04, -135.53, 39),
    ["stash"] = vector3(-323.19, -129.86, 39),
    ["duty"] = vector3(-344.35, -123.39, 39), 
    ["vehicle"] = vector4(-370.51, -107.88, 38.35, 72.56), 
}

Config.Vehicles = {
    ["flatbed"] = "Flatbed",
    ["towtruck"] = "Towtruck",
    ["minivan"] = "Minivan (Leen Auto)",
    ["blista"] = "Blista",
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
    ["radiator"] = "Radiator",
    ["axle"] = "Drive Shaft",
    ["brakes"] = "Brakes",
    ["clutch"] = "Clutch",
    ["fuel"] = "Fuel Tank",
}
