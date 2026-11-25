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

      # Enable libvirtd
      # https://wiki.nixos.org/wiki/Libvirt
      virtualisation.libvirtd.enable = true;

      # Enable virt-manager
      # https://wiki.nixos.org/wiki/Virt-manager
      programs.virt-manager.enable = true;

      # Trust virbr0 used by libvirt > dnsmasq for DNS and DHCP
      networking.firewall.trustedInterfaces = [ "virbr0" ];

      networking.firewall.interfaces.virbr0 = {
        allowedUDPPorts = [
          53
          67
        ];
        allowedTCPPorts = [
          22
          6443
        ];
      };

      networking.nat = {
        enable = true;
        internalInterfaces = [ "virbr0" ];
      };

      environment.systemPackages = [
        pkgs.qemu
      ];

      # Enable UEFI firmware support for QEMU
      systemd.tmpfiles.rules = [ "L+ /var/lib/qemu/firmware - - - - ${pkgs.qemu}/share/quemu/firmware" ];
    };

    homeManagerModules.default = { pkgs, ... }: {
      # Wayland fix for virt-manager
      home.pointerCursor = {
        gtk.enable = true;
        package = pkgs.vanilla-dmz;
        name = "Vanilla-DMZ";
      };

      home.packages = with pkgs; [
        kubectl
        kubectx
        k9s
        talosctl
        quickemu # https://github.com/quickemu-project/quickemu
      ];
    };
  };
}