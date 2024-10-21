{pkgs, ...}:

{
  networking = {
    networkmanager.enable = true;

    firewall = {
      enable = true;
      allowedUDPPorts = [ 53 80 3000 ];
      allowedTCPPorts = [ 53 80 3000 ];
    };
  };

  services = {
    openssh.enable = true;

    adguardhome = {
      enable = true;
      openFirewall = true;
      mutableSettings = true;
      allowDHCP = true;

      settings = null;
    };
  };
}
