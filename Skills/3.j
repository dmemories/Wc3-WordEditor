scope BaryonChakra initializer Init

    globals
        private constant integer skId = 'A005'
        private unit self
        private real skillDur
        private real garea
        private real healRate
        private unit array buffUnits
        private integer buffIndex
        private integer speedSk
        private integer speedBuff = 0
    endglobals

    private function InitSkill takes nothing returns nothing
        set garea = 600.00
        set healRate = 0.06
        set speedSk = 'A007'
        set speedBuff = 'B003'
    endfunction

    private function IsUnitInArray takes unit u returns boolean
        local integer i = buffIndex
        loop
            exitwhen (i < 1)
            set i = i - 1
            if (buffUnits[i] == u) then
                return true
            endif
        endloop
        return false
    endfunction

    private function ActL takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local real x
        local real y
        local real hp
        local unit picked
        local group g
        local integer i

        if (GetUnitState(self, UNIT_STATE_LIFE) > 0) and (skillDur > 0) then
            set skillDur = skillDur - 1
            set x = GetUnitX(self)
            set y = GetUnitY(self)
            set g = CreateGroup()
            call GroupEnumUnitsInRange(g, x, y, garea, null)
            loop
                set picked = FirstOfGroup(g)
                exitwhen (picked == null)
                call GroupRemoveUnit(g, picked)
                if (GetUnitState(picked, UNIT_STATE_LIFE) > 0) and (IsUnitAlly(picked, Naruto_Player)) and (IsUnitType(picked, UNIT_TYPE_MECHANICAL) == false) and (GetUnitAbilityLevel(picked, speedBuff) < 1) then
                    if (IsUnitInArray(picked) == false) then
                        set buffUnits[buffIndex] = picked
                        set buffIndex = buffIndex + 1
                    endif
                    set bj_lastCreatedUnit = CreateUnit(Naruto_Player, 'u003', x, y, bj_UNIT_FACING)
                    call UnitAddAbility(bj_lastCreatedUnit, speedSk)
                    call IssueTargetOrder(bj_lastCreatedUnit, "bloodlust", picked)
                    call UnitApplyTimedLife(bj_lastCreatedUnit, 1112820806, 1.00)
                endif
            endloop
            call DestroyGroup(g)
            set g = null

            if (ModuloInteger(R2I(skillDur), 4) == 0) then
                set i = buffIndex
                loop
                    exitwhen (i < 1)
                    set i = i - 1
                    set hp = GetUnitState(buffUnits[i], UNIT_STATE_LIFE)
                    if (hp > 0) and (GetUnitAbilityLevel(buffUnits[i], speedBuff) > 0) and (IsUnitHidden(buffUnits[i]) == false) then
                        call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Human\\HolyBolt\\HolyBoltSpecialArt.mdl", buffUnits[i], "origin"))
                        call SetUnitState(buffUnits[i], UNIT_STATE_LIFE, hp + (GetUnitState(buffUnits[i], UNIT_STATE_MAX_LIFE) * healRate))
                    endif
                endloop
            endif
        else
            call PauseTimer(t)
            call DestroyTimer(t)
            set self = null

            loop
                exitwhen (buffIndex < 1)
                set buffIndex = buffIndex - 1
                if (GetUnitState(buffUnits[buffIndex], UNIT_STATE_LIFE) > 0) then
                    call UnitRemoveAbility(buffUnits[buffIndex], speedBuff)
                endif
            endloop
        endif
        set t = null
    endfunction

    private function Act takes nothing returns nothing
        set self = GetTriggerUnit()
        if (speedBuff == 0) then
            call InitSkill()
        endif

        call SoundPatch_Spell(udg_soundPatch_Naruto + "\\Naruto\\BaryonChakra.wav", GetUnitX(self), GetUnitY(self))
        set skillDur = (7 + GetUnitAbilityLevel(self, skId)) * 4
        set buffIndex = 0
        call TimerStart(CreateTimer(), 0.25, true, function ActL)
    endfunction

    private function Cond takes nothing returns boolean
        return (GetSpellAbilityId() == skId)
    endfunction

// =======================================================================================
    private function Init takes nothing returns nothing
        set gg_trg_Baryon_Chakra = CreateTrigger()
        call TriggerAddCondition(gg_trg_Baryon_Chakra, Condition(function Cond))
        call TriggerAddAction(gg_trg_Baryon_Chakra, function Act)
    endfunction

endscope