local Translations = {
    labels = {
        engine = 'Motor',
        bodsy = 'Gövde',
        radiator = 'Radyatör',
        axle = 'Aks',
        brakes = 'Frenler',
        clutch = 'Debriyaj',
        fuel = 'Yakıt Tankı',
        sign_in = 'Giriş Yap',
        sign_off = 'Çıkış Yap',
        o_stash = '[E] Saklama Alanını Aç',
        h_vehicle = '[E] Aracı Gizle',
        g_vehicle = '[E] Aracı Al',
        o_menu = '[E] Menüyü Aç',
        work_v = '[E] Araç Üzerinde Çalış',
        progress_bar = 'Onarılıyor...',
        veh_status = 'Araç Durumu:',
        job_blip = 'Autocare Tamircisi',
    },

    lift_menu = {
        header_menu = 'Araç Seçenekleri',
        header_vehdc = 'Araç Bağlantısını Kes',
        desc_vehdc = 'Kaldırmadaki Araç Bağlantısını Kes',
        header_stats = 'Durumu Kontrol Et',
        desc_stats = 'Araç Durumunu Kontrol Et',
        header_parts = 'Araç Parçaları',
        desc_parts = 'Araç Parçalarını Onar',
        c_menu = '⬅ Menüyü Kapat'
    },

    parts_menu = {
        status = 'Durum: ',
        menu_header = 'Parça Menüsü',
        repair_op = 'Onarım:',
        b_menu = '⬅ Geri Menü',
        d_menu = 'Parçalar Menüsüne Geri Dön',
        c_menu = '⬅ Menüyü Kapat'
    },

    nodamage_menu = {
        header = 'Hasarsız',
        bh_menu = 'Geri Menü',
        bd_menu = 'Bu Parçada Hasar Yok!',
        c_menu = '⬅ Menüyü Kapat'
    },

    notifications = {
        not_enough = 'Yeterli paranız yok',
        not_have = 'Sahip değilsiniz',
        not_materials = 'Güvende yeterli malzeme yok',
        rep_canceled = 'Onarım iptal edildi',
        repaired = 'tamir edildi!',
        uknown = 'Bilinmeyen durum',
        not_valid = 'Geçerli bir araç değil',
        not_close = 'Araça yeterince yakın değilsiniz',
        veh_first = 'Önce araçta olmalısınız',
        outside = 'Araç dışında olmalısınız',
        wrong_seat = 'Sürücü değilsiniz veya bisiklet üzerinde değilsiniz',
        not_vehicle = 'Araç içinde değilsiniz',
        progress_bar = 'Araç tamir ediliyor..',
        process_canceled = 'İşlem iptal edildi',
        not_part = 'Geçerli bir parça değil',
        partrep = '%{value} Onarıldı!',
    }
}

if GetConvar('qb_locale', 'en') == 'tr' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end