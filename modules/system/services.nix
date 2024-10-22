{ config, pkgs, lib, username, ... }:
let
  inherit (pkgs) writeText;
in {

  programs = {
    dconf.enable = true;
    seahorse.enable = true;

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

    gnome = {
      gnome-keyring.enable = true;
      gnome-online-accounts.enable = true;
    };

    openssh = {
      enable = true;
      allowSFTP = true;
    };

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
