native UnitAlive takes unit u returns boolean

function TestRun takes nothing returns nothing
    local real array x
    local real array y
    local group g
    local unit mySelf
    local unit myTarget
    local unit dummy
    local player p
    local integer skWindWalk = 'AOwk'
    local integer skStormBolt = 'ANsb'
    local integer i

    call Echo("Test")
    set g = GetUnitsOfPlayerAll(Player(0))
    set mySelf = FirstOfGroup(g)
    call DestroyGroup(g)
    set g = null
    set g = GetUnitsOfPlayerAll(Player(1))
    set myTarget = FirstOfGroup(g)
    call DestroyGroup(g)
    set g = null
    set x[0] = GetUnitX(mySelf)
    set y[0] = GetUnitY(mySelf)
    set x[1] = GetUnitX(myTarget)
    set y[1] = GetUnitY(myTarget)


    //call IssuePointOrderById(myTarget, 852592, GetUnitX(mySelf), GetUnitY(mySelf))
    //call IssueImmediateOrderById(myTarget, 852526)
    //call IssuemyTargetOrderById(myTarget, 852230, mySelf)
    //call IssueImmediateOrder(myTarget, "mirrorimage")
    call IssueImmediateOrder(mySelf, "windwalk")
    if (GetUnitAbilityLevel(mySelf, Zabuza_WWBuff) > 0) then
        loop
            call TriggerSleepAction(0.01)
            if (GetUnitState(myTarget, UNIT_STATE_LIFE) < 1) then
                set myTarget = GetUnitNearestXY(GetUnitX(mySelf), GetUnitY(mySelf), 300.00, GetOwningPlayer(mySelf))
            endif
            if (myTarget != null) then
                call Echo(GetUnitName(mySelf) + " -> " + GetUnitName(myTarget))
                call IssueTargetOrder(mySelf, "attack", myTarget)
            endif
            exitwhen (GetUnitAbilityLevel(mySelf, Zabuza_WWBuff) < 1)
        endloop
    elseif (IsUnitType(myTarget, UNIT_TYPE_HERO)) then
        call IssueTargetOrder(mySelf, "channel", myTarget)
        call IssueImmediateOrder(mySelf, "roar")
        call IssueImmediateOrder(mySelf, "battleroar")
        call IssueImmediateOrderById(mySelf, 852478)
    endif

    set mySelf = null
    set myTarget = null
endfunction

//===========================================================================
function InitTrig_TestRun takes nothing returns nothing
    set gg_trg_TestRun = CreateTrigger(  )
    //call TriggerRegisterPlayerEventEndCinematic( gg_trg_TestRun, Player(0) )
    call TriggerAddAction( gg_trg_TestRun, function TestRun )
    call TriggerRegisterPlayerChatEvent( gg_trg_TestRun, Player(0), "test", true )
endfunction