{ pkgs, ... }:

{
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    initrd.systemd.dbus.enable = true;

    loader = {
      efi.canTouchEfiVariables = true;
      timeout = 0;

      systemd-boot = {
        enable = true;
        configurationLimit = null;
        consoleMode = "max";
      };
    };
  };

  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true;
  };

  hardware = {
    enableRedistributableFirmware = true;
    keyboard.qmk.enable = true;
    graphics.enable = true;

    bluetooth = {
      enable = true;
      powerOnBoot = false;
    };
  };

  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 25;
  };

}
