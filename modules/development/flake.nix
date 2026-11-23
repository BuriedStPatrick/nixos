{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    containers = {
      url = "path:./containers";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    kubernetes = {
      url = "path:./kubernetes";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    git = {
      url = "path:./git";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, containers, nixpkgs, kubernetes, git, ... }: {
    nixosModules.default = { pkgs, ... }: {
      imports = [
        containers.nixosModules.default
        kubernetes.nixosModules.default
      ];
    };

    homeManagerModules.default = { pkgs, ... }: {
      imports = [
        containers.homeManagerModules.default
        kubernetes.homeManagerModules.default
        git.homeManagerModules.default
      ];
    };
  };
}
