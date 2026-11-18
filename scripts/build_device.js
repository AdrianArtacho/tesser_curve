// Write the standard unfrozen Max MIDI Effect container (ampf/meta/ptch chunks).
// Runtime scripts stay beside the .amxd; use Max's Freeze command for a single-file distribution.
const fs = require('node:fs');
const path = require('node:path');
require('./build_runtime.js');
const dir = path.join(__dirname, '../tesser_curve/patchers');
function chunk(tag, data) {
    const header = Buffer.alloc(8); header.write(tag); header.writeUInt32LE(data.length, 4);
    return Buffer.concat([header, data]);
}
const patch = Buffer.concat([fs.readFileSync(path.join(dir, 'tesser_curve.maxpat')), Buffer.from([0])]);
const device = Buffer.concat([chunk('ampf', Buffer.from('mmmm')), chunk('meta', Buffer.alloc(4)), chunk('ptch', patch)]);
fs.writeFileSync(path.join(dir, 'tesser_curve.amxd'), device);
