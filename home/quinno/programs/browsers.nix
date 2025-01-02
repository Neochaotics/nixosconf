{ inputs
, pkgs
, config
, ...
}:
let

  core_extensions = with inputs.nur.repos.rycee.firefox-addons; [
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
        extensions = core_extensions;
      };
    };
  };
}
