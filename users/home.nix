# default home-manager config per machine
{ lib, ... }: let
  inherit (lib) mkDefault;
in {
  programs = {
    home-manager.enable = mkDefault true;
    git.enable = mkDefault true;
  };

  nixpkgs.config.allowUnfree = mkDefault true;

  home = {
    stateVersion = mkDefault "25.05";
  };
}
