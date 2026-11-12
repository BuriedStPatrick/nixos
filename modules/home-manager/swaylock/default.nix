{ pkgs, ... }:

{
  xdg.configFile."swaylock".source = ./config;

  home.packages = with pkgs; [
    swaylock-effects
  ];
}