{ pkgs, ... }:

{
  xdg.configFile."quickshell".source = ./config;

  home.packages = with pkgs; [
    quickshell
  ];
}