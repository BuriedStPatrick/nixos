{ pkgs, ... }:

{
  xdg.configFile."zsh".source = ./config;
  home.file.".zshrc".source = ./.zshrc;

  home.packages = with pkgs; [
    zsh
  ];
}