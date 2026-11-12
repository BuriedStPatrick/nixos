-- https://wiki.hypr.land/Configuring/Basics/Monitors/

-- ALIENWARE MONITOR
hl.monitor({
    output   = "DP-3",
    mode     = "3840x2160@240",
    position = "0x0",
    scale    = 1,
    supports_hdr = 1,
    cm = "hdr",
    bitdepth = 10,
    min_luminance = 0,
    max_luminance = 1000,
    sdrsaturation = 1.0,
    sdrbrightness = 1.0,
    sdr_min_luminance = 0,
    sdr_max_luminance = 1000,
    sdr_eotf = "srgb",
})

-- ACER MONITOR
hl.monitor({
    output   = "DP-2",
    mode     = "3840x2160@120",
    position = "3840x0",
    scale    = 1,
    supports_hdr = 1,
    cm = "hdr",
    bitdepth = 10,
    sdr_min_luminance = 0,
    sdr_max_luminance = 500,
    min_luminance = 0,
    max_luminance = 1000,
    sdrsaturation = 1,
    sdr_eotf = "srgb"
})

-- Thinkpad built-in monitor
hl.monitor({
    output   = "eDP-1",
    mode     = "2560x1600@165",
    position = "2560x0",
    scale    = 1.6
})

-- Primary monitor
hl.monitor({
    output   = "HDMI-A-1",
    mode     = "2560x1440@75",
    position = "0x0",
    scale    = 1
})
