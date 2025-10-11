{ config, lib, klib, ... }: let
  inherit (builtins) foldl';
  inherit (lib) length filter;
  inherit (klib) attrs-to-list;

  bootloaders = attrs-to-list config.modules.system.boot;
  enabled-bootloaders = filter (bl: bl.value.enable) bootloaders;
  enabled-bootloaders-names = foldl' (s: bl: "${bl.name} ${s}") "" enabled-bootloaders;
in {
  config = {
    assertions = [
      {
        assertion = (length enabled-bootloaders) != 0;
        message = "No bootloader selected!";
      }
      {
        assertion = (length enabled-bootloaders) == 1;
        message = "Multiple bootloaders enabled: [ ${enabled-bootloaders-names} ]";
      }
    ];
  };
}
