{
  description = "Nanashi's flake.nix";
  nixConfig = {
    substituters = [ 
      "https://mirrors.sjtu.edu.cn/nix-channels/store"
      "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
      "https://cache.nixos.org"
    ];
  };
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs-gvfs-1-54-2.url = "github:NixOS/nixpkgs/99a83d3cc8a962701b76ee1fb7b6799dd04e34a8";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/9df5ff73a8887edc8fb69a9facf3b7f6e8ed17d7";
    nix-alien.url = "github:thiagokokada/nix-alien/master";
  };
  outputs = { self, nixpkgs, nixpkgs-unstable, nixpkgs-gvfs-1-54-2, ... }@inputs: 
    with nixpkgs.lib; 
    {
      nixosConfigurations."unrelated" = nixosSystem rec {
	# now set system manually is work around, find if can use nixpkgs.hostPlatform
	system = "x86_64-linux";
        specialArgs = {
	  inherit self;
          secrets = import ./secrets/secrets.nix;
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
