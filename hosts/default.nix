{ inputs, config, lib, klib, pkgs, ... }: let
  inherit (lib) mkDefault;
in {
  imports = [
    ../users
    inputs.home-manager.nixosModules.home-manager
  ];

  time.timeZone = mkDefault "America/New_York";
  i18n.defaultLocale = mkDefault "en_US.UTF-8";

  nix.settings = {
    experimental-features = mkDefault "nix-command flakes";
    auto-optimise-store = mkDefault true;
    trusted-users = [ "kassie" ];
  };

  nixpkgs = {
    config.allowUnfree = mkDefault true;
    hostPlatform.system = "x86_64-linux";
  };

  environment.systemPackages = with pkgs; mkDefault [
    curl
    git
    neovim
  ];

  boot.kernelPackages = mkDefault pkgs.linuxPackages_latest;
  system.stateVersion = "25.05";
}
