{
  config,
  pkgs,
  lib,
  ...
}:

let
  inherit (lib) concatStringsSep getExe;
  greeter = getExe pkgs.greetd.tuigreet;
  systemSessions = config.services.displayManager.sessionData.desktops;
in
{
  services = {
    greetd = {
      enable = true;
      restart = true;
      package = pkgs.greetd.greetd;

      settings = {
        default_session = {
          command = concatStringsSep " " [
            greeter
            "--asterisks"
            "--remember"
            "--time"
            "--cmd '${pkgs.sway}/bin/sway --unsupported-gpu'"
          ];
          user = "greeter";
        };
      };
    };

    xserver = {
      enable = true;
      xkb = {
        layout = "de";
        options = "eurosign:e";
      };
    };
  };
}
