native UnitAlive takes unit u returns boolean

function TestRun takes nothing returns nothing
    local real array x
    local real array y
    local group g
    local unit self
    local unit target
    local unit dummy
    local player p
    local integer skWindWalk = 'AOwk'
    local integer skStormBolt = 'ANsb'
    local integer skWarStomp = 'AOws'
    local integer i = 0
    local integer rand = GetRandomInt(0, 3)

    call Echo("Test")
    set g = GetUnitsOfPlayerAll(Player(0))
    loop
        set self = FirstOfGroup(g)
        set i = i + 1
        exitwhen (i == rand) or (self == null)
        call GroupRemoveUnit(g, self)
    endloop
  // set self = FirstOfGroup(g)
    call DestroyGroup(g)
    set g = null

    set g = GetUnitsOfPlayerAll(Player(1))
    loop
        set target = FirstOfGroup(g)
        exitwhen (IsUnitType(target, UNIT_TYPE_HERO)) or (target == null)
        call GroupRemoveUnit(g, target)
    endloop
    call DestroyGroup(g)
    set g = null
    call Log(GetUnitName(target))
    set x[0] = GetUnitX(self)
    set y[0] = GetUnitY(self)
    set x[1] = GetUnitX(target)
    set y[1] = GetUnitY(target)


    //call IssuePointOrderById(target, 852592, GetUnitX(self), GetUnitY(self))
    //call IssueImmediateOrderById(target, 852526)
    //call IssuetargetOrderById(target, 852230, self)
    //call IssueTargetOrder(target, "stomp", self)
    //call IssueImmediateOrder(target, "mirrorimage")
    //call IssueImmediateOrder(target, "windwalk")
    call UnitAddAbility(target, skStormBolt)
    call IssueTargetOrder(target, "thunderbolt", self)
    //call IssueImmediateOrder(target, "stomp")
    set self = null
    set target = null
endfunction

//===========================================================================
function InitTrig_TestRun takes nothing returns nothing
    set gg_trg_TestRun = CreateTrigger(  )
    //call TriggerRegisterPlayerEventEndCinematic( gg_trg_TestRun, Player(0) )
    call TriggerAddAction( gg_trg_TestRun, function TestRun )
    call TriggerRegisterPlayerChatEvent( gg_trg_TestRun, Player(0), "test", true )
endfunction