# tesser_curve

A Max for Live MIDI effect for the original incoming-CC curve mapping and timed ramps triggered by **Session View clip names on the device's own track**. Each instance has its own remembered value and ramp state.

## Quick start

1. Drag `tesser_curve/patchers/tesser_curve.amxd` onto a MIDI track in Live (or choose **Open With → Ableton Live** in Finder). Keep `tesser_curve_runtime.js` and `tesser_session_runtime.js` beside it: the supplied device is unfrozen. Live’s **Open Live Set** command is for sets, not device insertion.
2. For editing, open `tesser_curve/tesser_curve.maxproj` in Max; the top-level patch is `tesser_curve/patchers/tesser_curve.maxpat`. Freeze/include dependencies in the Max for Live editor before distributing a single-file device.
3. Put the device on the MIDI track containing the Session clips. Set **Input CC**, **Output CC**, and the ramp **Channel**. Input/output CC default to 22.
4. Name a clip `lin 0-76 3.45''` and launch it: 0 to 76 over 3.45 seconds.
5. Name another clip `lin 20 2s`: the latest remembered value to 20 in two seconds.

The project targets Max 8's legacy `js` API. It needs no Node for Max, third-party packages, audio-rate DSP graph, or network connection. Node is used only for development tests and builds.

## Clip-name language

```text
[curve] [motion] [from-]to duration [amt=N] [rate=N] [shape=N] [seed=N]
```

Spaces separate fields; the range itself has no spaces. Names are case-insensitive. Omitted selectors always mean **linear, no motion**, independently of the menu's last selection. Menus display the last launched command and configure **Run**.

| Clip name | Result |
|---|---|
| `lin 0-76 3.45''` | Explicit start/end, duration in seconds |
| `lin 76 3.45''` | Latest remembered value → 76 |
| `76 3.45s` | Default linear curve |
| `lin 76% 3.45''` | Latest remembered value → 76% (MIDI 97 after rounding) |
| `lin 0-76% 3.45''` | 0% → 76% |
| `lin 25-100% 2s` | 25% → 100% (MIDI 31.75 → 127 before rounding) |
| `log 127-0 5s shape=3` | Descending logarithmic ramp |
| `sin 20-100 4s` | Sinusoidal ease-in/ease-out |
| `exp 25%-100% 2s` | Exponential ramp from 31.75 to 127 before MIDI rounding |
| `lin bro 0-76 3.45'' amt=8 rate=4 seed=42` | Linear plus repeatable Brownian motion |
| `sin cha 100 6s amt=12 rate=8` | Sinusoidal plus chaotic motion |
| `lin zig 20-100 4s amt=10 rate=2` | Linear plus two-Hz triangle motion |
| `lin 76 0s` | Immediate jump directly to 76 |

Durations accept `3.45''`, `3.45"`, `3.45″`, `3.45s`, `3.45sec`, bare seconds, or `3450ms`. Smart apostrophes are accepted. Values must be 0–127 or 0–100%; duration must be 0–86,400 seconds. Decimal outputs are rounded to MIDI integers. Invalid names/options display an explanation and produce no ramp.

A trailing `%` applies to both endpoints of a range: `25-76%` means the same as `25%-76%`. `100%` is exactly MIDI 127. Conversion happens before interpolation; only the emitted MIDI values are rounded, so `76%` arrives at MIDI 97. A single target such as `lin 76% 3.45s` still starts at the remembered MIDI value. Unsuffixed ranges such as `25-76` remain raw MIDI values. Percentages apply to target/start values, not `amt`, `rate` or other options.

### Curves

| Selector | Shape |
|---|---|
| `lin` / `linear` | Straight interpolation |
| `log` / `logarithmic` | Fast start, slower finish |
| `exp` / `exponential` | Slow start, faster finish |
| `sin` / `sinusoidal` | Half-cosine S-shaped easing |
| `smo` / `smoothstep` | Cubic S-shaped easing |

`shape=0.1` through `shape=10` controls log/exp strength; default 4. Other curves ignore shape. All curves support ascending, descending and equal endpoints.

### Motion

Choose `bro` / `brownian`, `cha` / `chaotic`, or `zig` / `zigzag` immediately after the curve. Motion is added in MIDI-value units, then limited to 0–127. Its envelope is zero at both endpoints, preserving the commanded start and final value.

- **amt**: maximum deviation, 0–127 MIDI units; default 8 when motion is specified. The envelope and output clipping can reduce the actual deviation.
- **rate**: 0.01–30 Hz; default 4. Zigzag uses cycles/second; Brownian/chaotic use approximately this many interpolated motion points/second.
- **seed**: integer 1–2,147,483,646. The same seed, duration and settings repeat the path; omission chooses a new path each launch. The GUI uses **0** for random. Zigzag is deterministic and ignores seed.

Brownian is a bounded random walk; chaotic uses an interpolated logistic map. Motion can temporarily reverse direction. Leave it out for a clean monotonic ramp. Motion-only options without a motion selector are rejected to catch misspelled commands.

## Remembered value and MIDI

**Current** is the latest emitted integer or latest received status-CC value, whichever happened most recently. It starts at zero when loaded and is intentionally temporary, not a stored preset. One-value ramps snapshot Current at launch; explicit `from-to` commands always use their written start.

Set **Status CC** to a different CC number for external feedback. **-1 disables it** (default). It updates Current without emitting MIDI or changing a running ramp's trajectory. The next emitted ramp value becomes Current again. If Input CC and Status CC match, primary input takes precedence and status input is inactive; the status display explains the conflict.

The original primary mapping remains `127 × (input / 127)^exponent`. Primary CC input or the Input dial cancels an active ramp and takes control. Incoming primary CC retains its channel; ramps and the manual Input dial use **Channel**. All input channels are accepted, sharing one Current per device.

Timed commands specify **output values**, bypassing the original CC exponent. Existing immediate clip commands retain their meaning:

- `67`: feed 67 into the original mapping.
- `56%`: feed 56% of 127 into the original mapping.
- `x1.56`: change the exponent to 1.56 (range 0.01–3).

Unselected MIDI passes through the native selector, including notes, unrelated CCs and full-resolution pitch bend. Selected status CCs are consumed. Disabling passes MIDI through and cancels the timer. Changing Output CC or Channel stops the ramp. Launching an ordinary clip label also cancels the previous ramp and holds its last output.

Multiple devices on one track read the same clip name. Use different output CCs to send that movement to different destinations, or use separate tracks for independent clip commands. This language does not address individual devices within one track.

## Launch and manual controls

- Start at **actual clip playback**, after launch quantization, not while queued.
- Another clip or a same-slot relaunch starts the new command. Normal looping does not repeat it.
- Renaming a playing clip takes effect on its next launch.
- Track/clip stop, transport stop, **Stop**, and disable cancel the ramp and hold its output. Restarting transport with a Session clip still playing starts its command again.
- **Run** uses the visible curve, motion, target, seconds and motion controls, starting at Current; it also works without a playing clip.
- Track reorder follows track identity. Enclosing racks are traversed to find the track. Reload after moving the device to a different track.

Arrangement clips are not scanned.

## Performance and timing

**Tick / ms** defaults to 20 (at most 50 ramp updates/second), adjustable from 10 to 100 ms. Larger intervals reduce CPU/MIDI traffic. Repeated integer values are suppressed; the final target is always sent. There is no ramp timer while idle. Brownian/chaotic paths allocate at most 4,096 points at launch and take constant work per tick. Long, fast-modulated ramps reach that cap and use a lower effective texture rate. Keep motion rate below roughly half the tick frequency for a well-resolved texture.

Clip detection observes the playing slot, transport state and active clip playback/start time, without beat polling or scanning all clips. See Cycling '74's [Track](https://docs.cycling74.com/apiref/lom/track/) and [Clip](https://docs.cycling74.com/apiref/lom/clip/) references.

Elapsed seconds, rather than accumulated tick counts, determine progress: a late callback skips to the correct point. JavaScript Tasks run at low priority, so delivery can be late under load. This is not sample-accurate or an offline-render timing guarantee; see [Task timing](https://docs.cycling74.com/apiref/js/task/). CPU usage must be measured in the target Live set; synthetic multi-instance tests establish correctness, not an Ableton CPU benchmark.

## Development and verification

Edit the three source files in `tesser_curve/code`: `tesser_ramp_core.js`, `tesser_curve_engine.js`, and `tesser_session_watch.js`. Regenerate the two runtime scripts beside the patch:

```sh
node scripts/build_device.js
node scripts/build_runtime.js --check
node tests/test.js
node scripts/build_native_test.js
```

The colocated runtime files avoid the user's global Max search path. Keep project auto-organization disabled so Max does not move them away. Do not edit generated runtimes directly.

Tests cover parsing, every curve/motion combination, endpoints, clipping, seeds, feedback, cancellation, idle tasks, independent instances, mocked Session lifecycle events, and patch connections. Native Max checks also exercise MIDI byte order, pitch-bend passthrough, the scheduler and Run.

Open `tests/generated/native_smoke.maxpat` in standalone Max to run the native MIDI checks; read its neighboring `native-result.json`. The fixture captures bytes instead of sending MIDI to hardware.

Verified on 2026-11-18: all 19 Node test groups and all seven native Max MIDI checks passed. In an empty Live 12 Suite Session set, explicit and remembered-start ramps, same-slot relaunch, ordinary looping without retrigger, sinusoidal/Brownian menu selection, endpoint completion and transport cancellation were exercised successfully.

The percentage-range update adds regression coverage for single targets, shared range suffixes, decimals, descending ramps, range validation and emitted MIDI rounding. All 21 Node test groups pass after this update; the host checks above were performed on the preceding version.

Before using this in a performance set, also check save/reopen, your external feedback routing, device movement/racks and a second device on another track. These have automated coverage where applicable but were not all exercised in the Live smoke check. No large-set CPU benchmark was performed.

## Credits

Based on [CURVE by SKINNERBOX version 1.0](https://maxforlive.com/library/device/3894/curve-by-skinnerbox), with the original tesser_curve CC/clip workflow retained and extended.
