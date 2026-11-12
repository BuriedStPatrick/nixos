{ pkgs, ... }:

{
  xdg.configFile."hypr".source = ./config;

  home.packages = with pkgs; [
    rofi
    wlogout
    hyprshot
  ];
}
