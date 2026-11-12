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

    hyprland = {
      url = "github:hyprwm/Hyprland";
    };

    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    split-monitor-workspaces = {
      url = "github:zjeffer/split-monitor-workspaces";
      inputs.hyprland.follows = "hyprland";
    };
  };

  outputs = {
    self,
    nixpkgs,
    hyprland,
    hyprland-plugins,
    split-monitor-workspaces,
    home-manager,
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
            hyprland
            hyprland-plugins
            split-monitor-workspaces
            inputs
            myConfig
            ;
          };

        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              extraSpecialArgs = { inherit inputs myConfig; };
              # backupFileExtension = "backup"; # Disabled to keep clean, enable if config symlinks are acting up.

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
