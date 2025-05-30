{
  description = "Nanashi's flake.nix";
  nixConfig = {
    substituters = [ 
      "https://mirrors.sjtug.sjtu.edu.cn/nix-channels/store"
      "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
      "https://cache.nixos.org"
    ];
  };
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs-sing-box.url = "github:NixOS/nixpkgs/9403a4f741ec24789c0718beb3aaca04c4a9b4ae";
    # nix-alien.url = "github:thiagokokada/nix-alien";
  };
  outputs = { self, nixpkgs, ... }@inputs: 
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
	  ./security
        ];
      };
    };
}
