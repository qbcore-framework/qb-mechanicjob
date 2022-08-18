--[[
Romanian base language translation for qb-mechanicjob
Translation done by wanderrer (Martin Riggs#0807 on Discord)
]]--
local Translations = {
    progress = {
        repveh = "Se repara...",
    },
    comm = {
        svstat = "Seteaza statutul unei piese",
        svstatp = "Piesa",
        svstatptxt = "Numele piesei pe care vrei sa o modifici",
        svstatpam = "Procent",
        svstatpamtxt = "Procentajul de reparare, Ex: 30",
        smch = "Oferi unui cetatean job-ul de mecanic auto",
        smchid = "ID",
        smchidtxt = "ID-ul persoanei pe care vrei sa o faci mecanic",
        famech = "Concediaza un mecanic",
        famechid = "ID",
        famechidtxt = "ID-ul persoanei pe care vrei sa o concediezi",
    },
    notify = {
        repcancel = "Reparatiile au fost anulate",
        pcanceled = "Procesul a fost anulat",
        nemat = "Nu ai suficiente materiale in depozit",
        partrep = "Piesa %{value} a fost reparata!",
        sunk = "Statut necunoscut",
        navveh = "Nu este un vehicul valid",
        navpart = "Nu este o piesa valida",
        yancveh = "Nu esti suficient de aproape de vehicul",
        ymbiaveh = "Trebuie sa fi la volanul vehiculului",
        ymboveh = "Nu trebuie sa fi in vehicul, da-te jos!",
        yantdob = "Hmm, ori nu esti la volan ori esti pe o bicicleta",
        yanoveh = "Nu esti intr-un vehicul",
        ydnhenough = "Nu ai suficient %{value1} (min. %{value2} x)",
        ydnhave = "Nu ai  %{value} deloc, cumpara!",
        ywhamech = "Ai fost angajat ca mecanic auto!",
        yhhamech = "Ai un nou angajat, %{value} ca mecanic auto!",
        ympavid = "Trebuie sa precizezi ID-ul cetateanului!",
        ycndt = "Din pacate, nu poti face treaba asta!",
        ywfasmech = "Ai fost concediat, nu mai esti mecanic auto!",
        yhfamech = "Ai concediat angajatul %{value} nu mai este mecanic auto!",
        yanaemmech = "Hmm, se pare ca nu esti mecanic auto!",

    },
    menu = {
        stjob = "Incepi tura",
        stpjob = "Iesi din tura",
        opstash = "Deschide depozitul",
        mheader = "Optiuni vehicul",
        disveh = "Deconecteaza vehiculul",
        disvehtxt = "Detaseaza vehiculul de pe cric",
        cvech = "Check Status",
        cvechtxt = "Verifica starea vehiculului",
        vehparts = "Piesele vehiculului",
        vehpartstxt = "Repara piesele vehiculului",
        closemenu = "⬅ Inchide",
        backmenu = "⬅ Inapoi la meniu",
        backmenutxt = "Inapoi la piese",
        repveh = "Repara : ",
        nodamage = "Fara probleme",
        pnodamage = "Inapoi",
        pnodamagetxt = "Componenta nu are probleme!",
    },

    interaction = {
        pstash = "[E] Deschide depozitul",
        hvehicle = "[E] Parcheaza vehicul",
        gvehicle = "[E] Foloseste vehicul",
        opmenu = "[E] Deschide meniul",
        wovehicle = "[E] Lucreaza la vehicul",
    },
    label = {
        vstatus = "Starea vehiculului",
        mstatus = "Stare",
        mstat2 = "Stare: ",
        vehlist = "Lista vehicule",
        vehtxt = "Vehicul: ",
        ablip = "Mecanic auto", -- name of the blip
    },

}
Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
