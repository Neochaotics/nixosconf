{ pkgs
, config
, ...
}:
let

  core_extensions = [
    ublock-origin
    darkreader
    vimium
    decentraleyes
    user-agent-string-switcher
    violentmonkey
    stylus
    bitwarden
  ];

in
{
  programs = {
    chromium = {
      enable = true;
      extensions = [
        # {id = "";}  // extension id, query from chrome web store
      ];
    };

    firefox = {
      enable = true;
      profiles.main = {
        extensions = with pkgs.nur.repos.rycee.firefox-addons;
          core_extensions;
      };
    };
  };
}
