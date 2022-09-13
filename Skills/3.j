scope BaryonChakra initializer Init

    globals
        private constant integer skId = 'A005'
        private string effPath = null
        private unit self
        private real skillDur
        private real garea
        private real blockRate
        private real healRate
        private group gcheck
        private integer buffStack
        private integer effectKey
        private integer dmgTrgKey
        private integer dmgTrgIndex
        private integer dmgTrgCondIndex
        private hashtable hash
    endglobals

    private function InitSkill takes nothing returns nothing
        set effPath = "war3mapImported\\BijuuAura2.mdl"
        set garea = 600.00
        set hash = InitHashtable()
        set effectKey = 1
        set dmgTrgKey = 2
        set dmgTrgIndex = 0
        set dmgTrgCondIndex = 1
        set blockRate = 0.40
        set healRate = 0.04
    endfunction

    private function DmgTrgCond takes nothing returns boolean
        call BlockDamageAct(GetTriggerUnit(), (GetEventDamage() * blockRate))
        return false
    endfunction

    private function ActL takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local trigger dmgTrg = LoadTriggerHandle(hash, dmgTrgKey, dmgTrgIndex)
        local real x
        local real y
        local real hp
        local unit picked
        local group g

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
                if (IsUnitAlly(picked, Naruto_Player)) and (GetUnitState(picked, UNIT_STATE_LIFE) > 0) and (IsUnitType(picked, UNIT_TYPE_MECHANICAL) == false) and (IsUnitInGroup(picked, gcheck) == false) then
                    call GroupAddUnit(gcheck, picked)
                    call SaveEffectHandle(hash, effectKey, buffStack, AddSpecialEffectTarget(effPath, picked, "origin"))
                    call TriggerRegisterUnitEvent(dmgTrg, picked, EVENT_UNIT_DAMAGED)
                    set buffStack = buffStack + 1
                endif
            endloop
            call DestroyGroup(g)
            set g = null

            if (ModuloInteger(R2I(skillDur), 4) == 0) then
                set g = CreateGroup()
                call GroupAddGroup(gcheck, g)
                loop
                    set picked = FirstOfGroup(g)
                    exitwhen (picked == null)
                    call GroupRemoveUnit(g, picked)
                    set hp = GetUnitState(picked, UNIT_STATE_LIFE)
                    if (hp > 0) and (IsUnitHidden(picked) == false) then
                        call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Human\\HolyBolt\\HolyBoltSpecialArt.mdl", picked, "origin"))
                        call SetUnitState(picked, UNIT_STATE_LIFE, hp + (GetUnitState(picked, UNIT_STATE_MAX_LIFE) * healRate))
                    endif
                endloop
                call DestroyGroup(g)
                set g = null
            endif
        else
            call PauseTimer(t)
            call DestroyTimer(t)
            call DestroyGroup(gcheck)
            set gcheck = null

            call TriggerRemoveCondition(dmgTrg, LoadTriggerConditionHandle(hash, dmgTrgKey, dmgTrgCondIndex))
            call DestroyTrigger(dmgTrg)

            loop
                exitwhen (buffStack == 0)
                set buffStack = buffStack - 1
                call DestroyEffect(LoadEffectHandle(hash, effectKey, buffStack))
            endloop
            set self = null
        endif
        set t = null
        set dmgTrg = null
    endfunction

    private function Act takes nothing returns nothing
        local timer t
        local integer tId
        local trigger dmgTrg

        set self = GetTriggerUnit()
        if (effPath == null) then
            call InitSkill()
        endif

        set dmgTrg = CreateTrigger()
        call SaveTriggerConditionHandle(hash, dmgTrgKey, dmgTrgCondIndex, TriggerAddCondition(dmgTrg, Condition(function DmgTrgCond)))
        call SaveTriggerHandle(hash, dmgTrgKey, dmgTrgIndex, dmgTrg)
        set dmgTrg = null

        call SoundPatch_Spell(udg_soundPatch_Naruto + "\\Naruto\\BaryonChakra.wav.wav", GetUnitX(self), GetUnitY(self))
        set buffStack = 0
        set skillDur = (7 + GetUnitAbilityLevel(self, skId)) * 4
        set gcheck = CreateGroup()
        set t = CreateTimer()
        set tId = GetHandleId(t)
        call TimerStart(t, 0.25, true, function ActL)
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