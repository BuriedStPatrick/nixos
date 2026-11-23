{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }: {
    nixosModules.default = { pkgs, ... }: {
      # At the system level, enable ZSH
      programs.zsh = {
        enable = true;
      };

      # At the system level, set the default shell for all users to ZSH
      users.defaultUserShell = pkgs.zsh;
    };

    homeManagerModules.default = { pkgs, ... }: {
      xdg.configFile."zsh".source = ./zsh/config;
      home.file.".zshrc".source = ./zsh/.zshrc;

      home.packages = with pkgs; [
        kitty
        eza
        fzf
        gitui
        fastfetch
        btop
        gh
        azure-cli
        wl-clipboard
      ];
    };
  };
}
