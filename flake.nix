{
  description = "Patrick's NixOS configuration";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-26.05";
    };

    nvf = {
      url = "path:./modules/nvf";
    };

    keymapp = {
      url = "path:./modules/keymapp";
    };

    terminal = {
      url = "path:./modules/terminal";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    development = {
      url = "path:./modules/development";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    bury-os = {
      url = "github:bury-os/bury-os";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    bury-os,
    nvf,
    keymapp,
    terminal,
    development,
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
          terminal.nixosModules.default
          development.nixosModules.default
          keymapp.nixosModules.default
          bury-os.nixosModules.default
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              extraSpecialArgs = { inherit inputs myConfig; };

              users.${myConfig.username} = import ./modules/home-manager;
            };
          }
          {
            services.blueman.enable = true;
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
