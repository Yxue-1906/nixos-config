{ pkgs, config, lib, ...}: {
  imports = [
    ./aria2.nix
    ./IDEs.nix
    ./editors.nix
    ./browsers.nix
  ];

  programs = {
    git.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    file-roller = {
      enable = true;
    };
    tmux.enable = true;
  };

  # Allow Unfree
  nixpkgs.config.allowUnfree = true;
  
  environment.systemPackages = with pkgs; [
    # vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    # wget
    dig
    inetutils
    git-crypt
    home-manager
    _7zz
    zotero
  ];
}
