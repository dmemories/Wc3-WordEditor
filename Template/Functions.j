//==========================================================================
// CreateGroupAllyXY         Lastest (12/12/21)
//==========================================================================

function CreateGroupAllyXYCond takes unit picked, player p returns boolean
    if (IsUnitAlly(picked, p) == false) then
        return false
    elseif (GetUnitState(picked, UNIT_STATE_LIFE) < 1) then
        return false
    elseif (GetUnitAbilityLevel(picked, udg_GlobalSkill[0]) != 0) then
        return false
    endif
    return true
endfunction

function CreateGroupAllyXY takes real x, real y, real area, player p returns group
    local group g = CreateGroup()
    local group g2 = CreateGroup()
    local unit picked

    call GroupEnumUnitsInRange(g, x, y, area, null)
    loop
        set picked = FirstOfGroup(g)
        exitwhen (picked == null)
        call GroupRemoveUnit(g, picked)
        if (CreateGroupAllyXYCond(picked, p)) then
            call GroupAddUnit(g2, picked)
        endif
        set picked = null
    endloop
    call DestroyGroup(g)
    set g = null
    return g2
endfunction

//==========================================================================
// AppendUnit2TargetL         Lastest (06/11/21)
//==========================================================================

function AppendUnit2TargetL takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer tId = GetHandleId(t)
    local unit dummy = LoadUnitHandle(AppendUnitHash, tId, 0)
    local unit target = LoadUnitHandle(AppendUnitHash, tId, 1)
    local integer loopCount = (LoadInteger(AppendUnitHash, tId, 2)) - 1
    local boolean dummyAlive = GetUnitState(dummy, UNIT_STATE_LIFE) > 0
    local boolean targetAlive = GetUnitState(target, UNIT_STATE_LIFE) > 0

    if (loopCount > 0) and (dummyAlive) and (targetAlive) then
        call SaveInteger(AppendUnitHash, tId, 2, loopCount)
        call SetUnitX(dummy, GetUnitX(target))
        call SetUnitY(dummy, GetUnitY(target))
    else
        call PauseTimer(t)
        call DestroyTimer(t)
        call FlushChildHashtable(AppendUnitHash, tId)
    endif
    set t = null
    set dummy = null
    set target = null
endfunction

function AppendUnit2Target takes unit dummy, unit target, real duration returns nothing
    local real delay
    local integer tId
    local integer loopCount
    local timer t

    if (duration > 0.10) then
        set delay = 0.04
        set loopCount = R2I(duration / delay)
        set t = CreateTimer()
        set tId = GetHandleId(t)
        call SaveUnitHandle(AppendUnitHash, tId, 0, dummy)
        call SaveUnitHandle(AppendUnitHash, tId, 1, target)
        call SaveInteger(AppendUnitHash, tId, 2, loopCount)
        call TimerStart(t, delay, true, function AppendUnit2TargetL)
        set t = null
    endif
endfunction


//==========================================================================
// SetUnitVertexColorAfter         Lastest (14/10/64)
//==========================================================================
function SetUnitVertexColorAfterAct takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer tId = GetHandleId(t)
    local unit u = LoadUnitHandle(UnitVertexHash, tId, 0)
    local integer r = LoadInteger(UnitVertexHash, tId, 1)
    local integer g = LoadInteger(UnitVertexHash, tId, 2) 
    local integer b = LoadInteger(UnitVertexHash, tId, 3)
    local integer alpha = LoadInteger(UnitVertexHash, tId, 4)

    call PauseTimer(t)
    call DestroyTimer(t)
    call FlushChildHashtable(UnitVertexHash, tId)
    call SetUnitVertexColor(u, r, g, b, alpha)
    set t = null
    set u = null
endfunction

function SetUnitVertexColorAfter takes unit u, integer r, integer g, integer b, integer alpha, real delay returns nothing
    local timer t
    local integer tId

    set t = CreateTimer()
    set tId = GetHandleId(t)
    call SaveUnitHandle(UnitVertexHash, tId, 0, u)
    call SaveInteger(UnitVertexHash, tId, 1, r)
    call SaveInteger(UnitVertexHash, tId, 2, g)
    call SaveInteger(UnitVertexHash, tId, 3, b)
    call SaveInteger(UnitVertexHash, tId, 4, alpha)
    call TimerStart(t, delay, false, function SetUnitVertexColorAfterAct)
    set t = null
endfunction


//==========================================================================
// SetUnitFadeScale         Lastest (10/10/64)
//==========================================================================
function SetUnitFadeScaleAct takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer tId = GetHandleId(t)
    local unit u = LoadUnitHandle(UnitScaleFadeHash, tId, 0)
    local integer maxLoop = (LoadInteger(UnitScaleFadeHash, tId, 1)) - 1
    local real currentSize

    if (maxLoop > 0) then
        call SaveInteger(UnitScaleFadeHash, tId, 1, maxLoop)
        set currentSize = (LoadReal(UnitScaleFadeHash, tId, 2)) + (LoadReal(UnitScaleFadeHash, tId, 3))
        call SaveReal(UnitScaleFadeHash, tId, 2, currentSize)
        call SetUnitScale(u, currentSize, currentSize, currentSize)
    else
        call PauseTimer(t)
        call DestroyTimer(t)
        set currentSize = LoadReal(UnitScaleFadeHash, tId, 4)
        call SetUnitScale(u, currentSize, currentSize, currentSize)
        call FlushChildHashtable(UnitFadeHash, tId)
    endif
    set t = null
    set u = null
endfunction

function SetUnitFadeScale takes unit u, real initSize, real finalSize, real duration returns nothing
    local timer t
    local integer tId
    local integer maxLoop
    local real sizePerLoop
    local real delay

    if (initSize < 0.01) or (finalSize < 0.01) or (duration < 0.01) then
        return
    endif
    set delay = 0.05
    set maxLoop = R2I(duration / delay)
    set sizePerLoop = (finalSize - initSize) / maxLoop

    set t = CreateTimer()
    set tId = GetHandleId(t)
    call SetUnitScale(u, initSize, initSize, initSize)
    call SaveUnitHandle(UnitScaleFadeHash, tId, 0, u)
    call SaveInteger(UnitScaleFadeHash, tId, 1, maxLoop)
    call SaveReal(UnitScaleFadeHash, tId, 2, initSize)
    call SaveReal(UnitScaleFadeHash, tId, 3, sizePerLoop)
    call SaveReal(UnitScaleFadeHash, tId, 4, finalSize)
    call TimerStart(t, delay, true, function SetUnitFadeScaleAct)
    set t = null
endfunction


//==========================================================================
// SetUnitAnimationAfter         Lastest (10/10/64)
//==========================================================================
function SetUnitAnimationAfterAct takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer tId = GetHandleId(t)
    local unit u = LoadUnitHandle(UnitAnimAfterHash, tId, 0)
    local string animName = LoadStr(UnitAnimAfterHash, tId, 1)

    call PauseTimer(t)
    call DestroyTimer(t)
    set t = null
    call FlushChildHashtable(UnitAnimAfterHash, tId)
    call SetUnitAnimation(u, animName)
    set u = null
endfunction

function SetUnitAnimationAfter takes unit u, string animName, real delay returns nothing
    local timer t = CreateTimer()
    local integer tId = GetHandleId(t)

    call SaveUnitHandle(UnitAnimAfterHash, tId, 0, u)
    call SaveStr(UnitAnimAfterHash, tId, 1, animName)
    call TimerStart(t, delay, false, function SetUnitAnimationAfterAct)
    set t = null
endfunction


//==========================================================================
// SetAbilityAvailable         Lastest (17/12/63)
//==========================================================================
function SetAbilityAvailable takes integer skId, boolean isAvailable returns nothing
    local integer i = 0
    loop
        call SetPlayerAbilityAvailable(Player(i), skId, isAvailable)
        set i = i + 1
        exitwhen i == bj_MAX_PLAYERS
    endloop
endfunction


//==========================================================================
// UnitApplyFadeLife         Lastest (13/12/63)
//==========================================================================
function UnitApplyFadeLifeAct takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer tId = GetHandleId(t)
    local integer maxLoop = (LoadInteger(UnitFadeHash, tId, 1)) - 1
    local unit u = LoadUnitHandle(UnitFadeHash, tId, 0)
    local integer vertex
    local integer r
    local integer g
    local integer b

    if (maxLoop > 0) then
        call SaveInteger(UnitFadeHash, tId, 1, maxLoop)
        set vertex = LoadInteger(UnitFadeHash, tId, 2)
        set r = LoadInteger(UnitFadeHash, tId, 3)
        set g = LoadInteger(UnitFadeHash, tId, 4)
        set b = LoadInteger(UnitFadeHash, tId, 5)
        call SetUnitVertexColor(u, r, g, b, (vertex * maxLoop))
    else
        call PauseTimer(t)
        call DestroyTimer(t)
        call FlushChildHashtable(UnitFadeHash, tId)
        call RemoveUnit(u)
    endif
    set t = null
    set u = null
endfunction

function UnitApplyFadeLifeDelay takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local real timePerLoop = 0.04

    call PauseTimer(t)
    call TimerStart(t, timePerLoop, true, function UnitApplyFadeLifeAct)
    set t = null
endfunction

function UnitApplyFadeLife takes unit u, real periods, integer r, integer g, integer b, integer startVertex, real delayStart returns nothing
    local real timePerLoop = 0.04
    local integer maxLoop = R2I(periods / timePerLoop)
    local integer vertexPerLoop = R2I(startVertex / maxLoop)
    local timer t = CreateTimer()
    local integer tId = GetHandleId(t)

    call SaveUnitHandle(UnitFadeHash, tId, 0, u)
    call SaveInteger(UnitFadeHash, tId, 1, maxLoop)
    call SaveInteger(UnitFadeHash, tId, 2, vertexPerLoop)
    call SaveInteger(UnitFadeHash, tId, 3, r)
    call SaveInteger(UnitFadeHash, tId, 4, g)
    call SaveInteger(UnitFadeHash, tId, 5, b)
    if (delayStart > 0) then
        call TimerStart(t, delayStart, false, function UnitApplyFadeLifeDelay)
    else
        call TimerStart(t, timePerLoop, true, function UnitApplyFadeLifeAct)
    endif
    set t = null
endfunction



//==========================================================================
// CreateDummy         Lastest (11/12/63)
//==========================================================================
function CreateDummy takes player p, integer uTypeId, real x, real y, real facing, integer vertexColor returns unit
    if (vertexColor < 0) then
        set vertexColor = 127
    endif

    set bj_lastCreatedUnit = CreateUnit(p, uTypeId, x, y, facing)
    call UnitAddAbility(bj_lastCreatedUnit, udg_GlobalSkill[0]) // Invul
    call UnitAddAbility(bj_lastCreatedUnit, udg_GlobalSkill[6]) // Loccust
    call SetUnitPathing(bj_lastCreatedUnit, false)
    call SetUnitX(bj_lastCreatedUnit, x)
    call SetUnitY(bj_lastCreatedUnit, y)
    call UnitRemoveAbility(bj_lastCreatedUnit, 'Aatk')
    call UnitRemoveAbility(bj_lastCreatedUnit, 'Amov')
    call SetUnitVertexColor(bj_lastCreatedUnit, 255, 255, 255, vertexColor)
    return bj_lastCreatedUnit
endfunction



//==========================================================================
// Block Damage          Lastest (26/12/62)
//==========================================================================
function BlockDamageAct2 takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer tId = GetHandleId(t)
    local unit u = LoadUnitHandle(BlackDamageHash, tId, 0)
    local real heal = LoadReal(BlackDamageHash, tId, 1)

    call FlushChildHashtable(BlackDamageHash, tId)
    call PauseTimer(t)
    call DestroyTimer(t)
    set  t = null
    call SetUnitState(u, UNIT_STATE_LIFE, (GetUnitState(u, UNIT_STATE_LIFE) + heal))
    set u = null
endfunction

function BlockDamageAct takes unit u, real heal returns nothing
    local real currentHP = GetUnitState(u, UNIT_STATE_LIFE)
    local real afterHealHP = heal + currentHP
    local real maxHP = GetUnitState(u, UNIT_STATE_MAX_LIFE)
    local timer t
    local integer tId

    if (afterHealHP > maxHP) then
        set t = CreateTimer()
        set tId = GetHandleId(t)
        call SaveUnitHandle(BlackDamageHash, tId, 0, u)
        call SaveReal(BlackDamageHash, tId, 1, heal)
        call TimerStart(t, 0, false, function BlockDamageAct2)
        set t = null
    else
        call SetUnitState(u , UNIT_STATE_LIFE, afterHealHP)
    endif
    set u = null
endfunction


//==========================================================================
// IsWindWalk             Lastest (06/02/60)
//==========================================================================

function IsWindWalk takes unit u returns boolean
    local integer i = 0
    local boolean b = false
    
    loop
        exitwhen i > udg_WindWalk_Max
        if(GetUnitAbilityLevel(u, udg_WindWalk_Ability[i]) > 0) then
            set b = true
            set i = udg_WindWalk_Max
        endif
        set i = i + 1
    endloop

    return b
endfunction




//==========================================================================
// SetAbilityCooldown             Lastest (03/02/60)
//==========================================================================

function SetAbilityCooldown_End takes nothing returns nothing
    local timer t  = GetExpiredTimer()
    local integer id = GetHandleId(t)
    local unit u = LoadUnitHandle(udg_Cooldown_Hash, id, 0)
    local integer skDummy = LoadInteger(udg_Cooldown_Hash, id, 1)
    local integer skBase = LoadInteger(udg_Cooldown_Hash, id, 2)
    local player p = LoadPlayerHandle(udg_Cooldown_Hash, id, 3)

    call UnitRemoveAbility(u, skDummy)
    call SetPlayerAbilityAvailable(p, skBase, true)

    call FlushChildHashtable(udg_Cooldown_Hash, id)
    call DestroyTimer(t)
    set t = null
    set u = null
    set p = null
endfunction

function SetAbilityCooldown takes unit u, integer skBase, integer skDummy, real cd returns nothing
    local real x = GetUnitX(u)
    local real y = GetUnitY(u)
    local player p1 = GetOwningPlayer(u)
    local player p2 = Player(14)
    local unit dummy = CreateUnit( p2, 'h05Z', x, y, bj_UNIT_FACING )
    local timer t = CreateTimer()
    local integer id = GetHandleId(t)
    
    call SetPlayerAbilityAvailable(p1, skBase, false)
    call UnitAddAbility(u, skDummy)
    call SetUnitAbilityLevel(u, skDummy, GetUnitAbilityLevel(u, skBase))
    call SetPlayerAlliance(p2, p1, ALLIANCE_PASSIVE, true)
    call IssueTargetOrderById(dummy, 852075, u)
    call SetPlayerAlliance(p2, p1, ALLIANCE_PASSIVE, false)
    call UnitApplyTimedLife(dummy, 1112820806, 1.00)

    call SaveUnitHandle(udg_Cooldown_Hash, id, 0, u)
    call SaveInteger(udg_Cooldown_Hash, id, 1, skDummy)
    call SaveInteger(udg_Cooldown_Hash, id, 2, skBase)
    call SavePlayerHandle(udg_Cooldown_Hash, id, 3, p1)
    call TimerStart(t, (cd+0.07), false, function SetAbilityCooldown_End)
    
    set p1 = null
    set p2 = null
    set dummy = null
endfunction



//==========================================================================
// SoundPatch Music             Lastest (21/01/61)
//==========================================================================

function SoundPatch_Music takes string s returns nothing
    call StopMusic(true)
    call PlayMusic(s)
endfunction



//==========================================================================
// SoundPatch Spell             Lastest (21/01/61)
//==========================================================================

function SoundPatch_Spell takes string s, real x, real y returns nothing
    local sound mySound
    local integer myVolume
 
    if( IsPlayerInForce(GetLocalPlayer(), udg_SoundPatch_EnableGroup) ) then
        set myVolume = 150
    else
        set myVolume = 0
    endif
    set mySound = CreateSound(s, false, true, true, 10, 10, "DefaultEAXON")
    call SetSoundDuration(mySound,3000)
    call SetSoundChannel(mySound,0)
    call SetSoundVolume(mySound,myVolume)
    call SetSoundPitch(mySound,1.0)
    call SetSoundDistances(mySound,600.0,2500.0)
    call SetSoundDistanceCutoff(mySound,2000.0)
    call SetSoundConeAngles(mySound,0.0,0.0,127)
    call SetSoundConeOrientation(mySound,0.0,0.0,0.0)
    call SetSoundPosition(mySound,x,y,0)
    call StartSound(mySound)
    call KillSoundWhenDone(mySound)

    set s = null
    set mySound = null
endfunction



//==========================================================================
// Gate Teleport Condition      Lastest (19/01/61)
//==========================================================================

function GateTeleportCond takes nothing returns boolean
    local unit u = GetTriggerUnit()

    if(IsUnitType(u, UNIT_TYPE_HERO) == false) then
        return false
    elseif(GetOwningPlayer(u) == Player(PLAYER_NEUTRAL_AGGRESSIVE)) then
        return false
    elseif(GetUnitAbilityLevel(u, udg_GlobalSkill[0]) > 0) then
        return false
    else
        return true
    endif
endfunction




//==========================================================================
// Final Boss Check      Lastest (18/01/61)
//==========================================================================

function FinalBossCheck takes nothing returns nothing
    if(udg_Golem_Final and udg_Boss_Check[0] and udg_Boss_Check[1] and udg_GateBoss_Integer>3 and udg_Divine_Bool and udg_Forgot_Bool) then
        call TriggerSleepAction(60.00)
        call TriggerExecute( gg_trg_FinalBoss )
    endif
endfunction




//==========================================================================
// FrozenItemSwap             Lastest (17/01/61)
//==========================================================================

function FrozenItemSwap takes unit u, boolean toRanged returns nothing
    local integer array base_item
    local integer array replace_item
    local real delay = 0.10
    local integer i = 0
    local integer j
    local integer maxFrozenSlot

    if(toRanged) then
        //-- Hogyoku Meelee --
            set base_item[0] = 'I05L'
        //-- Hogyoku Ranged --
            set replace_item[0] = 'I05P'
        //-- FrozenMask Meelee --
            set base_item[1] = 'I04L'
        //-- FrozenMask Ranged --
            set replace_item[1] = 'I05G'       
    else
        //-- Hogyoku Ranged --
            set base_item[0] = 'I05P'
        //-- Hogyoku Meelee --
            set replace_item[0] = 'I05L'
        //-- FrozenMask Ranged --
            set base_item[1] = 'I05G'
        //-- FrozenMask Meelee --
            set replace_item[1] = 'I04L'
    endif

    set maxFrozenSlot = 1

    loop
        exitwhen (GetWidgetLife(u)>0) or i>30
        set i = i+1
        call TriggerSleepAction(delay)
    endloop
    if(GetWidgetLife(u)<1) then
        return
    endif

    set i = 0
    loop
        set j = 0
        loop
            if(GetItemTypeId(UnitItemInSlot(u, i)) == base_item[j]) then
                call RemoveItem(UnitItemInSlot(u, i))
                call UnitAddItemToSlotById(u, replace_item[j], i)
            endif
            set j = j+1
            exitwhen j>maxFrozenSlot
        endloop
        set i = i+1
        exitwhen i>5
    endloop
endfunction




//==========================================================================
// PanCameraToTimedXYForPlayer             Lastest (28/12/60)
//==========================================================================

function PanCameraToTimedXYForPlayer takes player whichPlayer, real x, real y, real duration returns nothing
    if (GetLocalPlayer() == whichPlayer) then
        call PanCameraToTimed(x, y, duration)
    endif
endfunction




//==========================================================================
// CheckDay             Lastest (26/12/60)
//==========================================================================
function CheckDay takes nothing returns boolean
    local real gtime = GetFloatGameState(GAME_STATE_TIME_OF_DAY)
    return (gtime>6.00) and (gtime<18.00)
endfunction




//==========================================================================
// TerrainDeformationRippleXY             Lastest (22/12/60)
//==========================================================================

function TerrainDeformationRippleXY takes real duration, boolean limitNeg, real x, real y, real startRadius, real endRadius, real depth, real wavePeriod, real waveWidth returns terraindeformation
    local real spaceWave
    local real timeWave
    local real radiusRatio

    if (endRadius <= 0 or waveWidth <= 0 or wavePeriod <= 0) then
        return null
    endif

    set timeWave = 2.0 * duration / wavePeriod
    set spaceWave = 2.0 * endRadius / waveWidth
    set radiusRatio = startRadius / endRadius

    set bj_lastCreatedTerrainDeformation = TerrainDeformRipple(x, y, endRadius, depth, R2I(duration * 1000), 1, spaceWave, timeWave, radiusRatio, limitNeg)
    return bj_lastCreatedTerrainDeformation
endfunction




//==========================================================================
// CreateRectXY             Lastest (18/12/60)
//==========================================================================

function CreateRectXY takes real x, real y, real width, real height returns rect
    return Rect( x - width*0.5, y - height*0.5, x + width*0.5, y + height*0.5 )
endfunction




//==========================================================================
// UnitHideSelect             Lastest (16/12/60)
//==========================================================================

function UnitHideSelect takes unit whichUnit returns nothing
    call ShowUnit(whichUnit, false)
    call UnitRemoveAbility(whichUnit, 'Aloc')
    call ShowUnit(whichUnit, true)
endfunction




//==========================================================================
// CreateNUnitsXY             Lastest (15/12/60)
//==========================================================================

function CreateNUnitsXY takes integer count, integer unitId, player whichPlayer, real x, real y, real face returns nothing
    loop
        set count = count - 1
        exitwhen count < 0
        call CreateUnit( whichPlayer, unitId, x, y, face )
    endloop
endfunction




//==========================================================================
// RandomXYInRect             Lastest (14/12/60)
//==========================================================================

function RandomXInRect takes rect whichRect returns real
    return GetRandomReal(GetRectMinX(whichRect), GetRectMaxX(whichRect))
endfunction

function RandomYInRect takes rect whichRect returns real
    return GetRandomReal(GetRectMinY(whichRect), GetRectMaxY(whichRect))
endfunction




//==========================================================================
// DistanceBetweenXY             Lastest (10/12/60)
//==========================================================================

function DistanceBetweenXY takes real x1, real y1, real x2, real y2 returns real
    local real dx = x2 - x1
    local real dy = y2 - y1
    return SquareRoot(dx * dx + dy * dy)
endfunction




//==========================================================================
// PolarXY             Lastest (10/12/60)
//==========================================================================

function PolarX takes real x, real dist, real angle returns real
    return (x + dist * Cos(angle * bj_DEGTORAD))
endfunction

function PolarY takes real y, real dist, real angle returns real
    return (y + dist * Sin(angle * bj_DEGTORAD))
endfunction


//==========================================================================
// AngleBetweenXY             Lastest (10/12/60)
//==========================================================================

function AngleBetweenXY takes real x1, real y1, real x2, real y2 returns real
    return bj_RADTODEG * Atan2(y2 - y1, x2 - x1)
endfunction




//==========================================================================
// UnitMoveLoc             Lastest (26/11/60)
//==========================================================================

function UnitMoveLoc takes unit u, location loc returns nothing
    local real x = GetLocationX(loc)
    local real y = GetLocationY(loc)
    if(IsTerrainPathable(x, y, PATHING_TYPE_WALKABILITY)==false) then
        call SetUnitX(u, x)
        call SetUnitY(u, y)
    endif
endfunction



//==========================================================================
// UnitMoveXY             Lastest (26/11/60)
//==========================================================================

function UnitMoveXY takes unit u, real x, real y returns boolean
    if (IsUnitType(u, UNIT_TYPE_ANCIENT) or IsTerrainPathable(x, y, PATHING_TYPE_WALKABILITY)) then
        return false
    else
        call SetUnitX(u, x)
        call SetUnitY(u, y)
        return true
    endif
endfunction




//==========================================================================
// UnitPureDamageTarget             Lastest (11/11/60)
//==========================================================================

function UnitPureDamageTarget takes unit atker, unit atked, real rdmg returns nothing
    local integer hp = R2I(GetWidgetLife(atked))
    local integer dmg = R2I(rdmg)
    if(hp>dmg) then
        call SetUnitState(atked, UNIT_STATE_LIFE, I2R(hp-dmg))
    else
        call SetUnitState(atked, UNIT_STATE_LIFE, 1.00)
        call UnitDamageTarget(atker, atked, I2R(dmg), true, false, ATTACK_TYPE_CHAOS, DAMAGE_TYPE_NORMAL, WEAPON_TYPE_WHOKNOWS)
    endif
endfunction




//==========================================================================
// BasicDmg_Q             Lastest (16/06/60)
//==========================================================================

function BasicDmg_Q takes unit u, integer sk, integer whichStat returns real
    local integer my_atb
    local integer sklv = GetUnitAbilityLevel(u, sk)

    if(u==null or sklv==0) then
    call DisplayTimedTextToForce( GetPlayersAll(), 0.01, "#ERROR#  UNIT: "+GetUnitName(u)+" / ABILITY: "+GetAbilityName(sk) )
    return 0.00
    endif

    if(whichStat == bj_HEROSTAT_STR) then
        set my_atb = GetHeroStr(u, true)
    elseif(whichStat == bj_HEROSTAT_AGI) then
        set my_atb = GetHeroAgi(u, true)
    elseif(whichStat == bj_HEROSTAT_INT) then
        set my_atb = GetHeroInt(u, true)
    else
        call DisplayTimedTextToForce( GetPlayersAll(), 0.01, "#ERROR#  UNIT: "+GetUnitName(u)+" / ATTRIBUTE: "+I2S(whichStat) )
        return 0.00
    endif

    return (145.00+(I2R(sklv)*65.00))+(I2R(my_atb)*1.50)
endfunction




//==========================================================================
// Bonus Check             Lastest (04/06/60)
//==========================================================================

function BonusAbilityCheck takes unit u returns nothing
    local integer slot = (GetConvertedPlayerId(GetOwningPlayer(u))-1)
    if ( udg_Player_PermanentBonus[slot] == 1 and GetUnitAbilityLevel(u, udg_PermanentBonus_STR)==0) then
        call UnitAddAbility(u,udg_PermanentBonus_STR)
    elseif ( udg_Player_PermanentBonus[slot] == 2 and GetUnitAbilityLevel(u, udg_PermanentBonus_AGI)==0) then
        call UnitAddAbility(u,udg_PermanentBonus_AGI)
    elseif ( udg_Player_PermanentBonus[slot] == 3 and GetUnitAbilityLevel(u, udg_PermanentBonus_INT)==0) then
        call UnitAddAbility(u,udg_PermanentBonus_INT)
    endif
    set slot = 0
endfunction


//==========================================================================
// Attribute Check             Lastest (04/06/60)
//==========================================================================

function AttributeCheck takes unit u returns integer
    local integer STR = GetHeroStr(u,false)
    local integer AGI = GetHeroAgi(u,false)
    local integer INT = GetHeroInt(u,false)
    if((INT > STR) and (INT > AGI)) then
        return 2
    elseif((STR > AGI) and (STR > INT)) then
        return 0
    else
        return 1
    endif
endfunction



//==========================================================================
// Get Pimary Attribute             Lastest (10/11/62)
//==========================================================================

function GetPimaryAttribute takes unit u returns integer
    local integer i = AttributeCheck(u)

    if (i == 0) then
        return GetHeroStr(u, true)
    elseif (i == 1) then
        return GetHeroAgi(u, true)
    else
        return GetHeroInt(u, true)
    endif
endfunction




//==========================================================================
// Dynamic 3D Sound           Lastest (26/03/60)
//==========================================================================

function Dynamic_3D takes string s, real X, real Y returns nothing
    local sound My3d = CreateSound(s, false, true, true, 10, 10,"DefaultEAXON")
    if(My3d!=null)then
        //call SetSoundDuration(My3d,3000)
        call SetSoundChannel(My3d,0)
        call SetSoundVolume(My3d,150)
        call SetSoundPitch(My3d,1.0)
        call SetSoundDistances(My3d,600.0,2500.0)
        call SetSoundDistanceCutoff(My3d,2000.0)
        call SetSoundConeAngles(My3d,0.0,0.0,127)
        call SetSoundConeOrientation(My3d,0.0,0.0,0.0)
        call SetSoundPosition(My3d,X,Y,0)
        call StartSound(My3d)
        call KillSoundWhenDone(My3d)
        set My3d = null
    endif
    set s = null
endfunction




//==========================================================================
// Dynamic Create Group             Lastest (17/05/60)
//==========================================================================

function DynamicCreateGroupCond takes unit picked, player p returns boolean
    if(IsUnitAlly(picked, p)) then
        return false
    elseif(GetWidgetLife(picked) < 1) then
        return false
    elseif(GetUnitAbilityLevel(picked, udg_GlobalSkill[0]) != 0) then
        return false    
    endif
    return true
endfunction

function DynamicCreateGroup takes location loc, real area, player p returns group
    local unit picked
    local group g2 = CreateGroup()
    local group g = GetUnitsInRangeOfLocAll(area, loc)
    loop
        set picked = FirstOfGroup(g)
        exitwhen picked==null
        call GroupRemoveUnit(g, picked)
        if(DynamicCreateGroupCond(picked,p)) then
            call GroupAddUnit(g2, picked)
        endif
        set picked = null
    endloop
    call DestroyGroup(g)
    set g = null
    return g2
endfunction


//==========================================================================
// Dynamic Create Group2  (GroupCheck)        Lastest (04/11/60)
//==========================================================================

function DynamicCreateGroup2 takes location loc, real area, player p, group gcheck returns group
    local unit picked
    local group g2 = CreateGroup()
    local group g = GetUnitsInRangeOfLocAll(area, loc)
    loop
        set picked = FirstOfGroup(g)
        exitwhen picked==null
        call GroupRemoveUnit(g, picked)
        if(DynamicCreateGroupCond(picked,p) and IsUnitInGroup(picked, gcheck)==false) then
          call GroupAddUnit(g2, picked)
        endif
        set picked = null
    endloop
    call DestroyGroup(g)
    set g = null
    return g2
endfunction




//==========================================================================
// CreateGroupXY             Lastest (09/12/60)
//==========================================================================

function CreateGroupXY takes real x, real y, real area, player p returns group
    local group g = CreateGroup()
    local group g2 = CreateGroup()
    local unit picked
    
    call GroupEnumUnitsInRange(g, x, y, area, null)
    loop
        set picked = FirstOfGroup(g)
        exitwhen picked==null
        call GroupRemoveUnit(g, picked)
        if(DynamicCreateGroupCond(picked,p)) then
            call GroupAddUnit(g2, picked)
        endif
        set picked = null
    endloop
    call DestroyGroup(g)
    set g = null
    return g2
endfunction


function CreateGroupXY2 takes real x, real y, real area, player p, group g_check returns group
    local group g = CreateGroup()
    local group g2 = CreateGroup()
    local unit picked
    
    call GroupEnumUnitsInRange(g, x, y, area, null)
    loop
        set picked = FirstOfGroup(g)
        exitwhen picked==null
        call GroupRemoveUnit(g, picked)
        if(DynamicCreateGroupCond(picked,p) and IsUnitInGroup(picked, g_check)==false) then
            call GroupAddUnit(g2, picked)
        endif
        set picked = null
    endloop
    call DestroyGroup(g)
    set g = null
    return g2
endfunction


//==========================================================================
// CreateGroupXYnWW             Lastest (23/11/62)
//==========================================================================

function CreateGroupXYnWW takes real x, real y, real area, player p returns group
    local group g = CreateGroup()
    local group g2 = CreateGroup()
    local unit picked
    
    call GroupEnumUnitsInRange(g, x, y, area, null)
    loop
        set picked = FirstOfGroup(g)
        exitwhen (picked == null)
        call GroupRemoveUnit(g, picked)
        if (DynamicCreateGroupCond(picked, p) and IsUnitVisible(picked, p)) then
            call GroupAddUnit(g2, picked)
        endif
        set picked = null
    endloop
    call DestroyGroup(g)
    set g = null
    return g2
endfunction


//==========================================================================
// GetUnitNearestXY          Lastest (16/02/63)
//==========================================================================

function GetUnitNearestXY takes real x, real y, real area, player p returns unit
    local group g = CreateGroup()
    local group g2 = CreateGroup()
    local unit picked
    local unit nearestUnit
    local real nearestReal
    local real r

    call GroupEnumUnitsInRange(g, x, y, area, null)
    loop
        set picked = FirstOfGroup(g)
        exitwhen (picked == null)
        call GroupRemoveUnit(g, picked)
        if (DynamicCreateGroupCond(picked,p)) then
            call GroupAddUnit(g2, picked)
        endif
    endloop
    call DestroyGroup(g)
    set g = null

    set nearestUnit = FirstOfGroup(g2)
    if (nearestUnit != null) then
        call GroupRemoveUnit(g2, nearestUnit)
        set nearestReal = DistanceBetweenXY(x, y, GetUnitX(nearestUnit), GetUnitY(nearestUnit))
        loop
            set picked = FirstOfGroup(g2)
            exitwhen (picked == null)
            call GroupRemoveUnit(g2, picked)
            set r = DistanceBetweenXY(x, y, GetUnitX(picked), GetUnitY(picked))
            if (nearestReal > r) then
                set nearestUnit = picked
                set nearestReal = r
            endif
        endloop
    endif
    call DestroyGroup(g2)
    set g2 = null
    return nearestUnit
endfunction


//==========================================================================
// GroupRandomUnit             Lastest (17/05/60)
//==========================================================================

function GroupRandomUnit takes group g returns unit
    local unit u
    local unit array picked
    local integer i
    local integer slot = 0
    local group g2 = CreateGroup()
    call GroupAddGroup( g, g2 )
    loop
        set picked[slot] = FirstOfGroup(g2)
        exitwhen picked[slot]==null
        call GroupRemoveUnit(g2, picked[slot])
        set slot = slot+1
    endloop
    call DestroyGroup(g2)
    set g2 = null
    if(slot>0) then
    set slot = slot-1
    set u = picked[(GetRandomInt(0,slot))]
    set i = 0
    loop
        set picked[i] = null
        set i = i+1
        exitwhen i>slot
    endloop
    else
        set u = null
    endif
    set i = 0
    set slot = 0
    return u
endfunction




//==========================================================================
// Set Unit Fly             Lastest (08/05/60)
//==========================================================================

function SetUnitFly takes unit u returns nothing 
    call UnitAddAbility(u, udg_GlobalSkill[1])
    call UnitMakeAbilityPermanent(u, true, udg_GlobalSkill[1])
    call UnitRemoveAbility(u, udg_GlobalSkill[1])
endfunction




//==========================================================================
// Dynamic Pause             Lastest (11/04/60)
//==========================================================================

function PauseSystem takes unit u, boolean b returns nothing
    local integer handle_id = GetHandleId(u)
    local integer stack
    if(b) then
        set stack = LoadInteger(udg_Pause_Hash, handle_id, 0) + 1
    else
        set stack = LoadInteger(udg_Pause_Hash, handle_id, 0) - 1
    endif
    if(stack > 0) then
        call SaveInteger( udg_Pause_Hash, handle_id, 0, stack )
        call PauseUnit(u, true)
    else
        call FlushChildHashtable(udg_Pause_Hash, handle_id)
        call PauseUnit(u, false)
    endif
    set u = null
    set handle_id = 0
    set stack = 0
    set b = false
endfunction




//==========================================================================
// Destroy Tree           Lastest (10/04/60)
//==========================================================================

function TreeKiller takes nothing returns nothing
    call KillDestructable( GetEnumDestructable() )
endfunction




//==========================================================================
// DestroyTreeXY             Lastest (10/12/60)
//==========================================================================

function DestroyTreeXY takes real centerX, real centerY,real radius returns nothing
    local rect r
    local location loc = Location(centerX, centerY)

    set bj_enumDestructableCenter = loc
    set bj_enumDestructableRadius = radius
    set r = Rect(centerX - radius, centerY - radius, centerX + radius, centerY + radius)
    call EnumDestructablesInRect(r, filterEnumDestructablesInCircleBJ, function TreeKiller)
    call RemoveLocation(loc)
    set loc = null
    call RemoveRect(r)
    set r = null
endfunction




//==========================================================================
// Transform Group Conditions           Lastest (10/04/60)
//==========================================================================

function TransformGroup_Cond takes unit u, unit dummy returns boolean
    if( not( IsUnitEnemy(dummy, GetOwningPlayer(u)) ) ) then
        return false
    elseif( GetUnitAbilityLevelSwapped(udg_GlobalSkill[0], dummy) != 0 ) then
        return false
    elseif( not( IsUnitAliveBJ(dummy) ) ) then
        return false
    elseif( IsUnitPausedBJ(dummy) ) then
        return false
    endif
    return true
endfunction




//==========================================================================
// TransfromAction             Lastest (08/12/60)
//==========================================================================

function TransfromAction takes unit u, real x, real y returns nothing
    local real array xy
    local real facing
    local unit picked
    local player p = GetOwningPlayer(u)
    local group g = CreateGroupXY(x, y, udg_TransformArea, p)

    call DestroyTreeXY(x, y, udg_TransformArea)
    loop
        set picked = FirstOfGroup(g)
        exitwhen picked==null
        call GroupRemoveUnit(g, picked)
        if(TransformGroup_Cond(u, picked)) then
            set xy[0] = GetUnitX(picked)
            set xy[1] = GetUnitY(picked)
            set facing = AngleBetweenXY(x, y, xy[0], xy[1])
            set xy[0] = PolarX(xy[0], udg_TransformBackstab, facing)
            set xy[1] = PolarY(xy[1], udg_TransformBackstab, facing)
            call UnitMoveXY(picked, xy[0], xy[1])
            set bj_lastCreatedUnit = CreateUnit( p, 'h017', xy[0], xy[1], facing )
            call UnitApplyTimedLife(bj_lastCreatedUnit, 1112820806, 1.00)
            call IssueImmediateOrder( picked, "stop" )
        endif
        set picked = null
    endloop
    call DestroyGroup(g)
    set g = null
    set p = null
endfunction




//==========================================================================
// Force Display         Lastest (16/03/60)
//==========================================================================

function All_PlayerCond takes nothing returns boolean
    return ( GetPlayerSlotState(GetFilterPlayer()) == PLAYER_SLOT_STATE_PLAYING )
endfunction

function Force_Display takes real t, string s returns nothing
    local force Foc = GetPlayersMatching(Condition(function All_PlayerCond))
    call DisplayTimedTextToForce( Foc, t, s )
    call DestroyForce(Foc)
    set Foc = null
    set s = null
endfunction




//==========================================================================
// GroupCountUnits              Lastest (23/03/60)
//==========================================================================

function GroupCountUnits takes group G returns integer
    local group g = CreateGroup()
    local unit Dummy
    local integer i = 0
    call GroupAddGroup(G,g)
    loop
        set Dummy = FirstOfGroup(g)
        exitwhen Dummy == null
        set i = i + 1
        call GroupRemoveUnit(g, Dummy)
        set Dummy = null
    endloop
    call DestroyGroup(g)
    set g = null
    return i
endfunction




//==========================================================================
// Golem Check              Lastest (24/03/60)
//==========================================================================

function Golem_Check takes unit U returns boolean
    local integer i = 0
    loop
        if(GetUnitTypeId(U) == udg_Golem_BossType[i]) then
            set U = null
            return true
        endif
        set i = i + 1
        exitwhen i > 10
    endloop
    set U = null
    return false
endfunction




//==========================================================================
// Scept Upgrade Check              Lastest (26/03/60)
//==========================================================================

function Scept_UpgradeCheck takes nothing returns boolean
    if( GetItemTypeId(GetManipulatedItem()) == 'I05F' ) then
        return true
    elseif( GetItemTypeId(GetManipulatedItem()) == 'I05L' ) then
        return true
    elseif( GetItemTypeId(GetManipulatedItem()) == 'I05P' ) then
        return true
    else
        return false
    endif
endfunction

function Scept_AlreadyCheck takes unit u returns boolean
    if(GetUnitAbilityLevel(u, 'A00D')>0) then
        return false
    elseif(GetUnitAbilityLevel(u, 'A0GE')>0) then
        return false
    else
        return true
    endif
endfunction




//==========================================================================
// Preload Sound          Lastest (21/04/60)
//==========================================================================
//Credit http://www.wc3jass.com

function DoSoundPreload takes string path returns nothing
    local sound s = CreateSound(path, false, false, false, 10, 10, "")
    
    call SetSoundVolume(s, 0)
    call StartSound(s)
    call KillSoundWhenDone(s)
    set s = null
    set path = null
endfunction




//==========================================================================
// Dynamic Sound           Lastest (21/03/60)
//==========================================================================

function Dynamic_Sound takes string s returns nothing
    local sound MySound = CreateSound(s, false, false, false, 10, 10, "")

    //call SetSoundDuration(MySound, 3000)
    call SetSoundChannel(MySound, 0)
    call SetSoundVolume(MySound, udg_Sound_Volume)
    call SetSoundPitch(MySound, 1.0)
    call StartSound(MySound)
    call KillSoundWhenDone(MySound)
    
    set MySound = null
    set s = null
endfunction



//==========================================================================
// Alert      Lastest (19/01/61)
//==========================================================================

function Alert takes player p, string msg returns nothing
    local string s = ""
    local force f

    if( GetLocalPlayer() == p ) then
        set s = "Sound\\Interface\\UpkeepRing.wav"
    endif
    call Dynamic_Sound(s)

    set f = GetForceOfPlayer(p)
    call DisplayTimedTextToForce( f, 3.00, msg )
    call DestroyForce(f)
    set f = null

    set s = null
    set msg = null
endfunction




//==========================================================================
// Player Check              Lastest (25/03/60)
//==========================================================================

function Player_Check takes unit U, integer i, integer j returns boolean
    local player P = GetOwningPlayer(U)
    set U = null
    if(GetPlayerController(P) != MAP_CONTROL_COMPUTER) then
        set P = null
        return false
    endif
    loop
        if(P == Player(i)) then
            set P = null
            return true
        endif
        set i = i + 1
        exitwhen i > j
    endloop
    set P = null
    return false
endfunction

function Hero_Check takes unit U, integer i, integer j returns boolean
    loop
        if(U == udg_Player_UnitHero[i]) then
            set U = null
            return true
        endif
        set i = i + 1
        exitwhen i > j
    endloop
    set U = null
    return false
endfunction


//==========================================================================
// Add gold to player         Lastest (16/03/60)
//==========================================================================

// Relation Trigger : Board Update
// Global Variable(s) : Gold_Rate

function AddGold_Cond takes nothing returns boolean
    return ( GetPlayerSlotState(GetFilterPlayer()) == PLAYER_SLOT_STATE_PLAYING )
endfunction

function AddGold_Act takes nothing returns nothing
    call AdjustPlayerStateBJ( udg_Gold_Rate, GetEnumPlayer(), PLAYER_STATE_RESOURCE_GOLD )
endfunction

function AddGold takes nothing returns nothing
    local force AG = GetPlayersMatching(Condition(function AddGold_Cond))
    call ForForce( AG, function AddGold_Act )
    call DestroyForce(AG)
    set AG = null
endfunction




//==========================================================================
// Random Hero         Lastest (18/03/60)
//==========================================================================

// Relation Trigger : Initalization3
// Global Variable(s) : 

function Player_RandomHeroCheck takes integer Rand_Slot returns boolean
    return (udg_Player_HeroType[Rand_Slot] != 0)
endfunction

function Player_RandomGet takes integer Rand_Slot, integer Player_Slot returns nothing
    local location Loc = GetRandomLocInRect(gg_rct_HeroSelection)
    call CreateNUnitsAtLoc( 1, udg_Player_DummyType[Rand_Slot], Player(Player_Slot), Loc, bj_UNIT_FACING )
    call RemoveLocation(Loc)
    set Loc = null
endfunction

function Player_HideUnit takes integer Player_Type returns nothing
    local integer Player_Loop = 0
    loop
        exitwhen Player_Loop > 11
        call SetPlayerUnitAvailableBJ( Player_Type, false, Player(Player_Loop) )
        set Player_Loop = Player_Loop + 1
    endloop
    set Player_Loop = 0
    set Player_Type = 0
endfunction

function Player_ShowUnit takes player Player_Unit returns nothing
    local integer Player_Loop = 0
    loop
        exitwhen Player_Loop > udg_Player_MaxHeroes
        if(udg_Player_HeroType[Player_Loop] != 0) then
            call SetPlayerUnitAvailableBJ( udg_Player_HeroType[Player_Loop], true, Player_Unit )
        endif
        set Player_Loop = Player_Loop + 1
    endloop
    set Player_Loop = 0
    set Player_Unit = null
endfunction

function Random_Act takes integer Player_Slot returns nothing
    local integer Loop = 0
    local integer Loop2 = 0
    local integer Rand_Slot
    local boolean Player_Get = true
    set udg_Player_Random[Player_Slot] = false
    loop
        set Rand_Slot = GetRandomInt(0, udg_Player_MaxHeroes)
        if( Player_RandomHeroCheck(Rand_Slot) ) then
            set udg_Player_HeroType[Rand_Slot] = 0
            call Player_HideUnit(udg_Player_DummyType[Rand_Slot])
            call Player_RandomGet(Rand_Slot, Player_Slot)
            set Player_Get = false
        else
            set Loop = Loop + 1
            if(Loop > 30) then
                loop
                    if( Player_RandomHeroCheck(Loop2) ) then
                        set udg_Player_HeroType[Loop2] = 0
                        call Player_HideUnit(udg_Player_DummyType[Rand_Slot])
                        call Player_RandomGet(Loop2, Player_Slot)
                        set Loop2 = udg_Player_MaxHeroes
                    endif
                    set Loop2 = Loop2 + 1
                    exitwhen Loop2 > udg_Player_MaxHeroes
                endloop
                set Player_Get = false
            endif
        endif
        exitwhen Player_Get == false
    endloop
    set Player_Slot = 0
    set Loop = 0
    set Loop2 = 0
    set Rand_Slot = 0
endfunction




//==========================================================================
// Text Display System          Lastest (15/03/60)
//==========================================================================

function DisplayText takes string T, unit U, real Size, boolean Move, integer r, integer g, integer b, integer a returns nothing
    local texttag tt = CreateTextTag()
    call SetTextTagText(tt,T,Size)
    call SetTextTagPosUnit(tt,U,0)
    call SetTextTagColor(tt,r,g,b,a)
    if(Move) then
        call SetTextTagVelocity(tt,0,0.055)
    endif
    call SetTextTagFadepoint(tt,2)
    call SetTextTagPermanent(tt,false)
    call SetTextTagLifespan(tt,2.00)
    call SetTextTagVisibility(tt,true)
    set tt=null
endfunction




//==========================================================================
// Camera Shake System         Lastest (15/03/60)
//==========================================================================

// Relation Trigger : StopShake
// Global Variable(s) : ShakeTimer

function CameraShake takes real DuringTime, real ShakePower, unit U returns nothing
    local integer Slot = (GetConvertedPlayerId(GetOwningPlayer(U)) - 1)
    call CameraSetEQNoiseForPlayer( Player(Slot), ShakePower )
    if(Slot == 0) then
        call StartTimerBJ( udg_ShakeTimer1, false, DuringTime )
    elseif(Slot == 1) then
        call StartTimerBJ( udg_ShakeTimer2, false, DuringTime )
    elseif(Slot == 2) then
        call StartTimerBJ( udg_ShakeTimer3, false, DuringTime )
    elseif(Slot == 3) then
        call StartTimerBJ( udg_ShakeTimer4, false, DuringTime )
    elseif(Slot == 4) then
        call StartTimerBJ( udg_ShakeTimer5, false, DuringTime )
    elseif(Slot == 5) then
        call StartTimerBJ( udg_ShakeTimer6, false, DuringTime )
    elseif(Slot == 6) then
        call StartTimerBJ( udg_ShakeTimer7, false, DuringTime )
    elseif(Slot == 7) then
        call StartTimerBJ( udg_ShakeTimer8, false, DuringTime )
    elseif(Slot == 8) then
        call StartTimerBJ( udg_ShakeTimer9, false, DuringTime )
    elseif(Slot == 9) then
        call StartTimerBJ( udg_ShakeTimer10, false, DuringTime )
    elseif(Slot == 10) then
        call StartTimerBJ( udg_ShakeTimer11, false, DuringTime )
    else
        call StartTimerBJ( udg_ShakeTimer12, false, DuringTime )
    endif
    set U = null
    set Slot = 0
endfunction




//==========================================================================
// Dynamic Group Shake System         Lastest (02/04/60)
//==========================================================================

// Relation Function : CameraShake

function Dynamic_GroupShakeCond takes nothing returns boolean
    if( GetPlayerController(GetOwningPlayer(GetFilterUnit())) != MAP_CONTROL_USER ) then
        return false
    elseif( IsUnitAliveBJ(GetFilterUnit()) == false ) then
        return false
    elseif( IsUnitType(GetFilterUnit(), UNIT_TYPE_MECHANICAL) == true ) then
        return false
    endif
    return true
endfunction

function Dynamic_GroupShake takes real x, real y, real time, real power, real area, group gcheck returns nothing
    local unit dummy
    local group g = CreateGroup()

    call GroupEnumUnitsInRange(g, x, y, area, Condition(function Dynamic_GroupShakeCond))
    loop
        set dummy = FirstOfGroup(g)
        exitwhen dummy == null
        if(gcheck!=null) then
            if(IsUnitInGroup(dummy, gcheck)==false) then
                call GroupAddUnit( gcheck, dummy )
                call CameraShake(time, power, dummy)
            endif        
        else
            call CameraShake(time, power, dummy)
        endif
        call GroupRemoveUnit(g, dummy)
        set dummy = null
    endloop
    call DestroyGroup(g)
    set g = null
endfunction




//==========================================================================
// Duel Count         Lastest (20/03/60)
//==========================================================================

function Duel_CountCheck takes integer i returns boolean
    return udg_Player_UnitHero[i] != null
endfunction

function Duel_Count takes nothing returns integer
    local integer Loop = 0
    local integer Duel_Count1 = 0
    local integer Duel_Count2 = 0
    call GroupClear( udg_Duel_Team1 )
    call GroupClear( udg_Duel_Team2 )
    loop
        if(Duel_CountCheck(Loop)) then
            call GroupAddUnitSimple( udg_Player_UnitHero[Loop], udg_Duel_Team1 )
            set Duel_Count1 = Duel_Count1 + 1
        endif
        set Loop = Loop + 1
        exitwhen Loop > 5
    endloop
    loop
        if(Duel_CountCheck(Loop)) then
            call GroupAddUnitSimple( udg_Player_UnitHero[Loop], udg_Duel_Team2 )
            set Duel_Count2 = Duel_Count2 + 1
        endif
        set Loop = Loop + 1
        exitwhen Loop > 11
    endloop
    if(Duel_Count1 > Duel_Count2) then
        return Duel_Count2
    elseif(Duel_Count1 < Duel_Count2) then
        return Duel_Count1
    else
        return Duel_Count1
    endif
endfunction





//==========================================================================
// Duel Destroy         Lastest (21/03/60)
//==========================================================================

function Duel_DestroyCheck takes nothing returns boolean
    return (udg_GameModeNd == false) and (Duel_Count() > 0)
endfunction

function Duel_Destroy takes nothing returns nothing
    if( Duel_DestroyCheck() ) then
        call StartTimerBJ( udg_Timer_Duel, false, udg_Duel_Time )
        call StartTimerBJ( udg_Timer_DuelWarning, false, (udg_Duel_Time-10) )
        call CreateTimerDialogBJ( udg_Timer_Duel, "Next Event" )
        set udg_Game_TimerWindow = bj_lastCreatedTimerDialog
        call TimerDialogSetTitleColorBJ(udg_Game_TimerWindow, 30.00, 80.00, 90.00, 0)
        call TimerDialogSetTimeColorBJ(udg_Game_TimerWindow, 30.00, 80.00, 90.00, 0)
    else
        call DestroyTrigger(gg_trg_Duel)
        set gg_trg_Duel = null
        call DestroyTrigger(gg_trg_Duel_Invul)
        set gg_trg_Duel_Invul = null
        call DestroyTrigger(gg_trg_Duel_Vul)
        set gg_trg_Duel_Vul = null
        call DestroyTrigger(gg_trg_Duel_Kill)
        set gg_trg_Duel_Kill = null
        call DestroyTrigger(gg_trg_Duel_OverTime)
        set gg_trg_Duel_OverTime = null
        call DestroyTrigger(gg_trg_Duel_Move)
        set gg_trg_Duel_Move = null
        call DestroyTimer(udg_Timer_Duel)
        set udg_Timer_Duel = null
                if(udg_Timer_DuelReal != null) then
            call DestroyTimer(udg_Timer_DuelReal)
            set udg_Timer_DuelReal = null
                endif
                if(gg_trg_First_Blood != null) then
                    call DestroyTrigger(gg_trg_First_Blood)
                    set gg_trg_First_Blood = null
                endif
    endif
    call GroupClear( udg_Duel_Team1 )
    call GroupClear( udg_Duel_Team2 )
endfunction



//==========================================================================
// Duel Cancel         Lastest (20/03/60)
//==========================================================================

function Duel_Cancel takes nothing returns nothing
    local force Foc = GetPlayersMatching(Condition(function All_PlayerCond))
    call CinematicModeBJ( true, Foc )
    call DestroyForce(Foc)
    set Foc = null
    set udg_Duel_On = false
    if(IsTriggerEnabled(gg_trg_AI_Duel) == true) then
        call DisableTrigger( gg_trg_AI_Duel)
    endif
    if(IsTriggerEnabled(gg_trg_Duel_Kill) == true) then
        call DisableTrigger( gg_trg_Duel_Kill )
    endif
    if(IsTriggerEnabled(gg_trg_Duel_OverTime) == true) then
        call DisableTrigger( gg_trg_Duel_OverTime )
    endif
    set udg_Duel_OverTime = false
    call Dynamic_Sound("Sound\\Interface\\GoodJob.wav")
    call DestroyTimerDialogBJ( udg_Game_TimerWindow )
    call TriggerExecute( gg_trg_Duel_Move )
endfunction

function Duel_Draw takes nothing returns integer
    local integer Count1 = CountUnitsInGroup(udg_Duel_DummyTeam1)
    local integer Count2 = CountUnitsInGroup(udg_Duel_DummyTeam2)
    if(Count1 > Count2) then
        return 2
    elseif(Count2 > Count1) then
        return 1
    else
        return 3
    endif
endfunction

function Duel_Reward takes integer i returns nothing
    local integer StartLoop
    local integer EndLoop
    local integer Gold = 1000
    local integer Medal = 3
    local integer Exp = 250

    local force Foc = GetPlayersMatching(Condition(function All_PlayerCond))
    if(i == 1) then
        call DisplayTextToForce( Foc, "Winner: |c001E90FFTeam 2|r" )
        call DisplayTextToForce( Foc, "+1000 gold, +3 medal, +250 exp" )
        set StartLoop = 6
        set EndLoop = 11
    elseif(i == 2) then
        call DisplayTextToForce( Foc, "Winner: |c00ff0000Team 1|r" )
        call DisplayTextToForce( Foc, "+1000 gold, +3 medal, +250 exp" )
        set StartLoop = 0
        set EndLoop = 5     
    else
        call DisplayTextToForce( Foc, "|c00FFD700Draw|r" )
        call DisplayTextToForce( Foc, "+500 gold and +1 medal" )
        set Gold = 500
        set Medal = 1
        set Exp = 0
        set StartLoop = 0
        set EndLoop = 11
    endif
    call DestroyForce(Foc)
    set Foc = null
    loop
        call AdjustPlayerStateBJ( Gold, Player(StartLoop), PLAYER_STATE_RESOURCE_GOLD )
        call AdjustPlayerStateBJ( Medal, Player(StartLoop), PLAYER_STATE_RESOURCE_LUMBER )
        if(IsUnitAliveBJ(udg_Player_UnitHero[StartLoop]) == true) then
            call AddHeroXPSwapped( Exp, udg_Player_UnitHero[StartLoop], true )
        endif
        call SetUnitAnimation( udg_Player_UnitHero[StartLoop], "stand" ) 
        set StartLoop = StartLoop + 1
        exitwhen StartLoop > EndLoop
    endloop
endfunction

function Duel_CancelCheck1 takes nothing returns boolean
    if(IsUnitGroupEmptyBJ(udg_Duel_Team1) == true) and (IsUnitGroupEmptyBJ(udg_Duel_Team2) == true) then
        call Duel_Cancel()
        call Duel_Reward(3)
        return true
    elseif(IsUnitGroupEmptyBJ(udg_Duel_Team1) == true) then
        call Duel_Cancel()
        call Duel_Reward(1)
        return true
    elseif(IsUnitGroupEmptyBJ(udg_Duel_Team2) == true) then
        call Duel_Cancel()
        call Duel_Reward(2)
        return true
    endif
        return false
endfunction

function Duel_CancelCheck2 takes nothing returns boolean
    if(udg_Duel_OverTime) then
        call Duel_Cancel()
        call Duel_Reward((Duel_Draw()))
        return true
    elseif(IsUnitGroupEmptyBJ(udg_Duel_DummyTeam1) == true) and (IsUnitGroupEmptyBJ(udg_Duel_DummyTeam2) == true) then
        call Duel_Cancel()
        call Duel_Reward(3)
        return true
    elseif(IsUnitGroupEmptyBJ(udg_Duel_DummyTeam1) == true) then
        call Duel_Cancel()
        call Duel_Reward(1)
        return true
    elseif(IsUnitGroupEmptyBJ(udg_Duel_DummyTeam2) == true) then
        call Duel_Cancel()
        call Duel_Reward(2)
        return true
    endif
        return false
endfunction




//==========================================================================
// Duel Summon Warp           Lastest (20/03/60)
//==========================================================================

function Duel_SummonWarp takes unit U, real R returns nothing
    local player P = GetOwningPlayer(U)
    local group G = GetUnitsOfPlayerAll(P)
    local location Loc = GetUnitLoc(U)
    local unit Dummy
    call GroupRemoveUnitSimple( U, G )
    loop
        set Dummy = FirstOfGroup(G)
        exitwhen Dummy == null
        if(IsUnitType(Dummy, UNIT_TYPE_MECHANICAL) == false) then
            call SetUnitPositionLocFacingBJ( Dummy, Loc, R )
            call CreateNUnitsAtLoc( 1, 'h004', P, Loc, bj_UNIT_FACING )
            call UnitApplyTimedLifeBJ( 1.50, 'BTLF', GetLastCreatedUnit() )
        endif
        call GroupRemoveUnit(G, Dummy)
        set Dummy = null
    endloop
    call RemoveLocation(Loc)
    set Loc = null
    call DestroyGroup(G)
    set G = null
    set U = null
    set P = null
    set R = 0.00
endfunction




//==========================================================================
// Map Vulnerable           Lastest (20/03/60)
//==========================================================================

function Map_Vul_GroupAct takes nothing returns nothing
    local unit U = GetEnumUnit()
    if(IsUnitInGroup(U, udg_Leave_Group) == false and IsUnitType(U, UNIT_TYPE_MECHANICAL)==false) then
        call SetUnitInvulnerable( U, false )
        call PauseUnitBJ( false, U )
    endif
    set U = null
endfunction

function Map_Vul takes nothing returns nothing
    local group array G
    local integer Loop = 0
    loop
        set G[Loop] = GetUnitsOfPlayerAll(Player(Loop))
        call ForGroupBJ( G[Loop], function Map_Vul_GroupAct )
        call DestroyGroup(G[Loop])
        set G[Loop] = null
        set Loop = Loop + 1
        exitwhen Loop > 11
    endloop
endfunction



//==========================================================================
// Map Kill Summon           Lastest (20/03/60)
//==========================================================================

function Map_Kill_SummonGroupAct takes nothing returns nothing
    local unit U = GetEnumUnit()
    if(IsUnitType(U, UNIT_TYPE_MECHANICAL) == false) then
        call KillUnit(U)
    endif
    set U = null
endfunction

function Map_Kill_Summon takes unit U returns nothing
    local group G = GetUnitsOfPlayerAll(GetOwningPlayer(U))
    call GroupRemoveUnitSimple( U, G )
    call ForGroupBJ( G, function Map_Kill_SummonGroupAct )
    call DestroyGroup(G)
    set G = null
    set U = null
endfunction




//==========================================================================
// End Game           Lastest (22/03/60)
//==========================================================================

function End_ClearTrigger takes nothing returns nothing
    // Clear Duel
    set udg_Duel_On = false
    set udg_GameModeNd = true
    call Duel_Destroy()
    call DestroyTimerDialogBJ( udg_Game_TimerWindow )
    set udg_Game_TimerWindow = null
    
    // Clear AI
    set udg_AI_Run = false

    // Clear Trigger
    call DestroyTrigger(gg_trg_Leavegame)
    set gg_trg_Leavegame = null
    call DestroyTrigger(gg_trg_Remove_Unit)
    set gg_trg_Remove_Unit = null
    call DestroyTrigger(gg_trg_Spawn_Creep)
    set gg_trg_Spawn_Creep = null

    call FogEnableOff(  )
    call FogMaskEnableOff(  )

endfunction

function End_Invul_GroupAct takes nothing returns nothing
    local unit U = GetEnumUnit()
    call SetUnitInvulnerable( U, true )
    call PauseUnitBJ( true, U )
    set U = null
endfunction

function End_Invul_Actions takes nothing returns nothing
    local group array G
    local integer Loop = 0
    loop
        set G[Loop] = GetUnitsOfPlayerAll(Player(Loop))
        call ForGroupBJ( G[Loop], function End_Invul_GroupAct )
        call DestroyGroup(G[Loop])
        set G[Loop] = null
        set Loop = Loop + 1
        exitwhen Loop > 11
    endloop
endfunction

function End_GameRun takes integer i returns nothing
    local force Foc
    local rect R
    local rect RWin
    local rect RLose
    local real FaceWin
    local real FaceLose
    local integer Loop
    local integer WinLoop1
    local integer WinLoop2
    local integer LoseLoop1
    local integer LoseLoop2
    local location Loc
    local unit DummyEnd

    call DialogSetMessageBJ( udg_End_DialogWin, "Victory !" )
    call DialogSetMessageBJ( udg_End_DialogLose, "Defeat !" )
    call DialogAddButtonBJ( udg_End_DialogWin, "Continue" )
    call DialogAddButtonBJ( udg_End_DialogLose, "Continue" )

    set udg_Eng_Game = true
    call End_ClearTrigger()
    call FogEnableOff()
    call FogMaskEnableOff()

    set Foc = GetPlayersMatching(Condition(function All_PlayerCond))
    call CinematicModeBJ( true, Foc )
    call DisplayTextToForce(Foc,"|cffff0000LOADING RESULT....|r")
    call DestroyForce(Foc)
    set Foc = null
    call StopMusic(false)
    call VolumeGroupSetVolumeBJ( SOUND_VOLUMEGROUP_MUSIC, 0.00 )
    set udg_Sound_Volume = 150
    call Dynamic_Sound("Sound\\Interface\\ClanInvitation.wav")
    call End_Invul_Actions()
    call TriggerSleepAction(4.00)
    
    // Destroy Revive
    call DestroyTrigger(gg_trg_Revive)
    set gg_trg_Revive = null
    call End_Invul_Actions()
    if(i == 1) then
        set WinLoop1 = 0
        set WinLoop2 = 5
        set LoseLoop1 = 6
        set LoseLoop2 = 11
    else
        set WinLoop1 = 6
        set WinLoop2 = 11
        set LoseLoop1 = 0
        set LoseLoop2 = 5
    endif
    set RWin = Rect(160, -6976, 544, -6144)
    set RLose = Rect(928, -7040, 1376, -6400)
    set FaceWin = 360
    set FaceLose = 180

    // Team Win
    loop
        if((IsUnitAliveBJ(udg_Player_UnitHero[WinLoop1]) != null) and (IsUnitAliveBJ(udg_Player_UnitHero[WinLoop1]) == false)) then
            call TriggerSleepAction(0.10)
        else
            call SetUnitLifePercentBJ( udg_Player_UnitHero[WinLoop1], 100 )
            call SetUnitManaPercentBJ( udg_Player_UnitHero[WinLoop1], 0 )
            call UnitRemoveAbility(udg_Player_UnitHero[WinLoop1], 'Aatk')
            call PauseUnit(udg_Player_UnitHero[WinLoop1], true)
            call UnitAddAbilityBJ( 'A07R', udg_Player_UnitHero[WinLoop1] )
            call UnitAddAbilityBJ( 'A07S', udg_Player_UnitHero[WinLoop1] )
            set Loc = GetRandomLocInRect(RWin)
            call SetUnitPositionLocFacingBJ( udg_Player_UnitHero[WinLoop1], Loc, FaceWin )
            call RemoveLocation(Loc)
            set Loc = null
            call IssueImmediateOrder( udg_Player_UnitHero[WinLoop1], "holdposition" )
            call SetUnitAnimation( udg_Player_UnitHero[WinLoop1], "stand" )
            call UnitRemoveBuffsBJ( bj_REMOVEBUFFS_NEGATIVE, udg_Player_UnitHero[WinLoop1] )
            call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Human\\MassTeleport\\MassTeleportCaster.mdl", udg_Player_UnitHero[WinLoop1],"origin"))
            call Duel_SummonWarp(udg_Player_UnitHero[WinLoop1], FaceWin)
            set WinLoop1 = WinLoop1 + 1
        endif
        exitwhen WinLoop1 > WinLoop2
    endloop
    
    // Team Lose
    loop
        if((IsUnitAliveBJ(udg_Player_UnitHero[LoseLoop1]) != null) and (IsUnitAliveBJ(udg_Player_UnitHero[LoseLoop1]) == false)) then
            call TriggerSleepAction(0.10)
        else
            call GroupAddUnitSimple( udg_Player_UnitHero[LoseLoop1], udg_End_Group )
            call SetUnitLifePercentBJ( udg_Player_UnitHero[LoseLoop1], 100 )
            call SetUnitManaPercentBJ( udg_Player_UnitHero[LoseLoop1], 0 )
            call UnitRemoveAbility(udg_Player_UnitHero[LoseLoop1], 'Aatk')
            call PauseUnit(udg_Player_UnitHero[LoseLoop1], true)
            call UnitAddAbilityBJ( 'A07R', udg_Player_UnitHero[LoseLoop1] )
            call UnitAddAbilityBJ( 'A07S', udg_Player_UnitHero[LoseLoop1] )
            set Loc = GetRandomLocInRect(RLose)
            call SetUnitPositionLocFacingBJ( udg_Player_UnitHero[LoseLoop1], Loc, FaceLose )
            call RemoveLocation(Loc)
            set Loc = null
            call IssueImmediateOrder( udg_Player_UnitHero[LoseLoop1], "holdposition" )
            call SetUnitAnimation( udg_Player_UnitHero[LoseLoop1], "stand" )
            call UnitRemoveBuffsBJ( bj_REMOVEBUFFS_NEGATIVE, udg_Player_UnitHero[LoseLoop1] )
            call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Human\\MassTeleport\\MassTeleportCaster.mdl", udg_Player_UnitHero[LoseLoop1],"origin"))
            call Duel_SummonWarp(udg_Player_UnitHero[LoseLoop1], FaceLose)
            set LoseLoop1 = LoseLoop1 + 1
        endif
        exitwhen LoseLoop1 > LoseLoop2
    endloop
    call RemoveRect(RWin)
    set RWin = null
    call RemoveRect(RLose)
    set RLose = null

    set Loop = 0
    set R = Rect(-352, -7520, 1888, -5696)
    set Loc =  GetRectCenter(R)
    loop
        call PanCameraToTimedLocForPlayer( Player(Loop), Loc, 0 )
        set Loop = Loop + 1
        exitwhen Loop > 11
    endloop
    call RemoveRect(R)
    set R = null
    call RemoveLocation(Loc)
    set Loc = null

    call TriggerSleepAction(0.90)
    set Loc = Location(1145, -6170)
    call CreateNUnitsAtLoc( 1, 'h008', Player(PLAYER_NEUTRAL_PASSIVE), Loc, 270 )
    set DummyEnd = GetLastCreatedUnit()
    call CreateNUnitsAtLoc( 1, 'h004', Player(PLAYER_NEUTRAL_PASSIVE), Loc, bj_UNIT_FACING )
    call UnitApplyTimedLifeBJ( 1.50, 'BTLF', GetLastCreatedUnit() )
    call RemoveLocation(Loc)
    set Loc = null
    call TriggerSleepAction(1.40)
    call IssueImmediateOrderBJ( DummyEnd, "battleroar" )
    set Foc = GetPlayersMatching(Condition(function All_PlayerCond))
    call TransmissionFromUnitWithNameBJ( Foc, DummyEnd, "Thanks for playing", null, "Get the latest version from |c00FBB41Bwww.facebook.com/Wc3MapBvOvN|r", bj_TIMETYPE_ADD, 5.00, false )
    call DestroyForce(Foc)
    set Foc = null   
    call TriggerSleepAction(0.10)
    call StopMusic(false)
    call StopMusic(true)
    call TriggerSleepAction(2.50)

    call StopMusic(false)
    set udg_Sound_Volume = 160
    call Dynamic_Sound( "Sound\\Music\\mp3Music\\Credits.mp3" )



    set Loc = Location(1145, -6170)
    call CreateNUnitsAtLoc( 1, 'h004', Player(PLAYER_NEUTRAL_PASSIVE), Loc, bj_UNIT_FACING )
    call UnitApplyTimedLifeBJ( 1.50, 'BTLF', GetLastCreatedUnit() )
    call RemoveUnit(DummyEnd)
    call RemoveLocation(Loc)
    set Loc = null
    set DummyEnd = null
    call TriggerSleepAction(2.50)
    set Foc = GetPlayersMatching(Condition(function All_PlayerCond))
    call CinematicModeBJ( false, Foc )
    call DestroyForce(Foc)
    set Foc = null

    if(i == 1) then
        set WinLoop1 = 0
        set WinLoop2 = 5
        set LoseLoop1 = 6
        set LoseLoop2 = 11
    else
        set WinLoop1 = 6
        set WinLoop2 = 11
        set LoseLoop1 = 0
        set LoseLoop2 = 5
    endif
    loop
        call DialogDisplayBJ( true, udg_End_DialogWin, Player(WinLoop1) )
        set WinLoop1 = WinLoop1 + 1
        exitwhen WinLoop1 > WinLoop2
    endloop
    loop
        call DialogDisplayBJ( true, udg_End_DialogLose, Player(LoseLoop1) )
        set LoseLoop1 = LoseLoop1 + 1
        exitwhen LoseLoop1 > LoseLoop2
    endloop
endfunction

function End_Game takes nothing returns nothing
    if(udg_End_Game == false) then
        if(udg_Score_Team1 >= udg_Game_Score) then
            set udg_End_Game = true
            call End_GameRun(1)
        elseif(udg_Score_Team2 >= udg_Game_Score) then
            set udg_End_Game = true
            call End_GameRun(2)
        endif
    endif
endfunction


//==========================================================================
// Other Function
//==========================================================================


function Is_IkkakuBankai takes unit u returns boolean
    if(GetUnitTypeId(u) == 'U00M') then
        return true
    elseif(GetUnitTypeId(u) == 'U00N') then
        return true
    elseif(GetUnitTypeId(u) == 'U00O') then
        return true
    elseif(GetUnitTypeId(u) == 'U00P') then
        return true
    elseif(GetUnitTypeId(u) == 'U00Q') then
        return true
    else
        return false
    endif
endfunction



function HidanBuff takes unit u returns nothing
    set bj_lastCreatedUnit = CreateUnit(GetOwningPlayer(u), 'u003', GetUnitX(u), GetUnitY(u), bj_UNIT_FACING)
    call UnitAddAbility(bj_lastCreatedUnit, 'A0BU')
    call IssueTargetOrder(bj_lastCreatedUnit, "bloodlust", u)
    call UnitApplyTimedLife(bj_lastCreatedUnit, 1112820806, 1.00)
endfunction

function PeinSixPathSetEnable takes boolean isEnable returns nothing
    local integer i = 0
    loop
        call SetAbilityAvailable(Pein_SixPathSk[i], isEnable)
        set i = i + 1
        exitwhen(i > Pein_SixPathSkMaxIndex)
    endloop
endfunction



//==========================================================================
// DashStrike         Lastest (9/1/21)
//==========================================================================

function DashStrikeL takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer tId = GetHandleId(t)
    local integer moveCountdown = LoadInteger(DashStrikeHash, tId, DashStrikeMoveIndex)
    local unit self = LoadUnitHandle(DashStrikeHash, tId, DashStrikeSelfIndex)
    local real array x
    local real array y
    local real facing
    local real speed
    local real distan
    local boolean hasShadow
    local integer shadowAnimationIndex
    local unit shadowDummy
    local trigger callbackTrg

    if (moveCountdown < 1) then
        set callbackTrg = LoadTriggerHandle(DashStrikeHash, tId, DashStrikeCallbackTrgIndex)
        if (callbackTrg != null) then
            call Echo("DTrg : " + I2S(GetHandleId(callbackTrg)))
            call TriggerExecute(callbackTrg)
            call TriggerClearActions(callbackTrg)
            call DestroyTrigger(callbackTrg)
            set callbackTrg = null
        endif
        call FlushChildHashtable(DashStrikeHash, tId)
        call PauseTimer(t)
        call DestroyTimer(t)
        call Echo("DTimer")
    else
        set moveCountdown = moveCountdown - 1
        call SaveInteger(DashStrikeHash, tId, DashStrikeMoveIndex, moveCountdown)
        call Echo(I2S(moveCountdown))

        if (self != null) then
            set x[0] = LoadReal(DashStrikeHash, tId, DashStrikeXIndex)
            set y[0] = LoadReal(DashStrikeHash, tId, DashStrikeYIndex)
            set facing = LoadReal(DashStrikeHash, tId, DashStrikeFacingIndex)
            set speed = LoadReal(DashStrikeHash, tId, DashStrikeSpeedIndex)
            set hasShadow = LoadBoolean(DashStrikeHash, tId, DashStrikeHasShadowIndex)
            set x[1] = PolarX(x[0], speed, facing)
            set y[1] = PolarY(y[0], speed, facing)
            call SaveReal(DashStrikeHash, tId, DashStrikeXIndex, x[1])
            call SaveReal(DashStrikeHash, tId, DashStrikeYIndex, y[1])

            if (hasShadow) then
                set shadowAnimationIndex = LoadInteger(DashStrikeHash, tId, DashStrikeShadowAnimationIndex)
                set shadowDummy = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE), GetUnitTypeId(self), x[0], y[0], facing)
                call SetUnitPathing(shadowDummy, false)
                call UnitAddAbility(shadowDummy, udg_GlobalSkill[6])
                call SetUnitInvulnerable(shadowDummy, true)
                call SetUnitVertexColor(shadowDummy, 150, 150, 150, 178)
                call SetUnitTimeScale(shadowDummy, 4.00)
                if (shadowAnimationIndex > -1) then
                    call SetUnitAnimationByIndex(shadowDummy, shadowAnimationIndex)
                endif
                call SetUnitX(shadowDummy, x[0])
                call SetUnitY(shadowDummy, y[0])
                call UnitApplyTimedLife(shadowDummy, 1112820806, 0.14)
                set shadowDummy = null
            endif
            call UnitMoveXY(self, x[1], y[1])
        endif
    endif
    set self = null
    set t = null
    call Echo("-------------------------------------")
endfunction

function DashStrike takes unit self, real targetX, real targetY, real loopDelay, integer maxMove, boolean hasShadow, integer shadowAnimationIndex, trigger callbackTrg returns nothing
    local real selfX = GetUnitX(self)
    local real selfY = GetUnitY(self)
    local real distan = DistanceBetweenXY(selfX, selfY, targetX, targetY)
    local real facing = AngleBetweenXY(selfX, selfY, targetX, targetY)
    local timer t = CreateTimer()
    local integer tId = GetHandleId(t)

    if (loopDelay < 0.02) then
        set loopDelay = 0.03
    endif
    if (maxMove < 1) then
        set maxMove = 1
    endif
    call SaveUnitHandle(DashStrikeHash, tId, DashStrikeSelfIndex, self)
    call SaveReal(DashStrikeHash, tId, DashStrikeXIndex, selfX)
    call SaveReal(DashStrikeHash, tId, DashStrikeYIndex, selfY)
    call SaveReal(DashStrikeHash, tId, DashStrikeFacingIndex, facing)
    call SaveInteger(DashStrikeHash, tId, DashStrikeMoveIndex, maxMove)
    call SaveReal(DashStrikeHash, tId, DashStrikeSpeedIndex, (distan / I2R(maxMove)))
    call SaveBoolean(DashStrikeHash, tId, DashStrikeHasShadowIndex, hasShadow)
    call SaveInteger(DashStrikeHash, tId, DashStrikeShadowAnimationIndex, shadowAnimationIndex)
    call SaveTriggerHandle(DashStrikeHash, tId, DashStrikeCallbackTrgIndex, callbackTrg)

    call TimerStart(t, loopDelay, true, function DashStrikeL)
    set t = null
endfunction



//==========================================================================
// PushTarget         Lastest (09/01/22)
//==========================================================================

function PushTargetL takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer tId = GetHandleId(t)
    local unit whichUnit = LoadUnitHandle(PushTargetHash, tId, PushTargetUnitIndex)
    local integer moveCountdown = LoadInteger(PushTargetHash, tId, PushTargetMaxMoveIndex)
    local real angle
    local real speed
    local real speedDecRate
    local real x
    local real y
    local player p

    if (moveCountdown < 1) or (GetUnitName(whichUnit) == null) then
        call FlushChildHashtable(PushTargetHash, tId)
        call PauseTimer(t)
        call DestroyTimer(t)
    else
        set moveCountdown = moveCountdown - 1
        call SaveInteger(PushTargetHash, tId, PushTargetMaxMoveIndex, moveCountdown)

        set angle = LoadReal(PushTargetHash, tId, PushTargetAnglendex)
        set speed = LoadReal(PushTargetHash, tId, PushTargetMaxSpeedIndex)
        set speedDecRate = LoadReal(PushTargetHash, tId, PushTargetSpeedDecIndex)
        call SaveReal(PushTargetHash, tId, PushTargetMaxSpeedIndex, (speed - speedDecRate))
        set x = GetUnitX(whichUnit)
        set y = GetUnitY(whichUnit)
        set x = PolarX(x, speed, angle)
        set y = PolarY(y, speed, angle)
        call DestroyTreeXY(x, y, 120.00)
        set p = GetOwningPlayer(whichUnit)
        call UnitApplyTimedLife(CreateUnit(p, 'h017', x, y, angle), 1112820806, 0.70)
        set p = null
        call UnitMoveXY(whichUnit, x, y)
    endif
    set whichUnit = null
    set t = null
endfunction


function PushTarget takes unit whichUnit, real whichAngle, real maxPushSpeed, real minPushSpeed, integer maxLoop, real loopDelay returns nothing
    local real pushSpeedDecRate = (maxPushSpeed - minPushSpeed) / maxLoop
    local timer t = CreateTimer()
    local integer tId = GetHandleId(t)

    if (loopDelay < 0.02) then
        set loopDelay = 0.02
    endif
    if (maxLoop < 1) then
        set maxLoop = 1
    endif
    call SaveUnitHandle(PushTargetHash, tId, PushTargetUnitIndex, whichUnit)
    call SaveReal(PushTargetHash, tId, PushTargetAnglendex, whichAngle)
    call SaveReal(PushTargetHash, tId, PushTargetMaxSpeedIndex, maxPushSpeed)
    call SaveReal(PushTargetHash, tId, PushTargetSpeedDecIndex, pushSpeedDecRate)
    call SaveInteger(PushTargetHash, tId, PushTargetMaxMoveIndex, maxLoop)
    call TimerStart(t, loopDelay, true, function PushTargetL)
    set t = null
endfunction



//==========================================================================
// CreateIllusion         Lastest (23/02/21)
//==========================================================================

function CreateIllusionSummonAct takes nothing returns nothing
    local trigger trg = GetTriggeringTrigger()
    local unit summonUnit = GetSummonedUnit()
    local integer trgId = GetHandleId(trg)
    local integer illusionBuff = LoadInteger(CreateIllusionHash, trgId, CreateIllusionBuffIndex)
    local trigger callbackTrg
    local real moveX
    local real moveY


    if (GetUnitAbilityLevel(summonUnit, illusionBuff) > 0) then
        call DisableTrigger(trg)
        set moveX = LoadReal(CreateIllusionHash, trgId, CreateIllusionMoveXIndex)
        set moveY = LoadReal(CreateIllusionHash, trgId, CreateIllusionMoveYIndex)
        set callbackTrg = LoadTriggerHandle(CreateIllusionHash, trgId, CreateIllusionCallbackIndex)
        call UnitMoveXY2(summonUnit, moveX, moveY)
        if (callbackTrg != null) then
            set CreateIllusionUnit = summonUnit
            call TriggerExecute(callbackTrg)
        endif
    endif
    set trg = null
    set summonUnit = null
endfunction

function CreateIllusion takes unit targetUnit, integer illusionSk, integer illusionBuff, real moveX, real moveY, player p, trigger callbackTrg returns nothing
    local integer trgId
    local trigger summonTrg

    set summonTrg = CreateTrigger()
    set trgId = GetHandleId(summonTrg)
    call SaveInteger(CreateIllusionHash, trgId, CreateIllusionBuffIndex, illusionBuff)
    call SaveReal(CreateIllusionHash, trgId, CreateIllusionMoveXIndex, moveX)
    call SaveReal(CreateIllusionHash, trgId, CreateIllusionMoveYIndex, moveY)
    call SaveTriggerHandle(CreateIllusionHash, trgId, CreateIllusionCallbackIndex, callbackTrg)
    call TriggerAddAction(summonTrg, function CreateIllusionSummonAct)
    call TriggerRegisterPlayerUnitEvent(summonTrg, p, EVENT_PLAYER_UNIT_SUMMON, null)

    set bj_lastCreatedUnit = CreateUnit(p, 'u003', GetUnitX(targetUnit), GetUnitY(targetUnit), bj_UNIT_FACING)
    call UnitAddAbility(bj_lastCreatedUnit, illusionSk)
    call IssueTargetOrderById(bj_lastCreatedUnit, 852274, targetUnit)
    call UnitApplyTimedLife(bj_lastCreatedUnit, 1112820806, 0.40)
    call TriggerSleepAction(0.20)
    call TriggerClearActions(summonTrg)
    call DestroyTrigger(summonTrg)
    set summonTrg = null
    call FlushChildHashtable(CreateIllusionHash, trgId)
endfunction