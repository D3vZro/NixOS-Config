{
  config,
  pkgs,
  lib,
  nvimOS,
  ...
}:

{
  # programs = {
  #   vscode.enable = true;
  # };

  home.packages = [
    nvimOS
  ];
}
