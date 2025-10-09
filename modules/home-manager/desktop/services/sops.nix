{ inputs, config, ... }: {
  imports = [ inputs.sops-nix.homeManagerModules.sops ];

  sops = {
    validateSopsFiles = false;
    defaultSopsFile = "${inputs.self.outPath}/secrets/secrets.yaml";
  };
}
