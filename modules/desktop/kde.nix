{ pkgs, ... }:
{
  services = {
    desktopManager.plasma6.enable = true;
  };
  environment.plasma6.excludePackages = with pkgs.kdePackages; [ konsole ];
  hardware.opengl.enable = true;
  networking.networkmanager.enable = true;
}
