{
  description = "Nanashi's flake.nix";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
  };
  outputs = { self, nixpkgs, nixpkgs-unstable, ... }@inputs: 
    with nixpkgs-unstable.lib; 
    {
      nixosConfigurations = genAttrs [ "unrelated-desktop" "unrelated-laptop" ] 
        (hostname: nixosSystem {
          specialArgs = {
            secrets = import ./secrets/secrets.nix;
            inherit hostname;
          };
          modules = [
            ./networking
            ./applications
	    ./filesystem
            ./user
            ./basic-conf.nix
          ];
      });
    };
}
