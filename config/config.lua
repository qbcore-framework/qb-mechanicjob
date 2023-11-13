Config = {}
Config.RequireJob = true                       -- do you need a mech job to use parts?
Config.FuelResource = 'LegacyFuel'             -- supports any that has a GetFuel() and SetFuel() export

Config.PaintTime = 5                           -- how long it takes to paint a vehicle in seconds
Config.ColorFavorites = false                  -- add your own colors to the favorites menu (see bottom of const.lua)

Config.NitrousBoost = 1.8                      -- how much boost nitrous gives (want this above 1.0)
Config.NitrousUsage = 0.1                      -- how much nitrous is used per frame while holding key

Config.UseDistance = true                      -- enable/disable saving vehicle distance
Config.UseDistanceDamage = true                -- damage vehicle engine health based on vehicle distance
Config.UseWearableParts = true                 -- enable/disable wearable parts
Config.WearablePartsChance = 1                 -- chance of wearable parts being damaged while driving if enabled
Config.WearablePartsDamage = math.random(1, 2) -- how much wearable parts are damaged when damaged if enabled
Config.DamageThreshold = 25                    -- how worn a part needs to be or below to apply an effect if enabled
Config.WarningThreshold = 50                   -- how worn a part needs to be to show a warning color in toolbox if enabled

Config.MinimalMetersForDamage = {              -- unused if Config.UseDistanceDamage is false
    { min = 5000,  max = 10000, damage = 10 },
    { min = 15000, max = 20000, damage = 20 },
    { min = 25000, max = 30000, damage = 30 },
}

Config.WearableParts = { -- unused if Config.UseWearableParts is false (feel free to add/remove parts)
    radiator = { label = 'Radiator', maxValue = 100, repair = { steel = 2 } },
    axle = { label = 'Axle', maxValue = 100, repair = { aluminum = 2 } },
    brakes = { label = 'Brakes', maxValue = 100, repair = { copper = 2 } },
    clutch = { label = 'Clutch', maxValue = 100, repair = { copper = 2 } },
    fuel = { label = 'Fuel', maxValue = 100, repair = { plastic = 2 } },
}

Config.Shops = {
    mechanic = { -- City location
        managed = true,
        shopLabel = 'LS Customs',
        showBlip = true,
        blipSprite = 72,
        blipColor = 46,
        blipCoords = vector3(-346.02, -130.68, 39.02),
        shop = vector3(-343.66, -140.78, 39.02),
        duty = vector3(-348.18, -134.55, 39.59),
        stash = vector3(-346.02, -130.68, 39.02),
        paint = vector3(-324.11, -147.11, 39.10),
        vehicles = {
            withdraw = vector3(-369.30, -104.75, 38.38),
            spawn = vector4(-369.65, -107.8, 38.65, 70.52),
            list = { 'flatbed', 'towtruck', 'minivan', 'blista' }
        },
        shopItems = {
            { name = 'veh_toolbox',       price = 5000, amount = 50 },
            { name = 'veh_armor',         price = 5000, amount = 50 },
            { name = 'veh_brakes',        price = 5000, amount = 50 },
            { name = 'veh_engine',        price = 5000, amount = 50 },
            { name = 'veh_suspension',    price = 5000, amount = 50 },
            { name = 'veh_transmission',  price = 5000, amount = 50 },
            { name = 'veh_turbo',         price = 5000, amount = 50 },
            { name = 'veh_interior',      price = 5000, amount = 50 },
            { name = 'veh_exterior',      price = 5000, amount = 50 },
            { name = 'veh_wheels',        price = 5000, amount = 50 },
            { name = 'veh_neons',         price = 5000, amount = 50 },
            { name = 'veh_xenons',        price = 5000, amount = 50 },
            { name = 'veh_tint',          price = 5000, amount = 50 },
            { name = 'veh_plates',        price = 5000, amount = 50 },
            { name = 'nitrous',           price = 5000, amount = 50 },
            { name = 'tunerlaptop',       price = 5000, amount = 50 },
            { name = 'repairkit',         price = 5000, amount = 50 },
            { name = 'advancedrepairkit', price = 5000, amount = 50 },
            { name = 'tirerepairkit',     price = 5000, amount = 50 },
        }
    },
    mechanic2 = { -- Harmony Location
        managed = true,
        shopLabel = 'LS Customs',
        showBlip = true,
        blipSprite = 72,
        blipColor = 46,
        blipCoords = vector3(1174.93, 2639.45, 37.75),
        shop = vector3(1189.36, 2641.00, 38.44),
        duty = vector3(1185.86, 2638.70, 38.93),
        stash = vector3(1175.11, 2635.375, 37.78),
        paint = vector3(1181.29, 2634.69, 37.80),
        vehicles = {
            withdraw = vector3(1185.63, 2646.01, 37.91),
            spawn = vector4(1188.18, 2657.56, 37.79, 316.74),
            list = { 'flatbed', 'towtruck', 'minivan', 'blista' }
        },
        shopItems = {
            { name = 'veh_toolbox',       price = 5000, amount = 50 },
            { name = 'veh_armor',         price = 5000, amount = 50 },
            { name = 'veh_brakes',        price = 5000, amount = 50 },
            { name = 'veh_engine',        price = 5000, amount = 50 },
            { name = 'veh_suspension',    price = 5000, amount = 50 },
            { name = 'veh_transmission',  price = 5000, amount = 50 },
            { name = 'veh_turbo',         price = 5000, amount = 50 },
            { name = 'veh_interior',      price = 5000, amount = 50 },
            { name = 'veh_exterior',      price = 5000, amount = 50 },
            { name = 'veh_wheels',        price = 5000, amount = 50 },
            { name = 'veh_neons',         price = 5000, amount = 50 },
            { name = 'veh_xenons',        price = 5000, amount = 50 },
            { name = 'veh_tint',          price = 5000, amount = 50 },
            { name = 'veh_plates',        price = 5000, amount = 50 },
            { name = 'nitrous',           price = 5000, amount = 50 },
            { name = 'tunerlaptop',       price = 5000, amount = 50 },
            { name = 'repairkit',         price = 5000, amount = 50 },
            { name = 'advancedrepairkit', price = 5000, amount = 50 },
            { name = 'tirerepairkit',     price = 5000, amount = 50 },
        }
    },
    mechanic3 = { -- Airport Location
        managed = true,
        shopLabel = 'LS Customs',
        showBlip = true,
        blipSprite = 72,
        blipColor = 46,
        blipCoords = vector3(-1154.92, -2006.41, 13.18),
        shop = vector3(-1156.56, -1999.85, 13.19),
        duty = vector3(-1149.17, -1998.27, 13.91),
        stash = vector3(-1146.40, -2002.05, 13.19),
        paint = vector3(-1170.60, -2014.90, 13.23),
        vehicles = {
            withdraw = vector3(-1142.04, -1994.58, 13.26),
            spawn = vector4(-1137.42, -1993.26, 13.14, 226.07),
            list = { 'flatbed', 'towtruck', 'minivan', 'blista' }
        },
        shopItems = {
            { name = 'veh_toolbox',       price = 5000, amount = 50 },
            { name = 'veh_armor',         price = 5000, amount = 50 },
            { name = 'veh_brakes',        price = 5000, amount = 50 },
            { name = 'veh_engine',        price = 5000, amount = 50 },
            { name = 'veh_suspension',    price = 5000, amount = 50 },
            { name = 'veh_transmission',  price = 5000, amount = 50 },
            { name = 'veh_turbo',         price = 5000, amount = 50 },
            { name = 'veh_interior',      price = 5000, amount = 50 },
            { name = 'veh_exterior',      price = 5000, amount = 50 },
            { name = 'veh_wheels',        price = 5000, amount = 50 },
            { name = 'veh_neons',         price = 5000, amount = 50 },
            { name = 'veh_xenons',        price = 5000, amount = 50 },
            { name = 'veh_tint',          price = 5000, amount = 50 },
            { name = 'veh_plates',        price = 5000, amount = 50 },
            { name = 'nitrous',           price = 5000, amount = 50 },
            { name = 'tunerlaptop',       price = 5000, amount = 50 },
            { name = 'repairkit',         price = 5000, amount = 50 },
            { name = 'advancedrepairkit', price = 5000, amount = 50 },
            { name = 'tirerepairkit',     price = 5000, amount = 50 },
        }
    },
    bennys = { -- Default Bennys Location
        managed = true,
        shopLabel = 'Benny\'s Motorworks',
        showBlip = true,
        blipSprite = 72,
        blipColor = 46,
        blipCoords = vector3(-211.73, -1325.28, 30.89),
        shop = vector3(-195.80, -1318.24, 31.08),
        duty = vector3(-202.92, -1313.74, 31.70),
        stash = vector3(-199.58, -1314.65, 31.08),
        paint = vector3(-202.42, -1322.16, 31.29),
        vehicles = {
            withdraw = vector3(0, 0, 0),
            spawn = vector4(-370.51, -107.88, 38.35, 72.56),
            list = { 'flatbed', 'towtruck', 'minivan', 'blista' }
        },
        shopItems = {
            { name = 'veh_toolbox',       price = 5000, amount = 50 },
            { name = 'veh_armor',         price = 5000, amount = 50 },
            { name = 'veh_brakes',        price = 5000, amount = 50 },
            { name = 'veh_engine',        price = 5000, amount = 50 },
            { name = 'veh_suspension',    price = 5000, amount = 50 },
            { name = 'veh_transmission',  price = 5000, amount = 50 },
            { name = 'veh_turbo',         price = 5000, amount = 50 },
            { name = 'veh_interior',      price = 5000, amount = 50 },
            { name = 'veh_exterior',      price = 5000, amount = 50 },
            { name = 'veh_wheels',        price = 5000, amount = 50 },
            { name = 'veh_neons',         price = 5000, amount = 50 },
            { name = 'veh_xenons',        price = 5000, amount = 50 },
            { name = 'veh_tint',          price = 5000, amount = 50 },
            { name = 'veh_plates',        price = 5000, amount = 50 },
            { name = 'nitrous',           price = 5000, amount = 50 },
            { name = 'tunerlaptop',       price = 5000, amount = 50 },
            { name = 'repairkit',         price = 5000, amount = 50 },
            { name = 'advancedrepairkit', price = 5000, amount = 50 },
            { name = 'tirerepairkit',     price = 5000, amount = 50 },
        }
    },
    beeker = { -- Paleto Location
        managed = true,
        shopLabel = 'Beeker\'s Garage',
        showBlip = true,
        blipSprite = 72,
        blipColor = 46,
        blipCoords = vector3(109.95, 6627.34, 31.79),
        shop = vector3(100.92, 6616.00, 32.47),
        duty = vector3(101.74, 6620.04, 32.95),
        stash = vector3(107.00, 6629.88, 31.81),
        paint = vector3(102.17, 6626.08, 31.79),
        vehicles = {
            withdraw = vector3(107.08, 6614.90, 31.96),
            spawn = vector4(110.91, 6609.32, 31.81, 315.11),
            list = { 'flatbed', 'towtruck', 'minivan', 'blista' }
        },
        shopItems = {
            { name = 'veh_toolbox',       price = 5000, amount = 50 },
            { name = 'veh_armor',         price = 5000, amount = 50 },
            { name = 'veh_brakes',        price = 5000, amount = 50 },
            { name = 'veh_engine',        price = 5000, amount = 50 },
            { name = 'veh_suspension',    price = 5000, amount = 50 },
            { name = 'veh_transmission',  price = 5000, amount = 50 },
            { name = 'veh_turbo',         price = 5000, amount = 50 },
            { name = 'veh_interior',      price = 5000, amount = 50 },
            { name = 'veh_exterior',      price = 5000, amount = 50 },
            { name = 'veh_wheels',        price = 5000, amount = 50 },
            { name = 'veh_neons',         price = 5000, amount = 50 },
            { name = 'veh_xenons',        price = 5000, amount = 50 },
            { name = 'veh_tint',          price = 5000, amount = 50 },
            { name = 'veh_plates',        price = 5000, amount = 50 },
            { name = 'nitrous',           price = 5000, amount = 50 },
            { name = 'tunerlaptop',       price = 5000, amount = 50 },
            { name = 'repairkit',         price = 5000, amount = 50 },
            { name = 'advancedrepairkit', price = 5000, amount = 50 },
            { name = 'tirerepairkit',     price = 5000, amount = 50 },
        }
    },
}
