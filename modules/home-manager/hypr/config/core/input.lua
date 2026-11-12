hl.config({
    input = {
        kb_layout  = "us,dk",
        kb_variant = "",
        kb_model   = "",
        kb_options = "grp:caps_toggle",
        kb_rules   = "",
        accel_profile = "flat",
        repeat_rate = 100,
        repeat_delay = 175,

        follow_mouse = 0,

        sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.

        touchpad = {
            natural_scroll = true,
            tap_to_click = false,
            clickfinger_behavior = true,
            scroll_factor = 0.5,
        }
    },
})

hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace"
})