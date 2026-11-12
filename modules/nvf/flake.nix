{
  # Docs: https://nvf.notashelf.dev/
  description = "Patrick's NVF config.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nvf.url = "github:notashelf/nvf";
  };

  outputs = { self, nixpkgs, nvf, ... }: {
    packages."x86_64-linux".default = (
      nvf.lib.neovimConfiguration {
        pkgs = nixpkgs.legacyPackages."x86_64-linux";
        modules = [ ./nvf-configuration.nix ];
    }).neovim;

    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      modules = [
        nvf.nixosModules.default
      ];
    };
  };
}
