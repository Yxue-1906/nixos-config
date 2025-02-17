{ config, lib, pkgs, hostname, secrets, ...}: {

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.unrelated = {
    isNormalUser = true;
    password = secrets.password.${lib.strings.removePrefix "unrelated-" hostname};
    extraGroups = [ "aria2" "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
  };
}
