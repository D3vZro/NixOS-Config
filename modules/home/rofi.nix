{
  config,
  pkgs,
  lib,
  ...
}:

{
  programs.rofi = {
    enable = true;
    theme = ./../../configs/rofi/nord-twoLines.rasi;
    font = "BitstromWera Nerd Font 12";

    cycle = false;
    terminal = "alacritty";

    package = pkgs.rofi-wayland;

    extraConfig = {
      modi = "drun,window,filebrowser";
    };
  };
}
