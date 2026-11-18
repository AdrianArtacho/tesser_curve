autowatch=1; inlets=3; outlets=2;
var messages=[];
function anything(){if(inlet===2) messages.push(arrayfromargs(messagename,arguments));}
var results=[], bytes=[], tasks=[];
function msg_int(v) { if(inlet===1) bytes.push(v); }
function command() { var a=arrayfromargs(arguments); if(a[0]==='clipname') outlet(1,a); else this.patcher.getnamed('tesser_engine').message(a[0],a[1]); }
function check(name, yes, actual) { results.push({name:name,passed:!!yes,actual:actual}); }
function equal(a,b) { return JSON.stringify(a)===JSON.stringify(b); }
function send(a) { for(var i=0;i<a.length;i++) outlet(0,a[i]); }
function later(fn, ms) { var t=new Task(fn,this); tasks.push(t); t.schedule(ms); }
function bang() {
    var button=this.patcher.getnamed('run-button');
    command('init');
    bytes=[]; send([145,60,100,129,60,45,226,1,64]);
    later(function() {
        check('native unrelated MIDI passthrough',equal(bytes,[145,60,100,129,60,45,226,1,64]),bytes.slice());
        bytes=[]; command('factor',2); send([178,22,64]);
        later(function(){
            check('native CC number/value/channel order',equal(bytes,[178,22,32]),bytes.slice());
            bytes=[]; command('statuscc',23); send([176,23,41]);
            later(function(){
                check('status CC is consumed without output',bytes.length===0,bytes.slice());
                command('clipname',"lin 76 0.12s");
                later(function(){
                    check('native timed ramp starts at status value',equal(bytes.slice(0,3),[176,22,41]),bytes.slice(0,3));
                    check('native timed ramp lands at target',equal(bytes.slice(-3),[176,22,76]),bytes.slice(-3));
                    bytes=[]; command('target',20); command('duration',0); button.message('bang');
                    later(function(){
                        check('Run button reaches engine',equal(bytes,[176,22,20]),bytes.slice());
                        bytes=[]; command('enabled',0); send([179,22,64]);
                        later(function(){
                            check('disabled device passes selected CC unchanged',equal(bytes,[179,22,64]),bytes.slice());
                            var f=new File(this.patcher.filepath.replace(/[^\/]+$/, '') + 'native-result.json','write','TEXT');
                            f.eof=0; // Truncate a longer report from an earlier run.
                            f.writestring(JSON.stringify({results:results,messages:messages},null,2)); f.close(); post('TESSER NATIVE TEST COMPLETE\n');
                        },30);
                    },30);
                },200);
            },30);
        },30);
    },30);
}

function notifydeleted() { for(var i=0;i<tasks.length;i++){tasks[i].cancel();tasks[i].freepeer();} }
