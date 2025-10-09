{
  config,
  options,
  lib,
  klib,
  inputs,
  ...
}: let
  inherit (lib) types mkOption listToAttrs map mkDefault mkMerge mkIf;
  inherit (klib) mk-homes all-modules-in-dir-rec mk-users mk-opt;

  cfg = config.modules.users;
in {
  options.modules = {
    users = mkOption {
      type = types.listOf (
        types.submodule {
          options = {
            name = mkOption {
              type = types.str;
            };
            privileged = mkOption {
              type = types.bool;
              default = false;
            };
            config = mkOption {
              type = types.nullOr types.path;
              default = null;
            };
            password = mkOption {
              type = types.nullOr types.path;
              default = null;
            };
            extra-groups = mkOption {
              type = types.listOf types.str;
              default = [];
            };
          };
        }
      );
    };

    userDefaults = {
      extraGroups = mk-opt (types.listOf types.str) [] "Default groups for all users";
    };
  };

  config = mkMerge [
    {
      users.mutableUsers = false;
      users.users = let
        sops = {
          enabled = config.modules.services.sops.enable;
          paths = listToAttrs (map (user: {
              name = user.name;
              value = config.sops.secrets."passwords/${user.name}".path;
            })
            cfg);
        };
      in
        mk-users config.modules.userDefaults.extraGroups sops cfg;

      home-manager = let
        module-paths = klib.all-modules-in-dir-rec "${inputs.self.outPath}/modules/home-manager";
      in {
        extraSpecialArgs = {
          inherit inputs klib;
        };
        users = mk-homes module-paths ./home.nix cfg;
        backupFileExtension = "backup";
      };
    }
    (
      mkIf config.modules.services.sops.enable {
        sops.secrets = listToAttrs (map (user: {
            name = "passwords/${user.name}";
            value = {
              neededForUsers = true;
            };
          })
          cfg);
      }
    )
  ];
}
