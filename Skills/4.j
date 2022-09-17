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
            private boolean isRunning
            private integer n
            private integer sizeMaxLoop = 0
        endglobals

        private function InitSkill takes nothing returns nothing
            local real castingTime = 2.00
            local real diffSize = 2.00

            call Log("Initial")
            set shuriken = null
            set garea = 600.00
            set shurikenSizeDelay = 0.05
            set sizeMaxLoop = R2I(castingTime / shurikenSizeDelay)
            set shurikenSizeRate = diffSize / I2R(sizeMaxLoop)
            set shurikenSpeed = 90.00
            set reachRange = shurikenSpeed + 10.00
        endfunction

        private function ClearShuriken takes nothing returns nothing
            if (shuriken != null) then
                call RemoveUnit(shuriken)
                set shuriken = null
            endif
        endfunction

        private function ActL takes nothing returns nothing
            local timer t = GetExpiredTimer()
            local boolean isMoving = n > 0
            local real x
            local real y
            local real facing

            if (isMoving) then
                set n = n - 1
                set x = GetUnitX(shuriken)
                set y = GetUnitY(shuriken)
            endif
            call Log(R2S(DistanceBetweenXY(x, y, spellX, spellY)))
            if (isMoving) and (reachRange < DistanceBetweenXY(x, y, spellX, spellY)) then
                set facing = GetUnitFacing(shuriken)
                set x = PolarX(x, shurikenSpeed, facing)
                set y = PolarY(y, shurikenSpeed, facing)
                call DestroyTreeXY(x, y, 190.00)
                call UnitMoveXY2(shuriken, x, y)
            else
                call PauseTimer(t)
                call DestroyTimer(t)
                call ClearShuriken()
                set self = null
                set isRunning = false
                set n = 0
            endif
            set t = null
        endfunction

        private function Act takes nothing returns nothing
            set self = GetTriggerUnit()
            set isRunning = true
            call SoundPatch_Spell(udg_soundPatch_Naruto + "\\Naruto\\BaryonChakra.wav", GetUnitX(self), GetUnitY(self))
            set n = 40
            call TimerStart(CreateTimer(), 0.04, true, function ActL)
        endfunction

        private function CastEndAct takes nothing returns nothing
            call SetUnitTimeScale(GetSpellAbilityUnit(), 1.00)
            if (isRunning == false) then
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
                call Log(R2S(shurikenSize))
            else
                call PauseTimer(t)
                call DestroyTimer(t)
                call Log("end")
            endif
            set t = null
        endfunction

        private function CastAct takes nothing returns nothing
            local unit caster = GetSpellAbilityUnit()
            local real x
            local real y

            set spellX = GetSpellTargetX()
            set spellY = GetSpellTargetY()
            if (sizeMaxLoop == 0) then
                call InitSkill()
            endif
            call TriggerSleepAction(0.00)
            call SetUnitTimeScale(caster, 1.50)
            call SetUnitAnimation(caster, "spell four")

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
            call SetUnitFlyHeight(bj_lastCreatedUnit, 250.00, 0.00)
            call UnitApplyTimedLife(bj_lastCreatedUnit, 1112820806, 1.50)
            call SetUnitScale(bj_lastCreatedUnit, 1.00, 1.00, 1.00)

            set isRunning = false
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