{ pkgs, ... }:
{
  services = {
    desktopManager.plasma6.enable = true;
    xserver.xkb.layout = "us,ru";
  };
  environment.plasma6.excludePackages = with pkgs.kdePackages; [ konsole ];
  hardware.opengl.enable = true;
  networking.networkmanager.enable = true;
}
