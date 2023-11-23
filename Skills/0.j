scope HyugaClanTech initializer Init

    globals
        private constant integer skId = 'A003'
        private hashtable hash = null
        private integer stackHashIndex
        private integer dmgTrgHashIndex
        private integer atkedIdHashIndex
        private integer minStack
        private integer maxStack
        private integer bashSk
        private real maxDmgHpPercent
        private real atkedDelay
        private real burnAmount
        private boolean isAttacking
    endglobals

    private function InitSkill takes nothing returns nothing
        if (hash == null) then
            set hash = InitHashtable()
            set stackHashIndex = 0
            set dmgTrgHashIndex = 1
            set atkedIdHashIndex = 2
            set atkedDelay = 1.00
            set minStack = 0
            set maxStack = minStack + 2
            set bashSk = 'A00A'
            set maxDmgHpPercent = 3.00
            set burnAmount = 60.00
        endif
    endfunction

    private function CreateBurnTxt takes string str, unit u returns nothing
        local texttag tt = CreateTextTag()
        local real x = GetUnitX(u)
        local real y = GetUnitY(u)
        local real facing = 222.00

        set x = PolarX(x, 20.00, facing)
        set y = PolarY(y, 20.00, facing)
        call SetTextTagText(tt, str, 0.024)
        call SetTextTagPos(tt, x, y, 27)
        call SetTextTagColor(tt, 50, 100, 200, 255)
        call SetTextTagVelocity(tt, 0, 0.0395)
        call SetTextTagFadepoint(tt, 0.70)
        call SetTextTagPermanent(tt, false)
        call SetTextTagLifespan(tt, 1.40)
        call SetTextTagVisibility(tt, true)
        set tt = null
    endfunction

    private function Cond takes nothing returns boolean
        return (GetSpellAbilityId() == skId)
    endfunction

    private function Act takes nothing returns nothing
        local unit self = GetTriggerUnit()

        set bj_lastCreatedUnit = CreateUnit(GetOwningPlayer(self), 'u003', GetUnitX(self), GetUnitY(self), bj_UNIT_FACING)
        call UnitAddAbility(bj_lastCreatedUnit, 'A004')
        call IssueTargetOrder(bj_lastCreatedUnit, "unholyfrenzy", self)
        call UnitApplyTimedLife(bj_lastCreatedUnit, 1112820806, 1.00)
        set self = null
    endfunction

    private function DmgCond takes nothing returns boolean
        local unit atker = GetEventDamageSource()
        local unit atked
        local real dmg
        local real atkedMp
        local real atkedMaxMp
        local real atkedHp
        local real mpPercent
        local real maxBonusDmg
        local real bonusDmg

        if (GetUnitAbilityLevel(atker, skId) > 0) then
            if (atker == Neji_Unit) and (isAttacking == false) then
                set atker = null
                return false
            endif

            set atked = GetTriggerUnit()
            set atkedMp = GetUnitState(atked, UNIT_STATE_MANA)
            set atkedHp = GetUnitState(atked, UNIT_STATE_LIFE)
            call DestroyEffect(AddSpecialEffectTarget("war3mapImported\\NejiAttack.mdl", atked, "origin"))
            call SetUnitState(atked, UNIT_STATE_MANA, RMaxBJ(0, atkedMp - burnAmount))
            if (GetUnitAbilityLevel(atker, Neji_ByakuganBuff) > 0) then
                set dmg = GetEventDamage()
                set atkedMaxMp = GetUnitState(atked, UNIT_STATE_MAX_MANA)
                if (atkedMaxMp == 0) then
                    set atkedMaxMp = 1
                endif

                set mpPercent = (atkedMaxMp - atkedMp) / atkedMaxMp
                set maxBonusDmg = maxDmgHpPercent / 100 * GetUnitState(atked, UNIT_STATE_MAX_LIFE)
                set bonusDmg = RMinBJ(maxBonusDmg, dmg * RMaxBJ(0.001, mpPercent))
                call CreateBurnTxt(I2S(R2I(bonusDmg)) + "!", atked)
                if (atker == Neji_Unit) then
                    if (mpPercent >= 0.8) then
                        call UnitAddAbility(atker, bashSk)
                    else
                        call UnitRemoveAbility(atker, bashSk)
                    endif
                endif

                if (atkedHp > bonusDmg) then
                    call SetUnitState(atked, UNIT_STATE_LIFE, (atkedHp - bonusDmg))
                else
                    call SetUnitState(atked, UNIT_STATE_LIFE, 1.00)
                endif
            endif
            set atked = null
        endif
        set atker = null
        return false
    endfunction

    private function AtkedEnd takes nothing returns nothing
        local timer delayTimer = GetExpiredTimer()
        local integer timerId = GetHandleId(delayTimer)
        local integer atkedId = LoadInteger(hash, timerId, atkedIdHashIndex)
        local integer stack
        local trigger dmgTrg

        call PauseTimer(delayTimer)
        call DestroyTimer(delayTimer)
        set delayTimer = null
        call FlushChildHashtable(hash, timerId)

        set stack = LoadInteger(hash, atkedId, stackHashIndex) - 1
        if (stack <= minStack) then
            set dmgTrg = LoadTriggerHandle(hash, atkedId, dmgTrgHashIndex)
            call TriggerClearConditions(dmgTrg)
            call DestroyTrigger(dmgTrg)
            set dmgTrg = null
            call FlushChildHashtable(hash, atkedId)
        else
            call SaveInteger(hash, atkedId, stackHashIndex, stack)
        endif
    endfunction

    private function AtkCond takes nothing returns boolean
        local unit atker = GetAttacker()
        local unit atked = GetTriggerUnit()
        local integer stack
        local integer atkedId
        local trigger dmgTrg
        local timer delayTimer

        if (GetUnitAbilityLevel(atker, skId) > 0) and (GetUnitState(atked, UNIT_STATE_MAX_MANA) > 0) then
            call InitSkill()
            set atkedId = GetHandleId(atked)
            set stack = LoadInteger(hash, atkedId, stackHashIndex)
            if (stack < maxStack) then
                if (atker == Neji_Unit) then
                    set isAttacking = true
                endif

                if (stack == minStack) then
                    set dmgTrg = CreateTrigger()
                    call TriggerAddCondition(dmgTrg, Condition(function DmgCond))
                    call TriggerRegisterUnitEvent(dmgTrg, atked, EVENT_UNIT_DAMAGED)
                    call SaveTriggerHandle(hash, atkedId, dmgTrgHashIndex, dmgTrg)
                    set dmgTrg = null
                endif

                call SaveInteger(hash, atkedId, stackHashIndex, (stack + 1))
                set delayTimer = CreateTimer()
                call SaveInteger(hash, GetHandleId(delayTimer), atkedIdHashIndex, atkedId)
                call TimerStart(delayTimer, atkedDelay, true, function AtkedEnd)
                set delayTimer = null
            endif
        endif
        set atker = null
        set atked = null
        return false
    endfunction

    private function OrderAct takes nothing returns nothing
        if (851983 != GetIssuedOrderId()) then
            set isAttacking = false
            call UnitRemoveAbility(GetOrderedUnit(), bashSk)
        endif
    endfunction

// =======================================================================================
    private function Init takes nothing returns nothing
        set gg_trg_Hyuga_Clan_Tech = CreateTrigger()
        call TriggerAddCondition(gg_trg_Hyuga_Clan_Tech, Condition(function Cond))
        call TriggerAddAction(gg_trg_Hyuga_Clan_Tech, function Act)

        set Neji_HyugaClanTechAtkTrg = CreateTrigger()
        call TriggerAddCondition(Neji_HyugaClanTechAtkTrg, Condition(function AtkCond))

        set Neji_OrderTrg = CreateTrigger()
        call TriggerAddAction(Neji_OrderTrg, function OrderAct)
    endfunction

endscope