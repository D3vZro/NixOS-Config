{
  config,
  pkgs,
  lib,
  zenBrowser,
  ...
}:

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
      nerd-fonts.symbols-only
      nerd-fonts.bitstream-vera-sans-mono
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
    steam.enable = true;
    nano.enable = false; # Nano is cringe

    nh = {
      enable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    # Warning: Out-of-tree
    zenBrowser

    bat
    bottom
    btop
    easyeffects
    fd
    gammastep
    haruna
    imv
    killall
    libreoffice
    libsForQt5.okular
    mono
    neofetch
    networkmanagerapplet
    nix-output-monitor
    pamixer
    helvum
    pavucontrol
    playerctl
    polkit_gnome
    pulseaudio
    ranger
    ripgrep
    tealdeer
    tree
    vesktop
    viewnior
    waypipe
    wget
    wl-clipboard
    xfce.thunar
    zenity
    zotero
  ];
}
