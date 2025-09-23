{
  config,
  pkgs,
  ...
}: {
  modules = {
    desktop = {
      services = {
        impermanence.enable = true;
      };
    };
  };

  home = {
    packages = with pkgs; [
      # kicad
    ];

    persistence = {
      "/persist/home/kassie" = {
        directories = [
          # ".local/share/kicad";
        ];
      };
    };
  };
}
