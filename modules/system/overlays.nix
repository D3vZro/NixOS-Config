{
  config,
  pkgs,
  lib,
  ...
}:

{
  nix.package = pkgs.nix;

  nixpkgs.overlays = [
    # (final: prev: {
    #   sway = prev.sway.overrideAttrs (old: {
    #     version = "1.10";
    #
    #     src = prev.fetchFromGitHub {
    #       owner = "swaywm";
    #       repo = "sway";
    #       rev = "19ca790a9f304bb138e531719a8a42f145f835f9";
    #       hash = "sha256-guzEw7eO73WeK86tXu6ebHO20CCnEnd5JHN4BlyIQFg=";
    #     };
    #   });
    # })

    # (final: prev: {
    #   nix = prev.nix.overrideAttrs (previousAttrs: {
    #     patches = previousAttrs.patches ++ [../../configs/patch/fix_nix.patch];
    #     version = "2.18.1";
    #   });
    # })
  ];
}
