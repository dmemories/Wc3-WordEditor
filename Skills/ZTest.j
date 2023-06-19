scope AINaruto initializer Init

    globals
        private constant integer AINo = 2
        private constant integer AIType1 = 'U000'
        private constant integer AIType2 = 'U004'
    endglobals

    private function isAtked takes nothing returns boolean
        return ( (GetUnitTypeId(GetTriggerUnit())==AIType1 or GetUnitTypeId(GetTriggerUnit())==AIType2) and GetPlayerController(GetOwningPlayer(GetTriggerUnit())) == MAP_CONTROL_COMPUTER )
    endfunction

    private function isAtker takes nothing returns boolean
        return ( (GetUnitTypeId(GetAttacker())==AIType1 or GetUnitTypeId(GetAttacker())==AIType2) and GetPlayerController(GetOwningPlayer(GetAttacker())) == MAP_CONTROL_COMPUTER )
    endfunction

    private function Cond takes nothing returns boolean
        if ( not (isAtked() or isAtker()) ) then
            return false
        endif
        return ( IsUnitEnemy(GetAttacker(), GetOwningPlayer(GetTriggerUnit())) and IsUnitIllusion(GetAttacker())==false and IsUnitIllusion(GetTriggerUnit())==false )
    endfunction

    private function Act takes nothing returns nothing
        local unit mySelf
        local unit myTarget
        local real selfHPPercent
        local real targetHPPercent
        local real targetX
        local real targetY
        local boolean isAttacking = false
        local boolean isHeroTarget

        call DisableTrigger(udg_AI_Trig[AINo])
        call TriggerSleepAction(AI_TrigDelayRun)
        if (isAtked()) then
            set myTarget = GetAttacker()
            set mySelf = GetTriggerUnit()
        else
            set mySelf = GetAttacker()
            set myTarget = GetTriggerUnit()
            set isAttacking = true
        endif
        set selfHPPercent = GetUnitStatePercent(mySelf, UNIT_STATE_LIFE, UNIT_STATE_MAX_LIFE)
        set targetHPPercent = GetUnitStatePercent(myTarget, UNIT_STATE_LIFE, UNIT_STATE_MAX_LIFE)
        set isHeroTarget = IsUnitType(myTarget, UNIT_TYPE_HERO)

        if (selfHPPercent > AI_AtkSelfHP or (targetHPPercent < AI_AtkTargetHPBelow and isHeroTarget)) then
            if (GetHeroSkillPoints(mySelf) > 0) then
                call SelectHeroSkill(mySelf, 'A04S')
                call SelectHeroSkill(mySelf, 'A0MW')
                call SelectHeroSkill(mySelf, 'A0MS')
                call SelectHeroSkill(mySelf, 'A0MR')
                call SelectHeroSkill(mySelf, 'A04O')
            endif

            if ((selfHPPercent - targetHPPercent) > AI_AtkSelfHPAvt) then
                set targetX = GetUnitX(myTarget)
                set targetY = GetUnitY(myTarget)
                if (DistanceBetweenXY(GetUnitX(mySelf), GetUnitY(mySelf), targetX, targetY) > AI_OrderBlinkDistance) then
                    call IssuePointOrder(mySelf, "blink", targetX, targetY)
                    call TriggerSleepAction(AI_DelayAfterBlink)
                endif
            endif
            call IssueTargetOrder(mySelf, "silence", myTarget)
            if (IsUnitType(myTarget, UNIT_TYPE_HERO)) then
                call IssueTargetOrder(mySelf, "invisibility", myTarget)
                call IssueTargetOrder(mySelf, "shadowstrike", myTarget)
                if (isAttacking) then
                    call IssueImmediateOrder(mySelf, "mirrorimage")
                    call IssueImmediateOrder(mySelf, "battleroar")
                endif
            endif
        endif
        set mySelf = null
        set myTarget = null
        call TriggerSleepAction(AI_TrigDelayEnable)
        call EnableTrigger(udg_AI_Trig[AINo])
    endfunction

    //===========================================================================
    private function Init takes nothing returns nothing
        set udg_AI_Trig[AINo] = CreateTrigger()
        call TriggerAddCondition( udg_AI_Trig[AINo], Condition( function Cond ) )
        call TriggerAddAction( udg_AI_Trig[AINo], function Act )
    endfunction

endscope