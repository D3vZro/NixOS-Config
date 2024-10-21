{pkgs, username, ...}:

{
  networking.hostName = "nix-server";

  hardware.enableRedistributableFirmware = true;
  i18n.defaultLocale = "de_DE.UTF-8";
  system.stateVersion = "23.11";

  nix = {
    settings.auto-optimise-store = true;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

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

  time = {
    timeZone = "Europe/Berlin";
    hardwareClockInLocalTime = true;
  };

  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 25;
  };

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

  environment.systemPackages = with pkgs; [
    bottom
    git
    neofetch
    neovim
    nix-output-monitor
  ];
}
