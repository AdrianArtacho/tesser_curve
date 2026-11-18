// Open tests/generated/native_smoke.maxpat in standalone Max, then inspect native-result.json.
// The fixture replaces MIDI output with an assertion sink; it does not send to hardware.
const fs = require('node:fs');
const path = require('node:path');
const root = path.join(__dirname, '..');
const source = path.join(root, 'tesser_curve/patchers');
const output = path.resolve(process.argv[2] || path.join(root, 'tests/generated'));
fs.mkdirSync(output, {recursive:true});
const p = JSON.parse(fs.readFileSync(path.join(source, 'tesser_curve.maxpat'))).patcher;
p.lines = p.lines.filter(({patchline:l}) => l.source[0] !== 'obj-1' && l.destination[0] !== 'session-watch');
for (const {patchline:l} of p.lines) if(l.destination[0] === 'obj-2') l.destination=['native-probe',1];
for (const [id,text,ins,outs,x,y] of [
    ['native-probe','js native_probe.js',3,2,400,450],
    ['probe-load','loadbang',1,1,400,380], ['probe-delay','delay 500',2,1,400,410],
    ['native-cmd-defer','deferlow',1,1,850,450]
]) p.boxes.push({box:{id,maxclass:'newobj',text,numinlets:ins,numoutlets:outs,patching_rect:[x,y,300,22]}});
for (const [s,so,d,di] of [
    ['probe-load',0,'probe-delay',0],['probe-delay',0,'native-probe',0],
    ['native-probe',0,'midi-select',0],['native-probe',1,'native-cmd-defer',0],
    ['native-cmd-defer',0,'ramp-engine',0],['ramp-engine',2,'native-probe',2]
]) p.lines.push({patchline:{source:[s,so],destination:[d,di]}});
fs.writeFileSync(path.join(output,'native_smoke.maxpat'),JSON.stringify({patcher:p},null,2));
for (const name of ['tesser_curve_runtime.js','tesser_session_runtime.js']) fs.copyFileSync(path.join(source,name),path.join(output,name));
fs.copyFileSync(path.join(root,'tests/native_probe.js'),path.join(output,'native_probe.js'));
console.log(path.join(output,'native_smoke.maxpat'));
