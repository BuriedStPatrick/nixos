-- https://wiki.hypr.land/Configuring/Basics/Autostart/
hl.on("hyprland.start", function ()
  hl.exec_cmd("wl-clipboard-history -t")
  hl.exec_cmd("wl-paste --watch cliphist store")
  hl.exec_cmd("rm $HOME/.cache/cliphist/db")
end)