Config = {}
Config.UseTarget = GetConvar('UseTarget', 'false') == 'true'
Config.Targets = {}

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
    ["engine"] = Lang:t('labels.engine'),
    ["body"] = Lang:t('labels.bodsy'),
    ["radiator"] = Lang:t('labels.radiator'),
    ["axle"] = Lang:t('labels.axle'),
    ["brakes"] = Lang:t('labels.brakes'),
    ["clutch"] = Lang:t('labels.clutch'),
    ["fuel"] = Lang:t('labels.fuel'),
}

Config.RepairCostAmount = {
    ["engine"] = {item = "metalscrap", costs = 2},
    ["body"] = {item = "plastic", costs = 3},
    ["radiator"] = {item = "steel", costs = 5},
    ["axle"] = {item = "aluminum", costs = 7},
    ["brakes"] = {item = "copper", costs = 5},
    ["clutch"] = {item = "copper", costs = 6},
    ["fuel"] = {item = "plastic", costs = 5},
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

Config.Products = {
    ["mechanic"] = {
        {name = "veh_toolbox", price = 5000, amount = 50, info = {}, type = "item"},
        {name = "veh_armor", price = 5000, amount = 50, info = {}, type = "item"},
        {name = "veh_brakes", price = 5000, amount = 50, info = {}, type = "item"},
        {name = "veh_engine", price = 5000, amount = 50, info = {}, type = "item"},
        {name = "veh_suspension", price = 5000, amount = 50, info = {}, type = "item"},
        {name = "veh_transmission", price = 5000, amount = 50, info = {}, type = "item"},
        {name = "veh_turbo", price = 5000, amount = 50, info = {}, type = "item"},
        {name = "veh_interior", price = 5000, amount = 50, info = {}, type = "item"},
        {name = "veh_exterior", price = 5000, amount = 50, info = {}, type = "item"},
        {name = "veh_wheels", price = 5000, amount = 50, info = {}, type = "item"},
        {name = "veh_neons", price = 5000, amount = 50, info = {}, type = "item"},
        {name = "veh_xenons", price = 5000, amount = 50, info = {}, type = "item"},
        {name = "veh_tint", price = 5000, amount = 50, info = {}, type = "item"},
        {name = "veh_plates", price = 5000, amount = 50, info = {}, type = "item"},
        {name = "nitrous", price = 5000, amount = 50, info = {}, type = "item"},
        {name = "tunerlaptop", price = 5000, amount = 50, info = {}, type = "item"},
    },
    ["bennys"] = {
        {name = "veh_toolbox", price = 5000, amount = 50, info = {}, type = "item"},
        {name = "veh_armor", price = 5000, amount = 50, info = {}, type = "item"},
        {name = "veh_brakes", price = 5000, amount = 50, info = {}, type = "item"},
        {name = "veh_engine", price = 5000, amount = 50, info = {}, type = "item"},
        {name = "veh_suspension", price = 5000, amount = 50, info = {}, type = "item"},
        {name = "veh_transmission", price = 5000, amount = 50, info = {}, type = "item"},
        {name = "veh_turbo", price = 5000, amount = 50, info = {}, type = "item"},
        {name = "veh_interior", price = 5000, amount = 50, info = {}, type = "item"},
        {name = "veh_exterior", price = 5000, amount = 50, info = {}, type = "item"},
        {name = "veh_wheels", price = 5000, amount = 50, info = {}, type = "item"},
        {name = "veh_neons", price = 5000, amount = 50, info = {}, type = "item"},
        {name = "veh_xenons", price = 5000, amount = 50, info = {}, type = "item"},
        {name = "veh_tint", price = 5000, amount = 50, info = {}, type = "item"},
        {name = "veh_plates", price = 5000, amount = 50, info = {}, type = "item"},
        {name = "nitrous", price = 5000, amount = 50, info = {}, type = "item"},
        {name = "tunerlaptop", price = 5000, amount = 50, info = {}, type = "item"},
    },
    ["mechanic2"] = {
        {name = "veh_toolbox", price = 5000, amount = 50, info = {}, type = "item"},
        {name = "veh_armor", price = 5000, amount = 50, info = {}, type = "item"},
        {name = "veh_brakes", price = 5000, amount = 50, info = {}, type = "item"},
        {name = "veh_engine", price = 5000, amount = 50, info = {}, type = "item"},
        {name = "veh_suspension", price = 5000, amount = 50, info = {}, type = "item"},
        {name = "veh_transmission", price = 5000, amount = 50, info = {}, type = "item"},
        {name = "veh_turbo", price = 5000, amount = 50, info = {}, type = "item"},
        {name = "veh_interior", price = 5000, amount = 50, info = {}, type = "item"},
        {name = "veh_exterior", price = 5000, amount = 50, info = {}, type = "item"},
        {name = "veh_wheels", price = 5000, amount = 50, info = {}, type = "item"},
        {name = "veh_neons", price = 5000, amount = 50, info = {}, type = "item"},
        {name = "veh_xenons", price = 5000, amount = 50, info = {}, type = "item"},
        {name = "veh_tint", price = 5000, amount = 50, info = {}, type = "item"},
        {name = "veh_plates", price = 5000, amount = 50, info = {}, type = "item"},
        {name = "nitrous", price = 5000, amount = 50, info = {}, type = "item"},
        {name = "tunerlaptop", price = 5000, amount = 50, info = {}, type = "item"},
    },
    ["beeker"] = {
        {name = "veh_toolbox", price = 5000, amount = 50, info = {}, type = "item"},
        {name = "veh_armor", price = 5000, amount = 50, info = {}, type = "item"},
        {name = "veh_brakes", price = 5000, amount = 50, info = {}, type = "item"},
        {name = "veh_engine", price = 5000, amount = 50, info = {}, type = "item"},
        {name = "veh_suspension", price = 5000, amount = 50, info = {}, type = "item"},
        {name = "veh_transmission", price = 5000, amount = 50, info = {}, type = "item"},
        {name = "veh_turbo", price = 5000, amount = 50, info = {}, type = "item"},
        {name = "veh_interior", price = 5000, amount = 50, info = {}, type = "item"},
        {name = "veh_exterior", price = 5000, amount = 50, info = {}, type = "item"},
        {name = "veh_wheels", price = 5000, amount = 50, info = {}, type = "item"},
        {name = "veh_neons", price = 5000, amount = 50, info = {}, type = "item"},
        {name = "veh_xenons", price = 5000, amount = 50, info = {}, type = "item"},
        {name = "veh_tint", price = 5000, amount = 50, info = {}, type = "item"},
        {name = "veh_plates", price = 5000, amount = 50, info = {}, type = "item"},
        {name = "nitrous", price = 5000, amount = 50, info = {}, type = "item"},
        {name = "tunerlaptop", price = 5000, amount = 50, info = {}, type = "item"},
    },
    ["mechanic3"] = {
        {name = "veh_toolbox", price = 5000, amount = 50, info = {}, type = "item"},
        {name = "veh_armor", price = 5000, amount = 50, info = {}, type = "item"},
        {name = "veh_brakes", price = 5000, amount = 50, info = {}, type = "item"},
        {name = "veh_engine", price = 5000, amount = 50, info = {}, type = "item"},
        {name = "veh_suspension", price = 5000, amount = 50, info = {}, type = "item"},
        {name = "veh_transmission", price = 5000, amount = 50, info = {}, type = "item"},
        {name = "veh_turbo", price = 5000, amount = 50, info = {}, type = "item"},
        {name = "veh_interior", price = 5000, amount = 50, info = {}, type = "item"},
        {name = "veh_exterior", price = 5000, amount = 50, info = {}, type = "item"},
        {name = "veh_wheels", price = 5000, amount = 50, info = {}, type = "item"},
        {name = "veh_neons", price = 5000, amount = 50, info = {}, type = "item"},
        {name = "veh_xenons", price = 5000, amount = 50, info = {}, type = "item"},
        {name = "veh_tint", price = 5000, amount = 50, info = {}, type = "item"},
        {name = "veh_plates", price = 5000, amount = 50, info = {}, type = "item"},
        {name = "nitrous", price = 5000, amount = 50, info = {}, type = "item"},
        {name = "tunerlaptop", price = 5000, amount = 50, info = {}, type = "item"},
    },
}

Config.Shops = {
    ['lscustoms'] = {
        ['job'] = 'mechanic', -- job name or none (public)
        ['zone'] = {
            ['shape'] = {
                vector2(-319.19741821289, -131.34129333496),
                vector2(-324.78256225586, -147.92210388184),
                vector2(-356.32266235352, -136.65902709961),
                vector2(-354.97357177734, -132.8236541748),
                vector2(-345.1520690918, -122.33336639404)
            },
            ['minZ'] = 38.98,
            ['maxZ'] = 39.47
        },
        ['shopLabel'] = 'LS Customs', -- Blip name
        ['showBlip'] = true, -- true or false
        ['blipSprite'] = 72, -- Blip sprite
        ['blipColor'] = 46, -- Blip color
        ['blipCoords'] = vector3(-346.02432250977, -130.68141174316, 39.023941040039), -- Blip coordinates
        ["shop"] = vector3(-343.66229248047, -140.78297424316, 39.02725982666), -- crafting coords
        ["duty"] = vector3(-348.18588256836, -134.5559387207, 39.599033355713), -- duty coords
        ["stash"] = vector3(-346.02432250977, -130.68141174316, 39.023941040039), -- stash coords
        ['paint'] = vector3(-324.11489868164, -147.1162109375, 39.103149414063), -- paint dispenser coords
        ['vehicles'] = {
            withdraw = vector3(-369.30422973633, -104.75430297852, 38.382610321045),
            spawn = vector4(-369.65, -107.8, 38.65, 70.52),
            list = {'flatbed', 'towtruck', 'minivan', 'blista'}
        },
    },
    ['bennys'] = {
        ['job'] = 'bennys', -- job name or none (public)
        ['zone'] = {
            ['shape'] = {
                vector2(-203.55299377441, -1311.2630615234),
                vector2(-203.40112304688, -1322.1186523438),
                vector2(-204.0862121582, -1327.3107910156),
                vector2(-208.3600769043, -1334.4067382812),
                vector2(-217.08247375488, -1334.1473388672),
                vector2(-228.24615478516, -1334.2449951172),
                vector2(-228.08572387695, -1319.2351074219)
            },
            ['minZ'] = 30.89,
            ['maxZ'] = 31.29
        },
        ['shopLabel'] = 'Benny\'s Motorworks', -- Blip name
        ['showBlip'] = true, -- true or false
        ['blipSprite'] = 72, -- Blip sprite
        ['blipColor'] = 46, -- Blip color
        ['blipCoords'] = vector3(-211.73, -1325.28, 30.89), -- Blip coordinates
        ["shop"] = vector3(-195.80293273926, -1318.24609375, 31.089059829712), -- crafting coords
        ["duty"] = vector3(-202.92744445801, -1313.7484130859, 31.702411651611), -- duty coords
        ["stash"] = vector3(-199.58477783203, -1314.6579589844, 31.089347839355), -- stash coords
        ['paint'] = vector3(-202.42353820801, -1322.1693115234, 31.292694091797), -- paint dispenser coords
        ['vehicles'] = { -- Job Garage
            withdraw = vector3(0, 0, 0),
            spawn = vector4(-370.51, -107.88, 38.35, 72.56),
            list = {'flatbed', 'towtruck', 'minivan', 'blista'}
        },
    },
    ['harmony'] = {
        ['job'] = 'mechanic2', -- job name or none (public)
        ['zone'] = {
            ['shape'] = {
                vector2(1172.1085205078, 2644.75390625),
                vector2(1172.326171875, 2635.5859375),
                vector2(1184.9807128906, 2634.96875),
                vector2(1184.4918212891, 2644.9194335938)
            },
            ['minZ'] = 37.78,
            ['maxZ'] = 38.22
        },
        ['shopLabel'] = 'LS Customs', -- Blip name
        ['showBlip'] = true, -- true or false
        ['blipSprite'] = 72, -- Blip sprite
        ['blipColor'] = 46, -- Blip color
        ['blipCoords'] = vector3(1174.93, 2639.45, 37.75), -- Blip coordinates
        ["shop"] = vector3(1189.3612060547, 2641.0002441406, 38.446727752686), -- crafting coords
        ["duty"] = vector3(1185.8669433594, 2638.7021484375, 38.936878204346), -- duty coords
        ["stash"] = vector3(1175.1182861328, 2635.3757324219, 37.788326263428), -- stash coords
        ['paint'] = vector3(1181.2969970703, 2634.69140625, 37.804531097412), -- paint dispenser coords
        ['vehicles'] = {
            withdraw = vector3(1185.6307373047, 2646.0122070313, 37.912490844727),
            spawn = vector4(1188.18, 2657.56, 37.79, 316.74),
            list = {'flatbed', 'towtruck', 'minivan', 'blista'}
        },
    },
    ['paleto'] = {
        ['job'] = 'beeker', -- job name or none (public)
        ['zone'] = {
            ['shape'] = {
                vector2(109.28326416016, 6631.9150390625),
                vector2(115.78814697266, 6625.3198242188),
                vector2(107.11750793457, 6616.5166015625),
                vector2(99.764305114746, 6623.345703125)
            },
            ['minZ'] = 31.78,
            ['maxZ'] = 32.25
        },
        ['shopLabel'] = 'Beeker\'s Garage', -- Blip name
        ['showBlip'] = true, -- true or false
        ['blipSprite'] = 72, -- Blip sprite
        ['blipColor'] = 46, -- Blip color
        ['blipCoords'] = vector3(109.95, 6627.34, 31.79), -- Blip coordinates
        ["shop"] = vector3(100.92869567871, 6616.0083007813, 32.47770690918), -- crafting coords
        ["duty"] = vector3(101.74996948242, 6620.0434570313, 32.955493927002), -- duty coords
        ["stash"] = vector3(107.00458526611, 6629.888671875, 31.819875717163), -- stash coords
        ['paint'] = vector3(102.17151641846, 6626.0888671875, 31.793302536011), -- paint dispenser coords
        ['vehicles'] = {
            withdraw = vector3(107.08979797363, 6614.908203125, 31.96697807312),
            spawn = vector4(110.91, 6609.32, 31.81, 315.11),
            list = {'flatbed', 'towtruck', 'minivan', 'blista'}
        },
    },
    ['airport'] = {
        ['job'] = 'mechanic3', -- job name or none (public)
        ['zone'] = {
            ['shape'] = {
                vector2(-1147.5499267578, -1990.1391601562),
                vector2(-1144.7552490234, -1992.9509277344),
                vector2(-1139.1751708984, -2007.1807861328),
                vector2(-1158.3846435547, -2026.0313720703),
                vector2(-1171.0571289062, -2013.9622802734)
            },
            ['minZ'] = 12.00,
            ['maxZ'] = 18.00
        },
        ['shopLabel'] = 'LS Customs', -- Blip name
        ['showBlip'] = true, -- true or false
        ['blipSprite'] = 72, -- Blip sprite
        ['blipColor'] = 46, -- Blip color
        ['blipCoords'] = vector3(-1154.92, -2006.41, 13.18), -- Blip coordinates
        ["shop"] = vector3(-1156.5623779297, -1999.8576660156, 13.197587013245), -- crafting coords
        ["duty"] = vector3(-1149.1713867188, -1998.2711181641, 13.910863876343), -- duty coords
        ["stash"] = vector3(-1146.4028320313, -2002.0545654297, 13.193927764893), -- stash coords
        ['paint'] = vector3(-1170.6015625, -2014.9046630859, 13.234931945801), -- paint dispenser coords
        ['vehicles'] = {
            withdraw = vector3(-1142.0444335938, -1994.5899658203, 13.267748832703),
            spawn = vector4(-1137.42, -1993.26, 13.14, 226.07),
            list = {'flatbed', 'towtruck', 'minivan', 'blista'}
        },
    },
}

-- Customization Information (shouldn't be changed)

Config.HornLabels = {
    [0] = "Truck Horn",
    [1] = "Cop Horn",
    [2] = "Clown Horn",
    [3] = "Musical Horn 1",
    [4] = "Musical Horn 2",
    [5] = "Musical Horn 3",
    [6] = "Musical Horn 4",
    [7] = "Musical Horn 5",
    [8] = "Sad Trombone",
    [9] = "Classical Horn 1",
    [10] = "Classical Horn 2",
    [11] = "Classical Horn 3",
    [12] = "Classical Horn 4",
    [13] = "Classical Horn 5",
    [14] = "Classical Horn 6",
    [15] = "Classical Horn 7",
    [16] = "Scale - Do",
    [17] = "Scale - Re",
    [18] = "Scale - Mi",
    [19] = "Scale - Fa",
    [20] = "Scale - Sol",
    [21] = "Scale - La",
    [22] = "Scale - Ti",
    [23] = "Scale - Do",
    [24] = "Jazz Horn 1",
    [25] = "Jazz Horn 2",
    [26] = "Jazz Horn 3",
    [27] = "Jazz Horn Loop",
    [28] = "Star Spangled Banner 1",
    [29] = "Star Spangled Banner 2",
    [30] = "Star Spangled Banner 3",
    [31] = "Star Spangled Banner 4",
    [32] = "Classical Horn 8 Loop",
    [33] = "Classical Horn 9 Loop",
    [34] = "Classical Horn 10 Loop",
    [35] = "Classical Horn 8",
    [36] = "Classical Horn 9",
    [37] = "Classical Horn 10",
    [38] = "Funeral Loop",
    [39] = "Funeral",
    [40] = "Spooky Loop",
    [41] = "Spooky",
    [42] = "San Andreas Loop",
    [43] = "San Andreas",
    [44] = "Liberty City Loop",
    [45] = "Liberty City",
    [46] = "Festive 1 Loop",
    [47] = "Festive 1",
    [48] = "Festive 2 Loop",
    [49] = "Festive 2",
    [50] = "Festive 3 Loop",
    [51] = "Festive 3"
}

-- https://docs.fivem.net/natives/?_0xB3ED1BFB4BE636DC
Config.WheelCategories = {
    {label = 'Sport', id = 0},
    {label = 'Muscle', id = 1},
    {label = 'Lowrider', id = 2},
    {label = 'SUV', id = 3},
    {label = 'Offroad', id = 4},
    {label = 'Tuner', id = 5},
    {label = 'Motorcycle', id = 6},
    {label = 'High End', id = 7},
    {label = 'Benny\'s Originals', id = 8},
    {label = 'Benny\'s Bespoke', id = 9},
    {label = 'Open Wheel', id = 10},
    {label = 'Street', id = 11},
    {label = 'Track', id = 12},
}

-- https://docs.fivem.net/natives/?_0x6AF0636DDEDCB6DD
Config.InteriorCategories = {
    {label = "Roll Cage", id = 5},
    {label = "Horns", id = 14},
    {label = "Subwoofer", id = 19},
    {label = "Dashboard", id = 29},
    {label = "Dial", id = 30},
    {label = "Door Speaker", id = 31},
    {label = "Seats", id = 32},
    {label = "Steering Wheel", id = 33},
    {label = "Shifter Leaver", id = 34},
    {label = "Plaque", id = 35},
    {label = "Speaker", id = 36},
}

-- https://docs.fivem.net/natives/?_0x6AF0636DDEDCB6DD
Config.ExteriorCategories = {
    {label = "Spoiler", id = 0},
    {label = "Front Bumper", id = 1},
    {label = "Rear Bumper", id = 2},
    {label = "Side Skirt", id = 3},
    {label = "Exhaust", id = 4},
    {label = "Grille", id = 6},
    {label = "Hood", id = 7},
    {label = "Left Fender", id = 8},
    {label = "Right Fender", id = 9},
    {label = "Roof", id = 10},
    {label = "Hydraulics", id = 21},
    {label = "Headlights", id = 22},
    {label = "Tire Smoke", id = 20},
    {label = "Rear Wheels", id = 24},
    {label = "Plate Holder", id = 25},
    {label = "Vanity Plates", id = 26},
    {label = "Trim A", id = 27},
    {label = "Ornaments", id = 28},
    {label = "Trunk", id = 37},
    {label = "Hydraulic", id = 38},
    {label = "Engine Block", id = 39},
    {label = "Air Filter", id = 40},
    {label = "Strut", id = 41},
    {label = "Arch Cover", id = 42},
    {label = "Aerial", id = 43},
    {label = "Trim B", id = 44},
    {label = "Fuel Tank", id = 45},
    {label = "Window", id = 46},
    {label = "Door", id = 47},
    {label = "Livery", id = 48},
    {label = "Lightbar", id = 49},
    {label = "Paint", id = 50}
}

-- https://docs.fivem.net/natives/?_0x3DFF319A831E0CDB
Config.Xenon = {
    {label = 'Default', id = -1},
    {label = 'White', id = 0},
    {label = 'Blue', id = 1},
    {label = 'Electric Blue', id = 2},
    {label = 'Mint Green', id = 3},
    {label = 'Lime Green', id = 4},
    {label = 'Yellow', id = 5},
    {label = 'Golden Shower', id = 6},
    {label = 'Orange', id = 7},
    {label = 'Red', id = 8},
    {label = 'Pony Pink', id = 9},
    {label = 'Hot Pink', id = 10},
    {label = 'Purple', id = 11},
    {label = 'Blacklight', id = 12},
}

-- https://docs.fivem.net/natives/?_0x57C51E6BAD752696
Config.WindowTints = {
    {label = 'None', id = 0},
    {label = 'Pure black', id = 1},
    {label = 'Dark Smoke', id = 2},
    {label = 'Light Smoke', id = 3},
    {label = 'Stock', id = 4},
    {label = 'Limo', id = 5},
    {label = 'Green', id = 6},
}

-- https://docs.fivem.net/natives/?_0x9088EB5A43FFB0A1
Config.PlateIndexes = {
    {label = 'Blue on White 1', id = 0},
    {label = 'Yellow on Black', id = 1},
    {label = 'Yellow on Blue', id = 2},
    {label = 'Blue on White 2', id = 3},
    {label = 'Blue on White 3', id = 4},
    {label = 'Yankton', id = 5},
}

-- https://docs.fivem.net/natives/?_0x2AA720E4287BF269
Config.Neon = {
    {label = 'Left', id = 0},
    {label = 'Right', id = 1},
    {label = 'Front', id = 2},
    {label = 'Back', id = 3},
}

-- https://docs.fivem.net/natives/?_0x8E0A582209A62695
Config.NeonColors = {
    { label = 'White',         r = 222, g = 222, b = 255 },
    { label = 'Blue',          r = 2,   g = 21,  b = 255 },
    { label = 'Electric Blue', r = 3,   g = 83,  b = 255 },
    { label = 'Mint Green',    r = 0,   g = 255, b = 140 },
    { label = 'Lime Green',    r = 94,  g = 255, b = 1 },
    { label = 'Yellow',        r = 255, g = 255, b = 0 },
    { label = 'Golden Shower', r = 255, g = 150, b = 0 },
    { label = 'Orange',        r = 255, g = 62,  b = 0 },
    { label = 'Red',           r = 255, g = 1,   b = 1 },
    { label = 'Pony Pink',     r = 255, g = 50,  b = 100 },
    { label = 'Hot Pink',      r = 255, g = 5,   b = 190 },
    { label = 'Purple',        r = 35,  g = 1,   b = 255 },
    { label = 'Blacklight',    r = 15,  g = 3,   b = 255 },
}

-- https://docs.fivem.net/natives/?_0xB5BA80F839791C0F
Config.TyreSmoke = {
    { label = "White Smoke",  r = 254, g = 254, b = 254 },
    { label = "Black Smoke",  r = 1,   g = 1,   b = 1 },
    { label = "Blue Smoke",   r = 0,   g = 150, b = 255 },
    { label = "Yellow Smoke", r = 255, g = 255, b = 50 },
    { label = "Orange Smoke", r = 255, g = 153, b = 51 },
    { label = "Red Smoke",    r = 255, g = 10,  b = 10 },
    { label = "Green Smoke",  r = 10,  g = 255, b = 10 },
    { label = "Purple Smoke", r = 153, g = 10,  b = 153 },
    { label = "Pink Smoke",   r = 255, g = 102, b = 178 },
    { label = "Gray Smoke",   r = 128, g = 128, b = 128 }
}

-- https://wiki.rage.mp/index.php?title=Vehicle_Colors
-- https://forum.cfx.re/t/how-to-get-the-chameleon-paints/4869883
Config.Paints = {
    ['Normal'] = {
        {label = "Black", id = 0},
        {label = "Carbon Black", id = 147},
        {label = "Graphite", id = 1},
        {label = "Anhracite Black", id = 11},
        {label = "Black Steel", id = 2},
        {label = "Dark Steel", id = 3},
        {label = "Silver", id = 4},
        {label = "Bluish Silver", id = 5},
        {label = "Rolled Steel", id = 6},
        {label = "Shadow Silver", id = 7},
        {label = "Stone Silver", id = 8},
        {label = "Midnight Silver", id = 9},
        {label = "Cast Iron Silver", id = 10},
        {label = "Red", id = 27},
        {label = "Torino Red", id = 28},
        {label = "Formula Red", id = 29},
        {label = "Lava Red", id = 150},
        {label = "Blaze Red", id = 30},
        {label = "Grace Red", id = 31},
        {label = "Garnet Red", id = 32},
        {label = "Sunset Red", id = 33},
        {label = "Cabernet Red", id = 34},
        {label = "Wine Red", id = 143},
        {label = "Candy Red", id = 35},
        {label = "Hot Pink", id = 135},
        {label = "Pfsiter Pink", id = 137},
        {label = "Salmon Pink", id = 136},
        {label = "Sunrise Orange", id = 36},
        {label = "Orange", id = 38},
        {label = "Bright Orange", id = 138},
        {label = "Gold", id = 99},
        {label = "Bronze", id = 90},
        {label = "Yellow", id = 88},
        {label = "Race Yellow", id = 89},
        {label = "Dew Yellow", id = 91},
        {label = "Dark Green", id = 49},
        {label = "Racing Green", id = 50},
        {label = "Sea Green", id = 51},
        {label = "Olive Green", id = 52},
        {label = "Bright Green", id = 53},
        {label = "Gasoline Green", id = 54},
        {label = "Lime Green", id = 92},
        {label = "Midnight Blue", id = 141},
        {label = "Galaxy Blue", id = 61},
        {label = "Dark Blue", id = 62},
        {label = "Saxon Blue", id = 63},
        {label = "Blue", id = 64},
        {label = "Mariner Blue", id = 65},
        {label = "Harbor Blue", id = 66},
        {label = "Diamond Blue", id = 67},
        {label = "Surf Blue", id = 68},
        {label = "Nautical Blue", id = 69},
        {label = "Racing Blue", id = 73},
        {label = "Ultra Blue", id = 70},
        {label = "Light Blue", id = 74},
        {label = "Chocolate Brown", id = 96},
        {label = "Bison Brown", id = 101},
        {label = "Creeen Brown", id = 95},
        {label = "Feltzer Brown", id = 94},
        {label = "Maple Brown", id = 97},
        {label = "Beechwood Brown", id = 103},
        {label = "Sienna Brown", id = 104},
        {label = "Saddle Brown", id = 98},
        {label = "Moss Brown", id = 100},
        {label = "Woodbeech Brown", id = 102},
        {label = "Straw Brown", id = 99},
        {label = "Sandy Brown", id = 105},
        {label = "Bleached Brown", id = 106},
        {label = "Schafter Purple", id = 71},
        {label = "Spinnaker Purple", id = 72},
        {label = "Midnight Purple", id = 142},
        {label = "Bright Purple", id = 145},
        {label = "Cream", id = 107},
        {label = "Ice White", id = 111},
        {label = "Frost White", id = 112}
    },

    ['Matte'] = {
        {label = "Black", id = 12},
        {label = "Gray", id = 13},
        {label = "Light Gray", id = 14},
        {label = "Ice White", id = 131},
        {label = "Blue", id = 83},
        {label = "Dark Blue", id = 82},
        {label = "Midnight Blue", id = 84},
        {label = "Midnight Purple", id = 149},
        {label = "Schafter Purple", id = 148},
        {label = "Red", id = 39},
        {label = "Dark Red", id = 40},
        {label = "Orange", id = 41},
        {label = "Yellow", id = 42},
        {label = "Lime Green", id = 55},
        {label = "Green", id = 128},
        {label = "Forest Green", id = 151},
        {label = "Foliage Green", id = 155},
        {label = "Olive Darb", id = 152},
        {label = "Dark Earth", id = 153},
        {label = "Desert Tan", id = 154}
    },

    ['Metallic'] = {
        {label = "Brushed Steel", id = 117},
        {label = "Brushed Black Steel", id = 118},
        {label = "Brushed Aluminium", id = 119},
        {label = "Pure Gold", id = 158},
        {label = "Brushed Gold", id = 159},
        {label = "Chrome", id = 120}
    },

    ['Chameleon'] = {
        { label = 'Anodized Red', id = 161 },
        { label = 'Anodized Wine', id = 162 },
        { label = 'Anodized Purple', id = 163 },
        { label = 'Anodized Blue', id = 164 },
        { label = 'Anodized Green', id = 165 },
        { label = 'Anodized Lime', id = 166 },
        { label = 'Anodized Copper', id = 167 },
        { label = 'Anodized Bronze', id = 168 },
        { label = 'Anodized Champagne', id = 169 },
        { label = 'Anodized Gold', id = 170 },
        { label = 'Green Blue Flip', id = 171 },
        { label = 'Green Red Flip', id = 172 },
        { label = 'Green Brown Flip', id = 173 },
        { label = 'Green Turqoise Flip', id = 174 },
        { label = 'Green Purple Flip', id = 175 },
        { label = 'Teal Purple Flip', id = 176 },
        { label = 'Turqoise Red Flip', id = 177 },
        { label = 'Turqoise Purple Flip', id = 178 },
        { label = 'Cyan Purple Flip', id = 179 },
        { label = 'Blue Pink Flip', id = 180 },
        { label = 'Blue Green Flip', id = 181 },
        { label = 'Purple Red Flip', id = 182 },
        { label = 'Purple Green Flip', id = 183 },
        { label = 'Magenta Green Flip', id = 184 },
        { label = 'Magenta Yellow Flip', id = 185 },
        { label = 'Burgundy Green Flip', id = 186 },
        { label = 'Magenta Cyan Flip', id = 187 },
        { label = 'Copper Purple Flip', id = 188 },
        { label = 'Magenta Orange Flip', id = 189 },
        { label = 'Red Orange Flip', id = 190 },
        { label = 'Orange Purple Flip', id = 191 },
        { label = 'Orange Blue Flip', id = 192 },
        { label = 'White Purple Flip', id = 193 },
        { label = 'Red Rainbow Flip', id = 194 },
        { label = 'Blue Rainbow Flip', id = 195 },
        { label = 'Dark Green Pearl', id = 196 },
        { label = 'Dark Teal Pearl', id = 197 },
        { label = 'Dark Blue Pearl', id = 198 },
        { label = 'Dark Purple Pearl', id = 199 },
        { label = 'Oil Slick Pearl', id = 200 },
        { label = 'Light Green Pearl', id = 201 },
        { label = 'Light Blue Pearl', id = 202 },
        { label = 'Light Purple Pearl', id = 203 },
        { label = 'Light Pink Pearl', id = 203 },
        { label = 'Off White Pearl', id = 204 },
        { label = 'Pink Pearl', id = 205 },
        { label = 'Yellow Pearl', id = 206 },
        { label = 'Green Pearl', id = 207 },
        { label = 'Blue Pearl', id = 208 },
        { label = 'Cream Pearl', id = 209 },
        { label = 'White Prismatic', id = 210 },
        { label = 'Graphite Prismatic', id = 211 },
        { label = 'Dark Blue Prismatic', id = 212 },
        { label = 'Dark Purple Prismatic', id = 213 },
        { label = 'Hot Pink Prismatic', id = 214 },
        { label = 'Dark Red Prismatic', id = 215 },
        { label = 'Dark GREEEN Prismatic', id = 216 },
        { label = 'Black Prismatic', id = 217 },
        { label = 'Black Oil Spill', id = 218 },
        { label = 'Black Rainbow', id = 219 },
        { label = 'Prismatic', id = 220 },
        { label = 'Black Holographic', id = 221 },
        { label = 'White Holographic', id = 222 },
        { label = "Monochrome", id = 223 },
        { label = "Night & Day", id = 224 },
        { label = "The Verlierer", id = 225 },
        { label = "Sprunk Extreme", id = 226 },
        { label = "Vice City", id = 227 },
        { label = "Synthwave Nights", id = 228 },
        { label = "Four Seasons", id = 229 },
        { label = "Maisonette 9 Throwback", id = 230 },
        { label = "Bubblegum", id = 231 },
        { label = "Full Rainbow", id = 232 },
        { label = "Sunset", id = 233 },
        { label = "The Seven", id = 234 },
        { label = "Kamen Rider", id = 235 },
        { label = "Chromatic Aberration", id = 236 },
        { label = "It's Christmas", id = 237 },
        { label = "Temperature", id = 238 },
        { label = 'Yellow Orange Pearl', id = 239 },
        { label = 'Pink Blue Pearl', id = 240 },
        { label = 'Green Blue Pearl', id = 241 },
        { label = 'Turqoise Black Pearl', id = 242 }
    }
}