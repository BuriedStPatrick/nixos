{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }: {
    nixosModules.default = { pkgs, ... }: {
      virtualisation.podman = {
        enable = true;
        # Enables symlink from docker => podman for CLI commands
        dockerCompat = true;

        # Enables symlink from /var/run/docker.sock => /run/podman/podman.sock
        dockerSocket.enable = true;

        defaultNetwork.settings.dns_enabled = true;
      };

      # Since we're configuring ZSH at system-level, need to modify the aliases at that same level.
      programs.zsh.shellAliases = {
        lazy = "lazydocker";
      };

      programs.bash.shellAliases = {
        lazy = "lazydocker";
      };
    };

    homeManagerModules.default = { pkgs, ... }: {
      home.packages = with pkgs; [
        lazydocker
      ];
    };
  };
}