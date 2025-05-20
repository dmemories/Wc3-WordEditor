import { AbilityHero, AbilityNormal, AgilityPerLv, AttackCooldown, AttackRange, BaseDamage, ButtonPositionX, ButtonPositionY, DefaultAbilitiyTxt, Hero, IconGame, IconScreen, IntelligencePerLv, MainAbilitiyTxt, ModelFile, Name, PrimaryAttribute, ProperName, ScailingValue, SpeedBase, StartAgility, StartIntelligence, StartStrength, StrengthPerLv, TooltipExtend, UnitSound, WeaponSound } from "./base_object";
import {  WeaponSoundEnum } from "./types";

export default [
    new Hero([
        new Name("Dual Zangetsu"),
        new ProperName("Kurosaki Ichigo"),
        new AbilityHero(""),
        new AbilityNormal(""),
        new ButtonPositionX(0),
        new ButtonPositionY(0),
        new IconGame("Yhwach.blp"),
        new ModelFile("Button.mdx"),
        new ScailingValue(1),
        new AttackCooldown(1.5),
        new BaseDamage(60),
        new AttackRange(120),
        new WeaponSound(WeaponSoundEnum.MetalHeavySlice),
        new UnitSound("GryphonRider"),
        new MainAbilitiyTxt(["Getsuga Tenshou", "Quincy Power"]),
        new DefaultAbilitiyTxt(["Shunpo"]),

        new StartStrength(29.75),
        new StrengthPerLv(3.75),
        new StartAgility(31),
        new AgilityPerLv(3),
        new StartIntelligence(29.25),
        new IntelligencePerLv(2.25)
    ]),
    new Hero([
        new Name("Rifle Man"),
        new ProperName("GGG"),
        new AbilityHero(""),
        new AbilityNormal(""),
        new ButtonPositionX(0),
        new ButtonPositionY(0),
        new IconGame("Rifleman.blp"),
        new ModelFile("Button.mdx"),
        new ScailingValue(1),
        new AttackCooldown(1.5),
        new BaseDamage(60),
        new AttackRange(120),
        new WeaponSound(WeaponSoundEnum.MetalHeavySlice),
        new UnitSound("GryphonRider"),
        new MainAbilitiyTxt(["A", "B"]),
        new DefaultAbilitiyTxt(["Shunpo"]),

        new StartStrength(27),
        new StrengthPerLv(4),
        new StartAgility(27.75),
        new AgilityPerLv(2),
        new StartIntelligence(35.25),
        new IntelligencePerLv(4)
    ])
]