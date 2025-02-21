{
  description = "Nanashi's flake.nix";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs-22_11.url = "github:NixOS/nixpkgs/nixos-22.11";
    nixpkgs-24_11.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/24a2206ec1be5ecb32acf8ab089333eb75d7c4b1";
  };
  outputs = { self, nixpkgs, nixpkgs-22_11, nixpkgs-24_11, nixpkgs-unstable, ... }@inputs: 
    with nixpkgs.lib; 
    {
      nixosConfigurations."unrelated" = nixosSystem {
        specialArgs = {
          secrets = import ./secrets/secrets.nix;
          inherit nixpkgs nixpkgs-22_11 nixpkgs-24_11 nixpkgs-unstable;
        };
        modules = [
          ./networking
          ./applications
	  ./filesystem
          ./profile
          ./basic-config
        ];
      };
    };
}
