{
  description = "NixOS System Configuration";

  inputs = {
    # Core Nix dependencies
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";

    # System and state management
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    impermanence.url = "github:nix-community/impermanence";

    # Application specific inputs
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Development and formatting tools
    treefmt-nix.url = "github:numtide/treefmt-nix";
    devshell.url = "github:numtide/devshell";
    git-hooks-nix.url = "github:cachix/git-hooks.nix";

    # Flake infrastructure
    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-root.url = "github:srid/flake-root";
  };

  outputs =
    inputs@{ flake-parts, nixpkgs, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];

      imports = [
        inputs.treefmt-nix.flakeModule
        inputs.devshell.flakeModule
        inputs.flake-root.flakeModule
        inputs.git-hooks-nix.flakeModule
      ];

      perSystem =
        { config, pkgs, ... }:
        {
          # Code formatting and linting configuration
          treefmt.config = {
            inherit (config.flake-root) projectRootFile;
            flakeCheck = false;
            programs = {
              # Nix-specific tools
              nixfmt = {
                enable = true;
                package = pkgs.nixfmt-rfc-style;
              };
              statix.enable = true;
              deadnix.enable = true;
              # Other formatting tools
              actionlint.enable = true;
              mdformat.enable = true;
            };
          };

          # Development shell configuration
          devshells.default = {
            name = "nixdev";
            motd = "";
            packages = [
              pkgs.nil # Nix Language Server
              config.treefmt.build.wrapper
            ] ++ (pkgs.lib.attrValues config.treefmt.build.programs);
          };

          # Pre-commit hooks configuration
          pre-commit.settings.hooks = {
            treefmt = {
              enable = true;
              package = config.treefmt.build.wrapper;
            };
            statix = {
              enable = true;
              package = config.treefmt.build.programs.statix;
            };
          };
        };

      # NixOS system configurations
      flake = _: {
        nixosConfigurations =
          let
            hostNames = builtins.attrNames (builtins.readDir ./hosts);
            mkHost =
              hostname:
              nixpkgs.lib.nixosSystem {
                specialArgs = {
                  inherit inputs hostname;
                  outputs = inputs.self;
                };
                modules = [ ./hosts/${hostname} ];
              };
          in
          nixpkgs.lib.genAttrs hostNames mkHost;
      };
    };
}
