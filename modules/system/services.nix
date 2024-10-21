{ config, pkgs, lib, username, ... }:
let
  inherit (pkgs) writeText;
in {

  programs = {
    dconf.enable = true;
    seahorse.enable = true;

    # ausweisapp = {
    #   enable = true;
    #   openFirewall = true;
    # };

    gnupg = {
      dirmngr.enable = true;

      agent = {
        enable = true;
        enableSSHSupport = true;
        enableBrowserSocket = true;
        pinentryPackage = pkgs.pinentry-gnome3;
      };
    };
  };

  services = {
    fstrim.enable = true;
    acpid.enable = true;
    geoclue2.enable = true;
    blueman.enable = true;
    udisks2.enable = true; # Dependency of home-manager/services.udiskie

    # postgresql = {
    #   enable = true;

    #   authentication = ''
    #     local all all peer
    #   '';
    # };

    # syncthing = {
    #   enable = true;
    #   user = username;
    #   openDefaultPorts = true;
    #   dataDir = "/home/${username}/.syncthing";
    # };

    gnome = {
      gnome-keyring.enable = true;
      gnome-online-accounts.enable = true;
    };

    openssh = {
      enable = true;
      allowSFTP = true;
    };

    # printing = {
    #   enable = true;
    #   browsing = true;
    #   drivers = with pkgs; [ epson-escpr ];
    # };

    # avahi = {
    #   enable = true;
    #   nssmdns4 = true;
    # };

    pipewire = {
      enable = true;
      audio.enable = true;
      wireplumber.enable = true;
      pulse.enable = true;
      jack.enable = true;

      alsa.enable = true;
      alsa.support32Bit = true;
    };
  };
}
