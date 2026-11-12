--- APPS
local terminal = "kitty"
---

--- SPECIAL KEYS
local mainMod = "SUPER"   -- Sets "Windows" key as main modifier
local enter   = "code:36" -- The ENTER key
---

--- BINDS
hl.bind(mainMod .. " + " .. enter, hl.dsp.exec_cmd(terminal))
---