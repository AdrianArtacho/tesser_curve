/* Pure ES5: shared by Max's legacy js object and the Node regression tests. */
var TesserRamp = (function () {
    var curves = ["lin", "log", "exp", "sin", "smo"];
    var motions = ["none", "bro", "cha", "zig"];
    var curveAliases = {lin: "lin", linear: "lin", log: "log", logarithmic: "log",
        exp: "exp", exponential: "exp", sin: "sin", sinusoidal: "sin",
        smo: "smo", smooth: "smo", smoothstep: "smo"};
    var motionAliases = {none: "none", bro: "bro", brownian: "bro", brown: "bro",
        cha: "cha", chaotic: "cha", chaos: "cha", zig: "zig", zigzag: "zig"};
    var number = "(?:\\d+(?:\\.\\d*)?|\\.\\d+)";
    function clamp(x, lo, hi) { return Math.max(lo, Math.min(hi, x)); }
    function failure(message) { return {ok: false, error: message}; }
    function value(s) {
        if (!(new RegExp("^" + number + "%?$")).test(s)) { return NaN; }
        var n = parseFloat(s), percent = /%$/.test(s);
        if (n > (percent ? 100 : 127)) { return NaN; }
        return percent ? n * 1.27 : n;
    }
    function parse(input) {
        var s = String(input).replace(/[\u2018\u2019\u2032]/g, "'")
            .replace(/[\u201c\u201d\u2033]/g, '"').replace(/[\u2013\u2014]/g, "-")
            .replace(/^\s+|\s+$/g, "").toLowerCase();
        if (!s) { return failure("Empty clip name"); }
        // Full-string matches ensure ordinary clip labels cannot accidentally send CCs.
        var legacy = s.match(new RegExp("^x(" + number + ")$"));
        if (legacy) {
            var f = +legacy[1];
            return f >= 0.01 && f <= 3 ? {ok: true, kind: "factor", factor: f} : failure("CC exponent must be 0.01–3");
        }
        var immediate = value(s);
        if (isFinite(immediate)) { return {ok: true, kind: "value", value: immediate}; }
        var tokens = s.split(/\s+/), c = "lin", m = "none";
        if (curveAliases[tokens[0]]) { c = curveAliases[tokens.shift()]; }
        if (motionAliases[tokens[0]]) { m = motionAliases[tokens.shift()]; }
        if (tokens.length < 2) { return failure("Use: lin [bro|cha|zig] [from-]to seconds"); }
        var range = tokens.shift().split("-"), from = null, to;
        if (range.length === 2) {
            // A trailing percent sign supplies the unit for both endpoints: 25-76%.
            var start = range[0];
            if (/%$/.test(range[1]) && !/%$/.test(start)) { start += "%"; }
            from = value(start); to = value(range[1]);
        }
        else if (range.length === 1) { to = value(range[0]); }
        else { return failure("Use a value or from-to, within 0–127"); }
        if (!isFinite(to) || (from !== null && !isFinite(from))) { return failure("Values must be 0–127 or 0–100%"); }
        var time = tokens.shift().match(new RegExp("^(" + number + ")(ms|s|sec|''|\")?$"));
        if (!time) { return failure("Duration must be seconds, e.g. 3.45'' or 3.45s"); }
        var seconds = +time[1] / (time[2] === "ms" ? 1000 : 1);
        if (seconds > 86400) { return failure("Duration must be 0–86400 seconds"); }
        var opts = {amt: m === "none" ? 0 : 8, rate: 4, shape: 4, seed: null}, seen = {};
        for (var i = 0; i < tokens.length; i++) {
            var pair = tokens[i].split("="), key = pair[0];
            if (pair.length !== 2 || !Object.prototype.hasOwnProperty.call(opts, key) || seen[key] ||
                !(new RegExp("^" + number + "$" )).test(pair[1])) { return failure("Options: amt=8 rate=4 shape=4 seed=42 (once each)"); }
            opts[key] = +pair[1]; seen[key] = true;
        }
        if (opts.amt < 0 || opts.amt > 127) { return failure("amt must be 0–127 MIDI units"); }
        if (opts.rate < 0.01 || opts.rate > 30) { return failure("rate must be 0.01–30 Hz"); }
        if (opts.shape < 0.1 || opts.shape > 10) { return failure("shape must be 0.1–10"); }
        if (opts.seed !== null && (opts.seed % 1 || opts.seed < 1 || opts.seed > 2147483646)) { return failure("seed must be an integer, 1–2147483646"); }
        if (m === "none" && (seen.amt || seen.rate || seen.seed)) { return failure("Choose bro, cha or zig before motion options"); }
        return {ok: true, kind: "ramp", curve: c, motion: m, from: from, to: to,
            seconds: seconds, amount: opts.amt, rate: opts.rate, shape: opts.shape, seed: opts.seed};
    }
    function curve(c, p, shape) {
        p = clamp(p, 0, 1);
        if (p === 0 || p === 1) { return p; }
        var k = shape || 4;
        if (c === "log") { return Math.log(1 + (Math.exp(k) - 1) * p) / k; }
        if (c === "exp") { return (Math.exp(k * p) - 1) / (Math.exp(k) - 1); }
        if (c === "sin") { return (1 - Math.cos(Math.PI * p)) / 2; }
        if (c === "smo") { return p * p * (3 - 2 * p); }
        return p;
    }
    function random(seed) {
        var state = Math.floor(seed) % 2147483647;
        if (state <= 0) { state += 2147483646; }
        return function () { state = state * 16807 % 2147483647; return (state - 1) / 2147483646; };
    }
    function create(command, current, now, randomSeed) {
        var r = {}, key;
        for (key in command) { if (Object.prototype.hasOwnProperty.call(command, key)) { r[key] = command[key]; } }
        r.from = command.from === null ? clamp(current, 0, 127) : command.from;
        r.started = now; r.duration = command.seconds * 1000;
        r.seed = command.seed === null ? (randomSeed || 1) : command.seed;
        r.knots = [];
        if (r.amount > 0 && r.duration > 0 && (r.motion === "bro" || r.motion === "cha")) {
            // Bounded allocation and O(1) sampling, even after scheduler stalls.
            var count = Math.min(4096, Math.max(2, Math.ceil(r.seconds * r.rate) + 1));
            var rng = random(r.seed), x = r.motion === "cha" ? 0.1 + 0.8 * rng() : 0;
            for (var i = 0; i < count; i++) {
                if (r.motion === "bro") {
                    x += (rng() * 2 - 1) * 0.45;
                    if (x > 1) { x = 2 - x; } else if (x < -1) { x = -2 - x; }
                    r.knots.push(x);
                } else { x = 3.99 * x * (1 - x); r.knots.push(x * 2 - 1); }
            }
        }
        return r;
    }
    function sample(r, now) {
        var p = r.duration === 0 ? 1 : clamp((now - r.started) / r.duration, 0, 1);
        if (p === 1) { return {value: r.to, done: true, progress: 1}; }
        if (p === 0) { return {value: r.from, done: false, progress: 0}; }
        var base = r.from + (r.to - r.from) * curve(r.curve, p, r.shape), motion = 0;
        if (r.motion === "zig") { motion = 2 / Math.PI * Math.asin(Math.sin(2 * Math.PI * p * r.seconds * r.rate)); }
        else if (r.knots.length) {
            var at = p * (r.knots.length - 1), i = Math.floor(at), frac = at - i;
            motion = r.knots[i] * (1 - frac) + r.knots[Math.min(i + 1, r.knots.length - 1)] * frac;
        }
        return {value: clamp(base + r.amount * motion * 4 * p * (1 - p), 0, 127), done: false, progress: p};
    }
    return {curves: curves, motions: motions, parse: parse, curve: curve, create: create, sample: sample, clamp: clamp};
}());
if (typeof module !== "undefined" && module.exports) { module.exports = TesserRamp; }
