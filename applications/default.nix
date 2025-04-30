{ ... }: {
  imports = [
    ./nix-ld.nix
    ./aria2.nix
    ./IDEs.nix
    ./editors.nix
    ./browsers.nix
    ./misc.nix
    ./nautilus
    ./file-roller
  ];


  # Allow Unfree
  nixpkgs.config.allowUnfree = true;
  
}
