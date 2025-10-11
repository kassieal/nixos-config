{inputs, ...}: {
  imports = [./hardware-configuration.nix];

  modules = {
    system = {
      boot.systemd-boot.enable = true;
      network.enable = true;

      filesystem = {
        ephemeral-btrfs.enable = true;
        impermanence.enable = true;
        disko = {
          enable = true;
          config-file = ./disko.nix;
        };
      };
    };

    services = {
      # sops.enable = true;
      ssh.enable = true;
    };

    users = [
      {
        name = "kassie";
        privileged = true;
        config = "${inputs.self.outPath}/users/kassie";
      }
    ];
  };
}
