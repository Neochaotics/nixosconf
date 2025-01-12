{
  description = "NixOS System Configuration";

  inputs = {
    # Core dependencies
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";

    # System management
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    impermanence.url = "github:nix-community/impermanence";
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-stable,
      home-manager,
      ...
    }@inputs:
    let
      inherit (self) outputs;
      system = "x86_64-linux";

      pkgs = import nixpkgs { inherit system; };

      # Load all hosts from the hosts directory
      hostNames = builtins.attrNames (builtins.readDir ./hosts);
      hostConfigs = nixpkgs.lib.genAttrs hostNames (
        hostname:
        nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs outputs hostname;
            pkgs-stable = import nixpkgs-stable { inherit system; };
          };
          modules = [ ./hosts/${hostname} ];
        }
      );
    in
    {
      # NixOS configurations
      nixosConfigurations = hostConfigs;

      # Development shell
      devShells.${system}.default = pkgs.mkShell {
        packages = with pkgs; [
          nil
          nixfmt-rfc-style
          statix
        ];
      };

      # Formatter configuration
      formatter.${system} = pkgs.nixfmt-rfc-style;
    };
}
