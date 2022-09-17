function Trig_Init_Actions takes nothing returns nothing
    local unit u
    local item it
    local group g = GetUnitsOfPlayerAll(Player(0))
    set u = FirstOfGroup(g)
    call DestroyGroup(g)
    set g = null
    call UnitAddItem(u, CreateItem('bspd', GetUnitX(u), GetUnitY(u)))
// -----------------------------------------

    set Naruto_Player = GetOwningPlayer(u)
    set Naruto_CloneBuff = 'B001'
    call TriggerRegisterUnitEvent(Naruto_KagebunshinLearn, u, EVENT_UNIT_HERO_SKILL)
    call TriggerRegisterUnitEvent(Naruto_KagebunshinLvlUp, u, EVENT_UNIT_HERO_LEVEL)
    call TriggerRegisterUnitEvent(gg_trg_Kage_Bunshin, u, EVENT_UNIT_SPELL_EFFECT)
    call TriggerRegisterUnitEvent(gg_trg_Jiton_Rasengan, u, EVENT_UNIT_SPELL_EFFECT)
    call TriggerRegisterUnitEvent(gg_trg_Baryon_Chakra, u, EVENT_UNIT_SPELL_EFFECT)
    call TriggerRegisterUnitEvent(Naruto_RasenshurikenCast, u, EVENT_UNIT_SPELL_CHANNEL)
    call TriggerRegisterUnitEvent(Naruto_RasenshurikenCastEnd, u, EVENT_UNIT_SPELL_ENDCAST)
    call TriggerRegisterUnitEvent(gg_trg_Lava_Rasenshuriken, u, EVENT_UNIT_SPELL_EFFECT)

    /* set Zabuza_BashSk = 'A003'
    set Zabuza_CleavingSk = 'A004'
    set Zabuza_CriticalSk = 'A001'
    set Zabuza_EnvSpearSk = 'A002'
    set Zabuza_MuonSatsujinBonusAtkSk = 'A005'
    call SetAbilityAvailable(Zabuza_BashSk, false)
    call SetAbilityAvailable(Zabuza_CleavingSk, false)
    call SetAbilityAvailable(Zabuza_CriticalSk, false)
    call SetAbilityAvailable(Zabuza_EnvSpearSk, false)
    call SetAbilityAvailable('A006', false)

    call TriggerRegisterUnitEvent(gg_trg_Suiro_Jutsu, u, EVENT_UNIT_ISSUED_ORDER)
    call TriggerRegisterUnitEvent(gg_trg_Muon_Satsujin, u, EVENT_UNIT_SPELL_EFFECT)
    call TriggerRegisterUnitEvent(gg_trg_Kubikiribocho_Slash, u, EVENT_UNIT_HERO_SKILL)
    call TriggerRegisterUnitEvent(gg_trg_Kirigakure, u, EVENT_UNIT_SPELL_EFFECT)
    call TriggerRegisterUnitEvent(gg_trg_Demon_Power, u, EVENT_UNIT_SPELL_EFFECT)
    call TriggerRegisterUnitEvent(Zabuza_DaibakufuCast, u, EVENT_UNIT_SPELL_CHANNEL)
    call TriggerRegisterUnitEvent(gg_trg_Daibakufu, u, EVENT_UNIT_SPELL_EFFECT) */

    //call TriggerRegisterAnyUnitEventBJ(gg_trg_Suidanha, EVENT_PLAYER_UNIT_SPELL_EFFECT)
endfunction

//===========================================================================
function InitTrig_Init takes nothing returns nothing
    set gg_trg_Init = CreateTrigger(  )
    call TriggerRegisterTimerEventSingle( gg_trg_Init, 0.10 )
    call TriggerAddAction( gg_trg_Init, function Trig_Init_Actions )
endfunction