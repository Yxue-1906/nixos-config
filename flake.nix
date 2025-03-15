{
  description = "Nanashi's flake.nix";
  nixConfig = {
    substituters = [ 
      "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
      "https://cache.nixos.org"
    ];
  };
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/9df5ff73a8887edc8fb69a9facf3b7f6e8ed17d7";
  };
  outputs = { self, nixpkgs, nixpkgs-unstable, ... }@inputs: 
    with nixpkgs.lib; 
    {
      nixosConfigurations."unrelated" = nixosSystem rec {
	# now set system manually is work around, find if can use nixpkgs.hostPlatform
	system = "x86_64-linux";
        specialArgs = {
          secrets = import ./secrets/secrets.nix;
          unstable-pkgs = import nixpkgs-unstable {
	    inherit system;
	    config.allowUnfree = true;
	  };
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
