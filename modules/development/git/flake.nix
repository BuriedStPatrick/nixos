{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }: {
    homeManagerModules.default = { pkgs, ... }: {
      home.packages = with pkgs; [
        gitui
      ];

      programs.git = {
        enable = true;

        settings = {
          init.defaultBranch = "main";
          user = {
            name = "Patrick Christensen";
            email = "patrick@pat.gg";
          };
        };
      };
    };
  };
}