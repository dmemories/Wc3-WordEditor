scope HakkeHasangeki initializer Init

    globals
        private constant integer skId = 'A001'
        private unit self
        private unit dummyWave
        private real lastX
        private real lastY
        private real angle
        private real dmg
        private real speed
        private real garea
        private group gcheck
        private player p
        private integer n
    endglobals

    private function ActL takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local real x
        local real y
        local group g
        local unit picked

        if (n < 20) then
            set n = n + 1
            set lastX = PolarX(lastX, speed, angle)
            set lastY = PolarY(lastY, speed, angle)

            call DestroyTreeXY(lastX, lastY, garea)
            call UnitMoveXY2(dummyWave, lastX, lastY)
            set bj_lastCreatedUnit = CreateUnit(p, 'h003', lastX, lastY, angle)
            call UnitApplyTimedLife(bj_lastCreatedUnit, DEFAULT_TIMELIFE_BUFF, 0.90)
            call SetUnitVertexColor(bj_lastCreatedUnit, 0, 0, 0, 255)

            set g = CreateGroupXY2(lastX, lastY, garea, p, gcheck)
            loop
                set picked = FirstOfGroup(g)
                exitwhen (picked == null)
                call GroupRemoveUnit(g, picked)
                call GroupAddUnit(gcheck, picked)
                call UnitDamageTarget(self, picked, dmg, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS)
            endloop
            call DestroyGroup(g)
            set g = null
        else
            call PauseTimer(t)
            call DestroyTimer(t)
            call DestroyGroup(gcheck)
            set gcheck = null

            call UnitApplyTimedLife(dummyWave, DEFAULT_TIMELIFE_BUFF, 1.50)
            call SetUnitAnimation(dummyWave, "death")
            set dummyWave = null
            set self = null
            set p = null
        endif
        set t = null
    endfunction

    private function Act takes nothing returns nothing
        local real spellX = GetSpellTargetX()
        local real spellY = GetSpellTargetY()
        local real distan

        set self = GetTriggerUnit()
        set p = GetOwningPlayer(self)
        set lastX = GetUnitX(self)
        set lastY = GetUnitY(self)
        set angle = AngleBetweenXY(lastX, lastY, spellX, spellY)
        set dmg = BasicDmg_Q(self, skId, bj_HEROSTAT_AGI)
        call DisplayFloatTextAtUnit("Hakke Hasangeki", self)

        set distan = 80
        set dummyWave = CreateUnit(p, 'h00C', PolarX(lastX, distan, angle), PolarY(lastY, distan, angle), angle)

        set bj_lastCreatedUnit = CreateUnit(p, 'h019', lastX, lastY, angle)
        call UnitApplyTimedLife(bj_lastCreatedUnit, DEFAULT_TIMELIFE_BUFF, 2.00)
        call SetUnitFly(bj_lastCreatedUnit)
        call SetUnitFlyHeight(bj_lastCreatedUnit, 100.00, 0.00)
        call Dynamic_3D("Abilities\\Weapons\\FireBallMissile\\FireBallMissileDeath.wav", lastX, lastY)

        set gcheck = CreateGroup()
        set speed = 48.00
        set garea = 200.00
        set n = 0
        call TimerStart(CreateTimer(), 0.03, true, function ActL)
    endfunction

    private function Cond takes nothing returns boolean
        return (GetSpellAbilityId() == skId)
    endfunction

// =======================================================================================
    private function Init takes nothing returns nothing
        set gg_trg_Hakke_Hasangeki = CreateTrigger()
        call TriggerAddCondition(gg_trg_Hakke_Hasangeki, Condition(function Cond))
        call TriggerAddAction(gg_trg_Hakke_Hasangeki, function Act)
    endfunction

endscope