{ config, options, lib, klib, inputs, ... }:
let
  inherit (lib) mkIf;
  inherit (klib) mk-enable;

  cfg = config.modules.desktop.services.impermanence;
in {
  imports = [ inputs.impermanence.nixosModules.home-manager.impermanence ];

  options.modules.desktop.services.impermanence = { enable = mk-enable false; };

  config = mkIf cfg.enable {
    home.persistence = {
      # enable = true;
      "/persist/home/${config.home.username}" = {
        directories = [ ".gnupg" ".ssh" "Pictures" "Documents" "projects" ];
        allowOther = true;
      };
    };
  };
}
