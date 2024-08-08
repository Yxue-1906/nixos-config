{ pkgs, config, lib, ...}: {
  imports = [
    ./aria2.nix
  ];

  programs = {
    git.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    firefox.enable = true;
    neovim = {
      enable = true;
      defaultEditor = true;
      vimAlias = true;
    };
    gnome-terminal.enable = true;
    nano.enable = false;
    tmux.enable = true;
  };

  nixpkgs.config.allowUnfree = true;
  
  environment.gnome.excludePackages = with pkgs.gnome; [
    epiphany
  ];
  environment.systemPackages = with pkgs; [
    # vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    # wget
    dig
    inetutils
    git-crypt
    home-manager
    jetbrains.clion
    jetbrains.pycharm-professional
  ];
}
