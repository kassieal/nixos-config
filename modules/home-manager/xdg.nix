{
  config,
  lib,
  ...
}: with lib; {
  xdg.portal.extraPortals = [
    pkgs.xdg-desktop-portal-gtk
  ];

  xdg = {
    enable = mkDefault true;

    mimeApps = {
      enable = true;
      defaultApplications = {
        "application/json" = "firefox.desktop";
        "application/pdf" = "org.pwmt.zathura.desktop.desktop";
        "application/x-extension-htm" = "firefox.desktop";
        "application.x-extension-html" = "firefox.desktop";
        "application/x-extension-shtml" = "firefox.desktop";
        "application/x-extension-xht" = "firefox.desktop";
        "application/x-extension-xhtml" = "firefox.desktop";
        "application/xhtml+xml" = "firefox.desktop";
        "text/html" = "firefox.desktop";
        "x-scheme-handler/discord" = "discordcanary.desktop";
        "x-scheme-handler/ftp" = "firefox.desktop";
        "x-scheme-handler/http" = "firefox.desktop";
        "x-scheme-handler/https" = "firefox.desktop";
        "x-scheme-handler/about" = "firefox.desktop";
        "x-scheme-handler/unknown" = "firefox.desktop";
        "Terminal" = "foot.desktop";
        "image/jpeg" = "firefox.desktop";
        "image/png" = "firefox.desktop";
        "text/plain" = "nvim.desktop";
      };
    };
  };

  home.sessionVariables = {
    XDG_CACHE_HOME = mkDefault "$HOME/.cache";
    XDG_CONFIG_HOME = mkDefault "$HOME/.config";
    XDG_DATA_HOME = mkDefault "$HOME/.local/share";
    XDG_BIN_HOME = mkDefault "$HOME/.local/bin";
  };
}
