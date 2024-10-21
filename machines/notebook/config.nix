{ config, pkgs, lib, username, ... }:

{
  # Name
  networking.hostName = "nix-notebook";

  # Distributed builds
  nix = {
    distributedBuilds = false;

    buildMachines = [
      {
        hostName = "remote";
        system = "x86_64-linux";
        maxJobs = 6;
        speedFactor = 2;
        supportedFeatures = [ "kvm" "big-parallel" ];
      }
    ];

    extraOptions = ''
      builders-use-substitutes = true
    '';
  };

  # Hardware
  services.xserver.videoDrivers = [ "amdgpu" ];
  hardware.cpu.amd.updateMicrocode = true;
  networking.networkmanager.wifi.powersave = true;

  boot = {
    kernelModules = [ "acpi_call" ];
    loader.systemd-boot.consoleMode = pkgs.lib.mkForce "keep";

    extraModulePackages = with config.boot.kernelPackages; [
      acpi_call
    ];
  };

  powerManagement = {
    enable = true;
    cpuFreqGovernor = "powersave";
    powertop.enable = true;
  };

  services = {
    upower = {
      enable = true;
      usePercentageForPolicy = true;
      criticalPowerAction = "PowerOff";
    };
  };

  environment.systemPackages = with pkgs; [
    brightnessctl
  ];
}
