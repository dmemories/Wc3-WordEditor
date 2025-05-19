
// RAW CODE
// BLEACH:   H001 - H055   (85 Heroes)
// ONEPIECE: H056 - H0AA   (85 Heroes)
// NARUTO:   H0AB - H0FF   (85 Heroes)


import Constant from "./constant";
import bleach_hero from "./bleach_hero";
import { getExtendedTxt, incrementRawCode } from "./base_object";

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


let vars = "", macros = "";

for (let i = 0, len = bleach_hero.length; i < len; i++) {

    const rawCode = incrementRawCode(RAW_BLEACH_START, i);
    let heroName = bleach_hero[i].metadata[Constant.PROPER_NAME_RAW];

    if (!heroName) {
        throw new Error("not found hero name");
    }


    macros += `//! external ObjectMerger w3u ${RAW_BASE_HERO} ${rawCode}`;

    for (const field of bleach_hero[i].objs) {
        if (!field.rawField) continue;

        macros += ` ${field.rawField} ` + (typeof field.value === "number" ? field.value : `"${field.value}"`);
    }

    macros += ` ${Constant.TOOTIP_NAME_RAW} "${heroName}" ${getExtendedTxt(bleach_hero[i])}\n`;
    vars += `        integer Hero${heroName.replaceAll(" ", "")} = '${rawCode}'`;

    if (i == len - 1) continue;
    vars += "\n";
}


console.log(`globals
${vars}
endglobals

${macros}`)