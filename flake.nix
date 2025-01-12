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

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
          };
          modules = [ ./hosts/${hostname} ];
        }
      );
    in
    {
      # NixOS configurations
      nixosConfigurations = hostConfigs;

      # Development shell
      devShells.${system}.default = (import ./shell.nix { inherit pkgs; });

      # Formatter configuration
      formatter.${system} = pkgs.nixfmt-rfc-style;
    };
}
