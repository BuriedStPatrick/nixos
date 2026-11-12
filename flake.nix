{
  description = "Patrick's NixOS configuration";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-26.05";
    };

    nvf = {
      url = "path:./modules/nvf";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    bury-quickshell = {
      url = "github:bury-os/bury-quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    bury-hyprland = {
      url = "github:bury-os/bury-hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    bury-quickshell,
    bury-hyprland,
    nvf,
    ... } @inputs :
    let
      system = "x86_64-linux";

      username = "patrick";
      hostname = "nixos";
      homeDirectory = "/home/${username}";

      systemStateVersion = "26.05";
      homeStateVersion = "26.05";

      myConfig = {
        inherit
          username
          hostname
          homeDirectory
          systemStateVersion
          homeStateVersion
          ;
      };
    in {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        inherit system;

        specialArgs = {
          inherit
            inputs
            myConfig
            ;
          };

        modules = [
          ./configuration.nix
          bury-hyprland.nixosModules.default
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              extraSpecialArgs = { inherit inputs myConfig; };

              users.${myConfig.username} = import ./modules/home-manager;
            };
          }
          {
            environment.systemPackages = [
              nvf.packages."${system}".default
            ];

            environment.variables = {
              EDITOR = "nvim";
              VISUAL = "nvim";
            };
          }
        ];
    };
  };
}
