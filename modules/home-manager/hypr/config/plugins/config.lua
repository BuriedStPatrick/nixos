-- https://wiki.hypr.land/Configuring/Basics/Autostart/
-- hl.on("hyprland.start", function ()
--   hl.exec_cmd("hyprpm reload -n")
-- end)

-- Hyprland sets package.path to only search relative to the config directory,
-- so absolute-path require() calls do not work. Add the library directory to
-- package.path first, then require by module name.
package.path = package.path .. ";./?.lua;./?/init.lua"

-- Load split-monitor-workspaces
-- https://github.com/zjeffer/split-monitor-workspaces/blob/main/docs/example.lua
local smw = require("plugins.split-monitor-workspaces")

smw.setup({
  workspace_count = 5, -- Creates 5 persistent workspaces on each monitor at startup
})

-- KEYBINDS
local mainMod = "SUPER"

for i = 1, smw.get_amount_of_workspaces() do
  local n = tostring(i)
  if n == "10" then n = "0" end -- Optional if you configured 10 workspaces: bind workspace 10 to SUPER + 0

  -- Switch to the Nth worksapce on the currently focused monitor.
  hl.bind(mainMod .. " +" .. n, smw.workspace(n))

  -- Move the active window to the Nth workspace on the currently focused monitor silently (no focus change)
  hl.bind(mainMod .. " + SHIFT +" .. n, smw.move_to_workspace_silent(n))
end

-- Focus prev/next workspace
hl.bind(mainMod .. " + CTRL + LEFT", smw.cycle_workspaces("prev"))
hl.bind(mainMod .. " + CTRL + RIGHT", smw.cycle_workspaces("next"))

-- Move focused window to prev/next workspace
hl.bind(mainMod .. " + CTRL + SHIFT + LEFT", smw.move_to_workspace("prev"))
hl.bind(mainMod .. " + CTRL + SHIFT + RIGHT", smw.move_to_workspace("next"))

-- require('plugins.hymission.config')
