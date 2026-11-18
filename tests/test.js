/* Run with Node; no packages required. Max/Live integration still needs the manual smoke check. */
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const vm = require('node:vm');
const code = path.join(__dirname, '../tesser_curve/code');
const ramp = require(path.join(code, 'tesser_ramp_core.js'));
let passed = 0;
function test(name, fn) {
    try { fn(); passed++; console.log('PASS', name); }
    catch (e) { console.error('FAIL', name); throw e; }
}
function parse(s) { const c = ramp.parse(s); assert.equal(c.ok, true, c.error); return c; }
function close(a, b, epsilon = 1e-9) { assert.ok(Math.abs(a-b) <= epsilon, `${a} != ${b}`); }
test('user examples, omitted curve, descending values, percentages and Unicode seconds', () => {
    assert.deepEqual([parse("lin 0-76 3.45''").from, parse("lin 0-76 3.45''").to], [0,76]);
    const one = parse("lin 76 3.45''"); assert.equal(one.from, null); assert.equal(one.seconds, 3.45);
    assert.equal(parse('76 3.45s').curve, 'lin'); assert.equal(parse('76 3.45s').motion, 'none');
    assert.equal(parse('LOG 127–0 3.45″').seconds, 3.45);
    assert.equal(parse('sin 25%-100% 500ms').from, 31.75);
    assert.equal(parse('smo 0-127 0').seconds, 0);
    assert.equal(parse('lin brownian 76 2s amt=4 rate=7 seed=42').motion, 'bro');
    assert.equal(parse('chaotic 76 2s amt=4').curve, 'lin');
});
test('legacy absolute, percent and exponent commands', () => {
    assert.equal(parse('67').value, 67); close(parse('56.7%').value, 72.009);
    assert.equal(parse('x1.56').factor, 1.56);
});
test('percent targets and range suffixes convert to MIDI units before interpolation', () => {
    close(parse('76%').value, 96.52);
    assert.equal(parse('100%').value, 127);
    const one = parse("lin 76% 3.45''");
    assert.equal(one.from, null); close(one.to, 96.52);
    for (const [text, from, to] of [
        ['0-76%', 0, 96.52], ['25-76%', 31.75, 96.52],
        ['25%-76%', 31.75, 96.52], ['100-0%', 127, 0],
        ['12.5-87.5%', 15.875, 111.125], ['0-100%', 0, 127]
    ]) {
        const command = parse(`lin ${text} 2s`);
        close(command.from, from); close(command.to, to);
        close(ramp.sample(ramp.create(command, 55, 0, 1), 1000).value, (from + to) / 2);
    }
    // Unsuffixed ranges retain raw MIDI units; explicit first-only units remain supported.
    assert.equal(parse('lin 25-76 2s').from, 25);
    assert.equal(parse('lin 25%-76 2s').to, 76);
    for (const bad of ['101%', 'lin 101% 2s', 'lin 101-76% 2s', 'lin 0-101% 2s',
        'lin 127-0% 2s', 'lin 25%%-76% 2s', 'lin -1-76% 2s']) {
        assert.equal(ramp.parse(bad).ok, false, bad);
    }
});
test('reject malformed names, invalid numbers, stray suffixes and unsafe ranges', () => {
    for (const bad of ['', 'Verse 76', 'lin 0-128 2s', 'lin -1-76 2s', 'lin 76 -2s', 'lin 76 Infinity',
        'lin 76 NaN', 'lin 76 1e400s', 'lin 76 2s extra', 'lin 76 2s amt=8', 'lin bro 76 2s rate=0',
        'lin bro 76 2s amt=128', 'lin bro 76 2s seed=1.5', 'lin bro 76 2s seed=0', 'lin bro 76 2s amt=2 amt=3',
        'foo 76 2s', 'lin 0--76 2s', 'lin 76 86401s', 'lin 101%-20 2s', 'x0', 'x3.1', '128',
        'lin 76 2s; lin 10 1s', 'lin 76 2s shape=0']) {
        assert.equal(ramp.parse(bad).ok, false, bad);
    }
});
test('all base curves are monotonic, normalized and different', () => {
    for (const c of ramp.curves) {
        let previous = 0;
        for (let i=0; i<=1000; i++) { const x = ramp.curve(c,i/1000,4); assert.ok(x>=previous && x<=1); previous=x; }
        assert.equal(ramp.curve(c,0,4),0); assert.equal(ramp.curve(c,1,4),1);
    }
    assert.ok(ramp.curve('log', .25, 4) > .25);
    assert.ok(ramp.curve('exp', .25, 4) < .25);
    assert.ok(ramp.curve('sin', .25, 4) < .25);
});
test('every curve/motion hits exact endpoints and clamps MIDI under extreme modulation', () => {
    for (const c of ramp.curves) for (const m of ramp.motions) for (const range of ['0-127','127-0','40-90','70-70']) {
        const command = parse(`${c} ${m} ${range} 3.45s${m==='none'?'':' amt=127 rate=30 seed=99'}`);
        const r = ramp.create(command, 12, 100, 4);
        assert.equal(ramp.sample(r,100).value,command.from);
        assert.equal(ramp.sample(r,3550).value,command.to);
        assert.equal(ramp.sample(r,4000).done,true);
        for (let i=0;i<3450;i+=17) { const v=ramp.sample(r,100+i).value; assert.ok(v>=0 && v<=127 && Number.isFinite(v)); }
    }
});
test('from-current, zero duration, deterministic seeds and bounded allocation', () => {
    const r=ramp.create(parse('lin 76 2s'),23,0,1); assert.equal(r.from,23); close(ramp.sample(r,1000).value,49.5);
    assert.equal(ramp.sample(ramp.create(parse('lin 0-76 0s'),5,0,1),0).value,76);
    for (const m of ['bro','cha']) {
        const cmd=parse(`lin ${m} 0-76 3s amt=20 seed=123`);
        const a=ramp.create(cmd,0,0,1), b=ramp.create(cmd,0,0,999);
        assert.deepEqual(a.knots,b.knots); assert.ok(a.knots.some(v=>v!==0));
        const long=ramp.create(parse(`lin ${m} 76 86400s rate=30`),0,0,1); assert.equal(long.knots.length,4096);
    }
});

function maxHarness(file, extra={}) {
    let clock=0; const tasks=[], output=[];
    function FakeDate() { this.getTime=()=>clock; }
    class Task {
        constructor(fn, self) { this.fn=fn; this.self=self; this.due=null; tasks.push(this); }
        schedule(delay) { this.due=clock+delay; }
        cancel() { this.due=null; }
        freepeer() { this.cancel(); this.freed=true; }
    }
    const context=vm.createContext({Task, Date:FakeDate, Math, post:()=>{}, outlet:(...a)=>output.push(a),
        arrayfromargs:a=>Array.from(a), ...extra});
    context.include=name=>vm.runInContext(fs.readFileSync(path.join(code,name),'utf8'),context);
    const runtime = file === 'tesser_curve_engine.js' ? path.join(code, '../patchers/tesser_curve_runtime.js') : path.join(code,file);
    vm.runInContext(fs.readFileSync(runtime,'utf8'),context);
    if (file === 'tesser_curve_engine.js' && !extra.deferInit) context.init();
    return {ctx:context, output, tasks, now:()=>clock,
        advance(ms) {
            clock+=ms; let guard=100;
            while (tasks.some(t=>t.due!==null && t.due<=clock)) {
                assert.ok(guard-- > 0, 'task recursion');
                const t=tasks.find(t=>t.due!==null && t.due<=clock); t.due=null; t.fn.call(t.self);
            }
        },
        midi:()=>output.filter(x=>x[0]===0 && Array.isArray(x[1])).map(x=>Array.from(x[1]))};
}
test('Max engine remembers real outputs, lands on deadline and sleeps when done', () => {
    const h=maxHarness('tesser_curve_engine.js'), e=h.ctx;
    e.input(20,3); assert.deepEqual(h.midi().at(-1),[178,22,20]);
    e.clipname("lin 76 3.45''"); assert.deepEqual(h.midi().at(-1),[176,22,20]);
    h.advance(1725); assert.equal(h.midi().at(-1)[2],48);
    h.advance(1725); assert.equal(h.midi().at(-1)[2],76);
    assert.equal(e.current,76); assert.equal(e.activeRamp,null); assert.ok(h.tasks.every(t=>t.due===null));
    const n=h.midi().length; h.advance(10000); assert.equal(h.midi().length,n);
});
test('parameter initialization does not send an unsolicited input value on load', () => {
    const h=maxHarness('tesser_curve_engine.js',{deferInit:true}); h.ctx.input(64); assert.equal(h.midi().length,0);
    h.ctx.init(); h.ctx.input(64); assert.equal(h.midi().at(-1)[2],64);
});
test('percentage ramps preserve remembered MIDI state and round only the emitted values', () => {
    const h=maxHarness('tesser_curve_engine.js'), e=h.ctx;
    e.statuscc(23); e.cc(23,41,1); e.factor(2);
    e.clipname("lin 76% 3.45''"); assert.equal(h.midi().at(-1)[2],41);
    h.advance(3450); assert.equal(h.midi().at(-1)[2],97);
    e.clipname('lin 25-100% 2s'); assert.equal(h.midi().at(-1)[2],32);
    h.advance(1000); assert.equal(h.midi().at(-1)[2],79);
    h.advance(1000); assert.equal(h.midi().at(-1)[2],127);
    e.clipname('lin 100-0% 1s'); assert.equal(h.midi().at(-1)[2],127);
    h.advance(1000); assert.equal(h.midi().at(-1)[2],0);
});
test('status input does not echo; most recent value starts the next one-value ramp', () => {
    const h=maxHarness('tesser_curve_engine.js'), e=h.ctx;
    e.statuscc(23); e.cc(23,61,1); assert.equal(h.midi().length,0); assert.equal(e.current,61);
    e.clipname('lin 90 1s'); assert.equal(h.midi()[0][2],61);
    h.advance(500); assert.equal(e.current,76);
    e.cc(23,12,1); e.clipname('lin 100 1s'); assert.equal(h.midi().at(-1)[2],12);
    h.advance(1000); e.clipname('lin 40 1s'); assert.equal(h.midi().at(-1)[2],100);
});
test('explicit endpoints bypass CC exponent; original CC and legacy values retain it', () => {
    const h=maxHarness('tesser_curve_engine.js'), e=h.ctx; e.factor(2);
    e.clipname('lin 20-76 1s'); assert.equal(h.midi().at(-1)[2],20);
    h.advance(1000); assert.equal(h.midi().at(-1)[2],76);
    e.clipname('64'); assert.equal(h.midi().at(-1)[2],32);
    e.clipname('x1'); e.cc(22,64,7); assert.deepEqual(h.midi().at(-1),[182,22,64]);
});
test('new clip, primary input, stop and device disable cancel active ramps', () => {
    const h=maxHarness('tesser_curve_engine.js'), e=h.ctx;
    e.clipname('lin 0-100 1s'); h.advance(500); e.clipname('lin 0 1s');
    assert.equal(h.midi().at(-1)[2],50); h.advance(1000); assert.equal(e.current,0);
    e.clipname('lin 0-100 1s'); e.cc(22,90,1); assert.equal(e.activeRamp,null);
    e.clipname('lin 0-100 1s'); e.stop(); const n=h.midi().length; h.advance(2000); assert.equal(h.midi().length,n);
    e.clipname('lin 0-100 1s'); e.enabled(0); assert.equal(e.activeRamp,null);
    assert.deepEqual(h.output.at(-1),[3,'ctl','none']);
    e.cc(22,12,4); assert.deepEqual(h.midi().at(-1),[179,22,12]);
    e.enabled(1); e.clipname('ordinary clip label'); assert.equal(e.activeRamp,null);
});
test('deduplicate stationary ramps, force endpoint, isolate instances, and clean up tasks', () => {
    const a=maxHarness('tesser_curve_engine.js'), b=maxHarness('tesser_curve_engine.js');
    a.ctx.clipname('lin 42-42 1s'); for(let i=0;i<49;i++) a.advance(20);
    assert.equal(a.midi().length,1); a.advance(20); assert.equal(a.midi().length,2);
    assert.equal(b.ctx.current,0); assert.equal(b.midi().length,0);
    a.ctx.notifydeleted(); assert.ok(a.tasks.every(t=>t.freed));
});
test('manual Run uses menus; omitted clip selectors always reset to linear/clean', () => {
    const h=maxHarness('tesser_curve_engine.js'), e=h.ctx;
    e.curveindex(3); e.motionindex(3); e.target(80); e.duration(2); e.amount(5); e.run();
    assert.equal(e.activeRamp.curve,'sin'); assert.equal(e.activeRamp.motion,'zig');
    e.clipname('76 1s'); assert.equal(e.activeRamp.curve,'lin'); assert.equal(e.activeRamp.motion,'none');
});
test('control-rate stress: 64 independent one-second ramps produce bounded MIDI traffic', () => {
    const devices=Array.from({length:64},()=>maxHarness('tesser_curve_engine.js'));
    for(const d of devices) d.ctx.clipname('lin bro 0-127 1s amt=8 seed=42');
    for(let i=0;i<50;i++) for(const d of devices) d.advance(20);
    for(const d of devices) { assert.equal(d.ctx.current,127); assert.ok(d.midi().length<=51); assert.equal(d.ctx.activeRamp,null); }
});

function liveHarness() {
    const track={id:10,type:'Track',path:'live_set tracks 1',playing_slot_index:-1};
    const song={id:1,type:'Song',path:'live_set',is_playing:0};
    const device={id:5,type:'Device',path:'this_device'};
    const chain={id:6,type:'Chain',path:'live_set tracks 1 devices 0 chains 0'};
    const clips=[{id:100,type:'Clip',name:"lin 0-76 3.45''",is_playing:0,is_triggered:0,start_time:0},
        {id:101,type:'Clip',name:'log 20 2s',is_playing:0,is_triggered:0,start_time:0}];
    const observers=[];
    class LiveAPI {
        constructor(callback, address) {
            this.callback=callback; this._property=''; observers.push(this);
            this.obj=typeof address==='number' ? [track,song,device,chain,...clips].find(x=>x.id===address) :
                address==='this_device'?device:address==='live_set'?song:
                address.startsWith(track.path+' clip_slots ')?clips[Number(address.split(' clip_slots ')[1].split(' ')[0])]:null;
        }
        get id() { return this.obj?.id || 0; } set id(v) { if(!v) this.obj=null; }
        get type() { return this.obj?.type; }
        get unquotedpath() { return clips.includes(this.obj)?track.path+' clip_slots '+clips.indexOf(this.obj)+' clip':this.obj?.path; }
        get property() { return this._property; }
        set property(v) { this._property=v; if(v && this.callback) this.callback([v,this.obj?.[v]]); }
        goto(p) { assert.equal(p,'canonical_parent'); this.obj=this.obj===device?chain:track; }
        get(p) { assert.ok(this.obj && p in this.obj, 'invalid API read '+p); return this.obj[p]; }
    }
    const h=maxHarness('tesser_session_watch.js',{LiveAPI});
    return {...h, track, song, clips, observers,
        event(obj, prop, value) { obj[prop]=value; for(const a of [...observers]) if(a.obj===obj && a.property===prop) a.callback([prop,value]); },
        launches() { return h.output.filter(x=>x[0]===0 && x[1]==='clipname'); }};
}
test('Session watcher initializes after Live, climbs racks and stays idle', () => {
    const h=liveHarness(); assert.equal(h.observers.length,0); h.ctx.init(); h.advance(0);
    assert.equal(h.ctx.track.id,10); assert.equal(h.launches().length,0); assert.ok(h.tasks.every(t=>t.due===null));
});
test('Session launches wait for playback, retrigger same slot, ignore loops and names', () => {
    const h=liveHarness(); h.ctx.init(); h.advance(0);
    h.event(h.song,'is_playing',1); h.event(h.track,'playing_slot_index',0);
    h.clips[0].is_triggered=1; h.advance(0); assert.equal(h.launches().length,0);
    h.clips[0].is_playing=1; h.clips[0].is_triggered=0; h.event(h.clips[0],'start_time',4); h.advance(0);
    assert.equal(h.launches().length,1);
    h.event(h.clips[0],'playing_status',1); h.advance(0); assert.equal(h.launches().length,1);
    h.clips[0].name='sin 30 2s'; h.event(h.clips[0],'playing_status',1); h.advance(0); assert.equal(h.launches().length,1);
    h.clips[0].is_triggered=1; h.event(h.clips[0],'playing_status',1); h.advance(0); assert.equal(h.launches().length,1);
    h.clips[0].is_triggered=0; h.event(h.clips[0],'start_time',8); h.advance(0);
    assert.equal(h.launches().length,2); assert.equal(h.launches()[1][2],'sin 30 2s');
});
test('Session clip switches, transport stop/resume, track stop and observer disposal', () => {
    const h=liveHarness(); h.ctx.init(); h.advance(0); h.song.is_playing=1;
    h.clips[0].is_playing=1; h.event(h.track,'playing_slot_index',0); h.advance(0);
    h.clips[1].is_playing=1; h.event(h.track,'playing_slot_index',1); h.advance(0); assert.equal(h.launches().length,2);
    assert.equal(h.observers.filter(x=>x.obj===h.clips[0] && x.property).length,0);
    h.event(h.song,'is_playing',0); h.advance(0); assert.deepEqual(h.output.at(-1),[0,'stop']);
    h.event(h.song,'is_playing',1); h.advance(0); assert.equal(h.launches().length,3);
    h.event(h.track,'playing_slot_index',-2); h.advance(0); assert.deepEqual(h.output.at(-1),[0,'stop']);
    h.ctx.notifydeleted(); assert.ok(h.observers.every(x=>!x.id && !x.property)); assert.ok(h.tasks.every(t=>t.freed));
});
test('observer remains attached to its own track after track reorder', () => {
    const h=liveHarness(); h.ctx.init(); h.advance(0); h.song.is_playing=1; h.track.path='live_set tracks 3';
    h.clips[0].is_playing=1; h.event(h.track,'playing_slot_index',0); h.advance(0);
    assert.equal(h.launches().length,1); assert.equal(h.ctx.track.id,10);
});

test('patch graph, MIDI passthrough, curve controls and bundled dependencies', () => {
    const p=JSON.parse(fs.readFileSync(path.join(__dirname,'../tesser_curve/patchers/tesser_curve.maxpat'))).patcher;
    function validate(p) {
        const ids=new Map(p.boxes.map(x=>[x.box.id,x.box])); assert.equal(ids.size,p.boxes.length);
        for(const {patchline:l} of p.lines) {
            assert.ok(ids.has(l.source[0]) && ids.has(l.destination[0]),JSON.stringify(l));
            assert.ok(l.source[1] < ids.get(l.source[0]).numoutlets);
            assert.ok(l.destination[1] < ids.get(l.destination[0]).numinlets);
        }
        for(const {box:b} of p.boxes) if(b.patcher) validate(b.patcher);
    }
    validate(p);
    assert.ok(p.lines.some(({patchline:l})=>l.source[0]==='midi-select' && l.source[1]===7 && l.destination[0]==='obj-2'));
    assert.equal(p.boxes.filter(x=>x.box.maxclass==='live.menu').length,2);
    const project=JSON.parse(fs.readFileSync(path.join(__dirname,'../tesser_curve/tesser_curve.maxproj')));
    // Max may omit its optional dependency cache when saving; verify the actual JS references.
    for(const {box:b} of p.boxes) if(/^js /.test(b.text || '')) {
        assert.ok(fs.existsSync(path.join(code,'../patchers',b.text.split(/\s+/)[1])));
    }
    for(const d of p.dependency_cache || []) { assert.ok(fs.existsSync(path.join(code,'../patchers',d.name))); }
    for(const name of ['tesser_ramp_core.js','tesser_curve_engine.js','tesser_session_watch.js']) assert.ok(project.contents.code[name]);
    assert.ok(p.lines.some(({patchline:l})=>l.source[0]==='session-watch' && l.destination[0]==='session-command-defer'));
    assert.ok(p.boxes.some(({box:b})=>b.id==='midi-select' && b.text.includes('@hires 2')));
    for(const {box:b} of p.boxes) if(b.presentation) {
        const [x,y,w,h]=b.presentation_rect; assert.ok(x>=0 && y>=0 && x+w<=760 && y+h<=169,b.id);
    }
});
console.log(`\n${passed} test groups passed.`);
