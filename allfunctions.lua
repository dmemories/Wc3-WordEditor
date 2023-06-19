function Log takes string s returns nothing
function Echo takes string s returns nothing
function SetEnabledAttack takes unit whichUnit, boolean attackable returns nothing
function GetRemainToMaxAngle takes real whichValue returns real
function GetPositiveReal takes real whichValue returns real
function AngleBetweenAngle takes real angle1, real angle2 returns real
function CreateGroupAllyXYCond takes unit picked, player p returns boolean
function CreateGroupAllyXY takes real x, real y, real area, player p returns group
function AppendUnit2TargetL takes nothing returns nothing
function AppendUnit2Target takes unit dummy, unit target, real duration, real delay returns nothing
function AppendUnit2TargetL
function SetUnitVertexColorAfterAct takes nothing returns nothing
function SetUnitVertexColorAfter takes unit u, integer r, integer g, integer b, integer alpha, real delay returns nothing
function SetUnitVertexColorAfterAct
function SetUnitFadeScaleAct takes nothing returns nothing
function SetUnitFadeScale takes unit u, real initSize, real finalSize, real duration returns nothing
function SetUnitFadeScaleAct
function SetUnitAnimationAfterAct takes nothing returns nothing
function SetUnitAnimationAfter takes unit u, string animName, real delay returns nothing
function SetUnitAnimationAfterAct
function SetAbilityAvailable takes integer skId, boolean isAvailable returns nothing
function UnitApplyFadeLifeAct takes nothing returns nothing
function UnitApplyFadeLifeDelay takes nothing returns nothing
function UnitApplyFadeLifeAct
function UnitApplyFadeLife takes unit u, real periods, integer r, integer g, integer b, integer startVertex, real delayStart returns nothing
function UnitApplyFadeLifeDelay
function UnitApplyFadeLifeAct
function CreateDummy takes player p, integer uTypeId, real x, real y, real facing, integer vertexColor returns unit
function UnitDropItems takes unit u returns nothing
function UnitReplaceItemId takes unit u, integer baseItemId, integer replaceItemId returns boolean
function UnitDropItemId takes unit u, integer dropItemId returns item
function BlockDamageAct2 takes nothing returns nothing
function BlockDamageAct takes unit u, real heal returns nothing
function BlockDamageAct2
function CreateGroupUnitBuffCond takes unit u, integer buffId returns boolean
function CreateGroupUnitBuff takes integer buffId returns group
function CreateGroupUnitType takes integer unitid, player p returns group
function GetRandomIntDist takes integer min, integer max, integer dist returns integer
function SetAbilityCooldown_End takes nothing returns nothing
function SetAbilityCooldown takes unit u, integer skBase, integer skDummy, real cd returns nothing
function SetAbilityCooldown_End
function SoundPatch_Music takes string s returns nothing
function SoundPatch_Spell takes string s, real x, real y returns nothing
function GateTeleportCond takes nothing returns boolean
function FrozenItemSwap takes unit u, boolean toRanged returns nothing
function PanCameraToTimedXYForPlayer takes player whichPlayer, real x, real y, real duration returns nothing
function CheckDay takes nothing returns boolean
function TerrainDeformationRippleXY takes real duration, boolean limitNeg, real x, real y, real startRadius, real endRadius, real depth, real wavePeriod, real waveWidth returns terraindeformation
function CreateRectXY takes real x, real y, real width, real height returns rect
function UnitHideSelect takes unit whichUnit returns nothing
function CreateNUnitsXY takes integer count, integer unitId, player whichPlayer, real x, real y, real face returns nothing
function RandomXInRect takes rect whichRect returns real
function RandomYInRect takes rect whichRect returns real
function DistanceBetweenXY takes real x1, real y1, real x2, real y2 returns real
function PolarX takes real x, real dist, real angle returns real
function PolarY takes real y, real dist, real angle returns real
function AngleBetweenXY takes real x1, real y1, real x2, real y2 returns real
function UnitMoveLoc takes unit u, location loc returns nothing
function UnitMoveXY takes unit u, real x, real y returns boolean
function UnitMoveXY2 takes unit dummy,real x,real y returns boolean
function UnitPureDamageTarget takes unit atker, unit atked, real rdmg returns nothing
function BasicDmg_Q takes unit u, integer sk, integer whichStat returns real
function AttributeCheck takes unit u returns integer
function GetPimaryAttribute takes unit u returns integer
function Dynamic_3D takes string s, real X, real Y returns nothing
function DynamicCreateGroupCond takes unit picked, player p returns boolean
function DynamicCreateGroup takes location loc, real area, player p returns group
function DynamicCreateGroup2 takes location loc, real area, player p, group gcheck returns group
function GetUnitNearestXY takes real x, real y, real area, player p returns unit
function CreateGroupXY takes real x, real y, real area, player p returns group
function CreateGroupXY2 takes real x, real y, real area, player p, group g_check returns group
function CreateGroupXYHero takes real x, real y, real area, player p returns group
function CreateGroupXYnWW takes real x, real y, real area, player p returns group
function GroupRandomUnit takes group g returns unit
function SetUnitFly takes unit u returns nothing
function PauseSystem takes unit u, boolean b returns nothing
function TreeKiller takes nothing returns nothing
function DestroyTreeXY takes real centerX, real centerY,real radius returns nothing
function TreeKiller
function TransformGroup_Cond takes unit u, unit dummy returns boolean
function TransfromAction takes unit u, real x, real y returns nothing
function All_PlayerCond takes nothing returns boolean
function Force_Display takes real t, string s returns nothing
function All_PlayerCond
function GroupCountUnits takes group G returns integer
function Scept_UpgradeCheck takes nothing returns boolean
function Scept_AlreadyCheck takes unit u returns boolean
function DoSoundPreload takes string path returns nothing
function Dynamic_Sound takes string s returns nothing
function Alert takes player p, string msg returns nothing
function DisplayText takes string T, unit U, real Size, boolean Move, integer r, integer g, integer b, integer a returns nothing
function DisplayCriticalText takes string str, unit u, integer r, integer g, integer b, integer a returns nothing
function CameraShake takes real DuringTime, real ShakePower, unit U returns nothing
function Dynamic_GroupShakeCond takes nothing returns boolean
function Dynamic_GroupShake takes real x, real y, real time, real power, real area, group gcheck returns nothing
function Dynamic_GroupShakeCond
function CameraShakePlayer takes real shakeDuration, real shakePower, integer playerIndex returns nothing
function CameraShakeAllPlayers takes real shakeDuration, real shakePower returns nothing
function Map_Kill_SummonGroupAct takes nothing returns nothing
function Map_Kill_Summon takes unit U returns nothing
function Map_Kill_SummonGroupAct
function Is_IkkakuBankai takes unit u returns boolean
function HidanBuff takes unit u returns nothing
function PeinSixPathSetEnable takes boolean isEnable returns nothing
function DashStrikeL takes nothing returns nothing
function DashStrike takes unit self, real targetX, real targetY, real loopDelay, integer maxMove, boolean hasShadow, integer shadowAnimationIndex, trigger callbackTrg returns nothing
function DashStrikeL
function PushTargetL takes nothing returns nothing
function PushTarget takes unit whichUnit, real whichAngle, real maxPushSpeed, real minPushSpeed, integer maxLoop, real loopDelay returns nothing
function PushTargetL
function CreateIllusionSummonAct takes nothing returns nothing
function CreateIllusion takes unit targetUnit, integer illusionSk, integer illusionBuff, real moveX, real moveY, player p, trigger callbackTrg returns nothing
function CreateIllusionSummonAct
function CheckWalkableLoc takes real targetX, real targetY, real checkArea returns boolean
function GetWalkableLoc takes real x, real y, real maxArea, real checkArea returns location
function ResetUncastManaShieldEnd takes nothing returns nothing
function ResetUncastManaShield takes unit caster, integer skId returns nothing
function ResetUncastManaShieldEnd
function Char2Id takes string c returns integer
function String2Id takes string s returns integer
function Id2Char takes integer i returns string
function Id2String takes integer id returns string