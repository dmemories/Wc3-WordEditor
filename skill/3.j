scope Byakugan initializer Init

    globals
        private constant integer skId = 'A009'
        private unit self
        private integer hyugaClanSkId = 'A003'
    endglobals

    private function DelayAct takes nothing returns nothing
        local timer t = GetExpiredTimer()
        call PauseTimer(t)
        call DestroyTimer(t)
        set t = null
        call SetAbilityAvailable(hyugaClanSkId, false)
    endfunction

    private function Act takes nothing returns nothing
        local integer unholySkId = 'A004'
        local integer hyugaClanBuffId = 'B003'
        local integer trueSightBookId = 'A00C'
        local real delay = 0.06
        local real casterX
        local real casterY

        set self = GetTriggerUnit()
        set casterX = GetUnitX(self)
        set casterY = GetUnitY(self)
        call SoundPatch_Spell(udg_soundPatch_Naruto + "\\Naruto\\Byakugan.wav", casterX, casterY)
        call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Items\\AItb\\AItbTarget.mdl", self, "origin"))
        set bj_lastCreatedUnit = CreateUnit(GetOwningPlayer(self), 'u003', casterX, casterY, bj_UNIT_FACING)

        call UnitRemoveAbility(self, hyugaClanSkId)
        call UnitRemoveAbility(self, hyugaClanBuffId)
        call UnitAddAbility(self, hyugaClanSkId)
        call SetUnitAbilityLevel(self, hyugaClanSkId, GetUnitAbilityLevel(self, skId) + 1)
        call TimerStart(CreateTimer(), 0.01, false, function DelayAct)
        call IssueImmediateOrder(self, "berserk")
        call SetAbilityAvailable(trueSightBookId, false)
        call UnitAddAbility(self, trueSightBookId)
        loop
            call TriggerSleepAction(delay)
            exitwhen(GetUnitAbilityLevel(self, Neji_ByakuganBuff) == 0)
        endloop
        call UnitRemoveAbility(self, trueSightBookId)
        call SetAbilityAvailable(hyugaClanSkId, true)
        call SetAbilityAvailable(trueSightBookId, true)
        call SetUnitAbilityLevel(self, hyugaClanSkId, 1)

        set self = null
    endfunction

    private function Cond takes nothing returns boolean
        return (GetSpellAbilityId() == skId)
    endfunction

// =======================================================================================
    private function Init takes nothing returns nothing
        set gg_trg_Byakugan = CreateTrigger()
        call TriggerAddCondition(gg_trg_Byakugan, Condition(function Cond))
        call TriggerAddAction(gg_trg_Byakugan, function Act)
    endfunction

endscope