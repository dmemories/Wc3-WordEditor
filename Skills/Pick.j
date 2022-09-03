//TESH.scrollpos=208
//TESH.alwaysfold=0

function Ability_AddEvent takes unit u, integer i returns nothing
    if(i==0) then
        set Ichigo_Hash = InitHashtable()
        call TriggerRegisterPlayerUnitEvent(gg_trg_Getsuga_Tenshou, GetOwningPlayer(u), EVENT_PLAYER_UNIT_SPELL_EFFECT, null)
        call TriggerRegisterPlayerUnitEvent(gg_trg_White_Getsuga_Tenshou, GetOwningPlayer(u), EVENT_PLAYER_UNIT_SPELL_EFFECT, null)
        call TriggerRegisterUnitEvent(gg_trg_Ichigo_Getsuga, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Hollow_Power, u, EVENT_UNIT_HERO_SKILL)
        call TriggerRegisterUnitEvent(gg_trg_Fgt, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Black_Moon_Slash, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Gran_Getsuga_Cero, u, EVENT_UNIT_SPELL_EFFECT)
    elseif(i==1) then
        call TriggerRegisterUnitEvent(gg_trg_Gat, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Gomu_Rocket, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Gomu_Bazooka, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Gear4_Init, u, EVENT_UNIT_HERO_SKILL)
        call TriggerRegisterUnitEvent(gg_trg_Gear4, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Rdw, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Kkg, u, EVENT_UNIT_SPELL_EFFECT)
    elseif(i==2) then
        set Naruto_RikenHash = InitHashtable()
        call TriggerRegisterUnitEvent(gg_trg_Lrs, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Jiton_Rasengan, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Jiton_RasenganC, u, EVENT_UNIT_SPELL_CHANNEL)
        call TriggerRegisterUnitEvent(gg_trg_Kage_Bushin, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Biju_Rasenshuriken, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Cbr, u, EVENT_UNIT_SPELL_EFFECT)
    elseif(i==3) then
        set Rukia_BankaiHash = InitHashtable()
        call TriggerRegisterUnitEvent(gg_trg_Trs, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Smt, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Hkr, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_WhiteSword, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_HakkanoTogame, u, EVENT_UNIT_SPELL_EFFECT)
    elseif(i==4) then
        call TriggerRegisterUnitEvent(gg_trg_Ssn, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Ykd, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Sph, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Csp, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Tmk, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Sds, u, EVENT_UNIT_SPELL_EFFECT)
    elseif(i==5) then
        call UnitMakeAbilityPermanent(u, true, Sasuke_skUpgrade)
        call SetAbilityAvailable(Sasuke_skUpgrade, false)
        call UnitMakeAbilityPermanent(u, true, 'A0IY')
        call UnitMakeAbilityPermanent(u, true, 'A0IZ')
        call UnitMakeAbilityPermanent(u, true, 'A0IX')
        call UnitMakeAbilityPermanent(u, true, 'A0J0')
        call UnitMakeAbilityPermanent(u, true, Sasuke_skBookId)
        call UnitMakeAbilityPermanent(u, true, Sasuke_skUpgrade)
        call UnitMakeAbilityPermanent(u, true, Sasuke_skSwitch)
        call UnitMakeAbilityPermanent(u, true, Sasuke_skBonusAgi)
        call UnitMakeAbilityPermanent(u, true, Sasuke_skDefBonus)
        call UnitMakeAbilityPermanent(u, true, Sasuke_skRinneEff)
        call TriggerRegisterUnitEvent(gg_trg_Amenotejikara, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Sasuke_Genjutsu, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Gkn, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Dot, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Sasuke_Susanoo, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(Sasuke_SusanooD, u, EVENT_UNIT_DEATH)
        call TriggerRegisterUnitEvent(Sasuke_EyesTrg, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Kirin, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Sck, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Sasuke_Amaterasu, u, EVENT_UNIT_SPELL_EFFECT)
        call UnitAddAbility(u, 'A0IW')
        call UnitAddAbility(u, 'A05V')
    elseif(i==6) then
        call TriggerRegisterUnitEvent(gg_trg_Osg, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Dsf_Init, u, EVENT_UNIT_HERO_SKILL)
        call TriggerRegisterUnitEvent(gg_trg_BrazoDiablo, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Ets, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Tdh, u, EVENT_UNIT_SPELL_EFFECT)
    elseif(i==7) then
        call TriggerRegisterUnitEvent(gg_trg_Mto, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Lrt, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Tbt, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Scs, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Tlt, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_TltR, u, EVENT_UNIT_SPELL_EFFECT)
    elseif(i==8) then
        call TriggerRegisterUnitEvent(gg_trg_Rkb, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Lib, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Kml, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Lie, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Kakashi_KamuiStrike, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Tls, u, EVENT_UNIT_SPELL_EFFECT)
    elseif(i==9) then
        call TriggerRegisterUnitEvent(gg_trg_Mts, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Lrg, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Sda, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Sgr, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Qff, u, EVENT_UNIT_SPELL_EFFECT)
    elseif(i==10) then
        call TriggerRegisterUnitEvent(gg_trg_Dial, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Tjr, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Stf_Init, u, EVENT_UNIT_HERO_SKILL)
        call TriggerRegisterUnitEvent(gg_trg_StfU, u, EVENT_UNIT_HERO_SKILL)
        call TriggerRegisterUnitEvent(gg_trg_Seg, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Abe, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Ipf, u, EVENT_UNIT_SPELL_EFFECT)
    elseif(i==11) then
        call SetAbilityAvailable('A07M', false)
        call TriggerRegisterUnitEvent(gg_trg_Gef, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Eth, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Rti, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Bkg, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_BkgC, u, EVENT_UNIT_DEATH)
        call TriggerRegisterUnitEvent(gg_trg_Hns, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Etp, u, EVENT_UNIT_SPELL_EFFECT)
    elseif(i==12) then
        call SetAbilityAvailable('A0EF', false)
        call TriggerRegisterUnitEvent(gg_trg_Tcb, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Srl, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Senbonzakura_Kageyoshi, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(Byakuya_Gokei, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Anl, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Wes, u, EVENT_UNIT_SPELL_EFFECT)
    elseif(i==13) then
        call TriggerRegisterUnitEvent(gg_trg_Endurance, u, EVENT_UNIT_HERO_LEVEL)
        call TriggerRegisterUnitEvent(gg_trg_Nrt, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Grc_Init, u, EVENT_UNIT_HERO_SKILL)
        call TriggerRegisterUnitEvent(gg_trg_Kin, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Isk, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_IskD, u, EVENT_UNIT_DEATH)
    elseif(i==14) then
        call UnitRemoveAbility(u, 'A0J6') // Rinbo Ghost
        // Eyes Init
        call SetAbilityAvailable('A0KR', false) // SixPath Book
        call SetAbilityAvailable(Madara_skSharinBook, false)
        call SetAbilityAvailable(Madara_skEyesUpgrade, false)
        call UnitAddAbility(u, Madara_skSharinBook)

        set Madara = u
        call TriggerRegisterTimerEventPeriodic(Madara_EyesCheckTrg, 1.00)
        call TriggerRegisterUnitEvent(gg_trg_Madara_Eyes, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(Madara_EyesOrderTrg, u, EVENT_UNIT_ISSUED_ORDER)
        call TriggerRegisterUnitEvent(Madara_EyesDeathTrg, u, EVENT_UNIT_DEATH)
        call TriggerRegisterUnitEvent(gg_trg_Madara_SixPath, u, EVENT_UNIT_DAMAGED)

        call TriggerRegisterUnitEvent(gg_trg_Inton_Raiha, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Shadow_Strike, u, EVENT_UNIT_SPELL_EFFECT)
        set Madara_KatonHash = InitHashtable()
        call TriggerRegisterUnitEvent(gg_trg_Goka_Mekkyaku, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_GokaMekkyaku_Cast, u, EVENT_UNIT_SPELL_CAST)
        call TriggerRegisterUnitEvent(gg_trg_Jukai_Kotan, u, EVENT_UNIT_SPELL_EFFECT)
        call SetAbilityAvailable('A0KL', false) // Susanoo Book
        call TriggerRegisterUnitEvent(gg_trg_Madara_Susanoo, u, EVENT_UNIT_HERO_SKILL)
        call TriggerRegisterUnitEvent(gg_trg_Rinbo, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Mti, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Tengai_Shinsei, u, EVENT_UNIT_SPELL_EFFECT)
    elseif(i==15) then
        call SetAbilityAvailable('A0K8', false)
        call SetAbilityAvailable('A0KB', false)
        call UnitRemoveAbility(u, 'A0K4')
        call TriggerRegisterUnitEvent(gg_trg_Kanzen_Saimin, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Hypnosis_Strike, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Hogyoku_Power, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(Aizen_Hogyoku_Learn, u, EVENT_UNIT_HERO_SKILL)
        call TriggerRegisterUnitEvent(gg_trg_Kyokya_Suigetsu, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Mirage_Strike, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Khg, u, EVENT_UNIT_SPELL_EFFECT)
    elseif(i==16) then
        call TriggerRegisterUnitEvent(gg_trg_Fire_Skin, u, EVENT_UNIT_ATTACKED)
        call TriggerRegisterUnitEvent(gg_trg_Hik, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Fire_Shield, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Hibashira, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Hdb, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Eti, u, EVENT_UNIT_SPELL_EFFECT)
    elseif(i==17) then
        call UnitMakeAbilityPermanent(u, true, 'A09P')
        call UnitMakeAbilityPermanent(u, true, 'A0J9')
        call SetAbilityAvailable('A09P', false)
        call TriggerRegisterUnitEvent(gg_trg_Izanami, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Ffb_Init, u, EVENT_UNIT_HERO_SKILL)
        call TriggerRegisterUnitEvent(gg_trg_Ffb, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Bunshin_Daibakuha, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Iss_Init, u, EVENT_UNIT_HERO_SKILL)
        call TriggerRegisterUnitEvent(gg_trg_Iss, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Iss_Anim, u, EVENT_UNIT_SPELL_ENDCAST)
        call TriggerRegisterUnitEvent(gg_trg_Hii, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Tsukuyomi, u, EVENT_UNIT_SPELL_EFFECT)
    elseif(i==18) then
        call TriggerRegisterUnitEvent(gg_trg_Hnm, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Inv, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Inv2, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Daiguren_Init, u, EVENT_UNIT_HERO_SKILL)
        call TriggerRegisterUnitEvent(gg_trg_Daiguren, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Dhf, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Hho, u, EVENT_UNIT_SPELL_EFFECT)
    elseif(i==19) then
        call TriggerRegisterUnitEvent(gg_trg_Sand_Skin, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Dsd, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Csd, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Crocodile_Init, u, EVENT_UNIT_HERO_SKILL)
        call TriggerRegisterUnitEvent(gg_trg_Gse, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Sad, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Coe, u, EVENT_UNIT_SPELL_EFFECT)
    elseif(i==20) then
        call TriggerRegisterUnitEvent(gg_trg_Shinra_Tensei, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Bansho_Tein, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Ukojizai, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_SixPath_Missile, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_SixPath_AbsorbSoul, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_SixPath_AbsorbSpell, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_SixPath_SummonRhino, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_SixPath_SummonTeam, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_SixPath_HealTeam, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_SixPath_ChibakuTensei, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Shinra_Tensei_Maximum, u, EVENT_UNIT_SPELL_CHANNEL)
        call TriggerRegisterUnitEvent(Pein_Shinra_Tensei_Maximum_Cancel, u, EVENT_UNIT_SPELL_ENDCAST)
        call TriggerRegisterUnitEvent(Pein_Shinra_Tensei_Maximum_Finish, u, EVENT_UNIT_SPELL_FINISH)

        set Pein_BuffSoulDrain = 'B026'
        set Pein_SkSixPathBook = 'A0LN'
        set Pein_SkSixPathDrainBook = 'A0LS'

        call UnitAddAbility(u, Pein_SkSixPathBook)
        call UnitAddAbility(u, Pein_SkSixPathDrainBook)
        call UnitRemoveAbility(u, Pein_SkSixPathBook)
        call UnitRemoveAbility(u, Pein_SkSixPathDrainBook)
        set Pein_SixPathSkMaxIndex = 6
        set Pein_SixPathSk[0] = 'A0LO'
        set Pein_SixPathSk[1] = 'A0A3'
        set Pein_SixPathSk[2] = 'A0LR'
        set Pein_SixPathSk[3] = 'A0LW'
        set Pein_SixPathSk[4] = 'A0LY'
        set Pein_SixPathSk[5] = 'A0M1'
        set Pein_SixPathSk[6] = 'A0M2'
        set Pein_ShinraTenseiDeathGroup = CreateGroup()
        call TriggerRegisterUnitEvent(gg_trg_SixPath_Ability, u, EVENT_UNIT_HERO_SKILL)
    elseif(i==21) then
        call TriggerRegisterUnitEvent(gg_trg_Thrilling_Spiritual, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Czj, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Release_Eye, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Kds, u, EVENT_UNIT_SPELL_EFFECT)
    elseif(i==22) then
        call TriggerRegisterUnitEvent(gg_trg_Jog, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Tmt, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Vri_Cast, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Vri, u, EVENT_UNIT_SPELL_FINISH)
        call TriggerRegisterUnitEvent(gg_trg_Vri, u, EVENT_UNIT_SPELL_ENDCAST)
        call TriggerRegisterUnitEvent(gg_trg_Mmg, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(udg_Mmg_TrigDie, u, EVENT_UNIT_DEATH)
        call TriggerRegisterUnitEvent(gg_trg_Rgo, u, EVENT_UNIT_SPELL_EFFECT)
    elseif(i==23) then
        call TriggerRegisterUnitEvent(gg_trg_C1, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_C1_Bomb, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_C12, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_C3, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_C4, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_C0, u, EVENT_UNIT_SPELL_EFFECT)
    elseif(i==24) then
        call TriggerRegisterUnitEvent(gg_trg_Fsw, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Lot_Init, u, EVENT_UNIT_HERO_SKILL)
        call TriggerRegisterUnitEvent(gg_trg_Lot, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Cin, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Kjd, u, EVENT_UNIT_SPELL_EFFECT)
    elseif(i==25) then
        call TriggerRegisterUnitEvent(gg_trg_Ovp, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Bst, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Hws, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Wof, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Bwt, u, EVENT_UNIT_SPELL_EFFECT)
    elseif(i==26) then
        call TriggerRegisterUnitEvent(gg_trg_Immortaility, u, EVENT_UNIT_HERO_LEVEL)
        call TriggerRegisterUnitEvent(gg_trg_Straving_Strike, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Scythe_Hook, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Curse_Jutsu, u, EVENT_UNIT_HERO_SKILL)
        call TriggerRegisterUnitEvent(gg_trg_Crazy_Slash, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Stab_The_Heart, u, EVENT_UNIT_SPELL_EFFECT)
    elseif(i==27) then
        call TriggerRegisterUnitEvent(gg_trg_White_Getsuga, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Getsuga_Strike, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Btz_Init, u, EVENT_UNIT_HERO_SKILL)
        call TriggerRegisterUnitEvent(gg_trg_Btz, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Hsm, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Evil_Moon_Slash, u, EVENT_UNIT_SPELL_EFFECT)
    elseif(i==28) then
        call TriggerRegisterUnitEvent(gg_trg_Ptk_Cast, u, EVENT_UNIT_SPELL_CAST)
        call TriggerRegisterUnitEvent(gg_trg_Ptk, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Veal_Shot, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Diable_Jambe, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Csh, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Lsh, u, EVENT_UNIT_SPELL_EFFECT)
    elseif(i==29) then
        set Zabuza_WWBuff = 'B02T'
        set Zabuza_BashSk = 'A0CF'
        set Zabuza_CleavingSk = 'A0CG'
        set Zabuza_MuonSatsujinBonusAtkSk = 'A0CH'
        set Zabuza_CriticalSk = 'A0MA'
        set Zabuza_EnvSpearSk = 'A0MB'
        call SetAbilityAvailable('A0CI', false)
        call SetAbilityAvailable(Zabuza_BashSk, false)
        call SetAbilityAvailable(Zabuza_CleavingSk, false)
        call SetAbilityAvailable(Zabuza_CriticalSk, false)
        call SetAbilityAvailable(Zabuza_EnvSpearSk, false)
        call TriggerRegisterUnitEvent(gg_trg_Suiro_Jutsu, u, EVENT_UNIT_ISSUED_ORDER)
        call TriggerRegisterUnitEvent(gg_trg_Muon_Satsujin, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Kubikiribocho_Slash, u, EVENT_UNIT_HERO_SKILL)
        call TriggerRegisterUnitEvent(gg_trg_Kirigakure, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Demon_Power, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(Zabuza_DaibakufuCast, u, EVENT_UNIT_SPELL_CHANNEL)
        call TriggerRegisterUnitEvent(gg_trg_Daibakufu, u, EVENT_UNIT_SPELL_EFFECT)
    elseif(i==30) then
        call TriggerRegisterUnitEvent(gg_trg_Flb, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Flw, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Flash_Strike, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Shunko_Init, u, EVENT_UNIT_HERO_SKILL)
        call TriggerRegisterUnitEvent(gg_trg_Shunko, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Flo, u, EVENT_UNIT_SPELL_EFFECT)
    elseif(i==31) then
        set Lucci_geppoStack = 0
        call TriggerRegisterUnitEvent(gg_trg_Rankyaku, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Shigan, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(Lucci_TekkaiLearn, u, EVENT_UNIT_HERO_SKILL)
        call TriggerRegisterUnitEvent(Lucci_TekkaiAtked, u, EVENT_UNIT_ATTACKED)
        call TriggerRegisterUnitEvent(gg_trg_Tekkai, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Beast_Form, u, EVENT_UNIT_HERO_SKILL)
        call TriggerRegisterUnitEvent(gg_trg_Geppo, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Rokuogan, u, EVENT_UNIT_SPELL_EFFECT)
    elseif(i==32) then
        call TriggerRegisterUnitEvent(gg_trg_TimeSpace, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Kot, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Kamui_Strike_Learn, u, EVENT_UNIT_HERO_SKILL)
        call TriggerRegisterUnitEvent(gg_trg_Kmo, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Switch_Body_Init, u, EVENT_UNIT_HERO_SKILL)
        call TriggerRegisterUnitEvent(gg_trg_Switch_Body, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Izanagi_Init, u, EVENT_UNIT_HERO_SKILL)
    elseif(i==33) then
        call TriggerRegisterUnitEvent(gg_trg_Cero, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Rapid_Shot_Learn, u, EVENT_UNIT_HERO_SKILL)
        call TriggerRegisterUnitEvent(gg_trg_Shs, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Iah, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(udg_Wlv_Trigger[0], u, EVENT_UNIT_SPELL_EFFECT)
    elseif(i==34) then
        call SetAbilityAvailable('A0DZ', false)
        call TriggerRegisterUnitEvent(gg_trg_Mgh, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Ing, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Magma_Frenzy, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(Akainu_MagmaFrenzyDmg, u, EVENT_UNIT_DAMAGED)
        call TriggerRegisterUnitEvent(gg_trg_Ryu, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Mgo, u, EVENT_UNIT_SPELL_EFFECT)
    elseif(i==35) then
        set Hashirama_RashomonTable = InitHashtable()
        call UnitAddAbility(u, 'A0LB')
        call UnitMakeAbilityPermanent(u, true, 'A0LB')
        call UnitRemoveAbility(u, 'A0LB')
        call SetAbilityAvailable('A0LA', false)
        call SetAbilityAvailable('A0LD', false)
        call TriggerRegisterUnitEvent(gg_trg_Shinra_Bansho, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Daijurin_no_Jutsu, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_HJukaiKotan, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(Hashirama_RashomonLearn, u, EVENT_UNIT_HERO_SKILL)
        call TriggerRegisterUnitEvent(gg_trg_Rashomon, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Kajukai_Korin, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(Hashirama_MokujinDie, u, EVENT_UNIT_DEATH)
        call TriggerRegisterUnitEvent(gg_trg_Mokujin, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_ShinSusenju, u, EVENT_UNIT_SPELL_EFFECT)
    elseif(i==36) then
        call TriggerRegisterUnitEvent(gg_trg_Memory_Erasing, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Cero, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Hoq, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Urs_Init, u, EVENT_UNIT_HERO_SKILL)
        call TriggerRegisterUnitEvent(gg_trg_Urs, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Lance_of_Lightning, u, EVENT_UNIT_SPELL_EFFECT)
    elseif(i==37) then
        call TriggerRegisterUnitEvent(gg_trg_Lsc, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Light_Regeneration, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Eight_Span_Mirror, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Ama_no_Murakumo, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(Kizaru_Ama_no_MurakumoD, u, EVENT_UNIT_DEATH)
        call TriggerRegisterUnitEvent(gg_trg_Cje, u, EVENT_UNIT_SPELL_EFFECT)
    elseif(i==38) then
        call TriggerRegisterUnitEvent(gg_trg_Waveform, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterAnyUnitEventBJ(gg_trg_Suidanha, EVENT_PLAYER_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(Tobirama_SuiryudanLearn, u, EVENT_UNIT_HERO_SKILL)
        call TriggerRegisterUnitEvent(gg_trg_SuiryudanTobirama, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(Tobirama_SuiryudanBlink, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Suijinheki, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Suishoha, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Kokuangyo, u, EVENT_UNIT_SPELL_EFFECT)
    elseif(i==39) then
        call TriggerRegisterUnitEvent(gg_trg_Cpt, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Cero, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_BerserkerBlood_Learn, u, EVENT_UNIT_HERO_SKILL)
        call TriggerRegisterUnitEvent(gg_trg_Grimmjow_Res_Init, u, EVENT_UNIT_HERO_SKILL)
        call TriggerRegisterUnitEvent(gg_trg_Grimmjow_Res, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Pkc, u, EVENT_UNIT_SPELL_EFFECT)
    elseif(i==40) then
        call SetAbilityAvailable('A0FQ', false)
        call TriggerRegisterUnitEvent(gg_trg_GravityBlade_Init, u, EVENT_UNIT_HERO_SKILL)
        call TriggerRegisterUnitEvent(gg_trg_Gravity_Slam, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Gvs, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Meteor_Storm, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Fgr, u, EVENT_UNIT_SPELL_EFFECT)
    elseif(i==41) then
        set udg_Tnh_Hash = InitHashtable()
        set udg_Tnh_Max = 18
        set udg_Tnh_Per = 0.08
        call SetAbilityAvailable('A0FZ', false)
        call TriggerRegisterUnitEvent(gg_trg_Ush, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Tbi, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Dark_Roots, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Tnh, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Aoi_Learn, u, EVENT_UNIT_HERO_SKILL)
        call TriggerRegisterUnitEvent(gg_trg_Aoi, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Tso, u, EVENT_UNIT_SPELL_EFFECT)
    elseif(i==42) then
        set udg_Ikkaku_UpgradeSk = 'A0HA'
        set udg_CounterSpin_Ability[0] = 'A0H5'
        set udg_CounterSpin_Ability[1] = 'A0H7'
        set udg_CounterSpin_Ability[2] = 'A0H2'
        set udg_CounterSpin_Delay = 0.50
        set udg_CounterSpin_Hash = InitHashtable()
        call SetAbilityAvailable('A0HA', false)
        call EnableTrigger(gg_trg_Counter_Spin)
        call TriggerRegisterUnitEvent(gg_trg_Great_Cleave, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Ikkaku_Bankai, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Ikkaku_Bankai_Init, u, EVENT_UNIT_HERO_SKILL)
        call TriggerRegisterUnitEvent(gg_trg_Dragon_Charge, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Fnm, u, EVENT_UNIT_SPELL_EFFECT)
    elseif(i==43) then
        call SetAbilityAvailable('A0HT', false)
        call TriggerRegisterUnitEvent(gg_trg_FrostCounter, u, EVENT_UNIT_SPELL_EFFECT)
        call DisableTrigger( Aokiji_FrostCounterDmg)
        call TriggerRegisterUnitEvent(Aokiji_FrostCounterDmg, u, EVENT_UNIT_DAMAGED)
        call TriggerRegisterUnitEvent(gg_trg_Pheasant_Beak, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Ice_Saber, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Ice_Time, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Partisan, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_IceAge, u, EVENT_UNIT_SPELL_EFFECT)
    elseif(i==44) then
        call TriggerRegisterUnitEvent(gg_trg_Flying_Thunder_God, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(Minato_FlyingThunderGodB, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Flying_Raijin_Slash, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(Minato_FlyingRaijinSlashB, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_NineTails_Mode, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Rinbuko_Sanshiki, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Flying_Raijin_Rasengan, u, EVENT_UNIT_SPELL_EFFECT)
    elseif(i==45) then
        call UnitMakeAbilityPermanent(u, true, 'A0I2')
        set Soifon_AtkedHash = InitHashtable()
        call TriggerRegisterUnitEvent(Soifon_SuzumebachiLearn, u, EVENT_UNIT_HERO_SKILL)
        call TriggerRegisterUnitEvent(gg_trg_Wind_Blast, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Nigeki_Kessatsu, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Soifon_Shunkou, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Soifon_ShunkouD, u, EVENT_UNIT_DEATH)
        call TriggerRegisterUnitEvent(gg_trg_Jakuho_Raikoben, u, EVENT_UNIT_SPELL_EFFECT)
    elseif(i==46) then
        set Joker_TamaitoHash = InitHashtable()
        set Joker_SoraHash = InitHashtable()
        set Joker_SoraCDHash = InitHashtable()
        call TriggerRegisterUnitEvent(gg_trg_Goshikito, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Tamaito, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Black_Knight, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Sora_no_Michi, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_God_Thread, u, EVENT_UNIT_SPELL_EFFECT)
    elseif(i==47) then
        call SetAbilityAvailable('A0JN', false)
        call SetAbilityAvailable('A0JW', false)
        call TriggerRegisterUnitEvent(gg_trg_Bushogoma, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Katen_Kyokotsu, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Kageoni, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Kageoni_Strike, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(gg_trg_Karamatsu_Shinju, u, EVENT_UNIT_SPELL_EFFECT)
        call TriggerRegisterUnitEvent(Shunsui_Itokiribasami, u, EVENT_UNIT_SPELL_EFFECT)
    endif

    set u = null
    set i = 0
endfunction


//==========================================================================================
// Pick System
//==========================================================================================

// Relation Variables : Player_MaxHeroes, Player_HeroType[], Player_GroupSelected, Player_UnitHero[], Player_Repick[], Player_Random[], Player_Color[], Player_Icon[]

function PlayerRaceCheck takes race Player_Race returns boolean
    return ( Player_Race == RACE_HUMAN )
endfunction

function Trig_Pick_Actions takes nothing returns nothing
    local unit Pick_Unit = GetEnteringUnit()
    local player Player_Unit = GetOwningPlayer(Pick_Unit)
    local integer Player_Number = ( GetConvertedPlayerId(Player_Unit) - 1)
    local integer Player_Type = GetUnitTypeId(Pick_Unit)
    local race Player_Race = GetPlayerRace(Player_Unit)
    local rect Player_Rect
    local location Player_Loc
    local integer Player_Loop = 0

    if(udg_Player_Random[Player_Number]) then
        loop
            exitwhen Player_Loop > 11
            call SetPlayerUnitAvailableBJ( Player_Type, false, Player(Player_Loop))
            set Player_Loop = Player_Loop + 1
        endloop
        set Player_Loop = 0
    endif

    loop
        exitwhen Player_Loop > udg_Player_MaxHeroes
        call SetPlayerUnitAvailableBJ( udg_Player_HeroType[Player_Loop], false, Player_Unit)
        if(udg_Player_DummyType[Player_Loop] == Player_Type) then
            set udg_Player_HeroType[Player_Loop] = 0
            if(PlayerRaceCheck(Player_Race)) then
                call MultiboardSetItemIconBJ( udg_Board, 1, (Player_Number+3), udg_Player_Icon[Player_Loop])
            else
                call MultiboardSetItemIconBJ( udg_Board, 1, (Player_Number+5), udg_Player_Icon[Player_Loop])
            endif
            call Ability_AddEvent(Pick_Unit, Player_Loop)
        endif
        set Player_Loop = Player_Loop + 1
    endloop

    if ( PlayerRaceCheck(Player_Race) ) then
        set Player_Rect = Rect(-6272, -768, -5568, -160)
    else
        set Player_Rect = Rect(5472, -800, 6176, -192)
    endif
    if( Pick_Unit != null ) then
        set Player_Loc = GetRandomLocInRect(Player_Rect)
        call SetUnitPositionLoc( Pick_Unit, Player_Loc)
        call PanCameraToTimedLocForPlayer( Player_Unit, Player_Loc, 0)
        call SelectUnitForPlayerSingle( Pick_Unit, Player_Unit)
        call RemoveLocation(Player_Loc)
        set Player_Loc = null
    endif
    call RemoveRect(Player_Rect)
    set Player_Rect = null
    
    if(udg_Player_Random[Player_Number] == false) then
        call Force_Display(udg_Display_Time, ( udg_Player_Color[Player_Number] + ( GetPlayerName(Player_Unit) + ( "|r has randomed " + GetUnitName(Pick_Unit) ) ) ))
    elseif(udg_Player_Repick[Player_Number] == false and udg_Player_Selected[Player_Number]) then
       call Force_Display(udg_Display_Time, ( udg_Player_Color[Player_Number] + ( GetPlayerName(Player_Unit) + ( "|r has repicked " + GetUnitName(Pick_Unit) ) ) ))
    else
        call Force_Display(udg_Display_Time, ( udg_Player_Color[Player_Number] + ( GetPlayerName(Player_Unit) + ( "|r has selected " + GetUnitName(Pick_Unit) ) ) ))
        set udg_Player_Repick[Player_Number] = true
        set udg_Player_Random[Player_Number] = false
    endif

    if(GetPlayerController(Player(Player_Number)) == MAP_CONTROL_COMPUTER) then
        if(Player_Number < 6) then
            call GroupAddUnitSimple( Pick_Unit, udg_AI_Team1)
        else
            call GroupAddUnitSimple( Pick_Unit, udg_AI_Team2)
        endif
    endif
    set udg_AI_Name[Player_Number] = GetUnitName(Pick_Unit)
    set udg_Player_UnitHero[Player_Number] = Pick_Unit
    set udg_Player_Selected[Player_Number] = true

    // Revive Relation
    call TriggerRegisterUnitEvent(gg_trg_Revive, Pick_Unit, EVENT_UNIT_DEATH )


    // Skillpoint Relation
    call TriggerRegisterUnitEvent(gg_trg_Skill_Point_Manage, Pick_Unit, EVENT_UNIT_HERO_LEVEL )

    // Blink Relation
    call TriggerRegisterUnitEvent(gg_trg_Blink1, Pick_Unit, EVENT_UNIT_SPELL_EFFECT)
    call TriggerRegisterUnitEvent(gg_trg_Blink2, Pick_Unit, EVENT_UNIT_SPELL_EFFECT )

    // Item Relation
    call TriggerRegisterUnitEvent(gg_trg_DagonActive, Pick_Unit, EVENT_UNIT_SPELL_EFFECT)
    call TriggerRegisterUnitEvent(gg_trg_HexActive, Pick_Unit, EVENT_UNIT_SPELL_EFFECT)
    call TriggerRegisterUnitEvent(gg_trg_DiffusalActive, Pick_Unit, EVENT_UNIT_SPELL_EFFECT)
    call TriggerRegisterUnitEvent(gg_trg_Spiritual, Pick_Unit, EVENT_UNIT_SPELL_EFFECT)
    call TriggerRegisterUnitEvent(gg_trg_Blade_Mail, Pick_Unit, EVENT_UNIT_SPELL_EFFECT )

    set Pick_Unit = null
    set Player_Unit = null
    set Player_Race = null
    set Player_Type = 0
    set Player_Number = 0
    set Player_Loop = 0
endfunction

//===========================================================================
function InitTrig_Pick takes nothing returns nothing
    set gg_trg_Pick = CreateTrigger()
    call TriggerRegisterEnterRectSimple( gg_trg_Pick, gg_rct_HeroSelection)
    call TriggerAddAction( gg_trg_Pick, function Trig_Pick_Actions )
endfunction