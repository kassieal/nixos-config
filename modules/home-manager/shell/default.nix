{
  config,
  options,
  lib,
  klib,
  pkgs,
  ...
}: let
  cfg = config.modules.shell;
in {
  config = {
    home.packages = with pkgs; [
      btop
      htop
      zip
      unzip
      fd
      ripgrep
      fzf
    ];
  };
}
