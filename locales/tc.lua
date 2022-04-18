local Translations = {
    error = {
        canceled = '已取消..',
        no_materials = '備品庫中沒有足夠的材料',
        unknow_status = '狀況不明',
        invalid_vehicle = '無效的載具種類',
        invalid_part = '無效的部件',
        too_far_to_vehicle = '離載具太遠',
        getin_first = '您必須先進入載具',
        must_out = '您必須離開載具',
        not_driver_or_bike = '您不是駕駛員或您騎著腳踏車',
        not_in_veh = '您並未在任何載具內',
        not_enough_materials = '您至少需要%{cost}個%{Part}',
        not_materials = '身上沒有%{Part}',
        must_id = '玩家ID不得為空',
        not_auth = '您沒有權限',
    },
    success = {
        repaired = '%{part} 已經修好',
    },
    info = {
        map_name = '汽車維修廠',
        hired = '您被僱用維修車廠員工',
        have_hired = '僱用了 %{name} 為修車廠員工',
        repairing = '正在修理%{Part}',
        repairing_veh = '正在修理車輛',
        stash = '備品櫃',
    },
    menu = {
        veh_option = '工作選項',
        disconnect = '將載具下架',
        unattach_from_lift = '將車輛從工作區移開',
        check = '確認狀態',
        check_detail = '確認載具狀態',
        repair_part = '維修載具',
        repair_part_detail = '維修載具部件',
        back = '⬅ 返回',
        back_part = '返回部件目錄',
        close = '⬅ 關閉目錄',
        status = '目前狀態: %{status}.0% / 100.0%',
        no_damage = '沒有任何損傷',
        no_damage2 = '此部件沒有任何修理的必要!',
        repair_need = '修理: 需要%{cost}個%{Part}',
    },
    commands = {
        setmechanic = '僱用其他人作為修車廠員工',
    },
    progressbar = {
        blood_clear = '正在清理血跡...',
        bullet_casing = '正在收取彈殼..',
        robbing = '搶劫中...',
        place_object = '正在放置物品..',
        remove_object = '正在回收物品..',
    },
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
