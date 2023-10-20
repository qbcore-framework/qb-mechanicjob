local Translations = {
    labels = {
        engine = 'Motor',
        bodsy = 'Karrosseri',
        radiator = 'Radiator',
        axle = 'Drivaksel',
        brakes = 'Bremser',
        clutch = 'Kobling',
        fuel = 'Brændstoftank',
        sign_in = 'Log ind',
        sign_off = 'Log ud',
        o_stash = '[E] Åbn Depot',
        h_vehicle = '[E] Skjul Køretøj',
        g_vehicle = '[E] Hent Køretøj',
        o_menu = '[E] Åbn Menu',
        work_v = '[E] Arbejd på Køretøj',
        progress_bar = 'Reparerer...',
        veh_status = 'Køretøjets Status:',
        job_blip = 'Autocare Mekaniker',
    },

    lift_menu = {
        header_menu = 'Køretøj Muligheder',
        header_vehdc = 'Frakobl Køretøj',
        desc_vehdc = 'Fjern Køretøj fra Lift',
        header_stats = 'Tjek Status',
        desc_stats = 'Tjek Køretøjets Status',
        header_parts = 'Køretøjsdele',
        desc_parts = 'Reparer Køretøjsdele',
        c_menu = '⬅ Luk Menu'
    },

    parts_menu = {
        status = 'Status: ',
        menu_header = 'Delmenu',
        repair_op = 'Reparer:',
        b_menu = '⬅ Tilbage til Menu',
        d_menu = 'Tilbage til delmenuen',
        c_menu = '⬅ Luk Menu'
    },

    nodamage_menu = {
        header = 'Ingen Skade',
        bh_menu = 'Tilbage til Menu',
        bd_menu = 'Der er ingen skade på denne del!',
        c_menu = '⬅ Luk Menu'
    },

    notifications = {
        not_enough = 'Du har ikke nok',
        not_have = 'Du har ikke',
        not_materials = 'Der er ikke nok materialer i kassen',
        rep_canceled = 'Reparation annulleret',
        repaired = 'er blevet repareret!',
        uknown = 'Status ukendt',
        not_valid = 'Ikke gyldig bil',
        not_close = 'Du er ikke tæt nok på køretøjet',
        veh_first = 'Du skal være i køretøjet først',
        outside = 'Du skal være uden for køretøjet',
        wrong_seat = 'Du er ikke føreren eller på en cykel',
        not_vehicle = 'Du er ikke i et køretøj',
        progress_bar = 'Reparerer køretøj...',
        process_canceled = 'Proces annulleret',
        not_part = 'Ikke en gyldig del',
        partrep = 'Del %{value} er blevet repareret!',
    }
}


if GetConvar('qb_locale', 'en') == 'da' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
