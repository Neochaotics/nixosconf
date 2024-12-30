{ inputs
, outputs
, config
, lib
, pkgs
, ...
}: {
  imports = lib.flatten [
    inputs.disko.nixosModules.disko
    inputs.impermanence.nixosModules.impermanence
    inputs.home-manager.nixosModules.home-manager
    ../modules/common
    ./sudo.nix
    ./hyprland.nix
  ];

  hostSpec = {
    username = "quinno";
  };

  users.users.quinno = {
    isNormalUser = true;
    extraGroups = ["wheel"];
    description = "Quinn O";
  };
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.backupFileExtension = "bk";
  home-manager.users.quinno = import ../home/quinno; #${hostSpec.username} = import ../home/${hostSpec.username};
  home-manager.extraSpecialArgs = {
    inherit pkgs inputs;
    hostSpec = config.hostSpec;
  };


  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  nix =
    let
      flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
    in
    {
      settings = {
        connect-timeout = 5;
        min-free = 128000000;
        max-free = 1000000000;
        experimental-features = "nix-command flakes";
        trusted-users = [ "@wheel" ];
        fallback = true;
        warn-dirty = false;
        auto-optimise-store = true;
        flake-registry = "";
        substituters = ["https://hyprland.cachix.org"];
        trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
      };
      channel.enable = false;

      registry = lib.mapAttrs (_: flake: { inherit flake; }) flakeInputs;
      nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
    };

}
