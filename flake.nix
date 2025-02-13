{
  description = "A complete NixOS configuration for day-to-day use";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "nixpkgs/nixos-24.11";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    nixNeovim = {
      url = "github:D3vZro/NixNeovim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-stable,
      nixos-hardware,
      nixNeovim,
      spicetify-nix,
      home-manager,
      nix-index-database,
      zen-browser,
    }:
    let
      username = "zero";
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      zenBrowser = zen-browser.packages.${system}.default;
      nvim = nixNeovim.outputs.packages.${system}.nix;
      nvimOS = nixNeovim.outputs.packages.${system}.default;

      # Enable central username across files via top-level attribute set
      specialArgs = {
        inherit username;
        inherit zenBrowser;
        inherit nixos-hardware;
      };

      # Basic NixOS config for desktop systems
      base = [
        nix-index-database.nixosModules.nix-index
        ./modules/system.nix
        ./modules/packages.nix

        home-manager.nixosModules.home-manager
        {
          home-manager = {
            extraSpecialArgs = {
              inherit spicetify-nix;
              inherit nvimOS;
            };

            users.${username}.imports = [
              # Inputs
              spicetify-nix.homeManagerModules.default

              # Files for HM
              ./modules/home.nix
            ];
          };
        }
      ];
    in
    {
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
          ];
        };
      };

      # For remote systems
      devShells.${system}.default = pkgs.mkShell {
        packages = with pkgs; [
          nvim
          treefmt
          nil
          nixfmt-rfc-style
        ];
      };
    };
}
