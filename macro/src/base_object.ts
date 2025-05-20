import Constant from "./constant";
import { Attribute, WeaponSoundEnum }  from "./types";

export abstract class BaseObject {
    constructor(public readonly rawField: string, public readonly value: any) {}
}

export class Hero {
  public metadata: any = {};
  constructor(public readonly objs: BaseObject[]) {
    for (const obj of objs) { this.metadata[obj.rawField] = obj.value }
  }
}

function CreateBrandedClass<T>(rawField: string, brand: string) {
  return class extends BaseObject {
    private __brand: string = brand;
    constructor(value: T) {
      super(rawField, value);
    }
  };
}

export const AbilityHero = CreateBrandedClass("uhab", "AbilityHero");
export const AbilityNormal = CreateBrandedClass("uabi", "AbilityNormal");
export const ButtonPositionX = CreateBrandedClass<number>("ubpx", "ButtonPositionX");
export const ButtonPositionY = CreateBrandedClass<number>("ubpy", "ButtonPositionY");
export const MaxPitchAngle = CreateBrandedClass<number>("umxp", "MaxPitchAngle");
export const IconGame = CreateBrandedClass(Constant.ICON_GAME_RAW, "IconGame");
export const IconScreen = CreateBrandedClass(Constant.ICON_SCREEN_RAW, "IconScreen");
export const ModelFile = CreateBrandedClass("umdl", "ModelFile");
export const ScailingValue = CreateBrandedClass<number>("usca", "ScailingValue");
export const AttackCooldown = CreateBrandedClass<number>("ua1c", "AttackCooldown");
export const BaseDamage = CreateBrandedClass<number>("ua1b", "BaseDamage");
export const AttackRange = CreateBrandedClass(Constant.ATTACK_RANGE_RAW, "AttackRange");
export const WeaponSound = CreateBrandedClass<WeaponSoundEnum>("ua1w", "WeaponSound");
export const Height = CreateBrandedClass<number>("umvh", "Height");
export const SpeedBase = CreateBrandedClass<number>(Constant.SPEED_BASE_RAW, "SpeedBase");
export const UnitSound = CreateBrandedClass("usnd", "UnitSound");
export const PrimaryAttribute = CreateBrandedClass<Attribute>(Constant.PRIMARY_ATTRIBUTE_RAW, "PrimaryAttribute");
export const StartStrength = CreateBrandedClass<number>(Constant.START_STRENGTH_RAW, "StartStrength");
export const StrengthPerLv = CreateBrandedClass<number>(Constant.STRENGTH_PERLV_RAW, "StrengthPerLv");
export const StartAgility = CreateBrandedClass<number>(Constant.START_AGILITY_RAW, "StartAgility");
export const AgilityPerLv = CreateBrandedClass<number>(Constant.AGILITY_PERLV_RAW, "AgilityPerLv");
export const StartIntelligence = CreateBrandedClass<number>(Constant.START_INTELLIGENCE_RAW, "StartIntelligence");
export const IntelligencePerLv = CreateBrandedClass<number>(Constant.INTELLIGENCE_PERLV_RAW, "IntelligencePerLv");
export const Name = CreateBrandedClass("unam", "Name");
export const ProperName = CreateBrandedClass(Constant.PROPER_NAME_RAW, "ProperName");
export const TooltipBasic = CreateBrandedClass(Constant.TOOTIP_NAME_RAW, "TooltipBasic");
export const TooltipExtend = CreateBrandedClass(Constant.TOOLTIP_EXTEND_RAW, "TooltipExtend");

export const MainAbilitiyTxt = CreateBrandedClass<string[]>(Constant.MAIN_ABT_TXT, "MainAbilitiyTxt");
export const DefaultAbilitiyTxt = CreateBrandedClass<string[]>(Constant.DEFAULT_ABT_TXT, "DefaultAbilitiyTxt");

export interface IObject {
    name: string;
    objs: BaseObject[];
}