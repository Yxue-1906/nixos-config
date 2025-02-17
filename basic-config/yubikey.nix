{ pkgs, config, lib, ... }: {

  # Disable ssh-agent
  programs.ssh.startAgent = false;
  security.pam.sshAgentAuth.enable = false;
  nixpkgs.overlays = [
    # https://github.com/NixOS/nixpkgs/blob/nixos-24.11/pkgs/by-name/gn/gnome-keyring/package.nix
    # To disable SSH_AUTH_SOCK by gnome-keyring.
    #
    # And it should be override the package it self, the module is not configurable for the package. https://github.com/NixOS/nixpkgs/blob/nixos-24.11/nixos/modules/services/desktops/gnome/gnome-keyring.nix
    (final: prev: {
      gnome = prev.gnome.overrideScope' (gfinal: gprev: {
        gnome-keyring = gprev.gnome-keyring.overrideAttrs (oldAttrs: {
          configureFlags = oldAttrs.configureFlags or [ ] ++ [
            "--disable-ssh-agent"
          ];
        });
      });
    })
  ];

  # Enable hardware key support
  services.udev.packages = [ pkgs.yubikey-personalization ];
  services.pcscd.enable = true;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

}
