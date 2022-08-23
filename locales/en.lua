local Translations = {
    labels = {
        engine = 'Motor',
        bodsy = 'Body',
        radiator = 'Radiator',
        axle = 'Drive Shaft',
        brakes = 'Brakes',
        clutch = 'Clutch',
        fuel = 'Fuel tank',
        sign_in = 'Sign In',
        sign_off = 'Sign Off',
        o_stash = '[E] Open Stash',
        h_vehicle = '[E] Hide Vehicle',
        g_vehicle = '[E] Get Vehicle',
        o_menu = '[E] Open Menu',
        work_v = '[E] Work On Vehicle'
    }, 

    lift_menu = {
        header_menu = 'Vehicle Options',
        header_vehdc = 'Disconnect Vehicle',
        desc_vehdc = 'Unattach Vehicle in Lift',
        header_stats = 'Check Status',
        desc_stats = 'Check Vehicle Status',
        header_parts = 'Vehicle Parts',
        desc_parts = 'Repair Vehicle Parts',
        c_menu = '⬅ Close Menu'
    },

    parts_menu = {
        status = 'Status: ',
        menu_header = 'Part Menu',
        repair_op = 'Repair: ',
        b_menu = '⬅ Back Menu',
        d_menu = 'Back to parts menu',
        c_menu = '⬅ Close Menu'
    },

    nodamage_menu = {
        header = 'No Damage',
        bh_menu = 'Back Menu',
        bd_menu = 'There Is No Damage To This Part!',
        c_menu = '⬅ Close Menu'
    }
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})