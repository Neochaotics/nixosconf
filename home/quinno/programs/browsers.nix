{ inputs
, pkgs
, config
, ...
}:
let
  homeDir = config.home.homeDirectory;
in
{
  mimeApps.defaultApplications = {
    "text/html" = [ "firefox.desktop" "chromium.desktop" ];
    "x-scheme-handler/http" = [ "firefox.desktop" "chromium.desktop" ];
    "x-scheme-handler/https" = [ "firefox.desktop" "chromium.desktop" ];
    "x-scheme-handler/about" = [ "firefox.desktop" "chromium.desktop" ];
    "x-scheme-handler/unknown" = [ "firefox.desktop" "chromium.desktop" ];
  };

  programs = {
    # - https://mozilla.github.io/policy-templates/
    firefox = {
      enable = true;
      policies = {
        "AppAutoUpdate" = false;
        "AutofillAddressEnabled" = false;
        "AutofillCreditCardEnabled" = false;
        "BackgroundAppUpdate" = false;
        "BlockAboutAddons" = true;
        "BlockAboutConfig" = true;
        "BlockAboutProfiles" = true;
        "BlockAboutSupport" = true;
        "CaptivePortal" = true;
        "Cookies" = {
          "AcceptThirdParty" = "from-visited";
          "Behavior" = "reject-tracker";
          "BehaviorPrivateBrowsing" = "reject-tracker";
          "RejectTracker" = true;
        };
        "DefaultDownloadDirectory" = "${homeDir}/Downloads";
        "DisableAppUpdate" = true;
        "DisableDefaultBrowserAgent" = true;
        "DisableFeedbackCommands" = true;
        "DisableFirefoxAccounts" = true;
        "DisableFirefoxScreenshots" = true;
        "DisableFirefoxStudies" = true;
        "DisableFormHistory" = true;
        "DisablePasswordReveal" = true;
        "DisablePocket" = true;
        "DisableProfileImport" = true;
        "DisableSafeMode" = true;
        "DisableSetDesktopBackground" = true;
        "DisableSystemAddonUpdate" = true;
        "DisableTelemetry" = true;
        "DisplayBookmarksToolbar" = "newtab";
        "DisplayMenuBar" = "default-off";
        "DNSOverHTTPS" = {
          "Enabled" = true;
          "ProviderURL" = "https=//dns.quad9.net/dns-query";
          "Locked" = true;
        };
        "DontCheckDefaultBrowser" = true;
        "EnableTrackingProtection" = {
          "Value" = true;
          "Locked" = true;
          "Cryptomining" = true;
          "Fingerprinting" = true;
          "EmailTracking" = true;
        };
        "EncryptedMediaExtensions" = {
          "Enabled" = true;
          "Locked" = true;
        };
        "ExtensionUpdate" = true;
        "FirefoxHome" = {
          "Search" = false;
          "TopSites" = false;
          "SponsoredTopSites" = false;
          "Highlights" = false;
          "Pocket" = false;
          "SponsoredPocket" = false;
          "Snippets" = false;
          "Locked" = true;
        };
        "FirefoxSuggest" = {
          "WebSuggestions" = false;
          "SponsoredSuggestions" = false;
          "ImproveSuggest" = false;
          "Locked" = true;
        };
        "HardwareAcceleration" = true;
        "Homepage" = {
          "Locked" = true;
          "StartPage" = "none";
        };
        "HttpsOnlyMode" = "force_enabled";
        "InstallAddonsPermission" = {
          "Default" = false;
        };
        "NetworkPrediction" = false;
        "NewTabPage" = true;
        "NoDefaultBookmarks" = true;
        "OfferToSaveLogins" = false;
        "OverrideFirstRunPage" = "";
        "OverridePostUpdatePage" = "";
        "PasswordManagerEnabled" = false;
        "PopupBlocking" = {
          "Default" = true;
        };
        "Permissions" = {
          "Camera" = {
            "BlockNewRequests" = false;
            "Locked" = true;
          };
          "Microphone" = {
            "BlockNewRequests" = false;
            "Locked" = true;
          };
          "Location" = {
            "BlockNewRequests" = true;
            "Locked" = true;
          };
          "Notifications" = {
            "BlockNewRequests" = true;
            "Locked" = true;
          };
          "Autoplay" = {
            "Default" = "block-audio-video";
            "Locked" = true;
          };
        };
        "PictureInPicture" = {
          "Enabled" = false;
          "Locked" = true;
        };
        "PostQuantumKeyAgreementEnabled" = true;
        "SearchBar" = "unified";
        "SearchSuggestEnabled" = false;
        "ShowHomeButton" = false;
        "StartDownloadsInTempDirectory" = true;
        "SanitizeOnShutdown" = {
          "Cache" = true;
          "Cookies" = true;
          "History" = true;
          "Sessions" = true;
          "SiteSettings" = true;
          "Locked" = true;
        };
        "UserMessaging" = {
          "WhatsNew" = false;
          "ExtensionRecommendations" = true;
          "FeatureRecommendations" = false;
          "UrlbarInterventions" = false;
          "SkipOnboarding" = true;
          "MoreFromMozilla" = false;
          "Locked" = true;
        };
        "UseSystemPrintDialog" = true;
      };
    };
  };
}
