import Constant from "./constant";

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
export const ButtonPositionX = CreateBrandedClass("ubpx", "ButtonPositionX");
export const ButtonPositionY = CreateBrandedClass("ubpy", "ButtonPositionY");
export const MaxPitchAngle = CreateBrandedClass<number>("umxp", "MaxPitchAngle");
export const IconGame = CreateBrandedClass("uico", "IconGame");
export const IconScreen = CreateBrandedClass("ussi", "IconScreen");
export const ModelFile = CreateBrandedClass("umdl", "ModelFile");
export const ScailingValue = CreateBrandedClass<number>("usca", "ScailingValue");
export const AttackCooldown = CreateBrandedClass<number>("ua1c", "AttackCooldown");
export const BaseDamage = CreateBrandedClass<number>("ua1b", "BaseDamage");
export const AttackRange = CreateBrandedClass(Constant.ATTACK_RANGE_RAW, "AttackRange");
export const WeaponSound = CreateBrandedClass("ua1w", "WeaponSound");
export const Height = CreateBrandedClass<number>("umvh", "Height");
export const SpeedBase = CreateBrandedClass<number>(Constant.SPEED_BASE_RAW, "SpeedBase");
export const UnitSound = CreateBrandedClass("usnd", "UnitSound");
export const PrimaryAttribute = CreateBrandedClass(Constant.PRIMARY_ATTRIBUTE_RAW, "PrimaryAttribute");
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
export const MainAbilities = CreateBrandedClass<string[]>("", "MainAbilities");










export function rawCode(code: string): number {
  if (code.length !== 4) {
    throw new Error("Code must be 4 characters long.");
  }

  return (
    (code.charCodeAt(0) << 24) |
    (code.charCodeAt(1) << 16) |
    (code.charCodeAt(2) << 8) |
    code.charCodeAt(3)
  );
}

export function fromRawCode(value: number): string {
  return String.fromCharCode(
    (value >> 24) & 0xFF,
    (value >> 16) & 0xFF,
    (value >> 8) & 0xFF,
    value & 0xFF
  );
}

export function incrementRawCode(code: string, step: number = 1): string {
    const numeric = rawCode(code);
    return fromRawCode(numeric + step);
}


export function getDetail(objs: BaseObject[]): string {
    let result = "";

    for (const obj of objs) {
        result += " " + obj.rawField + " " + obj.value;
    }

    return result;
}

export interface IObject {
    name: string;
    objs: BaseObject[];
}

type genExtendedParam = {
  mainAbilities: string[]
}

enum Attribute {
  "STR", "AGI", "INT"
};

function getMainAttribute(h: Hero): Attribute {
  const sumStr = (h.metadata[Constant.START_STRENGTH_RAW] / 10) + (h.metadata[Constant.STRENGTH_PERLV_RAW]);
  const sumAgi = (h.metadata[Constant.START_AGILITY_RAW] / 10) + (h.metadata[Constant.AGILITY_PERLV_RAW]);
  const sumInt = (h.metadata[Constant.START_INTELLIGENCE_RAW] / 10) + (h.metadata[Constant.INTELLIGENCE_PERLV_RAW]);
  let mostVal = sumStr, mostStatus = Attribute.STR;

  if (mostVal < sumAgi) {
    mostVal = sumAgi
    mostStatus = Attribute.AGI;
  }
  if (mostVal < sumInt) {
    mostVal = sumInt
    mostStatus = Attribute.INT;
  }

  return mostStatus;
}

export function getExtendedTxt(h: Hero): string {
  let result = Constant.TOOLTIP_EXTEND_RAW + " \"";
  const mainAttbr = getMainAttribute(h);
  const getAttbrTxt = (a: Attribute, desc: string) => {
    if (a === mainAttbr) return "|c00ea1d2f" + desc + " -|r";
    return "|c003a59e5" + desc + " -|r";
  }

  result += getAttbrTxt(Attribute.STR, "Strength") + ` ${h.metadata[Constant.START_STRENGTH_RAW]} + ${h.metadata[Constant.STRENGTH_PERLV_RAW]}|n`
  result += getAttbrTxt(Attribute.AGI, "Agility") + ` ${h.metadata[Constant.START_AGILITY_RAW]} + ${h.metadata[Constant.AGILITY_PERLV_RAW]}|n`
  result += getAttbrTxt(Attribute.INT, "Intelligence") + ` ${h.metadata[Constant.START_INTELLIGENCE_RAW]} + ${h.metadata[Constant.INTELLIGENCE_PERLV_RAW]}|n`
  
  result += "|n|cffffcc00Main Ability:|r"

  return result + "\"";

  /*|c00ea1d2fStrength -|r 35.75 + 2.25
|c003a59e5Agility -|r 26.75 + 4
|c003a59e5Intelligence -|r 27.5 + 2.75

|cffffcc00Main Ability:|r
Getsuga
Reiatsu Blade
Bankai: Tensa Zangetsu + Hollow Mask
Black Moon Slash
True Hollow Form

|cffffcc00Default Ability:|r
Shunpo

Attack range of 100 (melee).
Movement speed of 290.*/
}