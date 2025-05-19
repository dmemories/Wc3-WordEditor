import { getDetail, Height, incrementRawCode, IObject, MaxPitchAngle, ModelFile, ScailingValue } from "./base_object";

const RAW_BASE_DUMMY = "d000";
const RAW_DUMMY_START = "d010";

const DUMMIES: IObject[] = [
    {
        name: "Select Hero",
        objs: [
            new MaxPitchAngle(-28.5),
            new ModelFile("HeroSelect.mdx"),
            new ScailingValue(0.6),
            new Height(40)
        ]
    },
];

let vars = "", macros = "";

for (let i = 0, len = DUMMIES.length; i < len; i++) {
    const rawCode = incrementRawCode(RAW_DUMMY_START, i);
    
    DUMMIES[i].name = "Dummy " + DUMMIES[i].name;

    vars += `        integer ${DUMMIES[i].name.replaceAll(" ", "")} = '${rawCode}'`;
    macros += `//! external ObjectMerger w3u ${RAW_BASE_DUMMY} ${rawCode} unam "${DUMMIES[i].name}"${getDetail(DUMMIES[i].objs)}\n`;
    
    if (i == len - 1) continue;

    vars += "\n";
}

console.log(`globals
${vars}
endglobals

${macros}`)