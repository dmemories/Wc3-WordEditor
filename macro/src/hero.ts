
// RAW CODE
// BLEACH:   H001 - H055   (85 Heroes)
// ONEPIECE: H056 - H0AA   (85 Heroes)
// NARUTO:   H0AB - H0FF   (85 Heroes)


import Constant from "./constant";
import bleach_hero from "./bleach_hero";
import { getExtendedTxt, getMainAttribute, getRandomInt, incrementRawCode } from "./util";
import { Attribute } from "./types";
import { writeFileSync } from 'fs';

/*
# Hero Relation

- Ability
Ichigo = H001
Ichigo Ability = A010 - A01F

- ButtonIcon
...

- AbilityScripts
...

- Bot
...

*/

const RAW_BASE_HERO = "H000";
const RAW_BLEACH_START = "H001";
const RAW_ONEPIECE_START = "H056";
const RAW_NARUTO_START = "H0AB";

const HERO_MOVE_SPEED = 295;
const RANDOM_MOVE_SPEED_RANGE = 15;
const BONUS_MOVE_SPEED_AGI = 15;
const BONUS_MOVE_SPEED_MIN = 5;


let vars = "", macros = "";

for (let i = 0, len = bleach_hero.length; i < len; i++) {

    const rawCode = incrementRawCode(RAW_BLEACH_START, i);
    const mainAttbr = getMainAttribute(bleach_hero[i]);
    let heroName = bleach_hero[i].metadata[Constant.PROPER_NAME_RAW];
    
    bleach_hero[i].metadata[Constant.ICON_GAME_RAW] = "ReplaceableTextures\\CommandButtons\\BTN" + bleach_hero[i].metadata[Constant.ICON_GAME_RAW];
    let heroIcon = bleach_hero[i].metadata[Constant.ICON_GAME_RAW];


    bleach_hero[i].metadata[Constant.ICON_SCREEN_RAW] = heroIcon;
    bleach_hero[i].metadata[Constant.SPEED_BASE_RAW] = HERO_MOVE_SPEED + getRandomInt(0, RANDOM_MOVE_SPEED_RANGE / BONUS_MOVE_SPEED_MIN) * BONUS_MOVE_SPEED_MIN;
    if (mainAttbr === Attribute.AGI) {
        bleach_hero[i].metadata[Constant.SPEED_BASE_RAW] += BONUS_MOVE_SPEED_AGI;
    }
    bleach_hero[i].metadata[Constant.PRIMARY_ATTRIBUTE_RAW] = mainAttbr;

    if (!heroName) {
        throw new Error("not found hero name");
    }

    macros += `//! external ObjectMerger w3u ${RAW_BASE_HERO} ${rawCode}`;

    for (const [key, val] of Object.entries(bleach_hero[i].metadata)) {
        if (key?.[0] === "!") continue;

        macros += ` ${key} ` + (typeof val === "number" ? val : `"${val}"`);
    }

    macros += ` ${Constant.TOOTIP_NAME_RAW} "${heroName}" ${getExtendedTxt(bleach_hero[i])}\n`;
    vars += `        integer Hero${heroName.replaceAll(" ", "")} = '${rawCode}'`;

    if (i == len - 1) continue;
    vars += "\n";
}


writeFileSync(
  'hero_output.txt',
  `globals
${vars}
endglobals

${macros}`
);