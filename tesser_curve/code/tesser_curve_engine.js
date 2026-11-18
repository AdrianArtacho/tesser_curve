/* Max 8 legacy js. Outlets: MIDI bytes list; UI route; status text; midiselect config. */
autowatch = 1;
inlets = 1;
outlets = 4;
include("tesser_ramp_core.js");
var current = 0, ccIn = 22, ccOut = 22, stateCC = -1, channel = 1, exponent = 1;
var isEnabled = true, ready = false, interval = 20, activeRamp = null, lastSent = {};
var choice = {curve: "lin", motion: "none", to: 76, seconds: 3.45, amount: 8, rate: 4, shape: 4, seed: null};
var ticker = new Task(tick, this);
function now() { return new Date().getTime(); }
function status(s) { outlet(2, "set", s); }
function ui(key, v) { outlet(1, key, "set", v); }
function finite(v, lo, hi) { return isFinite(v) && v >= lo && v <= hi; }
function filter() {
    if (!isEnabled) { outlet(3, "ctl", "none"); }
    else if (stateCC >= 0 && stateCC !== ccIn) { outlet(3, "ctl", ccIn, stateCC); }
    else { outlet(3, "ctl", ccIn); }
    if (stateCC === ccIn) { status("Status CC must differ from Input CC; status input inactive"); }
}
function init() { ready = true; filter(); ui("current", current); }
function enabled(v) { isEnabled = Number(v) !== 0; if (!isEnabled) { stop(); } filter(); }
function inputcc(v) { if (finite(v, 0, 127)) { ccIn = Math.round(v); filter(); } }
function outputcc(v) { if (finite(v, 0, 127)) { stop(); ccOut = Math.round(v); lastSent = {}; } }
function statuscc(v) { if (finite(v, -1, 127)) { stateCC = Math.round(v); filter(); } }
function outchannel(v) { if (finite(v, 1, 16)) { stop(); channel = Math.round(v); lastSent = {}; } }
function factor(v) { if (finite(v, 0.01, 3)) { exponent = Number(v); } }
function grain(v) { if (finite(v, 10, 100)) { interval = Math.round(v); } }
function curveindex(v) { if (TesserRamp.curves[v]) { choice.curve = TesserRamp.curves[v]; } }
function motionindex(v) { if (TesserRamp.motions[v]) { choice.motion = TesserRamp.motions[v]; } }
function target(v) { if (finite(v, 0, 127)) { choice.to = Number(v); } }
function duration(v) { if (finite(v, 0, 86400)) { choice.seconds = Number(v); } }
function amount(v) { if (finite(v, 0, 127)) { choice.amount = Number(v); } }
function rate(v) { if (finite(v, 0.01, 30)) { choice.rate = Number(v); } }
function shape(v) { if (finite(v, 0.1, 10)) { choice.shape = Number(v); } }
function seed(v) { if (finite(v, 0, 2147483646)) { choice.seed = Number(v) === 0 ? null : Math.round(v); } }
function remember(v) { current = Math.round(TesserRamp.clamp(v, 0, 127)); ui("current", current); }
function emit(v, ch, force) {
    v = Math.round(TesserRamp.clamp(v, 0, 127));
    var key = ch + ":" + ccOut;
    if (force || lastSent[key] !== v) {
        lastSent[key] = v; remember(v);
        outlet(0, [175 + ch, ccOut, v]);
    }
}
function cc(control, value, ch) {
    control = Number(control); value = Number(value); ch = Number(ch);
    if (!finite(value, 0, 127) || !finite(ch, 1, 16)) { return; }
    if (!isEnabled || (control !== ccIn && control !== stateCC)) { outlet(0, [175 + ch, control, value]); return; }
    if (stateCC >= 0 && stateCC !== ccIn && control === stateCC) { remember(value); return; }
    if (control === ccIn) { input(value, ch); }
}
function input(v, ch) {
    if (!isEnabled || !ready || !finite(v, 0, 127)) { return; }
    stop(false); ui("input", v);
    emit(127 * Math.pow(v / 127, exponent), ch || channel, true);
    status("CC input");
}
function stop(show) {
    ticker.cancel(); activeRamp = null;
    ui("running", 0);
    if (show !== false) { status("Stopped — holding " + current); }
}
function start(command) {
    if (!isEnabled || !ready) { return; }
    stop(false);
    activeRamp = TesserRamp.create(command, current, now(), 1 + Math.floor(Math.random() * 2147483645));
    ui("curve", TesserRamp.curves.indexOf(command.curve)); ui("motion", TesserRamp.motions.indexOf(command.motion));
    ui("target", command.to); ui("duration", command.seconds); ui("amount", command.amount);
    ui("rate", command.rate); ui("shape", command.shape); ui("seed", command.seed || 0);
    choice = {curve: command.curve, motion: command.motion, to: command.to, seconds: command.seconds,
        amount: command.amount, rate: command.rate, shape: command.shape, seed: command.seed};
    ui("running", 1);
    status(command.curve + " / " + command.motion + " → " + command.to + " in " + command.seconds + "s");
    tick(true);
}
function tick(first) {
    if (!activeRamp || !isEnabled) { return; }
    var time = now(), result = TesserRamp.sample(activeRamp, first === true ? activeRamp.started : time);
    emit(result.value, channel, first === true || result.done);
    if (result.done) { ticker.cancel(); activeRamp = null; ui("running", 0); status("Done — " + current); }
    else { ticker.schedule(Math.max(1, Math.min(interval, activeRamp.started + activeRamp.duration - time))); }
}
function run() {
    start({from: null, to: choice.to, seconds: choice.seconds, curve: choice.curve, motion: choice.motion,
        amount: choice.motion === "none" ? 0 : choice.amount, rate: choice.rate, shape: choice.shape, seed: choice.seed});
}
function clipname() {
    if (!isEnabled) { return; }
    try {
    var parts = [], i;
    for (i = 0; i < arguments.length; i++) { parts.push(String(arguments[i])); }
    var name = parts.join(" "), command = TesserRamp.parse(name);
    stop(false); outlet(1, "clip", "set", name);
    if (!command.ok) { status(command.error); return; }
    if (command.kind === "factor") { factor(command.factor); ui("factor", exponent); status("CC exponent " + exponent); }
    else if (command.kind === "value") { input(command.value); }
    else { start(command); }
    } catch (err) { stop(false); status("Command error: " + err); post("Tesser command error: " + err + "\n"); }
}
function notifydeleted() { ticker.cancel(); ticker.freepeer(); }
