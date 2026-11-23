{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    kubernetes.url = "path:./kubernetes";
    git.url = "path:./git";
  };

  outputs = { self, nixpkgs, kubernetes, git, ... }: {
    nixosModules.default = { pkgs, ... }: {
      imports = [
        kubernetes.nixosModules.default
      ];
    };

    homeManagerModules.default = { pkgs, ... }: {
      imports = [
        kubernetes.homeManagerModules.default
        git.homeManagerModules.default
      ];
    };
  };
}
