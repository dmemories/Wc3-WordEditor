native UnitAlive takes unit u returns boolean

    function TestRun takes nothing returns nothing
        local real array x
        local real array y
        local group g
        local unit self
        local unit bot
        local unit dummy
        local player p
        local integer skWindWalk = 'AOwk'
        local integer skStormBolt = 'AHtb'
        local integer skWarStomp = 'AOws'
        local integer i = 0
        local integer rand = GetRandomInt(0, 3)

        set g = GetUnitsOfPlayerAll(Player(0))
        /*loop
            set self = FirstOfGroup(g)
            set i = i + 1
            exitwhen (i == rand) or (self == null)
            call GroupRemoveUnit(g, self)
        endloop*/
        set self = FirstOfGroup(g)
        call DestroyGroup(g)
        set g = null

        set g = GetUnitsOfPlayerAll(Player(1))
        loop
            set bot = FirstOfGroup(g)
            exitwhen (IsUnitType(bot, UNIT_TYPE_HERO)) or (bot == null)
            call GroupRemoveUnit(g, bot)
        endloop
        call DestroyGroup(g)
        set g = null
        call Log(GetUnitName(bot))
        set x[0] = GetUnitX(self)
        set y[0] = GetUnitY(self)
        set x[1] = GetUnitX(bot)
        set y[1] = GetUnitY(bot)


        call Echo(GetUnitName(bot) + " => " + GetUnitName(self))


        //call IssuePointOrderById(bot, 852592, GetUnitX(self), GetUnitY(self))
        //call IssueImmediateOrderById(bot, 852526)
        //call IssuebotOrderById(bot, 852230, self)
        //call IssuebotOrder(bot, "stomp", self)
        //call IssueImmediateOrder(bot, "mirrorimage")
        //call IssueImmediateOrder(bot, "windwalk")
        call UnitAddAbility(bot, skStormBolt)
        call IssueTargetOrder(bot, "thunderbolt", self)
        //call IssueImmediateOrder(bot, "stomp")
        set self = null
        set bot = null
    endfunction
    
    //===========================================================================
    function InitTrig_TestRun takes nothing returns nothing
        set gg_trg_TestRun = CreateTrigger(  )
        //call TriggerRegisterPlayerEventEndCinematic( gg_trg_TestRun, Player(0) )
        call TriggerAddAction( gg_trg_TestRun, function TestRun )
        call TriggerRegisterPlayerChatEvent( gg_trg_TestRun, Player(0), "test", true )
    endfunction