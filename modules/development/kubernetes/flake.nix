{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }: {
    nixosModules.default = { pkgs, ... }: {
      # Since we're configuring ZSH at system-level, need to modify the aliases at that same level.
      programs.zsh.shellAliases = {
        k = "kubectl";
      };

      programs.bash.shellAliases = {
        k = "kubectl";
      };
    };

    homeManagerModules.default = { pkgs, ... }: {
      home.packages = with pkgs; [
        kubectl
        kubectx
        k9s
        talosctl
      ];
    };
  };
}