{ ... }: {
  imports = [
    ./basic-config.nix
    ./yubikey.nix
    ./hardware.nix
  ];
}
