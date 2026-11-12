{ pkgs, inputs, ... }:

{
  imports = [
    inputs.bury-quickshell.homeManagerModules.default
  ];
}
