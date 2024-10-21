{ config, pkgs, lib, ... }:

{
  services.mako = {
    enable = true;
    anchor = "top-right";
    maxVisible = -1;
    sort = "-time";
    defaultTimeout = 10000;

    height = 300;
    width = 400;
    margin = "10,10";
    padding = "10";

    icons = false;

    font = "BitstromWera Nerd Font Regular 12";
    format = "<b>%s</b>\\n%b";

    backgroundColor = "#2E3440";
    borderColor = "#5E81AC";
    textColor = "#E5E9F0";
    progressColor = "over #88C0D0";

    borderRadius = 2;
    borderSize = 3;

    extraConfig = ''
    '';
  };
}
