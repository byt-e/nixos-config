{
  description = "Flake-based NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";

    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nvf.url = "github:notashelf/nvf";
  };

  outputs = inputs@{ self, nixpkgs, home-manager, nvf, ... }: {
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
        nvf.homeManagerModules.default
        ./home/byte/home.nix
      ];
    };
    
  };
}

