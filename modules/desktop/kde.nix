{
  services.desktopManager.plasma6.enable = true;
  networking.networkmanager.enable = true;
  services.xserver = {
    layout = "us,ru";
  };
}
