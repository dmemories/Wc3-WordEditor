scope JitonRasengan initializer Init

    globals
        private constant integer skId = 'A003'
        private unit array caster
        private real array speed
        private boolean array isMoving
        private effect array rasenganEff
        private integer casterIndex
        private integer i

        private unit target
        private real cloneArea
        private real trgLoopDelay
        private real dmg
        private integer loopPerX
        private integer stunSk

        private hashtable hash
        private real pushFacing
        private real pushSpeed
        private integer pushMaxLoop
        private integer reachedCount
        private integer cancelCount
        private integer loopHashIndex
        private integer speedHashIndex
        private integer casterHashIndex = -1

        private integer pushDeathLoop
        private real rasenDummySize
        private unit rasenDummy
        private unit clapDummy
        private real garea
    endglobals

    private function InitSkill takes nothing returns nothing
        set cloneArea = 1300
        set trgLoopDelay = 0.04
        set loopPerX = R2I(0.6 / trgLoopDelay)
        set stunSk = 'A002'
        set hash = InitHashtable()
        set pushSpeed = 4
        set pushMaxLoop = 20
        set loopHashIndex = 0
        set speedHashIndex = 1
        set casterHashIndex = 2
        set garea = 300.00
    endfunction

    private function ClearIndex takes integer index returns nothing
        set isMoving[index] = false
        set speed[index] = 0.00
        call DestroyEffect(rasenganEff[index])
        set rasenganEff[index] = null
        call PauseSystem(caster[index], false)
        call SetUnitTimeScale(caster[index], 1.00)
        if (GetUnitState(caster[index], UNIT_STATE_LIFE) > 0) and (GetUnitState(target, UNIT_STATE_LIFE) > 0) then
            call IssueTargetOrder(caster[index], "attack", target)
        endif
        set caster[index] = null
    endfunction

    private function ClearIndexResource takes nothing returns nothing
        local integer j = casterIndex
        loop
            exitwhen (j == 0)
            set j = j - 1
            if (isMoving[j]) then
                call ClearIndex(j)
            endif
        endloop
    endfunction

    private function AddCasterData takes unit self returns nothing
        local real array x
        local real array y
        local real distan

        set x[0] = GetUnitX(self)
        set y[0] = GetUnitY(self)
        set x[1] = GetUnitX(target)
        set y[1] = GetUnitY(target)
        set distan = DistanceBetweenXY(x[1], y[1], x[0], y[0])
        if (distan < cloneArea) then
            set caster[casterIndex] = self
            set isMoving[casterIndex] = true
            if (GetUnitState(caster[casterIndex], UNIT_STATE_LIFE) > 0) then
                set speed[casterIndex] = (distan / I2R(loopPerX)) * 2
                set rasenganEff[casterIndex] = AddSpecialEffectTarget("war3mapImported\\JitonRasengan.mdx", caster[casterIndex], "hand right")
                call PauseSystem(caster[casterIndex], true)
                call SetUnitTimeScale(caster[casterIndex], 1.40)
                call SetUnitAnimation(caster[casterIndex], "spell two")
                call SetUnitFacing(caster[casterIndex], AngleBetweenXY(x[0], y[0], x[1], y[1]))
                call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Human\\Invisibility\\InvisibilityTarget.mdl", caster[casterIndex], "hand right"))
            endif
            set casterIndex = casterIndex + 1
        endif
    endfunction

    private function PushDeathL takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local real speed
        local real array x
        local real array y

        set x[0] = GetUnitX(target)
        set y[0] = GetUnitY(target)
        if (pushDeathLoop > 0) then
            set pushDeathLoop = pushDeathLoop - 1
            set speed = 36.00
            set x[1] = PolarX(x[0], speed, pushFacing)
            set y[1] = PolarY(y[0], speed, pushFacing)
            call DestroyTreeXY(x[1], y[1], UNIT_MOVE_AREA)
            call UnitApplyTimedLife(CreateUnit(Naruto_Player, 'h017', x[0], y[0], pushFacing), 1112820806, 0.70)
            if (ModuloInteger(pushDeathLoop, 6) == 0) then
                call UnitApplyTimedLife(CreateUnit(Naruto_Player, 'h019', x[0], y[0], pushFacing), 1112820806, 1.60)
            endif
            call UnitMoveXY(target, x[1], y[1])
            call UnitMoveXY2(clapDummy, x[1], y[1])
            call UnitMoveXY2(rasenDummy, x[1], y[1])
        else
            call PauseTimer(t)
            call DestroyTimer(t)
            call RemoveUnit(clapDummy)
            set clapDummy = null
            set bj_lastCreatedUnit = CreateUnit(Naruto_Player, 'h00E', x[0], y[0], pushFacing)
            call SetUnitScale(bj_lastCreatedUnit, 1.80, 1.80, 1.80)
            call UnitApplyTimedLife(bj_lastCreatedUnit, 1112820806, 1.00)
            if (rasenDummy != null) then
                call RemoveUnit(rasenDummy)
                set rasenDummy = null
            endif
        endif
        set t = null
    endfunction

    private function PushL takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local integer tId = GetHandleId(t)
        local integer j = LoadInteger(hash, tId, loopHashIndex) - 1
        local real speed
        local real array x
        local real array y
        local boolean reachedAll = casterIndex == reachedCount
        local boolean waitRunDeathP = pushDeathLoop < 0

        if (j > 0) then
            set x[0] = GetUnitX(target)
            set y[0] = GetUnitY(target)
            set speed = LoadReal(hash, tId, speedHashIndex)
            set x[1] = PolarX(x[0], speed, pushFacing)
            set y[1] = PolarY(y[0], speed, pushFacing)
            if (rasenDummySize < 2.3) then
                set rasenDummySize = rasenDummySize + (0.10 / reachedCount)
                call SetUnitScale(rasenDummy, rasenDummySize, rasenDummySize, rasenDummySize)
            endif

            if (reachedCount < 3) or (ModuloInteger(j, 2) == 0) then
                call DestroyTreeXY(x[1], y[1], UNIT_MOVE_AREA)
                call UnitMoveXY(target, x[1], y[1])
                call UnitMoveXY2(rasenDummy, x[1], y[1])
                call UnitApplyTimedLife(CreateUnit(Naruto_Player, 'h017', x[0], y[0], pushFacing), 1112820806, 0.70)
                set bj_lastCreatedUnit = CreateUnit(Naruto_Player, 'h008', x[1], y[1], pushFacing + 180)
                call SetUnitVertexColor(bj_lastCreatedUnit, 0, 0, 0, 255)
                call UnitApplyTimedLife(bj_lastCreatedUnit, 1112820806, 0.70)
                call SetUnitTimeScale(bj_lastCreatedUnit, 1.40)
            endif

            if (GetUnitState(target, UNIT_STATE_LIFE) > 0) then
                call UnitDamageTarget(LoadUnitHandle(hash, tId, casterHashIndex), target, dmg, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS)
            endif

            if (waitRunDeathP) then
                if (GetUnitState(target, UNIT_STATE_LIFE) < 1) and (reachedAll) then
                    set pushDeathLoop = 24
                    set clapDummy = CreateUnit(Naruto_Player, 'h008', x[1], y[1], pushFacing - 180)
                    call SetUnitScale(clapDummy, 2.20, 2.20, 2.20)
                    call TimerStart(CreateTimer(), 0.03, true, function PushDeathL)
                endif
            else
                set j = 0
            endif
            call SaveInteger(hash, tId, loopHashIndex, j)
        else
            call PauseTimer(t)
            call DestroyTimer(t)
            call FlushChildHashtable(hash, tId)
            if (rasenDummy != null) and (reachedAll) and (waitRunDeathP) then
                call RemoveUnit(rasenDummy)
                set rasenDummy = null
            endif
        endif
        set t = null
    endfunction

    private function ActL takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local timer tPush
        local real array x
        local real array y
        local real facing
        local real distan
        local integer n
        local integer tPushId
        local unit picked
        local group g

        if (i > 0) and (casterIndex > (reachedCount + cancelCount)) then
            set i = i - 1
            set x[0] = GetUnitX(target)
            set y[0] = GetUnitY(target)
            set n = casterIndex
            loop
                exitwhen (n == 0)
                set n = n - 1
                if (isMoving[n]) then
                    if (GetUnitState(caster[n], UNIT_STATE_LIFE) > 0) then
                        set x[1] = GetUnitX(caster[n])
                        set y[1] = GetUnitY(caster[n])
                        set facing = AngleBetweenXY(x[1], y[1], x[0], y[0])
                        set x[2] = PolarX(x[1], speed[n], facing)
                        set y[2] = PolarY(y[1], speed[n], facing)
                        call DestroyTreeXY(x[2], y[2], UNIT_MOVE_AREA)
                        call UnitMoveXY(caster[n], x[2], y[2])
                        call SetUnitFacing(caster[n], facing)
                        set distan = DistanceBetweenXY(x[2], y[2], x[0], y[0])
                        if (distan < 150.00) then
                            if (pushFacing == 9999) then
                                call DisplayText("Senpo: Jiton Rasengan", caster[n], 0.023, true, 255, 255, 255, 255)
                                set rasenDummy = CreateUnit(Naruto_Player, 'h01A', x[0], y[0], facing)
                                call SetUnitFly(rasenDummy)
                                set rasenDummySize = 1.00
                                set pushFacing = facing
                                set bj_lastCreatedUnit = CreateUnit(Naruto_Player, 'u003', x[0], y[0], bj_UNIT_FACING)
                                call UnitAddAbility(bj_lastCreatedUnit, stunSk)
                                call IssueTargetOrder(bj_lastCreatedUnit, "thunderbolt", target)
                                call UnitApplyTimedLife(bj_lastCreatedUnit, 1112820806, 1.00)
                                set g = CreateGroupXY(x[0], y[0], garea, Naruto_Player)
                                loop
                                    set picked = FirstOfGroup(g)
                                    exitwhen (picked == null)
                                    call GroupRemoveUnit(g, picked)
                                    call UnitApplyTimedLife(CreateUnit(Naruto_Player, 'h00E', GetUnitX(picked), GetUnitY(picked), facing), 1112820806, 0.70)
                                    call UnitDamageTarget(caster[n], picked, dmg, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS)
                                endloop
                                call DestroyGroup(g)
                                set g = null
                                set dmg = dmg / 10
                            endif

                            set reachedCount = reachedCount + 1
                            if (reachedCount == 0) then
                                set reachedCount = 1
                            endif
                            set tPush = CreateTimer()
                            set tPushId = GetHandleId(tPush)
                            call SaveInteger(hash, tPushId, loopHashIndex, pushMaxLoop)
                            call SaveReal(hash, tPushId, speedHashIndex, (pushSpeed / reachedCount))
                            call SaveUnitHandle(hash, tPushId, casterHashIndex, caster[n])
                            call TimerStart(tPush, GetRandomReal(0.06, 0.10), true, function PushL)
                            set tPush = null
                            call ClearIndex(n)
                        endif
                    else
                        set cancelCount = cancelCount + 1
                        call ClearIndex(n)
                    endif
                endif
            endloop
        else
            call PauseTimer(t)
            call DestroyTimer(t)
            set reachedCount = casterIndex
            set cancelCount = 0
            call ClearIndexResource()
        endif
        set t = null
    endfunction

    private function ActRun takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local integer n = casterIndex

        call PauseTimer(t)
        call DestroyTimer(t)
        set t = null
        call SoundPatch_Spell(udg_soundPatch_Naruto + "\\Naruto\\Rasengan.wav", GetUnitX(caster[0]), GetUnitY(caster[0]))
        loop
            exitwhen (n < 0)
            call SetUnitAnimationByIndex(caster[n], 3)
            set n = n - 1
        endloop

        set reachedCount = 0
        set cancelCount = 0
        set pushDeathLoop = -1
        set pushFacing = 9999
        set rasenDummy = null
        call TimerStart(CreateTimer(), trgLoopDelay, true, function ActL)
    endfunction

    private function Act takes nothing returns nothing
        local unit self
        local unit picked
        local group g

        set self = GetTriggerUnit()
        set target = GetSpellTargetUnit()
        if (casterHashIndex < 0) then
            call InitSkill()
        endif
        call SoundPatch_Spell(udg_soundPatch_Naruto + "\\Naruto\\RasenganCharge.wav", GetUnitX(self), GetUnitY(self))
        set dmg = ((100.00 + (GetUnitAbilityLevel(self, skId) * 5.00)) + (GetHeroAgi(self, false) * 5.00))

        set casterIndex = 0
        call AddCasterData(self)
        set g = CreateGroup()
        call GroupEnumUnitsOfPlayer(g, Naruto_Player, null)
        loop
            set picked = FirstOfGroup(g)
            exitwhen (picked == null)
            call GroupRemoveUnit(g, picked)
            if (GetUnitAbilityLevel(picked, Naruto_CloneBuff) > 0) then
                call AddCasterData(picked)
            endif
        endloop
        call DestroyGroup(g)
        set g = null

        set i = R2I(loopPerX * 1.5)
        call TimerStart(CreateTimer(), 0.60, false, function ActRun)
        set self = null
    endfunction

    private function Cond takes nothing returns boolean
        return (GetSpellAbilityId() == skId)
    endfunction

// =======================================================================================
    private function Init takes nothing returns nothing
        set gg_trg_Jiton_Rasengan = CreateTrigger()
        call TriggerAddCondition(gg_trg_Jiton_Rasengan, Condition(function Cond))
        call TriggerAddAction(gg_trg_Jiton_Rasengan, function Act)
    endfunction

endscope