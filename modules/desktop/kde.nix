{ pkgs, ... }:
{
  services = {
    desktopManager.plasma6.enable = true;
  };
  environment.plasma6.excludePackages = with pkgs.kdePackages; [ konsole ];
  hardware.graphics.enable = true;
  networking.networkmanager.enable = true;
}
