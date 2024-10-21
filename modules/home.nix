{ config, pkgs, lib, ... }:

{
  imports = [
    ./home/alacritty.nix
    ./home/editor.nix
    ./home/git.nix
    ./home/rofi.nix
    ./home/shell.nix
    ./home/spotify.nix
    ./home/zathura.nix
    ./home/sway.nix
  ];

  home.keyboard = null;
  home.stateVersion = "22.05";
  home.language.base = "de";

  qt = {
    enable = true;
    platformTheme.name = "gtk";
  };

  xdg = {
    enable = true; # Enable xdg explicitly
    userDirs.enable = true;
  };

  home.pointerCursor = {
    package = pkgs.capitaine-cursors;
    name = "capitaine-cursors-white";
    size = 16;
    gtk.enable = true;
    x11.enable = true;
  };

  gtk = {
    enable = true;

    theme = {
      package = pkgs.nordic;
      name = "Nordic";
    };

    font = {
      name = "Noto Sans";
      size = 10;
    };

    iconTheme = {
      package = pkgs.luna-icons;
      name = "Luna-Dark";
    };
  };

  programs.keychain = {
    enable = true;
    enableXsessionIntegration = true;
    enableZshIntegration = true;
  };

  services = {
    playerctld.enable = true;

    udiskie = {
      enable = true;
      automount = true;
      notify = true;
    };

    gnome-keyring = {
      enable = true;
      components = ["secrets" "pkcs11" "ssh"];
    };

    gpg-agent = {
      enable = true;
      enableSshSupport = true;
    };
  };
}
