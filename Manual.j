// Unit
local unit xxx = GetTriggerUnit()
local unit xxx = GetSpellTargetUnit()
local unit xxx = GetLearningUnit()
local unit xxx = GetEventDamageSource()
local unit xxx = GetAttacker()
local unit xxx = GetOrderedUnit()
local unit xxx = GetDyingUnit()
local unit xxx = GetKillingUnit()
local unit xxx = GetLevelingUnit()
call SetUnitPathing(caster, false)
call SetUnitPosition(caster, x, y)
call SetUnitX(caster, x)
call UnitMoveXY(caster, x y)
call UnitMoveXY2(caster, x, y)
call UnitApplyTimedLife(CreateUnit(p, 'h002', x, y, bj_UNIT_FACING), DEFAULT_TIMELIFE_BUFF, 1.00)
set bj_lastCreatedUnit = CreateUnit(p, 'h002', x, y, bj_UNIT_FACING)
call UnitApplyTimedLife(bj_lastCreatedUnit, DEFAULT_TIMELIFE_BUFF, 1.00)
call UnitApplyFadeLife(u, periods, 255, 255, 255, 255, delayStart)
call SetUnitFadeScale(bj_lastCreatedUnit, 2.00, 10.00, 3.00)
call SetUnitScale(bj_lastCreatedUnit, 2.00, 2.00, 2.00)
call SetUnitTimeScale(bj_lastCreatedUnit, 2.00)
call SetUnitFly(caster)
call SetUnitFlyHeight(bj_lastCreatedUnit, 800.00, 0.00)
call SetUnitVertexColor(bj_lastCreatedUnit, 255, 255, 255, 255)
call SetUnitVertexColorAfter(bj_lastCreatedUnit, 255, 255, 255, 255, 3.00)
call SetUnitAnimation(bj_lastCreatedUnit, "death")
call SetUnitAnimationAfter(bj_lastCreatedUnit, "death", 3.00)
call SetUnitAnimationByIndex(bj_lastCreatedUnit, 3)
call QueueUnitAnimation(u, "stand")
call AppendUnit2Target(dummy, target, 2.00)
call SetUnitFacing(caster, facing)
call SetUnitState(whichUnit, UNIT_STATE_LIFE, RMaxBJ(0,newValue))
call UnitAddAbility(caster, 'A001')
call UnitRemoveAbility(caster, 'A001')
call PauseSystem(caster, true)
call SetUnitInvulnerable(caster, true)
call ShowUnitHide(caster)
call ShowUnitShow(caster)
call SetUnitUserData(caster, 0)
call GetUnitUserData(caster)
call SetAbilityAvailable('A000', false)
call SetPlayerAbilityAvailable(p, 'A000', false)
call UnitDamageTarget(caster, picked, dmg, true, false, ATTACK_TYPE_HERO, DAMAGE_TYPE_NORMAL, WEAPON_TYPE_WHOKNOWS)
call UnitDamageTarget(caster, picked, dmg, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS)
call UnitPureDamageTarget(caster, picked, dmg)

// Unit Group
call DestroyTreeXY(x, y, tarea)
call DestroyTreeXY(x, y, UNIT_MOVE_AREA)
call GroupAddGroup(groupPush, g)
call GroupAddUnit(gcheck, picked)
local group g = CreateGroupXY2(x, y, garea, p, gcheck)
local group g = CreateGroupXY(x, y, garea, p)
loop
    set picked = FirstOfGroup(g)
    exitwhen (picked == null)
    call GroupRemoveUnit(g, picked)
endloop
call DestroyGroup(g)
set g = null

// Real
local real xxx = GetUnitState(whichUnit, UNIT_STATE_LIFE)
local real xxx = GetUnitState(whichUnit, UNIT_STATE_MANA)
local real xxx = GetUnitState(whichUnit, UNIT_STATE_MAX_LIFE)
local real xxx = GetUnitState(whichUnit, UNIT_STATE_MAX_MANA)
local real xxx = GetWidgetLife(whichUnit)
local real xxx = GetUnitStatePercent(whichUnit, UNIT_STATE_LIFE, UNIT_STATE_MAX_LIFE)
local real dmg = BasicDmg_Q(unit, 'A0EH', bj_HEROSTAT_AGI)
local real dmg = ((1000.00 + (GetUnitAbilityLevel(caster, skId)*5.00)) + (GetHeroAgi(caster, false) * 5.00))
local real xxx = GetUnitFacing(u)
local real xxx = GetUnitX(u)
local real xxx = GetUnitY(u)
local real xxx = PolarX(x, distan, facing)
local real xxx = PolarY(y, distan, facing)
local real xxx = GetSpellTargetX()
local real xxx = GetSpellTargetY()
local real xxx = AngleBetweenXY(x, y, x, y)
local real xxx = DistanceBetweenXY(x, y, x, y)
local real xxx = GetOrderPointX()
local real xxx = GetOrderPointY()
local real xxx = GetEventDamage()

// Integer
local integer sk = GetLearnedSkill()
local integer skLv = GetLearnedSkillLevel()
local integer skLv = GetUnitAbilityLevel(whichUnit, skId)
local integer orderId = GetIssuedOrderId()
local integer n = ModuloInteger(0, 0)
local integer n = GetUnitCurrentOrder(whichUnit) == OrderId("absorb")
local integer n = GetUnitTypeId(whichUnit) == 'N01T'
local integer n = GroupCountUnits(g)
local integer n = GetHeroAgi(caster, true)

// Dummy & Order
set bj_lastCreatedUnit = CreateUnit(p, 'u003', x[0], y[0], bj_UNIT_FACING)
call UnitAddAbility(bj_lastCreatedUnit, 'A000')
call UnitRemoveAbility(bj_lastCreatedUnit, 'Amov')
call IssueTargetOrder(bj_lastCreatedUnit, "thunderbolt", picked)
call UnitApplyTimedLife(bj_lastCreatedUnit, DEFAULT_TIMELIFE_BUFF, 1.00)
"chainlightning", "thunderclap"
call IssueImmediateOrder(bj_lastCreatedUnit, "stomp")
call IssueImmediateOrderById(bj_lastCreatedUnit, 111111)
call IssueTargetOrder(bj_lastCreatedUnit, "thunderbolt", u[1])
call IssueTargetOrderById(bj_lastCreatedUnit, 111111, u[1])
call IssuePointOrder(u, "silence", x, y)
call IssuePointOrderById(u, 11111, x, y)

// Player
Player(PLAYER_NEUTRAL_AGGRESSIVE)
GetOwningPlayer(whichUnit)

// Rect
local rect r = CreateRectXY(x, y, width, height)
local rect x = RandomXInRect(rect)
local rect x = GetRectCenterX(rect)
call RemoveRect(r)

// Timer
local timer t = GetExpiredTimer()
local timer t = CreateTimer()
call TimerStart(t, 0.04, true, function ActL)
call PauseTimer(t)
call DestroyTimer(t)
set t = null

// Hash Table
local hashtable hash = InitHashtable()
local integer i = LoadInteger(hash, GetHandleId(whichUnit), 0)
call SaveInteger(hash, missionKey, column, value)
call FlushChildHashtable(hash, missionKey)
call FlushParentHashtable(hash)

// Boolean
RectContainsCoords(MAP_RECT, x, y)
IsTerrainPathable(x, y, PATHING_TYPE_WALKABILITY)
IsUnitPaused(whichUnit)
IsTriggerEnabled(GetTriggeringTrigger())
IsUnitInGroup(picked, gcheck)
IsUnitAlly(whichUnit, p)
IsUnitEnemy(whichUnit, p)

// Effect & Text
call DestroyEffect(AddSpecialEffectTarget("XXXXX", caster, "origin"))
call DestroyEffect(AddSpecialEffect("XXXX", x, y))
call DisplayTimedTextToForce(GetPlayersAll(), 0.01, "1")
call DisplayCriticalText("XXXXX", targetUnit, red, green, blue, alpha)
call DisplayTextAtUnit("TTTTTT", caster)
call DisplayFloatTextAtUnit("FFFFFFF", caster)
call DisplayText("XXXXXXXXXXX", caster, 0.023, true, 255, 255, 255, 255)
call DisplayText("XXXX", caster, 0.023, true, 220, 5, 5, 255)
if (IsUnitType(u, UNIT_TYPE_MECHANICAL)) then
if (IsUnitType(u, UNIT_TYPE_HERO)) then
    call DisplayText(I2S(R2I(dmg)) + "!", picked, 0.027, true, 255, 0, 0, 255)
endif
call TerrainDeformationRippleXY( duration, false, x, y, 100.00, 100.00, deep, ratio, 512)

// Sound
call Dynamic_3D("XXXXXX", x, y)
call SoundPatch_Spell(udg_soundPatch_OnePiece + "\\Lucci\\RankyakuGaichou.wav", x, y)
call Dynamic_Sound("Sounds\\Ryuusenka.mp3")

// Camera
call PanCameraToTimedXYForPlayer(p, x, y, 0)
call CameraShake(udg_CameraShakeTime, udg_CameraShakePow, whichUnit)
call Dynamic_GroupShake(x, y, udg_CameraShakeTime, udg_CameraShakePow, udg_CameraArea, null)

// Event
call TriggerRegisterAnyUnitEventBJ(trg, EVENT_PLAYER_UNIT_SPELL_EFFECT)
call TriggerRegisterUnitEvent(trg, u, EVENT_UNIT_SPELL_EFFECT)
call TriggerRegisterUnitEvent(trg, u, EVENT_UNIT_DAMAGED)
call TriggerRegisterUnitEvent(trg, u, EVENT_UNIT_HERO_SKILL)
call TriggerRegisterUnitEvent(trg, u, EVENT_UNIT_DEATH)
call TriggerRegisterUnitEvent(trg, u, EVENT_UNIT_HERO_LEVEL)
call TriggerRegisterAnyUnitEventBJ(trg, EVENT_PLAYER_UNIT_ATTACKED)
call TriggerRegisterAnyUnitEventBJ(trg, EVENT_PLAYER_UNIT_DEATH)
