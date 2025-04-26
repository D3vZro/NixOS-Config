{
  config,
  pkgs,
  lib,
  username,
  nixos-hardware,
  ...
}:

{
  imports = [
    nixos-hardware.nixosModules.framework-13-7040-amd
  ];

  # Name
  networking.hostName = "nix-notebook";

  # Desktop
  home-manager.users.${username} = {
    xdg.configFile."sway/workspace" = {
      source = ../../configs/sway/notebook/workspace.in;
    };
  };

  # Hardware
  services.xserver.videoDrivers = [ "amdgpu" ];
  hardware.cpu.amd.updateMicrocode = true;
  hardware.wirelessRegulatoryDatabase = true;
  # hardware.framework.laptop13.audioEnhancement.enable = true;

  boot = {
    kernelPackages = lib.mkForce pkgs.linuxPackages_latest;
    kernelModules = [ "acpi_call" ];
    loader.systemd-boot.consoleMode = pkgs.lib.mkForce "keep";

    extraModulePackages = with config.boot.kernelPackages; [
      acpi_call
    ];

    extraModprobeConfig = ''
      options cfg80211 ieee80211_regdom="DE"
      options snd_hda_intel power_save=0 power_save_controller=N
    '';
  };

  networking.networkmanager.wifi = {
    powersave = false;
  };

  # Use device as remote builder
  users.groups.builder = {};
  nix.settings.trusted-users = [ "builder" ];

  users.users.builder = {
    isNormalUser = true;
    createHome = false;
    group = "builder";

    openssh.authorizedKeys.keys = [
      # Add ssh key from requesting device
    ];
  };

  powerManagement = {
    enable = true;
    cpuFreqGovernor = "powersave";
  };

  services = {
    upower = {
      enable = true;
      usePercentageForPolicy = true;
      criticalPowerAction = "PowerOff";
    };

    fwupd.enable = true;
  };

  environment.systemPackages = with pkgs; [
    brightnessctl
    fw-ectool
  ];
}
