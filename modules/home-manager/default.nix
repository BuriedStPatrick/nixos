{ pkgs, inputs, myConfig, ... }:

{
  home.username = myConfig.username;
  home.homeDirectory = myConfig.homeDirectory;
  home.stateVersion = myConfig.homeStateVersion;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Submodules
  imports = [
    inputs.terminal.homeManagerModules.default
    inputs.development.homeManagerModules.default
    inputs.bury-os.homeManagerModules.default
  ];

  home.packages = with pkgs; [
    vscodium
    discord
    brave # backup browser
    yq-go
    jq
  ];
}
