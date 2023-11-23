globals
    rect MAP_RECT = null
    real UNIT_MOVE_AREA = 120.00
    integer DEFAULT_TIMELIFE_BUFF = 1112820806
    player NEUTRAL_AGGRESSIVE_PLAYER = Player(PLAYER_NEUTRAL_AGGRESSIVE)

    trigger Aizen_Hogyoku_Learn = CreateTrigger()
    trigger Akainu_MagmaFrenzyDmg = CreateTrigger()
    trigger Aokiji_FrostCounterDmg = CreateTrigger()
    trigger Byakuya_Gokei = CreateTrigger()
    trigger Hashirama_ShinraBanshoAtk = CreateTrigger()
    trigger Hashirama_RashomonLearn = CreateTrigger()
    trigger Hashirama_MokujinDie = CreateTrigger()
    trigger Kizaru_Ama_no_MurakumoD = CreateTrigger()
    trigger Minato_FlyingThunderGodB = CreateTrigger()
    trigger Minato_FlyingRaijinSlashA = CreateTrigger()
    trigger Minato_FlyingRaijinSlashB = CreateTrigger()
    trigger Lucci_TekkaiLearn = CreateTrigger()
    trigger Lucci_TekkaiAtked = CreateTrigger()
    trigger Sasuke_EyesTrg = CreateTrigger()
    trigger Sasuke_SusanooD = CreateTrigger()
    trigger Shunsui_Itokiribasami = CreateTrigger()
    trigger Soifon_SuzumebachiLearn = CreateTrigger()

    hashtable Hashirama_RashomonTable
    hashtable Ichigo_Hash
    hashtable Joker_TamaitoHash
    hashtable Joker_SoraHash
    hashtable Joker_SoraCDHash
    hashtable Naruto_RikenHash
    hashtable Rukia_BankaiHash
    hashtable Soifon_AtkedHash

    hashtable AppendUnitHash = InitHashtable()
    hashtable BlackDamageHash = InitHashtable()
    hashtable UnitAnimAfterHash = InitHashtable()
    hashtable UnitFadeHash = InitHashtable()
    hashtable UnitScaleFadeHash = InitHashtable()
    hashtable UnitVertexHash = InitHashtable()

    hashtable CreateIllusionHash = InitHashtable()
    unit CreateIllusionUnit = null
    integer CreateIllusionBuffIndex = 0
    integer CreateIllusionMoveXIndex = 1
    integer CreateIllusionMoveYIndex = 2
    integer CreateIllusionCallbackIndex = 3

    hashtable DashStrikeHash = InitHashtable()
    integer DashStrikeSelfIndex = 0
    integer DashStrikeXIndex = 1
    integer DashStrikeYIndex = 2
    integer DashStrikeFacingIndex = 3
    integer DashStrikeMoveIndex = 4
    integer DashStrikeSpeedIndex = 5
    integer DashStrikeHasShadowIndex = 6
    integer DashStrikeShadowAnimationIndex = 7
    integer DashStrikeCallbackTrgIndex = 8

    hashtable PushTargetHash = InitHashtable()
    integer PushTargetUnitIndex = 0
    integer PushTargetAnglendex = 1
    integer PushTargetMaxSpeedIndex = 2
    integer PushTargetSpeedDecIndex = 3
    integer PushTargetMaxMoveIndex = 4

    hashtable ManaShieldHash = InitHashtable()
    integer ManaShieldHashUnitIndex = 0
    integer ManaShieldHashSkIndex = 1

    integer DivineItemId = 'I077'

//======================================================================================

    // Hashirama
    integer Hashirama_SpellBook = 'A0LF'

    // Hidan
    unit Hidan_bloodTarget = null
    unit Hidan_bloodDummy = null
    integer Hidan_curseBookId = 'A0BT'

    // Lucci
    integer Lucci_tranTypeId = 'N01V'
    integer Lucci_skBeastForm = 'A0CY'
    integer Lucci_skUpgrade = 'A0KD'
    integer Lucci_skGeppo = 'A0KH'
    integer Lucci_geppoStack

    // Madara
    unit Madara
    trigger Madara_EyesCheckTrg
    trigger Madara_EyesOrderTrg
    trigger Madara_EyesDeathTrg
    integer Madara_skSharinBook = 'A0KS'
    integer Madara_skEyesUpgrade = 'A0KU'
    hashtable Madara_KatonHash

    // Naruto
    player Naruto_Player
    trigger Naruto_KagebunshinLearn
    trigger Naruto_KagebunshinLvlUp
    integer Naruto_CloneBuff
    trigger Naruto_RasenshurikenCast
    trigger Naruto_RasenshurikenCastEnd
    trigger Naruto_ShurikenLearn

    // Neji
    trigger Neji_HyugaClanTechAtkTrg
    trigger Neji_OrderTrg
    unit Neji_Unit
    integer Neji_ByakuganBuff

    // Pein
    integer Pein_BuffSoulDrain = 'B00A'
    integer Pein_SkSixPathBook = 'A006'
    integer Pein_SkSixPathDrainBook = 'A00J'
    integer Pein_SixPathSkMaxIndex
    integer array Pein_SixPathSk
    trigger Pein_Shinra_Tensei_Maximum_Cancel
    trigger Pein_Shinra_Tensei_Maximum_Finish
    group Pein_ShinraTenseiDeathGroup

    // Tobirama
    trigger Tobirama_SuiryudanLearn
    trigger Tobirama_SuiryudanBlink
    boolean Tobirama_CastingWaveForm = false

    // Zabuza
    integer Zabuza_WWBuff
    integer Zabuza_BashSk
    integer Zabuza_CleavingSk
    integer Zabuza_CriticalSk
    integer Zabuza_EnvSpearSk
    integer Zabuza_MuonSatsujinBonusAtkSk
    trigger Zabuza_DaibakufuCast

endglobals