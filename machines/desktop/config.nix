{ config, pkgs, lib, username, ... }:

{
  # Name
  networking.hostName = "nix-desktop";

  # Desktop
  home-manager.users.${username} = {
    home.sessionVariables.WLR_RENDERER = lib.mkForce "vulkan";
  };

  # Hardware
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware = {
    cpu.amd.updateMicrocode = true;

    nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.beta;
      modesetting.enable = true;
      open = false;
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
    ];
  };
}
