-- https://wiki.hypr.land/Configuring/Basics/Autostart/
hl.on("hyprland.start", function ()
  hl.exec_cmd("mako --config ~/.config/mako/config &")
end)