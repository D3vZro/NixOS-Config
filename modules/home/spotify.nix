{ config, pkgs, lib, spicetify-nix, ... }:
let
  spicePkgs = spicetify-nix.legacyPackages.${pkgs.system};
in {
  programs.spicetify = {
    enable = true;
    theme = spicePkgs.themes.sleek;
    colorScheme = "Nord";
  };
}
