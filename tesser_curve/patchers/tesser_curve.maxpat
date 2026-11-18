{
    "patcher": {
        "fileversion": 1,
        "appversion": {
            "major": 9,
            "minor": 1,
            "revision": 5,
            "architecture": "x64",
            "modernui": 1
        },
        "classnamespace": "box",
        "rect": [ 34.0, 100.0, 760.0, 169.0 ],
        "openrect": [ 0.0, 0.0, 760.0, 169.0 ],
        "openrectmode": 0,
        "openinpresentation": 1,
        "default_fontsize": 11.0,
        "gridsize": [ 8.0, 8.0 ],
        "boxanimatetime": 500,
        "devicewidth": 760.0,
        "boxes": [
            {
                "box": {
                    "hint": "",
                    "id": "obj-43",
                    "maxclass": "live.numbox",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "float" ],
                    "parameter_enable": 1,
                    "patching_rect": [ 12.0, 768.0, 64.0, 15.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 12.0, 48.0, 64.0, 15.0 ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_initial": [ 22 ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "cc_num",
                            "parameter_modmode": 0,
                            "parameter_shortname": "Input CC",
                            "parameter_type": 1,
                            "parameter_unitstyle": 0
                        }
                    },
                    "varname": "cc_num"
                }
            },
            {
                "box": {
                    "id": "obj-43-message",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 12.0, 648.0, 140.0, 21.0 ],
                    "text": "prepend inputcc"
                }
            },
            {
                "box": {
                    "hint": "",
                    "id": "obj-9",
                    "maxclass": "live.numbox",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "float" ],
                    "parameter_enable": 1,
                    "patching_rect": [ 88.0, 768.0, 64.0, 15.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 88.0, 48.0, 64.0, 15.0 ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_initial": [ 22 ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "cc_num_out",
                            "parameter_modmode": 0,
                            "parameter_shortname": "Output CC",
                            "parameter_type": 1,
                            "parameter_unitstyle": 0
                        }
                    },
                    "varname": "cc_num_out"
                }
            },
            {
                "box": {
                    "id": "obj-9-message",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 88.0, 648.0, 140.0, 21.0 ],
                    "text": "prepend outputcc"
                }
            },
            {
                "box": {
                    "hint": "-1 disables status input. Updates the remembered value without generating MIDI; must differ from Input CC.",
                    "id": "status-cc",
                    "maxclass": "live.numbox",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "float" ],
                    "parameter_enable": 1,
                    "patching_rect": [ 164.0, 768.0, 64.0, 15.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 164.0, 48.0, 64.0, 15.0 ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_initial": [ -1 ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "Status CC",
                            "parameter_mmin": -1.0,
                            "parameter_modmode": 0,
                            "parameter_shortname": "Status CC",
                            "parameter_type": 1,
                            "parameter_unitstyle": 0
                        }
                    },
                    "varname": "status_cc"
                }
            },
            {
                "box": {
                    "id": "status-cc-message",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 164.0, 648.0, 140.0, 21.0 ],
                    "text": "prepend statuscc"
                }
            },
            {
                "box": {
                    "hint": "MIDI channel for clip ramps and manual input. Incoming primary CC retains its original channel.",
                    "id": "out-channel",
                    "maxclass": "live.numbox",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "float" ],
                    "parameter_enable": 1,
                    "patching_rect": [ 240.0, 768.0, 64.0, 15.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 240.0, 48.0, 64.0, 15.0 ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_initial": [ 1 ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "Ramp Channel",
                            "parameter_mmax": 16.0,
                            "parameter_mmin": 1.0,
                            "parameter_modmode": 0,
                            "parameter_shortname": "Channel",
                            "parameter_type": 1,
                            "parameter_unitstyle": 0
                        }
                    },
                    "varname": "out_channel"
                }
            },
            {
                "box": {
                    "id": "out-channel-message",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 240.0, 648.0, 140.0, 21.0 ],
                    "text": "prepend outchannel"
                }
            },
            {
                "box": {
                    "hint": "",
                    "id": "curve-menu",
                    "maxclass": "live.menu",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [ "", "", "float" ],
                    "parameter_enable": 1,
                    "patching_rect": [ 322.0, 768.0, 92.0, 15.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 322.0, 48.0, 92.0, 15.0 ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_enum": [ "lin — Linear", "log — Logarithmic", "exp — Exponential", "sin — Sinusoidal", "smo — Smoothstep" ],
                            "parameter_initial": [ 0 ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "Ramp Curve",
                            "parameter_mmax": 4,
                            "parameter_modmode": 0,
                            "parameter_shortname": "Curve",
                            "parameter_type": 2,
                            "parameter_unitstyle": 9
                        }
                    },
                    "varname": "curve_menu"
                }
            },
            {
                "box": {
                    "id": "curve-menu-message",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 322.0, 648.0, 140.0, 21.0 ],
                    "text": "prepend curveindex"
                }
            },
            {
                "box": {
                    "hint": "",
                    "id": "motion-menu",
                    "maxclass": "live.menu",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [ "", "", "float" ],
                    "parameter_enable": 1,
                    "patching_rect": [ 426.0, 768.0, 92.0, 15.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 426.0, 48.0, 92.0, 15.0 ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_enum": [ "none — Clean", "bro — Brownian", "cha — Chaotic", "zig — Zigzag" ],
                            "parameter_initial": [ 0 ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "Ramp Motion",
                            "parameter_mmax": 3,
                            "parameter_modmode": 0,
                            "parameter_shortname": "Motion",
                            "parameter_type": 2,
                            "parameter_unitstyle": 9
                        }
                    },
                    "varname": "motion_menu"
                }
            },
            {
                "box": {
                    "id": "motion-menu-message",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 426.0, 648.0, 140.0, 21.0 ],
                    "text": "prepend motionindex"
                }
            },
            {
                "box": {
                    "hint": "Maximum additive deviation in MIDI units, tapered to zero at the ramp endpoints.",
                    "id": "motion-amount",
                    "maxclass": "live.numbox",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "float" ],
                    "parameter_enable": 1,
                    "patching_rect": [ 530.0, 768.0, 64.0, 15.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 530.0, 48.0, 64.0, 15.0 ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_initial": [ 8 ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "Motion Amount",
                            "parameter_modmode": 0,
                            "parameter_shortname": "Amount",
                            "parameter_type": 0,
                            "parameter_unitstyle": 1
                        }
                    },
                    "varname": "motion_amount"
                }
            },
            {
                "box": {
                    "id": "motion-amount-message",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 530.0, 648.0, 140.0, 21.0 ],
                    "text": "prepend amount"
                }
            },
            {
                "box": {
                    "hint": "",
                    "id": "motion-rate",
                    "maxclass": "live.numbox",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "float" ],
                    "parameter_enable": 1,
                    "patching_rect": [ 606.0, 768.0, 64.0, 15.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 606.0, 48.0, 64.0, 15.0 ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_initial": [ 4 ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "Motion Rate",
                            "parameter_mmax": 30.0,
                            "parameter_mmin": 0.01,
                            "parameter_modmode": 0,
                            "parameter_shortname": "Rate",
                            "parameter_type": 0,
                            "parameter_unitstyle": 1
                        }
                    },
                    "varname": "motion_rate"
                }
            },
            {
                "box": {
                    "id": "motion-rate-message",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 606.0, 648.0, 140.0, 21.0 ],
                    "text": "prepend rate"
                }
            },
            {
                "box": {
                    "hint": "",
                    "id": "curve-shape",
                    "maxclass": "live.numbox",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "float" ],
                    "parameter_enable": 1,
                    "patching_rect": [ 682.0, 768.0, 64.0, 15.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 682.0, 48.0, 64.0, 15.0 ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_initial": [ 4 ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "Curve Shape",
                            "parameter_mmax": 10.0,
                            "parameter_mmin": 0.1,
                            "parameter_modmode": 0,
                            "parameter_shortname": "Shape",
                            "parameter_type": 0,
                            "parameter_unitstyle": 1
                        }
                    },
                    "varname": "curve_shape"
                }
            },
            {
                "box": {
                    "id": "curve-shape-message",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 682.0, 648.0, 140.0, 21.0 ],
                    "text": "prepend shape"
                }
            },
            {
                "box": {
                    "activedialcolor": [ 0.28, 0.84, 1.0, 1.0 ],
                    "activeneedlecolor": [ 0.85, 0.9, 0.94, 1.0 ],
                    "hint": "",
                    "id": "obj-3",
                    "maxclass": "live.dial",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "float" ],
                    "parameter_enable": 1,
                    "patching_rect": [ 12.0, 814.0, 50.0, 37.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 12.060301780700684, 102.01005256175995, 50.0, 37.0 ],
                    "saved_attribute_attributes": {
                        "activedialcolor": {
                            "expression": ""
                        },
                        "activeneedlecolor": {
                            "expression": ""
                        },
                        "textcolor": {
                            "expression": ""
                        },
                        "valueof": {
                            "parameter_initial": [ 0 ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "MIDI IN",
                            "parameter_modmode": 0,
                            "parameter_shortname": "Input",
                            "parameter_type": 0,
                            "parameter_unitstyle": 1
                        }
                    },
                    "showname": 0,
                    "textcolor": [ 0.85, 0.9, 0.94, 1.0 ],
                    "varname": "live.dial"
                }
            },
            {
                "box": {
                    "id": "obj-3-message",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 12.0, 694.0, 140.0, 21.0 ],
                    "text": "prepend input"
                }
            },
            {
                "box": {
                    "activedialcolor": [ 0.28, 0.84, 1.0, 1.0 ],
                    "activeneedlecolor": [ 0.85, 0.9, 0.94, 1.0 ],
                    "hint": "Original incoming-CC exponent. Timed ramps use their own Curve and Shape.",
                    "id": "obj-6",
                    "maxclass": "live.dial",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "float" ],
                    "parameter_enable": 1,
                    "patching_rect": [ 88.0, 814.0, 50.0, 37.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 87.93970048427582, 102.01005256175995, 50.0, 37.0 ],
                    "saved_attribute_attributes": {
                        "activedialcolor": {
                            "expression": ""
                        },
                        "activeneedlecolor": {
                            "expression": ""
                        },
                        "textcolor": {
                            "expression": ""
                        },
                        "valueof": {
                            "parameter_initial": [ 1 ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "factor",
                            "parameter_mmax": 3.0,
                            "parameter_mmin": 0.01,
                            "parameter_modmode": 0,
                            "parameter_shortname": "Exponent",
                            "parameter_type": 0,
                            "parameter_unitstyle": 1
                        }
                    },
                    "showname": 0,
                    "textcolor": [ 0.85, 0.9, 0.94, 1.0 ],
                    "varname": "factor"
                }
            },
            {
                "box": {
                    "id": "obj-6-message",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 88.0, 694.0, 140.0, 21.0 ],
                    "text": "prepend factor"
                }
            },
            {
                "box": {
                    "hint": "Last emitted MIDI value or last status CC value. Starts at zero when the device loads.",
                    "id": "obj-44",
                    "ignoreclick": 1,
                    "maxclass": "number",
                    "maximum": 127,
                    "minimum": 0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 164.03508615493774, 819.7368342876434, 64.0, 21.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 164.0, 103.0, 64.0, 21.0 ]
                }
            },
            {
                "box": {
                    "hint": "20 ms = 50 Hz. Higher values reduce work for large device counts. Timer sleeps between ramps.",
                    "id": "tick-ms",
                    "maxclass": "live.numbox",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "float" ],
                    "parameter_enable": 1,
                    "patching_rect": [ 240.0, 823.0, 64.0, 15.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 240.0, 103.0, 64.0, 15.0 ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_initial": [ 20 ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "Update Interval",
                            "parameter_mmax": 100.0,
                            "parameter_mmin": 10.0,
                            "parameter_modmode": 0,
                            "parameter_shortname": "Tick ms",
                            "parameter_type": 1,
                            "parameter_unitstyle": 0
                        }
                    },
                    "varname": "tick_ms"
                }
            },
            {
                "box": {
                    "id": "tick-ms-message",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 240.0, 703.0, 140.0, 21.0 ],
                    "text": "prepend grain"
                }
            },
            {
                "box": {
                    "hint": "",
                    "id": "ramp-target",
                    "maxclass": "live.numbox",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "float" ],
                    "parameter_enable": 1,
                    "patching_rect": [ 322.0, 823.0, 92.0, 15.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 322.0, 103.0, 92.0, 15.0 ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_initial": [ 76 ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "Ramp Target",
                            "parameter_modmode": 0,
                            "parameter_shortname": "Target",
                            "parameter_type": 0,
                            "parameter_unitstyle": 1
                        }
                    },
                    "varname": "ramp_target"
                }
            },
            {
                "box": {
                    "id": "ramp-target-message",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 322.0, 703.0, 140.0, 21.0 ],
                    "text": "prepend target"
                }
            },
            {
                "box": {
                    "hint": "",
                    "id": "ramp-duration",
                    "maxclass": "live.numbox",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "float" ],
                    "parameter_enable": 1,
                    "patching_rect": [ 426.0, 823.0, 92.0, 15.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 426.0, 103.0, 92.0, 15.0 ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_initial": [ 3.45 ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "Ramp Duration",
                            "parameter_mmax": 86400.0,
                            "parameter_modmode": 0,
                            "parameter_shortname": "Seconds",
                            "parameter_type": 0,
                            "parameter_unitstyle": 1
                        }
                    },
                    "varname": "ramp_duration"
                }
            },
            {
                "box": {
                    "id": "ramp-duration-message",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 426.0, 703.0, 140.0, 21.0 ],
                    "text": "prepend duration"
                }
            },
            {
                "box": {
                    "hint": "0 = new random motion on each launch. A positive seed repeats the pattern.",
                    "id": "motion-seed",
                    "maxclass": "live.numbox",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "float" ],
                    "parameter_enable": 1,
                    "patching_rect": [ 530.0, 823.0, 82.0, 15.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 530.0, 103.0, 82.0, 15.0 ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_initial": [ 0 ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "Motion Seed",
                            "parameter_mmax": 255.0,
                            "parameter_modmode": 0,
                            "parameter_shortname": "Seed",
                            "parameter_type": 1,
                            "parameter_unitstyle": 0
                        }
                    },
                    "varname": "motion_seed"
                }
            },
            {
                "box": {
                    "id": "motion-seed-message",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 530.0, 703.0, 140.0, 21.0 ],
                    "text": "prepend seed"
                }
            },
            {
                "box": {
                    "id": "run-button",
                    "maxclass": "textbutton",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [ "", "", "int" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 626.0, 840.0, 56.0, 24.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 626.0, 99.0, 56.0, 26.0 ],
                    "text": "Run",
                    "varname": "run-button"
                }
            },
            {
                "box": {
                    "id": "run-button-cmd",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 626.0, 500.0, 50.0, 21.0 ],
                    "text": "run"
                }
            },
            {
                "box": {
                    "id": "stop-button",
                    "maxclass": "textbutton",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [ "", "", "int" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 690.0, 840.0, 56.0, 24.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 690.0, 99.0, 56.0, 26.0 ],
                    "text": "Stop",
                    "varname": "stop-button"
                }
            },
            {
                "box": {
                    "id": "stop-button-cmd",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 690.0, 500.0, 50.0, 21.0 ],
                    "text": "stop"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 13.0,
                    "id": "title",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 12.0, 907.0, 150.0, 21.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 12.0, 7.0, 150.0, 21.0 ],
                    "text": "TESSER / CURVE",
                    "textcolor": [ 0.28, 0.84, 1.0, 1.0 ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "session-label",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 170.0, 909.0, 60.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 170.0, 9.0, 60.0, 18.0 ],
                    "text": "SESSION",
                    "textcolor": [ 0.76, 0.8, 0.83, 1.0 ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 11.0,
                    "id": "clip-display",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 240.0, 907.0, 506.0, 19.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 240.0, 7.0, 506.0, 19.0 ],
                    "text": "Launch a named clip on this track",
                    "textcolor": [ 0.76, 0.8, 0.83, 1.0 ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "label-top-12",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 12.0, 930.0, 64.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 12.0, 30.0, 64.0, 18.0 ],
                    "text": "Input CC",
                    "textcolor": [ 0.76, 0.8, 0.83, 1.0 ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "label-top-88",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 88.0, 930.0, 64.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 88.0, 30.0, 64.0, 18.0 ],
                    "text": "Output CC",
                    "textcolor": [ 0.76, 0.8, 0.83, 1.0 ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "label-top-164",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 164.0, 930.0, 76.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 164.0, 30.0, 76.0, 18.0 ],
                    "text": "Status CC",
                    "textcolor": [ 0.76, 0.8, 0.83, 1.0 ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "label-top-240",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 240.0, 930.0, 64.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 240.0, 30.0, 64.0, 18.0 ],
                    "text": "Channel",
                    "textcolor": [ 0.76, 0.8, 0.83, 1.0 ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "label-top-322",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 322.0, 930.0, 92.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 322.0, 30.0, 92.0, 18.0 ],
                    "text": "Curve",
                    "textcolor": [ 0.76, 0.8, 0.83, 1.0 ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "label-top-426",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 426.0, 930.0, 92.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 426.0, 30.0, 92.0, 18.0 ],
                    "text": "Motion",
                    "textcolor": [ 0.76, 0.8, 0.83, 1.0 ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "label-top-530",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 530.0, 930.0, 64.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 530.0, 30.0, 64.0, 18.0 ],
                    "text": "Amount",
                    "textcolor": [ 0.76, 0.8, 0.83, 1.0 ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "label-top-606",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 606.0, 930.0, 64.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 606.0, 30.0, 64.0, 18.0 ],
                    "text": "Rate / Hz",
                    "textcolor": [ 0.76, 0.8, 0.83, 1.0 ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "label-top-682",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 682.0, 930.0, 64.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 682.0, 30.0, 64.0, 18.0 ],
                    "text": "Shape",
                    "textcolor": [ 0.76, 0.8, 0.83, 1.0 ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "label-bottom-12",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 12.0, 984.0, 64.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 12.0, 84.0, 64.0, 18.0 ],
                    "text": "Input",
                    "textcolor": [ 0.76, 0.8, 0.83, 1.0 ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "label-bottom-88",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 88.0, 984.0, 70.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 88.0, 84.0, 70.0, 18.0 ],
                    "text": "CC exponent",
                    "textcolor": [ 0.76, 0.8, 0.83, 1.0 ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "label-bottom-164",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 164.0, 984.0, 64.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 164.0, 84.0, 64.0, 18.0 ],
                    "text": "Current",
                    "textcolor": [ 0.76, 0.8, 0.83, 1.0 ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "label-bottom-240",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 240.0, 984.0, 64.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 240.0, 84.0, 64.0, 18.0 ],
                    "text": "Tick / ms",
                    "textcolor": [ 0.76, 0.8, 0.83, 1.0 ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "label-bottom-322",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 322.0, 984.0, 92.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 322.0, 84.0, 92.0, 18.0 ],
                    "text": "Target",
                    "textcolor": [ 0.76, 0.8, 0.83, 1.0 ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "label-bottom-426",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 426.0, 984.0, 100.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 426.0, 84.0, 100.0, 18.0 ],
                    "text": "Duration / seconds",
                    "textcolor": [ 0.76, 0.8, 0.83, 1.0 ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "label-bottom-530",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 530.0, 984.0, 90.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 530.0, 84.0, 90.0, 18.0 ],
                    "text": "Seed / 0 random",
                    "textcolor": [ 0.76, 0.8, 0.83, 1.0 ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 11.0,
                    "id": "status-display",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 12.0, 1045.0, 600.0, 19.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 12.0, 145.0, 600.0, 19.0 ],
                    "text": "Session observer: Place this MIDI device on a Session track",
                    "textcolor": [ 0.76, 0.8, 0.83, 1.0 ]
                }
            },
            {
                "box": {
                    "id": "running-led",
                    "ignoreclick": 1,
                    "maxclass": "led",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "int" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 225.0, 900.0, 10.0, 10.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 225.0, 12.0, 10.0, 10.0 ]
                }
            },
            {
                "box": {
                    "id": "obj-1",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "int" ],
                    "patching_rect": [ 20.0, 30.0, 70.0, 21.0 ],
                    "text": "midiin"
                }
            },
            {
                "box": {
                    "id": "midi-select",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 8,
                    "outlettype": [ "", "", "", "int", "int", "", "int", "int" ],
                    "patching_rect": [ 20.0, 80.0, 230.0, 21.0 ],
                    "text": "midiselect @ch all @ctl 22 @hires 2",
                    "varname": "midi_selector"
                }
            },
            {
                "box": {
                    "id": "midi-channel-join",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 2,
                    "outlettype": [ "", "" ],
                    "patching_rect": [ 20.0, 140.0, 100.0, 21.0 ],
                    "text": "zl.join"
                }
            },
            {
                "box": {
                    "id": "midi-cc-message",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 20.0, 185.0, 100.0, 21.0 ],
                    "text": "prepend cc"
                }
            },
            {
                "box": {
                    "id": "midi-defer",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 20.0, 220.0, 90.0, 21.0 ],
                    "text": "deferlow"
                }
            },
            {
                "box": {
                    "id": "ramp-engine",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 4,
                    "outlettype": [ "", "", "", "" ],
                    "patching_rect": [ 274.56140089035034, 247.36841869354248, 210.0, 21.0 ],
                    "saved_object_attributes": {
                        "filename": "tesser_curve_runtime.js",
                        "parameter_enable": 0
                    },
                    "text": "js tesser_curve_runtime.js",
                    "varname": "tesser_engine"
                }
            },
            {
                "box": {
                    "id": "midi-iter",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 274.56140089035034, 362.71929478645325, 70.0, 21.0 ],
                    "text": "iter"
                }
            },
            {
                "box": {
                    "id": "obj-2",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 231.0, 417.10525918006897, 80.0, 21.0 ],
                    "text": "midiout"
                }
            },
            {
                "box": {
                    "id": "obj-8",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [ "bang", "int", "int" ],
                    "patching_rect": [ 520.0, 30.0, 110.0, 21.0 ],
                    "text": "live.thisdevice"
                }
            },
            {
                "box": {
                    "id": "device-init-defer",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 520.0, 70.0, 90.0, 21.0 ],
                    "text": "deferlow"
                }
            },
            {
                "box": {
                    "id": "device-init",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 520.0, 110.0, 50.0, 21.0 ],
                    "text": "init"
                }
            },
            {
                "box": {
                    "id": "device-enabled",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 660.0, 70.0, 130.0, 21.0 ],
                    "text": "prepend enabled"
                }
            },
            {
                "box": {
                    "id": "device-enabled-defer",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 660.0, 110.0, 90.0, 21.0 ],
                    "text": "deferlow"
                }
            },
            {
                "box": {
                    "id": "session-watch",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "" ],
                    "patching_rect": [ 520.0, 185.0, 220.0, 21.0 ],
                    "saved_object_attributes": {
                        "filename": "tesser_session_runtime.js",
                        "parameter_enable": 0
                    },
                    "text": "js tesser_session_runtime.js"
                }
            },
            {
                "box": {
                    "id": "session-command-defer",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 520.0, 235.0, 90.0, 21.0 ],
                    "text": "deferlow"
                }
            },
            {
                "box": {
                    "id": "device-width",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 800.0, 30.0, 160.0, 21.0 ],
                    "text": "loadmess setwidth 760"
                }
            },
            {
                "box": {
                    "id": "ui-route",
                    "maxclass": "newobj",
                    "numinlets": 14,
                    "numoutlets": 14,
                    "outlettype": [ "", "", "", "", "", "", "", "", "", "", "", "", "", "" ],
                    "patching_rect": [ 338.22806755701697, 320.6140320301056, 850.0, 21.0 ],
                    "text": "route current input factor curve motion target duration amount rate shape seed running clip"
                }
            },
            {
                "box": {
                    "color": [ 1.0, 0.741176470588235, 0.086274509803922, 1.0 ],
                    "id": "obj-64",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 1114.52991771698, 90.59829151630402, 67.0, 21.0 ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_invisible": 1,
                            "parameter_longname": "u741006968",
                            "parameter_modmode": 0,
                            "parameter_shortname": "u741006968",
                            "parameter_type": 3
                        }
                    },
                    "saved_object_attributes": {
                        "parameter_enable": 1,
                        "parameter_mappable": 0
                    },
                    "text": "pattrstorage",
                    "varname": "u741006968"
                }
            },
            {
                "box": {
                    "id": "obj-67",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 1114.52991771698, 63.24786388874054, 71.0, 21.0 ],
                    "text": "clientwindow"
                }
            },
            {
                "box": {
                    "id": "obj-69",
                    "maxclass": "live.text",
                    "mode": 0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "" ],
                    "parameter_enable": 1,
                    "patching_rect": [ 1114.52991771698, 38.46153885126114, 44.0, 15.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 620.0, 146.0, 60.0, 17.0 ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_enum": [ "val1", "val2" ],
                            "parameter_invisible": 2,
                            "parameter_linknames": 1,
                            "parameter_longname": "settings",
                            "parameter_mmax": 1,
                            "parameter_modmode": 0,
                            "parameter_shortname": "settings",
                            "parameter_type": 2
                        }
                    },
                    "text": "Settings",
                    "varname": "settings"
                }
            },
            {
                "box": {
                    "id": "obj-72",
                    "maxclass": "newobj",
                    "numinlets": 3,
                    "numoutlets": 0,
                    "patcher": {
                        "fileversion": 1,
                        "appversion": {
                            "major": 9,
                            "minor": 1,
                            "revision": 5,
                            "architecture": "x64",
                            "modernui": 1
                        },
                        "classnamespace": "box",
                        "rect": [ 100.0, 138.0, 99.0, 154.0 ],
                        "openinpresentation": 1,
                        "toolbarvisible": 0,
                        "enablehscroll": 0,
                        "enablevscroll": 0,
                        "boxes": [
                            {
                                "box": {
                                    "activebgcolor": [ 0.764705882352941, 0.764705882352941, 0.764705882352941, 0.0 ],
                                    "bordercolor": [ 0.313725490196078, 0.313725490196078, 0.313725490196078, 0.0 ],
                                    "fontsize": 24.0,
                                    "id": "obj-6",
                                    "maxclass": "live.numbox",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [ "", "float" ],
                                    "parameter_enable": 1,
                                    "patching_rect": [ 330.0, 85.0, 87.0, 32.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 14.0, 52.0, 74.0, 32.0 ],
                                    "saved_attribute_attributes": {
                                        "activebgcolor": {
                                            "expression": ""
                                        },
                                        "bordercolor": {
                                            "expression": ""
                                        },
                                        "textcolor": {
                                            "expression": ""
                                        },
                                        "valueof": {
                                            "parameter_longname": "live.numbox",
                                            "parameter_modmode": 3,
                                            "parameter_shortname": "live.numbox",
                                            "parameter_type": 0,
                                            "parameter_unitstyle": 0
                                        }
                                    },
                                    "textcolor": [ 1.0, 1.0, 1.0, 1.0 ],
                                    "varname": "live.numbox"
                                }
                            },
                            {
                                "box": {
                                    "comment": "",
                                    "id": "obj-3",
                                    "index": 3,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 330.0, 23.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "",
                                    "id": "obj-2",
                                    "index": 1,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 44.91453021764755, 23.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-16",
                                    "ignoreclick": 1,
                                    "maxclass": "slider",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 44.91453021764755, 239.44444793462753, 20.0, 140.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 2.0, 2.0, 19.0, 147.0 ]
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-37",
                                    "ignoreclick": 1,
                                    "maxclass": "slider",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 280.34188318252563, 224.44444793462753, 20.0, 140.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 23.0, 2.0, 70.0, 147.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "",
                                    "id": "obj-1",
                                    "index": 2,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 280.34188318252563, 23.0, 30.0, 30.0 ]
                                }
                            }
                        ],
                        "lines": [
                            {
                                "patchline": {
                                    "destination": [ "obj-37", 0 ],
                                    "source": [ "obj-1", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-16", 0 ],
                                    "source": [ "obj-2", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-6", 0 ],
                                    "source": [ "obj-3", 0 ]
                                }
                            }
                        ]
                    },
                    "patching_rect": [ 1354.7008603215218, 410.25641441345215, 82.34419767847828, 21.0 ],
                    "text": "p popup"
                }
            },
            {
                "box": {
                    "id": "obj-75",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 1354.7008603215218, 241.38269000000003, 33.0, 21.0 ],
                    "text": "open"
                }
            },
            {
                "box": {
                    "id": "obj-76",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 1354.7008603215218, 369.23077297210693, 48.0, 21.0 ],
                    "text": "pcontrol"
                }
            },
            {
                "box": {
                    "id": "obj-77",
                    "maxclass": "live.text",
                    "mode": 0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "" ],
                    "parameter_enable": 1,
                    "patching_rect": [ 1354.7008603215218, 38.46153885126114, 44.0, 15.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 686.0, 146.0, 60.0, 17.0 ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_enum": [ "val1", "val2" ],
                            "parameter_invisible": 2,
                            "parameter_linknames": 1,
                            "parameter_longname": "popup",
                            "parameter_mmax": 1,
                            "parameter_modmode": 0,
                            "parameter_shortname": "popup",
                            "parameter_type": 2
                        }
                    },
                    "text": "Monitor",
                    "varname": "popup"
                }
            },
            {
                "box": {
                    "id": "monitor-current",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 2,
                    "outlettype": [ "", "" ],
                    "patching_rect": [ 1020.0, 400.0, 90.0, 21.0 ],
                    "text": "route set"
                }
            },
            {
                "box": {
                    "id": "monitor-input",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 2,
                    "outlettype": [ "", "" ],
                    "patching_rect": [ 1020.0, 435.0, 90.0, 21.0 ],
                    "text": "route set"
                }
            }
        ],
        "lines": [
            {
                "patchline": {
                    "destination": [ "curve-menu-message", 0 ],
                    "source": [ "curve-menu", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "ramp-engine", 0 ],
                    "source": [ "curve-menu-message", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "curve-shape-message", 0 ],
                    "source": [ "curve-shape", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "ramp-engine", 0 ],
                    "source": [ "curve-shape-message", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "device-enabled-defer", 0 ],
                    "source": [ "device-enabled", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "ramp-engine", 0 ],
                    "order": 1,
                    "source": [ "device-enabled-defer", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "session-watch", 0 ],
                    "order": 0,
                    "source": [ "device-enabled-defer", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "ramp-engine", 0 ],
                    "order": 1,
                    "source": [ "device-init", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "session-watch", 0 ],
                    "order": 0,
                    "source": [ "device-init", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "device-init", 0 ],
                    "source": [ "device-init-defer", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-8", 0 ],
                    "source": [ "device-width", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "midi-defer", 0 ],
                    "source": [ "midi-cc-message", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "midi-cc-message", 0 ],
                    "source": [ "midi-channel-join", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "ramp-engine", 0 ],
                    "source": [ "midi-defer", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-2", 0 ],
                    "source": [ "midi-iter", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "midi-channel-join", 1 ],
                    "source": [ "midi-select", 6 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "midi-channel-join", 0 ],
                    "source": [ "midi-select", 2 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-2", 0 ],
                    "source": [ "midi-select", 7 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-72", 1 ],
                    "source": [ "monitor-current", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-72", 0 ],
                    "source": [ "monitor-input", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "motion-amount-message", 0 ],
                    "source": [ "motion-amount", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "ramp-engine", 0 ],
                    "source": [ "motion-amount-message", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "motion-menu-message", 0 ],
                    "source": [ "motion-menu", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "ramp-engine", 0 ],
                    "source": [ "motion-menu-message", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "motion-rate-message", 0 ],
                    "source": [ "motion-rate", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "ramp-engine", 0 ],
                    "source": [ "motion-rate-message", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "motion-seed-message", 0 ],
                    "source": [ "motion-seed", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "ramp-engine", 0 ],
                    "source": [ "motion-seed-message", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "midi-select", 0 ],
                    "source": [ "obj-1", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-3-message", 0 ],
                    "source": [ "obj-3", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "ramp-engine", 0 ],
                    "source": [ "obj-3-message", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-43-message", 0 ],
                    "source": [ "obj-43", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "ramp-engine", 0 ],
                    "source": [ "obj-43-message", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-6-message", 0 ],
                    "source": [ "obj-6", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "ramp-engine", 0 ],
                    "source": [ "obj-6-message", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-64", 0 ],
                    "source": [ "obj-67", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-67", 0 ],
                    "source": [ "obj-69", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-76", 0 ],
                    "source": [ "obj-75", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-72", 0 ],
                    "source": [ "obj-76", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-75", 0 ],
                    "source": [ "obj-77", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "device-enabled", 0 ],
                    "source": [ "obj-8", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "device-init-defer", 0 ],
                    "source": [ "obj-8", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-72", 2 ],
                    "order": 0,
                    "source": [ "obj-9", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-9-message", 0 ],
                    "order": 1,
                    "source": [ "obj-9", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "ramp-engine", 0 ],
                    "source": [ "obj-9-message", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "out-channel-message", 0 ],
                    "source": [ "out-channel", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "ramp-engine", 0 ],
                    "source": [ "out-channel-message", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "ramp-duration-message", 0 ],
                    "source": [ "ramp-duration", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "ramp-engine", 0 ],
                    "source": [ "ramp-duration-message", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "midi-iter", 0 ],
                    "source": [ "ramp-engine", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "midi-select", 0 ],
                    "source": [ "ramp-engine", 3 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "status-display", 0 ],
                    "source": [ "ramp-engine", 2 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "ui-route", 0 ],
                    "source": [ "ramp-engine", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "ramp-target-message", 0 ],
                    "source": [ "ramp-target", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "ramp-engine", 0 ],
                    "source": [ "ramp-target-message", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "run-button-cmd", 0 ],
                    "source": [ "run-button", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "ramp-engine", 0 ],
                    "source": [ "run-button-cmd", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "ramp-engine", 0 ],
                    "source": [ "session-command-defer", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "session-command-defer", 0 ],
                    "source": [ "session-watch", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "status-display", 0 ],
                    "source": [ "session-watch", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "status-cc-message", 0 ],
                    "source": [ "status-cc", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "ramp-engine", 0 ],
                    "source": [ "status-cc-message", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "stop-button-cmd", 0 ],
                    "source": [ "stop-button", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "ramp-engine", 0 ],
                    "source": [ "stop-button-cmd", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tick-ms-message", 0 ],
                    "source": [ "tick-ms", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "ramp-engine", 0 ],
                    "source": [ "tick-ms-message", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "clip-display", 0 ],
                    "source": [ "ui-route", 12 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "curve-menu", 0 ],
                    "source": [ "ui-route", 3 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "curve-shape", 0 ],
                    "source": [ "ui-route", 9 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "monitor-current", 0 ],
                    "order": 0,
                    "source": [ "ui-route", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "monitor-input", 0 ],
                    "order": 0,
                    "source": [ "ui-route", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "motion-amount", 0 ],
                    "source": [ "ui-route", 7 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "motion-menu", 0 ],
                    "source": [ "ui-route", 4 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "motion-rate", 0 ],
                    "source": [ "ui-route", 8 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "motion-seed", 0 ],
                    "source": [ "ui-route", 10 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-3", 0 ],
                    "order": 1,
                    "source": [ "ui-route", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-44", 0 ],
                    "order": 1,
                    "source": [ "ui-route", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-6", 0 ],
                    "source": [ "ui-route", 2 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "ramp-duration", 0 ],
                    "source": [ "ui-route", 6 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "ramp-target", 0 ],
                    "source": [ "ui-route", 5 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "running-led", 0 ],
                    "source": [ "ui-route", 11 ]
                }
            }
        ],
        "parameters": {
            "curve-menu": [ "Ramp Curve", "Curve", 0 ],
            "curve-shape": [ "Curve Shape", "Shape", 0 ],
            "motion-amount": [ "Motion Amount", "Amount", 0 ],
            "motion-menu": [ "Ramp Motion", "Motion", 0 ],
            "motion-rate": [ "Motion Rate", "Rate", 0 ],
            "motion-seed": [ "Motion Seed", "Seed", 0 ],
            "obj-3": [ "MIDI IN", "Input", 0 ],
            "obj-43": [ "cc_num", "Input CC", 0 ],
            "obj-6": [ "factor", "Exponent", 0 ],
            "obj-64": [ "u741006968", "u741006968", 0 ],
            "obj-69": [ "settings", "settings", 0 ],
            "obj-72::obj-6": [ "live.numbox", "live.numbox", 0 ],
            "obj-77": [ "popup", "popup", 0 ],
            "obj-9": [ "cc_num_out", "Output CC", 0 ],
            "out-channel": [ "Ramp Channel", "Channel", 0 ],
            "ramp-duration": [ "Ramp Duration", "Seconds", 0 ],
            "ramp-target": [ "Ramp Target", "Target", 0 ],
            "status-cc": [ "Status CC", "Status CC", 0 ],
            "tick-ms": [ "Update Interval", "Tick ms", 0 ],
            "parameterbanks": {
                "0": {
                    "index": 0,
                    "name": "Ramp",
                    "parameters": [ "Ramp Curve", "Ramp Motion", "Ramp Target", "Ramp Duration", "Motion Amount", "Motion Rate", "Curve Shape", "Motion Seed" ],
                    "buttons": [ "-", "-", "-", "-", "-", "-", "-", "-" ]
                }
            },
            "inherited_shortname": 1
        },
        "autosave": 0,
        "patchlinecolor": [ 0.313725490196078, 0.313725490196078, 0.313725490196078, 1.0 ],
        "bgcolor": [ 0.14, 0.16, 0.18, 1.0 ],
        "editing_bgcolor": [ 0.9, 0.9, 0.9, 1.0 ]
    }
}