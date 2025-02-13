{
  config,
  pkgs,
  lib,
  ...
}:

{
  imports = [
    ../home/mako.nix
  ];

  wayland.windowManager.sway = {
    enable = true;
    package = pkgs.sway;

    wrapperFeatures = {
      base = true;
      gtk = true;
    };
  };

  programs = {
    waybar.enable = true;

    swaylock = {
      enable = true;

      settings = {
        image = "$WALLPAPER/wallpaper.png";
      };
    };
  };

  xdg.configFile = {
    "sway/config".source = lib.mkForce ../../configs/sway/config.in;
    "sway/keybindings".source = ../../configs/sway/keybindings.in;
    "sway/io".source = ../../configs/sway/ioNotebook.in;
    "waybar/config".source = ../../configs/waybar/config.json;
    "waybar/modules".source = ../../configs/waybar/modules.json;
    "waybar/style.css".source = ../../configs/waybar/style.css;
    "workstyle/config.toml".source = ../../configs/waybar/config.toml;
  };

  home.packages = with pkgs; [
    swayidle
    autotiling-rs
    workstyle
  ];
}
