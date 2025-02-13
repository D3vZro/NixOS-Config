{
  config,
  pkgs,
  lib,
  username,
  ...
}:

{
  # Name
  networking.hostName = "nix-desktop";

  # Desktop
  home-manager.users.${username} = {
    home.sessionVariables.WLR_RENDERER = lib.mkForce "vulkan";
    xdg.configFile."sway/io".source = lib.mkForce ../../configs/sway/ioDesktop.in;
  };

  # Hardware
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware = {
    cpu.amd.updateMicrocode = true;

    nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.beta;
      modesetting.enable = true;
      open = true;
      nvidiaSettings = false;
      powerManagement.enable = false;
    };
  };

  # Utils
  virtualisation.libvirtd = {
    enable = true;

    qemu = {
      swtpm.enable = true;
      package = pkgs.qemu_kvm;
      ovmf.enable = true;
      runAsRoot = false;
    };
  };

  powerManagement = {
    enable = true;
    cpuFreqGovernor = "performance";
  };

  environment = {
    sessionVariables = {
      WLR_DRM_NO_ATOMIC = "1";
      WLR_NO_HARDWARE_CURSORS = "1";
      LIBVA_DRIVER_NAME = "nvidia";
      MOZ_DISABLE_RDD_SANDBOX = "1";
      EGL_PLATFORM = "wayland";
    };

    systemPackages = with pkgs; [
      virt-manager
      vulkan-validation-layers
    ];
  };
}
