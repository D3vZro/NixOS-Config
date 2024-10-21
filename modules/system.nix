{ config, pkgs, lib, username, ... }:

{
  imports = [
    ./system/env.nix
    ./system/hardware.nix
    ./system/overlays.nix
    ./system/services.nix
    ./system/display.nix
  ];

  home-manager.users.${username} = { config, pkgs, lib, ... }: {
    imports = [ ./home.nix ];
  };

  i18n.defaultLocale = "de_DE.UTF-8";
  system.stateVersion = "22.05";

  time = {
    timeZone = "Europe/Berlin";
    hardwareClockInLocalTime = true;
  };

  networking = {
    firewall = {
      enable = true;
      # allowedTCPPorts = [ 57621 ];
      # allowedUDPPorts = [ 5353 ];
    };

    networkmanager = {
      enable = true;
      # wifi.macAddress = "random";

      plugins = with pkgs; [
        networkmanager-openvpn
        networkmanager-openconnect
      ];
    };
  };

  security = {
    rtkit.enable = true;
    polkit.enable = true;

    pam.services = {
      swaylock = {
        gnupg.enable = true;
        enableGnomeKeyring = true;
      };

      greetd = {
        gnupg.enable = true;
        enableGnomeKeyring = true;
      };
    };
  };

  # User
  users = {
    defaultUserShell = pkgs.zsh;

    users.${username} = {
      isNormalUser = true;
      home = "/home/${username}";
      useDefaultShell = true;
      extraGroups = [
        "wheel"
        "audio"
        "input"
        "video"
        "networkmanager"
        "libvirtd"
      ];
    };
  };
}
