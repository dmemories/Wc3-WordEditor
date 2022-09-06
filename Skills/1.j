scope KageBunshin initializer Init

    globals
        private constant integer skId = 'A000'
        private trigger atkedTrg
        private unit atker
        private unit atked
        private unit caster
        private integer countdown
        private integer cloneType
        private integer shadowCloneType
        private integer skChance
        private real skDelay
        private real moveSpeed
        private real lastX
        private real lastY
        private real garea
        private real dmg
        private integer illusionSk
        private integer illusionLv
        private integer stunSk
    endglobals

    private function CooldownCallback takes nothing returns nothing
        local timer t = GetExpiredTimer()
        call PauseTimer(t)
        call DestroyTimer(t)
        set t = null
        call EnableTrigger(atkedTrg)
    endfunction

    private function CloneAttackL takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local real x
        local real y
        local real facing
        local boolean atkedAlive

        if (GetUnitState(atker, UNIT_STATE_LIFE) < 1) then
            set countdown = 0
        else
            set countdown = countdown - 1
        endif
        if (countdown > 10) then
            set atkedAlive = GetUnitState(atked, UNIT_STATE_LIFE) > 0
            if (atkedAlive) then
                set lastX = GetUnitX(atked)
                set lastY = GetUnitY(atked)
            endif
            set x = GetUnitX(atker)
            set y = GetUnitY(atker)
            set facing = AngleBetweenXY(x, y, lastX, lastY)
            set x = PolarX(x, moveSpeed, facing)
            set y = PolarY(y, moveSpeed, facing)
            call DestroyTreeXY(x, y, garea)
            call UnitMoveXY2(atker, x, y)
            if (DistanceBetweenXY(x, y, lastX, lastY) < 120) then
                set bj_lastCreatedUnit = CreateUnit(Naruto_Player, 'h0BX', lastX, lastY, bj_UNIT_FACING)
                call UnitAddAbility(bj_lastCreatedUnit, stunSk)
                call UnitRemoveAbility(bj_lastCreatedUnit, 'Amov')
                call IssueTargetOrder(bj_lastCreatedUnit, "thunderbolt", atked)
                call UnitApplyTimedLife(bj_lastCreatedUnit, 1112820806, 1.00)
                if (atkedAlive) then
                    call UnitDamageTarget(atker, atked, dmg, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS)
                endif
                set countdown = 10
            else
                call SetUnitFacing(atker, facing)
            endif
        elseif (countdown < 1) then
            call PauseTimer(t)
            call DestroyTimer(t)
            call UnitApplyTimedLife(CreateUnit(Naruto_Player, shadowCloneType, GetUnitX(atker), GetUnitY(atker), bj_UNIT_FACING), 1112820806, 1.00)
            call RemoveUnit(atker)
            set atker = null
            set atked = null
        endif
        set t = null
    endfunction

    private function AtkedCond takes nothing returns boolean
        local real x
        local real y
        local real facing
        local real dist

        set atker = GetAttacker()
        if (GetUnitTypeId(atker) == cloneType) and (GetOwningPlayer(atker) == Naruto_Player) and (GetRandomInt(0, 99) < skChance) then
            call DisableTrigger(atkedTrg)
            set atked = GetTriggerUnit()

            set dmg = GetHeroStr(atker, true)
            set lastX = GetUnitX(atked)
            set lastY = GetUnitY(atked)
            set dist = 400
            set facing = GetRandomReal(0, 360)
            set x = PolarX(lastX, dist, facing)
            set y = PolarY(lastY, dist, facing)
            set facing = AngleBetweenXY(x, y, lastX, lastY)
            set atker = CreateDummy(Player(PLAYER_NEUTRAL_AGGRESSIVE), cloneType, x, y, facing, 255)
            call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Orc\\MirrorImage\\MirrorImageCaster.mdl", atker, "origin"))
            call PauseUnit(atker, true)
            call SetUnitTimeScale(atker, 1.60)
            call SetUnitAnimationByIndex(atker, 3)
            set countdown = 30
            call TimerStart(CreateTimer(), 0.03, true, function CloneAttackL)
            call TimerStart(CreateTimer(), skDelay, false, function CooldownCallback)
        else
            set atker = null
        endif
        return false
    endfunction

    private function LearnCond takes nothing returns boolean
        return (GetLearnedSkill() == skId)
    endfunction

    private function LearnAct takes nothing returns nothing
        local integer skLv = GetLearnedSkillLevel()

        if (skLv == 1) then
            set skChance = 9
            set cloneType = 'U002'
            set shadowCloneType = 'h01K'
            set skDelay = 5.00
            set moveSpeed = 40
            set garea = 120
            set dmg = 0
            set illusionSk = 'A001'
            set illusionLv = 1
            set stunSk = 'A002'

            set atkedTrg = CreateTrigger()
            call TriggerRegisterAnyUnitEventBJ(atkedTrg, EVENT_PLAYER_UNIT_ATTACKED)
            call TriggerAddCondition(atkedTrg, Condition(function AtkedCond))
        else
            if (skLv == 6) then
                call DestroyTrigger(Naruto_KagebunshinLearn)
            endif
        endif
    endfunction

    private function Cond takes nothing returns boolean
        return (GetSpellAbilityId() == skId)
    endfunction

    private function CreateShadowClone takes unit u returns nothing
        set bj_lastCreatedUnit = CreateUnit(Naruto_Player, 'u003', GetUnitX(u), GetUnitY(u), bj_UNIT_FACING)
        call UnitAddAbility(bj_lastCreatedUnit, illusionSk)
        call SetUnitAbilityLevel(bj_lastCreatedUnit, illusionSk, illusionLv)
        call IssueTargetOrderById(bj_lastCreatedUnit, 852274, u)
        call UnitApplyTimedLife(bj_lastCreatedUnit, 1112820806, 0.40)
    endfunction

    private function CreateShadowCloneAct takes nothing returns nothing
        local unit summonUnit = GetSummonedUnit()

        if (GetUnitAbilityLevel(summonUnit, Naruto_CloneBuff) > 0) then
            call UnitApplyTimedLife(CreateUnit(Naruto_Player, 'h01K', GetUnitX(summonUnit), GetUnitY(summonUnit), GetUnitFacing(summonUnit)), 1112820806, 1.00)
            call SelectUnitAddForPlayer(summonUnit, Naruto_Player)
        endif
        set summonUnit = null
    endfunction

    private function ActEnd takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local real x
        local real y

        call PauseTimer(t)
        call DestroyTimer(t)
        set t = null
        call ShowUnitShow(caster)
        call SetEnabledAttack(caster, true)
        call SetUnitInvulnerable(caster, false)
        call SelectUnitAddForPlayer(caster, Naruto_Player)
        call CreateShadowClone(caster)
        call CreateShadowClone(caster)
        call CreateShadowClone(caster)

        set x = GetUnitX(caster)
        set y = GetUnitY(caster)
        call UnitApplyTimedLife(CreateUnit(Naruto_Player, 'h01K', x, y, GetUnitFacing(caster)), 1112820806, 1.00)
        call SoundPatch_Spell(udg_soundPatch_Naruto + "\\Naruto\\KageBunshinEff.wav", x, y)
        set caster = null
    endfunction

    private function ClearOldShadowClone takes nothing returns nothing
        local unit picked
        local group g = CreateGroup()

        call GroupEnumUnitsOfPlayer(g, Naruto_Player, null)
        loop
            set picked = FirstOfGroup(g)
            exitwhen (picked == null)
            call GroupRemoveUnit(g, picked)
            if (GetUnitAbilityLevel(picked, Naruto_CloneBuff) > 0) then
                call UnitApplyTimedLife(CreateUnit(Naruto_Player, 'h013', GetUnitX(picked), GetUnitY(picked), GetUnitFacing(picked)), 1112820806, 1.00)
                call RemoveUnit(picked)
            endif
        endloop
        call DestroyGroup(g)
        set g = null
    endfunction

    private function Act takes nothing returns nothing
        local trigger summonTrg = CreateTrigger()
        local real x
        local real y

        set caster = GetTriggerUnit()
        set x = GetUnitX(caster)
        set y = GetUnitY(caster)
        call DisplayText("Kage Bunshin no Jutsu", caster, 0.023, true, 255, 255, 255, 255)
        call SoundPatch_Spell(udg_soundPatch_Naruto + "\\Naruto\\KageBunshin.wav", x, y)
        call ClearOldShadowClone()
        set illusionLv = GetUnitAbilityLevel(caster, illusionSk)
        call UnitApplyTimedLife(CreateUnit(Naruto_Player, 'h013', x, y, GetUnitFacing(caster)), 1112820806, 1.00)
        call SetUnitInvulnerable(caster, true)
        call SetEnabledAttack(caster, false)
        call ShowUnitHide(caster)
        call TimerStart(CreateTimer(), 1.00, false, function ActEnd)

        call TriggerAddAction(summonTrg, function CreateShadowCloneAct)
        call TriggerRegisterPlayerUnitEvent(summonTrg, Naruto_Player, EVENT_PLAYER_UNIT_SUMMON, null)
        call TriggerSleepAction(1.20)
        call TriggerClearActions(summonTrg)
        call DestroyTrigger(summonTrg)
        set summonTrg = null
    endfunction


// =======================================================================================
    private function Init takes nothing returns nothing
        set gg_trg_Kage_Bunshin = CreateTrigger()
        call TriggerAddCondition(gg_trg_Kage_Bunshin, Condition(function Cond))
        call TriggerAddAction(gg_trg_Kage_Bunshin, function Act)

        set Naruto_KagebunshinLearn = CreateTrigger()
        call TriggerAddCondition(Naruto_KagebunshinLearn, Condition(function LearnCond))
        call TriggerAddAction(Naruto_KagebunshinLearn, function LearnAct)
    endfunction

endscope