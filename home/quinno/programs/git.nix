{ pkgs
, ...
}: {
  home.packages = [ pkgs.gh ];

  programs.git = {
    enable = true;

    userName = "Neochaotics";
    userEmail = "neochaotics@pm.me";

    extraConfig = {
      core = {
        editor = nvim;
      };
      color = {
        branch = auto;
        diff = auto;
        interactive = auto;
        pager = true;
        status = auto;
        branch = auto;
        ui = true;
      };
      rerere = {
        enabled = true;
        autoupdate = true;
      };
      rebase = {
        autoSquash = true;
      };
      push.default = upstream;
      pull.rebase = true;
    };
  };
}
