{
  config,
  options,
  lib,
  klib,
  ...
}: let
  inherit (lib) mkIf;
  inherit (klib) mk-enable;

  cfg = config.modules.services.ssh;
in {
  options.modules.services.ssh = {
    enable = mk-enable true;
  };

  config = mkIf cfg.enable {
    services.openssh = {
      enable = true;
    };
  };
}
