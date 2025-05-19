const BASE_STATUS_POINT = 90;
const MIN_BASE_STATUS = 25;
const MAX_BASE_STATUS = 99;

const GROWN_STATUS_POINT = 9;
const MIN_GROWN_STATUS = 2;
const MAX_GROWN_STATUS = 4;

function randomFloat(min: number, max: number, step: number = 0.25): number {
    const steps = Math.floor((max - min) / step);
    const randomStep = Math.floor(Math.random() * (steps + 1));
    return parseFloat((min + randomStep * step).toFixed(2));
}

class HeroStatus {
    public status: any = {
        Strength: 0,
        Agility: 0,
        Intelligence: 0,
    };

    private remain: number;
    private min: number;
    private max: number;

    constructor(baseStatus: number, min: number, max: number) {
        this.min = min;
        this.max = max;

        for (let i = 0, keys = Object.keys(this.status), max = keys.length; i < max; i++) {
            this.status[keys[i]] = min;;
        }

        const used: any = Object.values(this.status).reduce((agg: any, item) => agg + item, 0);
        this.remain = baseStatus - used;
    }

    public random() {
       for (let i = 0, keys = Object.keys(this.status).sort(() => Math.random() - 0.5), max = keys.length; i < max; i++) {
            if (this.remain <= 0) break;

            const rand = (i === max - 1 ? this.remain : randomFloat(0, this.remain));

            let newVal = this.status[keys[i]] + rand;
            if (newVal > this.max) {
                this.remain -= newVal - this.max;
                this.status[keys[i]] = this.max;
            } else {
                this.remain -= rand;
                this.status[keys[i]] = newVal;
            }
        }
    }
}

function generateStatus() {
    const baseStatus = new HeroStatus(BASE_STATUS_POINT, MIN_BASE_STATUS, MAX_BASE_STATUS);
    const grownStatus = new HeroStatus(GROWN_STATUS_POINT, MIN_GROWN_STATUS, MAX_GROWN_STATUS);

    baseStatus.random();
    grownStatus.random();

    let result = "\n";
    let mostIndex = -1;
    let maxVal = 0;
    
    for (let i = 0, keys = Object.keys(baseStatus.status), max = keys.length; i < max; i++) {
        const sum = (baseStatus.status[keys[i]] / 10) + grownStatus.status[keys[i]];

        if (sum > maxVal) {
            maxVal = sum;
            mostIndex = i;
        }
    }

    const txts = [
        `    new StartStrength($1),
        new StrengthPerLv($2),`,
    `        new StartAgility($1),
        new AgilityPerLv($2),`,
    `        new StartIntelligence($1),
        new IntelligencePerLv($2)`
    ];
    let txtResult = "";

    for (let i = 0, keys = Object.keys(baseStatus.status), max = keys.length; i < max; i++) {
        result += (i == mostIndex ? "|c00ea1d2f" : "|c003a59e5") + keys[i] + " -|r " + baseStatus.status[keys[i]] + " + " + grownStatus.status[keys[i]] + "\n"
        txtResult += txts[i].replaceAll("$1", baseStatus.status[keys[i]]).replaceAll("$2", grownStatus.status[keys[i]]) + "\n";
    }
    
    console.log(result);
    console.log(txtResult);
    console.log(Object.keys(baseStatus.status)[mostIndex]);
}

console.clear();
generateStatus();