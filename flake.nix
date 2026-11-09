{
  description = "Patrick's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    hyprland.url = "github:hyprwm/Hyprland";
    hjem.url = "github:feel-co/hjem";
    hjem.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... } @ inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };

      system = "x86_64-linux";

      modules = [
        ./configuration.nix
        inputs.hjem.nixosModules.default
        ./hjem.nix
      ];
    };
  };
}
