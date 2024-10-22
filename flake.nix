{
  description = "A complete NixOS configuration for day-to-day use";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "nixpkgs/nixos-24.05";

    nixNeovim = {
      url = "github:D3vZro/NixNeovim";
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-stable,
    nixNeovim, 
    spicetify-nix, 
    nixvim,
    home-manager,
    nix-index-database
  }:
    let
      username = "zero";
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      nvim = nixNeovim.outputs.packages.${system}.nvim-nix;

      # Enable central username across files via top-level attribute set
      specialArgs = { inherit username; };

      # Basic NixOS config for desktop systems
      base = [
        ./modules/system.nix
        ./modules/packages.nix

        home-manager.nixosModules.home-manager {
          home-manager = {
            extraSpecialArgs = { inherit spicetify-nix; };

            users.${username}.imports = [
              # Inputs
              nixvim.homeManagerModules.nixvim
              spicetify-nix.homeManagerModules.default
              nix-index-database.hmModules.nix-index

              # Files for HM
              ./modules/home.nix
            ];
          };
        }
      ];
    in {
    nixosConfigurations = {
      nix-desktop = nixpkgs.lib.nixosSystem {
        inherit system;
        inherit specialArgs;

        modules = base ++ [
          ./machines/desktop/config.nix
          ./machines/desktop/hardware-configuration.nix
        ];
      };

      nix-notebook = nixpkgs.lib.nixosSystem {
        inherit system;
        inherit specialArgs;

        modules = base ++ [
          ./machines/notebook/config.nix
          ./machines/notebook/hardware-configuration.nix
        ];
      };

      nix-server = nixpkgs-stable.lib.nixosSystem {
        inherit system;
        inherit specialArgs;
        
        modules = [
          ./machines/server/config.nix
          ./machines/server/hardware-configuration.nix
          ./machines/server/env.nix
          ./machines/server/services.nix
        ];
      };
    };

    # For remote systems
    devShells.${system}.default = pkgs.mkShell {
      packages = with pkgs; [
        ripgrep
        fd
        nvim
      ];
    };
  };
}
