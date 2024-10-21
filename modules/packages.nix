{ config, pkgs, lib, ... }:

{
  nixpkgs.config.allowUnfree = true;
  home-manager.useGlobalPkgs = true;
  gtk.iconCache.enable = true;

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    xdgOpenUsePortal = true;
    config.common.default = "*";
  };

  nix = {
    settings.auto-optimise-store = true;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  fonts = {
    fontDir.enable = true;

    packages = with pkgs; [
      (nerdfonts.override {
        fonts = [
          "BitstreamVeraSansMono"
          "NerdFontsSymbolsOnly"
        ];
      })
      corefonts
      liberation_ttf # Fixes unity games
      font-awesome
      jetbrains-mono
      noto-fonts
      sarasa-gothic
      source-code-pro
    ];
  };

  programs = {
    # steam.enable = true;
    nano.enable = false; # Nano is cringe
  };

  # Bare minimum
  environment.systemPackages = with pkgs; [
    btop
    easyeffects
    firefox
    gammastep
    haruna
    killall
    mono
    neofetch
    networkmanagerapplet
    nix-index
    nix-output-monitor
    pamixer
    pavucontrol
    playerctl
    polkit_gnome
    pulseaudio
    ranger
    tealdeer
    viewnior
    wget
    wl-clipboard
    xfce.thunar
    zenity

    # Neovim external depends
    ripgrep
    fd
  ];
}
