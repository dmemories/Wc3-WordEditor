scope HakkeHyakuNijuhachi initializer Init

    globals
        private constant integer skId = 'A00D'
        private unit caster
        private unit array hakkeDummies
        private integer i
        private integer j
        private real delay = 0
    endglobals

    private function InitSkill takes nothing returns nothing
        if (delay == 0) then
            set delay = 0.04
        endif
        /*local real castingTime = 2.00
        local real diffSize = 2.00

        set shuriken = null
        set garea = 600.00
        set shurikenSizeDelay = 0.05
        set sizeMaxLoop = R2I(castingTime / shurikenSizeDelay)
        set shurikenSizeRate = diffSize / I2R(sizeMaxLoop)
        set shurikenSpeed = 97.00
        set reachRange = shurikenSpeed + 10.00
        set maxDummy = 3
        set skSlow = 'A009'*/
    endfunction

    private function ActL takes nothing returns nothing
        local timer t = GetExpiredTimer()

        if (i > 0) then
            if (i == j) then
                call SetUnitTimeScale(hakkeDummies[1], 0)
            endif
            set i = i - 1
        else
            call PauseTimer(t)
            call DestroyTimer(t)
            call RemoveUnit(hakkeDummies[0])
            call RemoveUnit(hakkeDummies[1])
            set hakkeDummies[0] = null
            set hakkeDummies[1] = null
        endif
        set t = null
    endfunction

    private function Act takes nothing returns nothing
        local real casterX
        local real casterY

        set caster = GetTriggerUnit()
        set casterX = GetUnitX(caster)
        set casterY = GetUnitY(caster)
        call InitSkill()

        set hakkeDummies[0] = CreateUnit(GetOwningPlayer(caster), 'h01R', casterX, casterY, GetRandomReal(0, 360))
        set hakkeDummies[1] = CreateUnit(GetOwningPlayer(caster), 'h00D', casterX, casterY, bj_UNIT_FACING)
        call SetUnitTimeScale(hakkeDummies[1], 2)

        //call SoundPatch_Spell(udg_soundPatch_Naruto + "\\Naruto\\Rasensuriken.wav", GetUnitX(self), GetUnitY(self))
        set i = 10 * R2I(1 / delay)
        set j = i - 5
        call TimerStart(CreateTimer(), delay, true, function ActL)
    endfunction

    private function Cond takes nothing returns boolean
        return (GetSpellAbilityId() == skId)
    endfunction

// =======================================================================================
    private function Init takes nothing returns nothing
        set gg_trg_Hakke_Hyaku_Nijuhachi = CreateTrigger()
        call TriggerAddCondition(gg_trg_Hakke_Hyaku_Nijuhachi, Condition(function Cond))
        call TriggerAddAction(gg_trg_Hakke_Hyaku_Nijuhachi, function Act)
    endfunction

endscope