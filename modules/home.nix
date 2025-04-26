{
  config,
  pkgs,
  lib,
  ...
}:

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
  home.language.base = "de_DE.UTF-8";

  qt = {
    enable = true;
    platformTheme.name = "gtk";
  };

  xdg = {
    enable = true; # Enable xdg explicitly
    mime.enable = true;

    userDirs = {
      enable = true;
      createDirectories = true;

      desktop = "${config.home.homeDirectory}/Desktop";
      documents = "${config.home.homeDirectory}/Dokumente";
      download = "${config.home.homeDirectory}/Downloads";
      music = "${config.home.homeDirectory}/Musik";
      pictures = "${config.home.homeDirectory}/Bilder";
      publicShare = "${config.home.homeDirectory}/Öffentlich";
      templates = "${config.home.homeDirectory}/Vorlagen";
      videos = "${config.home.homeDirectory}/Videos";
    };
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
      package = pkgs.papirus-nord;
      name = "Papirus-Dark";
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
      components = [
        "secrets"
        "pkcs11"
      ];
    };

    gpg-agent = {
      enable = true;
      # enableSshSupport = false;
    };
  };
}
