scope XXXXXXX initializer Init

    globals
        private constant integer skId = 'A000'
        private unit self
        private unit target
        private real garea
        private integer n
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

        if (n > 0) then
            set n = n - 1
            set x = GetUnitX(self)
            set y = GetUnitY(self)
            set facing = AngleBetweenXY(x, y, x, y)
            set x = PolarX(x, speed, facing)
            set y = PolarY(y, speed, facing)
            call DestroyTreeXY(x, y, garea)
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

        set n = 100
        call TimerStart(CreateTimer(), 1.00, false, function ActL)
    endfunction

    private function Cond takes nothing returns boolean
        return (GetSpellAbilityId() == skId)
    endfunction

// =======================================================================================
    private function Init takes nothing returns nothing
        set gg_trg_Kage_Bunshin = CreateTrigger()
        call TriggerAddCondition(gg_trg_Kage_Bunshin, Condition(function Cond))
        call TriggerAddAction(gg_trg_Kage_Bunshin, function Act)

        set Naruto_KagebunshinLearn = CreateTrigger()
        call TriggerAddCondition(Naruto_KagebunshinLearn, Condition(function LearnCond))
        call TriggerAddAction(Naruto_KagebunshinLearn, function LearnAct)
    endfunction

endscope