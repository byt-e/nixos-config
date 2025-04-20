{
  description = "Flake-based NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";

    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nixpkgs, home-manager, ... }: {
    # MiniPC Environment Configuration
    nixosConfigurations.minipc = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./hosts/minipc/configuration.nix
        ./hardware-configuration.nix
      ];
    };

    # Home Configuration for Byte user.
    homeConfigurations.byte = home-manager.lib.homeManagerConfiguration {
      pkgs = import nixpkgs {
        system = "x86_64-linux";
        config.allowUnfree = true;
      };
      
      extraSpecialArgs = { inherit inputs; };
    
      modules = [
        ./home/byte/home.nix
      ];
    };
    
  };
}

