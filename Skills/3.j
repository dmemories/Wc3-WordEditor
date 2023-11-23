scope Byakugan initializer Init

    globals
        private constant integer skId = 'A009'
    endglobals

    private function Act takes nothing returns nothing
        local unit self = GetTriggerUnit()
        local integer unholySkId = 'A004'
        local integer unholyBuffId = 'B003'
        local real delay = 0.06
        local real casterX = GetUnitX(self)
        local real casterY = GetUnitY(self)

        call SoundPatch_Spell(udg_soundPatch_Naruto + "\\Naruto\\Byakugan.wav", casterX, casterY)
        call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Items\\AItb\\AItbTarget.mdl", self, "origin"))
        set bj_lastCreatedUnit = CreateUnit(GetOwningPlayer(self), 'u003', casterX, casterY, bj_UNIT_FACING)
        call UnitAddAbility(bj_lastCreatedUnit, unholySkId)
        call SetUnitAbilityLevel(bj_lastCreatedUnit, unholySkId, 2)
        call IssueTargetOrder(bj_lastCreatedUnit, "unholyfrenzy", self)
        call UnitApplyTimedLife(bj_lastCreatedUnit, DEFAULT_TIMELIFE_BUFF, 1.00)

        loop
            call TriggerSleepAction(delay)
            exitwhen(GetUnitAbilityLevel(self, Neji_ByakuganBuff) == 0)
        endloop

        if (GetUnitAbilityLevel(self, unholyBuffId) > 0) then
            call UnitRemoveAbility(self, unholyBuffId)
        endif
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