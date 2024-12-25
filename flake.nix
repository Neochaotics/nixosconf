{
  description = "NIXOS";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";

    # Home manager
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    disko.url = "github:nix-community/disko/latest";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    impermanence.url = "github:nix-community/impermanence";
  };

  outputs =
    { self
    , nixpkgs
    , nixpkgs-stable
    , home-manager
    , ...
    } @ inputs:
    let
      inherit (self) outputs;
      forAllSystems = nixpkgs.lib.genAttrs [ "x86_64-linux" ];
      hostConfigs = nixpkgs.lib.foldl
        (acc: host:
          let
            systemConfig = nixpkgs.lib.nixosSystem {
              specialArgs = { inherit inputs outputs; };
              modules = [ ./hosts/${host} ];
            };
          in
          acc // { ${host} = systemConfig; }
        )
        { }
        (nixpkgs.lib.attrNames (builtins.readDir ./hosts));
    in
    {
      nixosConfigurations = hostConfigs;
    };
}
