import { AgilityPerLv, AttackRange, Hero, IntelligencePerLv, MainAbilities, Name, ProperName, SpeedBase, StartAgility, StartIntelligence, StartStrength, StrengthPerLv, TooltipExtend } from "./base_object";

export default [
    new Hero([
        new Name("Dual Zangetsu"),
        new ProperName("Kurosaki Ichigo"),
        new MainAbilities(["Getsuga Tenshou", "Quincy Power"]),
        /*new AbilityHero(""),
        new AbilityNormal(""),
        new MaxPitchAngle(""),
        new IconGame(""),
        new IconScreen(""),
        new ModelFile(""),
        new ScailingValue(""),
        new AttackCooldown(""),
        new BaseDamage(""),
        new WeaponSound(""),
        new Height(""),*/
        new AttackRange(120),
        new SpeedBase(522),
        /*new UnitSound(""),
        new PrimaryAttribute(""),
        */
        new StartStrength(29.75),
        new StrengthPerLv(3.75),
        new StartAgility(31),
        new AgilityPerLv(3),
        new StartIntelligence(29.25),
        new IntelligencePerLv(2.25)
    ])
]