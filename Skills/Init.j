function Trig_Init_Actions takes nothing returns nothing
    local unit u
    local item it
    local group g = GetUnitsOfPlayerAll(Player(0))

    set u = FirstOfGroup(g)
    call DestroyGroup(g)
    set g = null
    call UnitAddItem(u, CreateItem('bspd', GetUnitX(u), GetUnitY(u)))
// -----------------------------------------

    set Neji_Unit = u
    call TriggerRegisterUnitEvent(Neji_OrderTrg, u, EVENT_UNIT_ISSUED_ORDER)
    call TriggerRegisterUnitEvent(Neji_OrderTrg, u, EVENT_UNIT_ISSUED_POINT_ORDER)
    call TriggerRegisterUnitEvent(Neji_OrderTrg, u, EVENT_UNIT_ISSUED_TARGET_ORDER)
    call TriggerRegisterAnyUnitEventBJ(Neji_HyugaClanTechAtkTrg, EVENT_PLAYER_UNIT_ATTACKED)
    call TriggerRegisterUnitEvent(gg_trg_Hyuga_Clan_Tech, u, EVENT_UNIT_SPELL_EFFECT)
    call TriggerRegisterUnitEvent(gg_trg_Hakke_Hasangeki, u, EVENT_UNIT_SPELL_EFFECT)
    call TriggerRegisterUnitEvent(gg_trg_Hakkesho_Kaiten, u, EVENT_UNIT_SPELL_EFFECT)

/*     call TriggerRegisterUnitEvent(Naruto_KagebunshinLearn, u, EVENT_UNIT_HERO_SKILL)
    call TriggerRegisterUnitEvent(Naruto_KagebunshinLvlUp, u, EVENT_UNIT_HERO_LEVEL)
    call TriggerRegisterUnitEvent(gg_trg_Kage_Bunshin, u, EVENT_UNIT_SPELL_EFFECT)
    call TriggerRegisterUnitEvent(gg_trg_Jiton_Rasengan, u, EVENT_UNIT_SPELL_EFFECT)
    call TriggerRegisterUnitEvent(gg_trg_Baryon_Chakra, u, EVENT_UNIT_SPELL_EFFECT)
    call TriggerRegisterUnitEvent(Naruto_RasenshurikenCast, u, EVENT_UNIT_SPELL_CHANNEL)
    call TriggerRegisterUnitEvent(Naruto_RasenshurikenCastEnd, u, EVENT_UNIT_SPELL_ENDCAST)
    call TriggerRegisterUnitEvent(gg_trg_Lava_Rasenshuriken, u, EVENT_UNIT_SPELL_EFFECT) */

    //call TriggerRegisterAnyUnitEventBJ(gg_trg_Suidanha, EVENT_PLAYER_UNIT_SPELL_EFFECT)
endfunction

//===========================================================================
function InitTrig_Init takes nothing returns nothing
    set gg_trg_Init = CreateTrigger(  )
    call TriggerRegisterTimerEventSingle( gg_trg_Init, 0.10 )
    call TriggerAddAction( gg_trg_Init, function Trig_Init_Actions )
endfunction