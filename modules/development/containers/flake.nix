{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }: {
    nixosModules.default = { pkgs, ... }: {
      virtualisation.podman = {
        enable = true;
        # Enables symlink from docker => podman for CLI commands
        # NOTE: Does NOT create a symlink from /var/run/docker.sock => /run/podman/podman.sock
        dockerCompat = true;
        # TODO: Figure out how to enable symlink to docker socket like this (for maximum compatibility):
        # sudo ln -sf /run/podman/podman.sock /var/run/docker.sock
        # HINT: Test socket with curl:
        # curl --unix-socket /run/podman/podman.sock http://localhost/v1.40/version | jq .
        # curl --unix-socket /var/run/docker.sock http://localhost/v1.40/version | jq .
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