    scope LavaRasenshuriken initializer Init

        globals
            private constant integer skId = 'A008'
            private unit self
            private unit shuriken
            private real shurikenSize
            private real shurikenSizeRate
            private real shurikenSizeDelay
            private real shurikenSpeed
            private real garea
            private real spellX
            private real spellY
            private real reachRange
            private boolean finishCasting
            private integer n
            private integer sizeMaxLoop

            private unit array dummies
            private real dmg
            private integer skSlow
            private integer maxDummy = 0
        endglobals

        private function InitSkill takes nothing returns nothing
            local real castingTime = 2.00
            local real diffSize = 2.00

            set shuriken = null
            set garea = 600.00
            set shurikenSizeDelay = 0.05
            set sizeMaxLoop = R2I(castingTime / shurikenSizeDelay)
            set shurikenSizeRate = diffSize / I2R(sizeMaxLoop)
            set shurikenSpeed = 97.00
            set reachRange = shurikenSpeed + 10.00
            set maxDummy = 3
            set skSlow = 'A009'
        endfunction

        private function ClearShuriken takes nothing returns nothing
            if (shuriken != null) then
                call RemoveUnit(shuriken)
                set shuriken = null
            endif
        endfunction

        private function DmgL takes nothing returns nothing
            local timer t = GetExpiredTimer()
            local group g
            local unit picked
            local boolean modSlow

            if (n > 0) then
                set n = n - 1
                set modSlow = ModuloInteger(n, 8) == 0
                set g = CreateGroupXY(spellX, spellY, garea, Naruto_Player)
                loop
                    set picked = FirstOfGroup(g)
                    exitwhen (picked == null)
                    call GroupRemoveUnit(g, picked)
                    call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Other\\Stampede\\StampedeMissileDeath.mdl", picked, "origin"))
                    call UnitDamageTarget(self, picked, dmg, true, false, ATTACK_TYPE_HERO, DAMAGE_TYPE_NORMAL, WEAPON_TYPE_WHOKNOWS)
                    if (GetUnitState(picked, UNIT_STATE_LIFE) > 0) then
                        if (modSlow) then
                            set bj_lastCreatedUnit = CreateUnit(Naruto_Player, 'u003', spellX, spellY, bj_UNIT_FACING)
                            call UnitAddAbility(bj_lastCreatedUnit, skSlow)
                            call IssueTargetOrder(bj_lastCreatedUnit, "slow", picked)
                            call UnitApplyTimedLife(bj_lastCreatedUnit, 1112820806, 1.00)
                        endif
                    else
                        set bj_lastCreatedUnit = CreateUnit(Naruto_Player, 'h003', GetUnitX(picked), GetUnitY(picked), GetRandomReal(0, 360))
                        call UnitApplyTimedLife(bj_lastCreatedUnit, 1112820806, 2.00)
                    endif
                endloop
                call DestroyGroup(g)
                set g = null
                set bj_lastCreatedUnit = CreateUnit(Naruto_Player, 'h01B', spellX, spellY, GetRandomReal(0, 360))
                call SetUnitVertexColor(bj_lastCreatedUnit, 255, 50, 0, 255)
                call UnitApplyTimedLife(bj_lastCreatedUnit, 1112820806, 2.00)
            else
                call PauseTimer(t)
                call DestroyTimer(t)
                set self = null
                set finishCasting = false

                set n = maxDummy
                loop
                    exitwhen (n < 1)
                    set n = n - 1
                    call RemoveUnit(dummies[n])
                    set dummies[n] = null
                endloop
                set bj_lastCreatedUnit = CreateUnit(Naruto_Player, 'h007', spellX, spellY, GetRandomReal(0, 360))
                call SetUnitScale(bj_lastCreatedUnit, 3.00, 3.00, 3.00)
                call UnitApplyTimedLife(bj_lastCreatedUnit, 1112820806, 8.00)
            endif
            set t = null
        endfunction

        private function ActL takes nothing returns nothing
            local timer t = GetExpiredTimer()
            local real x = GetUnitX(shuriken)
            local real y = GetUnitY(shuriken)
            local boolean isMoving = reachRange < DistanceBetweenXY(x, y, spellX, spellY)
            local real facing

            if (n > 0) and (isMoving) then
                set n = n - 1
                set facing = GetUnitFacing(shuriken)
                set x = PolarX(x, shurikenSpeed, facing)
                set y = PolarY(y, shurikenSpeed, facing)
                call DestroyTreeXY(x, y, 190.00)
                call UnitMoveXY2(shuriken, x, y)
                if (ModuloInteger(n, 4) == 0) then
                    set bj_lastCreatedUnit = CreateUnit(Naruto_Player, 'h019', x, y, facing)
                    call SetUnitFly(bj_lastCreatedUnit)
                    call SetUnitFlyHeight(bj_lastCreatedUnit, 250.00, 0.00)
                    call UnitApplyTimedLife(bj_lastCreatedUnit, 1112820806, 1.60)
                endif
            else
                call PauseTimer(t)
                call DestroyTimer(t)
                call ClearShuriken()

                if (isMoving == false) then
                    set spellX = x
                    set spellY = y
                    set n = maxDummy
                    loop
                        exitwhen (n < 1)
                        set n = n - 1
                        set dummies[n] = CreateUnit(Naruto_Player, 'h01M', x, y, GetRandomReal(0, 360))
                        call SetUnitTimeScale(dummies[n], GetRandomReal(1.5,  2.8))
                    endloop

                    call DestroyTreeXY(x, y, garea)
                    set n = 70
                    call TimerStart(CreateTimer(), 0.08, true, function DmgL)
                else
                    set self = null
                endif
            endif
            set t = null
        endfunction

        private function Act takes nothing returns nothing
            set self = GetTriggerUnit()
            set finishCasting = true
            set dmg = 50
            call SoundPatch_Spell(udg_soundPatch_Naruto + "\\Naruto\\BaryonChakra.wav", GetUnitX(self), GetUnitY(self))
            set n = 40
            call TimerStart(CreateTimer(), 0.04, true, function ActL)
        endfunction

        private function CastEndAct takes nothing returns nothing
            call SetUnitTimeScale(GetSpellAbilityUnit(), 1.00)
            if (finishCasting == false) then
                call ClearShuriken()
                set n = 0
            endif
        endfunction

        private function SizeL takes nothing returns nothing
            local timer t = GetExpiredTimer()

            if (n > 100) then
                set n = n - 1
                set shurikenSize = shurikenSize + shurikenSizeRate
                call SetUnitScale(shuriken, shurikenSize, shurikenSize, shurikenSize)
            else
                call PauseTimer(t)
                call DestroyTimer(t)
            endif
            set t = null
        endfunction

        private function CastAct takes nothing returns nothing
            local unit caster = GetSpellAbilityUnit()
            local real x
            local real y

            set spellX = GetSpellTargetX()
            set spellY = GetSpellTargetY()
            if (maxDummy == 0) then
                call InitSkill()
            endif
            call SetUnitTimeScale(caster, 1.50)
            call SetUnitAnimationAfter(caster, "spell four", 0.00)

            call ClearShuriken()
            set x = GetUnitX(caster)
            set y = GetUnitY(caster)
            set shuriken = CreateUnit(Naruto_Player, 'h01L', x, y, AngleBetweenXY(x, y, spellX, spellY))
            call SetUnitFly(shuriken)
            call SetUnitFlyHeight(shuriken, 250.00, 0.00)
            set shurikenSize = 0.50
            call SetUnitScale(shuriken, shurikenSize, shurikenSize, shurikenSize)
            call SetUnitTimeScale(shuriken, 8.9)

            set bj_lastCreatedUnit = CreateUnit(Naruto_Player, 'h01B', x, y, GetRandomReal(0, 360))
            call SetUnitFly(bj_lastCreatedUnit)
            call SetUnitFlyHeight(bj_lastCreatedUnit, 280.00, 0.00)
            call UnitApplyTimedLife(bj_lastCreatedUnit, 1112820806, 1.50)
            call SetUnitScale(bj_lastCreatedUnit, 1.00, 1.00, 1.00)
            call SetUnitVertexColor(bj_lastCreatedUnit, 255, 50, 0, 255)

            set finishCasting = false
            set n = 100 + sizeMaxLoop
            call TimerStart(CreateTimer(), shurikenSizeDelay, true, function SizeL)
            set caster = null
        endfunction

        private function Cond takes nothing returns boolean
            return (GetSpellAbilityId() == skId)
        endfunction

    // =======================================================================================
        private function Init takes nothing returns nothing
            set gg_trg_Lava_Rasenshuriken = CreateTrigger()
            call TriggerAddCondition(gg_trg_Lava_Rasenshuriken, Condition(function Cond))
            call TriggerAddAction(gg_trg_Lava_Rasenshuriken, function Act)

            set Naruto_RasenshurikenCast = CreateTrigger()
            call TriggerAddCondition(Naruto_RasenshurikenCast, Condition(function Cond))
            call TriggerAddAction(Naruto_RasenshurikenCast, function CastAct)

            set Naruto_RasenshurikenCastEnd = CreateTrigger()
            call TriggerAddCondition(Naruto_RasenshurikenCastEnd, Condition(function Cond))
            call TriggerAddAction(Naruto_RasenshurikenCastEnd, function CastEndAct)
        endfunction

    endscope