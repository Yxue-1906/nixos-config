{ pkgs, config, nixpkgs-24_11, nixpkgs-unstable, lib, secrets, ...}: {

  networking.hostName = "unrelated";
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  networking.firewall = {
    trustedInterfaces = [ "singbox_tun" ];
    checkReversePath = "loose";
  };

  disabledModules = [
    "services/networking/sing-box.nix"
  ];
  imports = [
    "${nixpkgs-24_11}/nixos/modules/services/networking/sing-box.nix"
  ];

  systemd.services.sing-box.preStart = with pkgs; lib.mkForce ''
    ${lib.getExe (python3.withPackages (pypkgs: with pypkgs; [requests]))} ${./singbox-prestart.py} --token ${secrets.sing-box.github-token} --configuration_url "${secrets.sing-box.configuration-url}" --save_to "/run/sing-box/config.json"
  '';
  systemd.services.sing-box.overrideStrategy = "asDropin";

  services.sing-box = {
    enable = true;
    package = 
      let
        unstable-pkgs = (import nixpkgs-unstable { inherit (pkgs) system; });
      in
        unstable-pkgs.sing-box;
  };

} 
