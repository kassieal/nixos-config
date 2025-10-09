{ config, options, lib, klib, inputs, ... }:
let
  inherit (lib) mkIf;
  inherit (klib) mk-enable;

  cfg = config.modules.services.sops;
in {
  imports = [ inputs.sops-nix.nixosModules.sops ];

  options.modules.services.sops = { enable = mk-enable false; };

  config = mkIf cfg.enable {
    sops = {
      validateSopsFiles = false;
      defaultSopsFile = "${inputs.self.outPath}/secrets/secrets.yaml";
    };
  };
}
