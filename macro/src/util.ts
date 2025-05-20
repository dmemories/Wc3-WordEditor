import { BaseObject, Hero } from "./base_object";
import Constant from "./constant";
import { Attribute } from "./types";

export function getRandomInt(min: number, max: number): number {
  min = Math.ceil(min);
  max = Math.floor(max);

  return Math.floor(Math.random() * (max - min + 1)) + min;
}


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


export function getMainAttribute(h: Hero): Attribute {
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
  
  result += "|n|cffffcc00Main Ability:|r" + h.metadata[Constant.MAIN_ABT_TXT].reduce((agg: any, item: any) => agg + "|n" + item, "");
  result += "|n|n|cffffcc00Default Ability:|r" + h.metadata[Constant.DEFAULT_ABT_TXT].reduce((agg: any, item: any) => agg + "|n" + item, "");
  result += "|n|nAttack range of " + h.metadata[Constant.ATTACK_RANGE_RAW];
  result += "|nMovement speed of " + h.metadata[Constant.SPEED_BASE_RAW];

  return result + "\"";
}