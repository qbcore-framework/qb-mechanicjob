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
        work_v = '[E] Work On Vehicle',
        progress_bar = 'Repairing...',
        veh_status = 'Vehicle Status:',
        job_blip = 'Autocare Mechanic',
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
        repair_op = 'Repair:',
        b_menu = '⬅ Back Menu',
        d_menu = 'Back to parts menu',
        c_menu = '⬅ Close Menu'
    },

    nodamage_menu = {
        header = 'No Damage',
        bh_menu = 'Back Menu',
        bd_menu = 'There Is No Damage To This Part!',
        c_menu = '⬅ Close Menu'
    },

    notifications = {
        not_enough = 'You don\'t Have Enough',
        not_have = 'You don\'t have',
        not_materials = 'There are not enough materials in the safe',
        rep_canceled = 'Repair canceled',
        repaired = 'has been repaired!',
        uknown = 'Status uknown',
        not_valid = 'Not valid vehicle',
        not_close = 'You are not close enough to the vehicle',
        veh_first = 'You must be in the vehicle first',
        outside = 'You must be outside the vehicle',
        wrong_seat = 'You are not the driver or on a bicycle',
        not_vehicle = 'You are not in a vehicle',
        progress_bar = 'Repairing vehicle..',
        process_canceled = 'Proccess canceled',
        not_part = 'Not a valid part',
        partrep ='The %{value} Is Repaired!',
    },

    success = {
        this_vehicle_has_been_tuned = "This Vehicle Has Been Tuned",
    },

    text = {
        this_is_not_the_idea_is_it = "This is not the idea, is it?",
        connecting_nos = "Connecting NOS...",
    },

    error = {
        tunerchip_vehicle_tuned = "TunerChip v1.05: Vehicle Tuned!",
        this_vehicle_has_not_been_tuned = "This Vehicle Has Not Been Tuned",
        no_vehicle_nearby = "No Vehicle Nearby",
        tunerchip_vehicle_has_been_reset = "TunerChip v1.05: Vehicle has been reset!",
        you_are_not_in_a_vehicle = "You Are Not In A Vehicle",
        you_cannot_do_that_from_this_seat = "You cannot do that from this seat!",
        you_already_have_nos_active = "You Already Have NOS Active",
        canceled = "Canceled",
    },
}

Lang = Lang or Locale:new({
    phrases = Translations,
    warnOnMissing = true
})