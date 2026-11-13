{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { ... }: {
    homeManagerModules.default = { pkgs, ... }: {
      home.packages = with pkgs; [
        kitty
        eza
        fzf
        gitui
        fastfetch
        btop
        k9s
        kubectl
        kubectx
        gh
        azure-cli
      ];
    };
  };
}