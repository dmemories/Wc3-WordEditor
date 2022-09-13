scope KageBunshin initializer Init

    globals
        private constant integer skId = 'A000'
        private trigger atkedTrg
        private unit atker
        private unit atked
        private unit caster
        private integer countdown
        private integer cloneType
        private integer cloneDummyType
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
        private integer maxClones
        private real array imageDummyX
        private real array imageDummyY
        private real array imageDummyAngle
        private unit array imageDummies
        private real imageLastX
        private real imageLastY
        private integer imageDummyType
        private integer imageDummyIndex
        private integer imageLoop
        private integer msBonusSk
        private integer cloneSuccCount
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
            call UnitApplyTimedLife(CreateUnit(Naruto_Player, cloneDummyType, GetUnitX(atker), GetUnitY(atker), bj_UNIT_FACING), 1112820806, 1.50)
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
            set cloneDummyType = 'h01K'
            set skDelay = 5.00
            set moveSpeed = 40
            set garea = 120
            set dmg = 0
            set illusionSk = 'A001'
            set illusionLv = 1
            set stunSk = 'A002'
            set maxClones = 3
            set imageDummyType = 'h01I'
            set msBonusSk = 'Alms'

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

    private function MoveImageDummy takes real x, real y returns nothing
        if (imageDummyIndex > 0) then
            set imageDummyIndex = imageDummyIndex - 1
            call UnitMoveXY2(imageDummies[imageDummyIndex], x, y)
            call UnitApplyTimedLife(imageDummies[imageDummyIndex], 1112820806, 0.10)
            set imageDummies[imageDummyIndex] = null
        endif
    endfunction

    private function CreateXYDummy takes real x, real y, real facing returns nothing
        set imageDummyX[imageDummyIndex] = x
        set imageDummyY[imageDummyIndex] = y
        set imageDummyAngle[imageDummyIndex] = facing
    endfunction

    private function CreateShadowCloneAct takes nothing returns nothing
        local unit summonUnit = GetSummonedUnit()
        local real x
        local real y

        if (GetUnitAbilityLevel(summonUnit, Naruto_CloneBuff) > 0) then
            set x = GetUnitX(summonUnit)
            set y = GetUnitY(summonUnit)
            call UnitApplyTimedLife(CreateUnit(Naruto_Player, cloneDummyType, x, y, GetUnitFacing(summonUnit)), 1112820806, 1.50)
            call SelectUnitAddForPlayer(summonUnit, Naruto_Player)
            call MoveImageDummy(x, y)
            set cloneSuccCount = cloneSuccCount + 1
        endif
        set summonUnit = null
    endfunction

    private function ActCheckBug takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local real x
        local real y
        local integer i
        local location walkableLoc
        local group g
        local unit picked

        call PauseTimer(t)
        call DestroyTimer(t)
        set t = null

        set x = GetUnitX(caster)
        set y = GetUnitY(caster)
        if (cloneSuccCount == 0) then
            set walkableLoc = GetWalkableLoc(x, y, 850.00, 140.00)
            if (walkableLoc != null) then
                set x = GetLocationX(walkableLoc)
                set y = GetLocationY(walkableLoc)
                call RemoveLocation(walkableLoc)
                set walkableLoc = null
                call UnitMoveXY(caster, x, y)

                set i = maxClones
                loop
                    exitwhen (i < 1)
                    set i = i - 1
                    call CreateShadowClone(caster)
                endloop
            else
                set g = CreateGroup()
                call GroupEnumUnitsOfPlayer(g, GetOwningPlayer(caster), null)
                loop
                    set picked = FirstOfGroup(g)
                    exitwhen (picked == null)
                    call GroupRemoveUnit(g, picked)
                    if (GetUnitTypeId(picked) == imageDummyType) then
                        call RemoveUnit(picked)
                    endif
                endloop
                call DestroyGroup(g)
                set g = null
            endif
        endif
        call MoveImageDummy(x, y)
        call UnitApplyTimedLife(CreateUnit(Naruto_Player, cloneDummyType, x, y, GetUnitFacing(caster)), 1112820806, 1.50)
        set caster = null
    endfunction

    private function ActEnd takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local real x
        local real y
        local integer i

        call PauseTimer(t)
        call DestroyTimer(t)
        set t = null

        set x = GetUnitX(caster)
        set y = GetUnitY(caster)
        if (IsTerrainPathable(x, y, PATHING_TYPE_WALKABILITY)) then
            set x = imageLastX
            set y = imageLastY
            call UnitMoveXY(caster, x, y)
        endif
        call DestroyTreeXY(x, y, 300.00)
        call ShowUnitShow(caster)
        call UnitRemoveAbility(caster, msBonusSk)
        call SetUnitPathing(caster, true)
        call SetEnabledAttack(caster, true)
        call SetUnitInvulnerable(caster, false)
        call SelectUnitAddForPlayer(caster, Naruto_Player)

        set i = maxClones
        loop
            exitwhen (i < 1)
            set i = i - 1
            call CreateShadowClone(caster)
        endloop
        call SoundPatch_Spell(udg_soundPatch_Naruto + "\\Naruto\\KageBunshinEff.wav", x, y)
        call TimerStart(CreateTimer(), 0.02, false, function ActCheckBug)
    endfunction

    private function ActCreateImageL takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local integer i
        local real x
        local real y

        if (imageLoop > 0) then
            set imageLoop = imageLoop - 1
            set x = GetUnitX(caster)
            set y = GetUnitY(caster)
            if (IsTerrainPathable(x, y, PATHING_TYPE_WALKABILITY) == false) then
                set imageLastX = x
                set imageLastY = y
            endif
        else
            call PauseTimer(t)
            call DestroyTimer(t)
            set i = maxClones + 1
            loop
                exitwhen (i < 1)
                set i = i - 1
                set imageDummies[i] = CreateUnit(Naruto_Player, imageDummyType, imageDummyX[i], imageDummyY[i], imageDummyAngle[i])
                call SetUnitFly(imageDummies[i])
                call SetUnitFlyHeight(imageDummies[i], 100.00, 0.00)
            endloop
            call TimerStart(CreateTimer(), 0.10, false, function ActEnd)
        endif
        set t = null
    endfunction

    private function ClearOldShadowClone takes nothing returns nothing
        local unit picked
        local real x
        local real y
        local real facing
        local group g = CreateGroup()

        set imageDummyIndex = 0
        call GroupEnumUnitsOfPlayer(g, Naruto_Player, null)
        loop
            set picked = FirstOfGroup(g)
            exitwhen (picked == null)
            call GroupRemoveUnit(g, picked)
            if (GetUnitAbilityLevel(picked, Naruto_CloneBuff) > 0) then
                set x = GetUnitX(picked)
                set y = GetUnitY(picked)
                set facing = GetUnitFacing(picked)
                call UnitApplyTimedLife(CreateUnit(Naruto_Player, 'h013', x, y, facing), 1112820806, 1.00)
                call RemoveUnit(picked)
                call CreateXYDummy(x, y, facing)
                set imageDummyIndex = imageDummyIndex + 1
            endif
        endloop
        call DestroyGroup(g)
        set g = null

        if (imageDummyIndex <= maxClones) then
            set facing = GetUnitFacing(caster)
            set x = GetUnitX(caster)
            set y = GetUnitY(caster)
            loop
                call CreateXYDummy(x, y, facing)
                set imageDummyIndex = imageDummyIndex + 1
                exitwhen (maxClones < imageDummyIndex)
            endloop
        endif
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
        call SetUnitPathing(caster, false)
        call UnitAddAbility(caster, msBonusSk)
        call ShowUnitHide(caster)
        set imageLoop = 9
        set imageLastX = GetUnitX(caster)
        set imageLastY = GetUnitY(caster)
        call TimerStart(CreateTimer(), 0.10, true, function ActCreateImageL)

        set cloneSuccCount = 0
        call TriggerAddAction(summonTrg, function CreateShadowCloneAct)
        call TriggerRegisterPlayerUnitEvent(summonTrg, Naruto_Player, EVENT_PLAYER_UNIT_SUMMON, null)
        call TriggerSleepAction(1.20)
        call TriggerClearActions(summonTrg)
        call DestroyTrigger(summonTrg)
        set summonTrg = null
    endfunction

    private function LevelUpAct takes nothing returns nothing
        local unit self = GetTriggerUnit()
        local integer currLevel = GetHeroLevel(self)
        local group g = CreateGroup()
        local unit picked

        call GroupEnumUnitsOfPlayer(g, GetOwningPlayer(self), null)
        loop
            set picked = FirstOfGroup(g)
            exitwhen (picked == null)
            call GroupRemoveUnit(g, picked)
            if (GetUnitAbilityLevel(picked, Naruto_CloneBuff) > 0) then
                call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Other\\Levelup\\LevelupCaster.mdl", picked, "origin"))
            endif
        endloop
        call DestroyGroup(g)
        set g = null
        set self = null
    endfunction

// =======================================================================================
    private function Init takes nothing returns nothing
        set gg_trg_Kage_Bunshin = CreateTrigger()
        call TriggerAddCondition(gg_trg_Kage_Bunshin, Condition(function Cond))
        call TriggerAddAction(gg_trg_Kage_Bunshin, function Act)

        set Naruto_KagebunshinLearn = CreateTrigger()
        call TriggerAddCondition(Naruto_KagebunshinLearn, Condition(function LearnCond))
        call TriggerAddAction(Naruto_KagebunshinLearn, function LearnAct)

        set Naruto_KagebunshinLvlUp = CreateTrigger()
        call TriggerAddAction(Naruto_KagebunshinLvlUp, function LevelUpAct)
    endfunction

endscope