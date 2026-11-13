{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }: {
    nixosModules.default = { pkgs, ... }: {
      users.defaultUserShell = pkgs.zsh;

      programs.zsh.enable = true;
    };

    homeManagerModules.default = { pkgs, ... }: {
      xdg.configFile."zsh".source = ./zsh/config;
      home.file.".zshrc".source = ./zsh/.zshrc;

      home.packages = with pkgs; [
        zsh
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