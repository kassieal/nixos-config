{
  config,
  lib,
  klib,
  inputs,
  ...
}: let
  inherit (lib) mkIf types mkDefault mkOption;
  inherit (builtins) foldl';
  inherit (klib) mk-enable mk-opt mk-str-opt;

  cfg = config.modules.system.filesystem.impermanence;
in {
  imports = [ inputs.impermanence.nixosModules.impermanence ];

  options.modules.system.filesystem.impermanence = {
    enable = mk-enable false;
    persist-dir = mk-str-opt "/persist";
    dirs-to-persist = mkOption {
      type = types.listOf types.str;
      description = "Directories to persist";
      default = [];
    };
    files-to-persist = mkOption {
      type = types.listOf types.str;
      description = "Files to persist";
      default = [];
    };
  };

  config = mkIf cfg.enable {
    assertions = [
      {
        assertion = config.modules.system.filesystem.ephemeral-btrfs.enable;
        message = "Impermanence requires an ephemeral file system!";
      }
    ];

    programs.fuse.userAllowOther = mkDefault true;

    security.sudo.extraConfig = "Defaults lecture=never"; # avoid getting lectured on rollback

    environment.persistence."${cfg.persist-dir}" = {
      enable = true;
      hideMounts = true;
      directories =
        [
          "/etc/NetworkManager/system-connections/"
          "/etc/ssh/"
          "/var/lib/bluetooth/"
          "/var/lib/nixos/"
          "/var/lib/systemd/backlight/"
        ] 
        ++ cfg.dirs-to-persist;
      files = 
      [      
      ]
      ++ cfg.files-to-persist;
    };
  };
}
