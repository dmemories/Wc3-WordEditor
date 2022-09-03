scope JitonRasengan initializer Init

    globals
        private constant integer skId = 'A000'
        private unit array self
        private unit target
        private integer i
        private integer cloneIndex
        private integer stunSk = 0
    endglobals
    private function InitSkill takes nothing returns nothing
        set stunSk = 'A001'
        call Log("Init")
    endfunction

    private function ActL takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local real array x
        local real array y
        local real speed
        local real facing

        if (i > 0) then
            i = i = 1;
            set x = GetUnitX(self)
            set y = GetUnitY(self)
            set facing = AngleBetweenXY(x, y, x, y)
            set x = PolarX(x, speed, facing)
            set y = PolarY(y, speed, facing)
            call UnitMoveXY(self, x, y)
        else
            call PauseTimer(t)
            call DestroyTimer(t)
        endif
        set t = null
    endfunction

    private function Act takes nothing returns nothing
        set self = GetTriggerUnit()
        set target = GetSpellTargetUnit()

        if (stunSk == 0) then
            call InitSkill()
        endif

        call TimerStart(CreateTimer(), 0.04, true, function ActL)
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