scope HakkeshoKaiten initializer Init

    globals
        private constant integer skId = 'A000'
        private unit caster
        private real casterX
        private real casterY
        private real garea
        private real dmg
        private integer n
        private integer endCastN
        private integer spellBookSk
        private group gPush
        private player p
        private string dmgEffStr
        private string dmgEffPoint

        private hashtable hash = null
        private group gpush
        private integer maxPush
        private integer pushNIndex
        private integer facingIndex
        private integer pushSpeedIndex
        private integer speedDecIndex

        private real pushSpeed

    endglobals

    private function InitSkill takes nothing returns nothing
        call Echo("Initial")
        set garea = 270.00
        set endCastN = 40
        set dmgEffStr = "ThunderClapNoGroundEff.mdx"
        set dmgEffPoint = "origin"
        set spellBookSk = 'A008'
        call SetAbilityAvailable(spellBookSk, false)

        set hash = InitHashtable()
        set maxPush = 19
        set pushNIndex = 1
        set facingIndex = 2
        set pushSpeedIndex = 3
        set speedDecIndex = 4
        set pushSpeed = 16.00
    endfunction

    private function SpawnDummy takes unit caster, player p, real x, real y returns nothing
        local integer casterType = GetUnitTypeId(caster)

        set bj_lastCreatedUnit = CreateDummy(NEUTRAL_AGGRESSIVE_PLAYER, casterType, x, y, GetUnitFacing(caster), 255)
        call SetUnitAnimation(bj_lastCreatedUnit, "spell")
        call SetUnitTimeScale(bj_lastCreatedUnit, 3.20)
        call UnitApplyTimedLife(bj_lastCreatedUnit, DEFAULT_TIMELIFE_BUFF, 0.86)
        set bj_lastCreatedUnit = CreateDummy(NEUTRAL_AGGRESSIVE_PLAYER, casterType, x, y, GetRandomReal(0, 360), 255)
        call SetUnitAnimation(bj_lastCreatedUnit, "spell")
        call SetUnitTimeScale(bj_lastCreatedUnit, 3.20)
        call UnitApplyTimedLife(bj_lastCreatedUnit, DEFAULT_TIMELIFE_BUFF, 0.86)

        set bj_lastCreatedUnit = CreateUnit(p, 'h01Q', x, y, GetRandomReal(0, 360))
        call UnitApplyTimedLife(bj_lastCreatedUnit, DEFAULT_TIMELIFE_BUFF, 1.20)
        call SetUnitScale(bj_lastCreatedUnit, 2.70, 2.70, 2.70)

        set bj_lastCreatedUnit = CreateUnit(p, 'h01P', x, y, GetRandomReal(0, 360))
        call UnitApplyTimedLife(bj_lastCreatedUnit, DEFAULT_TIMELIFE_BUFF, 1.00)
        call SetUnitAnimation(bj_lastCreatedUnit, "death")
        call SetUnitTimeScale(bj_lastCreatedUnit, 2.50)
        call SetUnitFly(bj_lastCreatedUnit)
        call SetUnitFlyHeight(bj_lastCreatedUnit, 120.00, 0.00)
        call SetUnitVertexColor(bj_lastCreatedUnit, 100, 100, 100, 100)

        set bj_lastCreatedUnit = CreateUnit(p, 'h01O', x, y, GetRandomReal(0, 360))
        call UnitApplyTimedLife(bj_lastCreatedUnit, DEFAULT_TIMELIFE_BUFF, 1.20)
        call UnitAddAbility(bj_lastCreatedUnit, 'A005')
        call IssueImmediateOrder(bj_lastCreatedUnit, "stomp")
    endfunction

    private function ActMove takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local unit picked
        local group g
        local real speed
        local real facing
        local real x
        local real y
        local integer countPicked
        local integer pushN
        local integer uId

        if (n > 0) then
            set n = n - 1

            set countPicked = 0
            set g = CreateGroup()
            call GroupAddGroup(gPush, g)
            loop
                set picked = FirstOfGroup(g)
                exitwhen (picked == null)
                call GroupRemoveUnit(g, picked)
                set countPicked = countPicked + 1

                set uId = GetHandleId(picked)
                set pushN = LoadInteger(hash, uId, pushNIndex) - 1
                set facing = LoadReal(hash, uId, facingIndex)
                set speed = LoadReal(hash, uId, pushSpeedIndex)
                set speed = (speed - ((maxPush - pushN) * LoadReal(hash, uId, speedDecIndex)))
                if (pushN > 0) then
                    call SaveInteger(hash, uId, pushNIndex, pushN)
                else
                    call FlushChildHashtable(hash, uId)
                    call GroupRemoveUnit(gPush, picked)
                endif

                set x = GetUnitX(picked)
                set y = GetUnitY(picked)
                set x = PolarX(x, speed, facing)
                set y = PolarY(y, speed, facing)
                call DestroyTreeXY(x, y, UNIT_MOVE_AREA)
                call UnitApplyTimedLife(CreateUnit(p, 'h017', x, y, facing), 1112820806, 0.70)
                call UnitMoveXY(picked, x, y)
            endloop
            call DestroyGroup(g)
            set g = null

            if (n > 1) and (n <= endCastN) and (countPicked < 1) then
                set n = 1
            endif
        else
            call PauseTimer(t)
            call DestroyTimer(t)

            call DestroyGroup(gPush)
            set gPush = null
            set p = null
            call Echo("Clear ActMove")
        endif
        set t = null
    endfunction

    private function ActL takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local unit picked
        local group g
        local real x
        local real y
        local real maxSpeed
        local real minSpeed
        local integer uId

        if (n > endCastN) then
            set g = CreateGroupXY2(casterX, casterY, garea, p, gPush)
            loop
                set picked = FirstOfGroup(g)
                exitwhen (picked == null)
                call GroupRemoveUnit(g, picked)
                call DestroyEffect(AddSpecialEffectTarget(dmgEffStr, picked, dmgEffPoint))
                call UnitDamageTarget(caster, picked, dmg, true, false, ATTACK_TYPE_HERO, DAMAGE_TYPE_NORMAL, WEAPON_TYPE_WHOKNOWS)

                if (GetUnitState(picked, UNIT_STATE_LIFE) > 0) then
                    set maxSpeed = pushSpeed
                else
                    set maxSpeed = pushSpeed * GetRandomReal(2.00, 2.70)
                endif
                set minSpeed = maxSpeed * 0.16
                set uId = GetHandleId(picked)
                call SaveInteger(hash, uId, pushNIndex, maxPush)
                call SaveReal(hash, uId, facingIndex, AngleBetweenXY(casterX, casterY, GetUnitX(picked), GetUnitY(picked)))
                call SaveReal(hash, uId, pushSpeedIndex, maxSpeed)
                call SaveReal(hash, uId, speedDecIndex, ((maxSpeed - minSpeed) / maxPush))
                call GroupAddUnit(gPush, picked)
            endloop
            call DestroyGroup(g)
            set g = null
        else
            call PauseTimer(t)
            call DestroyTimer(t)

            call UnitRemoveAbility(caster, spellBookSk)
            set caster = null
            call Echo("Clear ActL")
        endif
        set t = null
    endfunction

    private function Act takes nothing returns nothing
        set caster = GetTriggerUnit()
        call ResetUncastManaShield(caster, skId)

        if (hash == null) then
            call InitSkill()
        endif

        call UnitAddAbility(caster, spellBookSk)
        set casterX = GetUnitX(caster)
        set casterY = GetUnitY(caster)
        set p = GetOwningPlayer(caster)
        set gPush = CreateGroup()
        set dmg = 300.00 + ((3.00 + I2R(GetUnitAbilityLevel(caster, skId))) * I2R(GetHeroAgi(caster, true)))
        set n = 60
        call DisplayFloatTextAtUnit("Hakkesho Kaiten", caster)

        call DestroyTreeXY(casterX, casterY, garea)
        call SpawnDummy(caster, p, casterX, casterY)
        call TimerStart(CreateTimer(), 0.06, true, function ActL)
        call TimerStart(CreateTimer(), 0.04, true, function ActMove)
    endfunction

    private function Cond takes nothing returns boolean
        return (GetSpellAbilityId() == skId)
    endfunction

// =======================================================================================
    private function Init takes nothing returns nothing
        set gg_trg_Hakkesho_Kaiten = CreateTrigger()
        call TriggerAddCondition(gg_trg_Hakkesho_Kaiten, Condition(function Cond))
        call TriggerAddAction(gg_trg_Hakkesho_Kaiten, function Act)
    endfunction

endscope