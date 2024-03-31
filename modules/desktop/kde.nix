{ pkgs, environment, ... }:
{
  hardware.opengl.enable = true;
  services.desktopManager.plasma6.enable = true;
  networking.networkmanager.enable = true;
  services.xserver = {
    layout = "us,ru";
  };
  environment.plasma6.excludePackages = with pkgs.kdePackages; [ konsole ];
}
