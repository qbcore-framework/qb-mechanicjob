local Translations = {
    labels = {
        engine = 'Motor',
        body = 'Carroceria',
        radiator = 'Radiador',
        axle = 'Eixo de Transmissão',
        brakes = 'Freios',
        clutch = 'Embreagem',
        fuel = 'Tanque de Combustível',
        sign_in = 'Entrar',
        sign_off = 'Sair',
        o_stash = '[E] Abrir Inventário',
        h_vehicle = '[E] Esconder Veículo',
        g_vehicle = '[E] Pegar Veículo',
        o_menu = '[E] Abrir Menu',
        work_v = '[E] Trabalhar no Veículo',
        progress_bar = 'Reparando...',
        veh_status = 'Status do Veículo:',
        job_blip = 'Mecânico da Autocare',
    },

    lift_menu = {
        header_menu = 'Opções do Veículo',
        header_vehdc = 'Desconectar Veículo',
        desc_vehdc = 'Desacoplar Veículo no Elevador',
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
        bh_menu = 'Menu Anterior',
        bd_menu = 'Não há danos nesta parte!',
        c_menu = '⬅ Fechar Menu'
    },

    notifications = {
        not_enough = 'Você não tem o suficiente',
        not_have = 'Você não possui',
        not_materials = 'Não há materiais suficientes no cofre',
        rep_canceled = 'Reparo cancelado',
        repaired = 'foi reparado!',
        unknown = 'Status desconhecido',
        not_valid = 'Veículo inválido',
        not_close = 'Você não está perto o suficiente do veículo',
        veh_first = 'Você deve entrar no veículo primeiro',
        outside = 'Você deve estar fora do veículo',
        wrong_seat = 'Você não é o motorista ou está em uma bicicleta',
        not_vehicle = 'Você não está em um veículo',
        progress_bar = 'Reparando veículo...',
        process_canceled = 'Processo cancelado',
        not_part = 'Parte inválida',
        partrep ='O %{value} foi reparado!',
    }
}


if GetConvar('qb_locale', 'en') == 'pt-br' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end