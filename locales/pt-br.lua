local Translations = {
    labels = {
        engine = 'Motor',
        bodsy = 'Carroceria',
        radiator = 'Radiador',
        axle = 'Eixo de Tração',
        brakes = 'Freios',
        clutch = 'Embreagem',
        fuel = 'Tanque de Combustível',
        sign_in = 'Entrar',
        sign_off = 'Sair',
        o_stash = '[E] Abrir Baú',
        h_vehicle = '[E] Esconder Veículo',
        g_vehicle = '[E] Pegar Veículo',
        o_menu = '[E] Abrir Menu',
        work_v = '[E] Trabalhar no Veículo',
        progress_bar = 'Reparando...',
        veh_status = 'Status do Veículo:',
        job_blip = 'Mecânico Autocare',
    },

    lift_menu = {
        header_menu = 'Opções do Veículo',
        header_vehdc = 'Desconectar Veículo',
        desc_vehdc = 'Desconectar Veículo na Plataforma',
        header_stats = 'Verificar Status',
        desc_stats = 'Verificar Status do Veículo',
        header_parts = 'Peças do Veículo',
        desc_parts = 'Reparar Peças do Veículo',
        c_menu = '⬅ Fechar Menu'
    },

    parts_menu = {
        status = 'Status: ',
        menu_header = 'Menu de Peças',
        repair_op = 'Reparar:',
        b_menu = '⬅ Voltar ao Menu',
        d_menu = 'Voltar ao menu de peças',
        c_menu = '⬅ Fechar Menu'
    },

    nodamage_menu = {
        header = 'Sem Danos',
        bh_menu = 'Voltar ao Menu',
        bd_menu = 'Não há danos nesta parte!',
        c_menu = '⬅ Fechar Menu'
    },

    notifications = {
        not_enough = 'Você não tem o suficiente',
        not_have = 'Você não tem',
        not_materials = 'Não há material suficiente no cofre',
        rep_canceled = 'Reparo cancelado',
        repaired = 'foi reparado!',
        uknown = 'Status desconhecido',
        not_valid = 'Veículo inválido',
        not_close = 'Você não está perto o suficiente do veículo',
        veh_first = 'Você deve estar dentro do veículo primeiro',
        outside = 'Você deve estar fora do veículo',
        wrong_seat = 'Você não é o motorista ou está em uma bicicleta',
        not_vehicle = 'Você não está em um veículo',
        progress_bar = 'Reparando o veículo...',
        process_canceled = 'Processo cancelado',
        not_part = 'Não é uma parte válida',
        partrep = 'A %{value} foi reparada!',
    }
}

Lang = Lang or Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
