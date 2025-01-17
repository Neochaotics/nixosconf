{
  ...
}:
{
  imports = [
    ./desktops/hyprland
    ./bash.nix
    ./firefox.nix
    ./common.nix
    ./git.nix
    ./xdg.nix
    ./foot.nix
  ];

  programs.home-manager.enable = true;

}
